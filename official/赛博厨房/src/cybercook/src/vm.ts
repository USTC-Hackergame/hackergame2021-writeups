import { CyberCookState } from './state'
export { CyberCookVM }

import CryptoJS from  'crypto-js'
import seedrandom from 'seedrandom'

interface IRunLog {
    pc: number,
    action: string,
}

interface IRunResult {
    finished: boolean
    win: boolean
    msg: string
    log: Array<IRunLog>
}

interface IBaseInstr {
    reg: RegExp,
    type: string,
    func: (args: Array<number>, pc: number) => number
}

class CyberCookVM {
    public maxSteps = 100000;
    public recipe: Array<number>;

    public state: CyberCookState
    public executionSteps = 0;

    private baseInstrs: Array<IBaseInstr> = [
        /* skip empty */
        { reg: /^\s*$/, type: 'empty', func: (args, pc) => pc + 1 },
        /* skip comment */
        { reg: /^\s*#/, type:' empty', func: (args, pc) => pc + 1 },
        /* reset */
        { reg: /^清理厨房$/, type: 'normal', func: (args, pc) => { this.state.clear(); return pc + 1; } },
        /* movement */
        { reg: /^向上 (\d+) 步$/, type: 'normal', func: (args, pc) => { this.state.moveUp(args[0]); return pc + 1; } },
        { reg: /^向下 (\d+) 步$/, type: 'normal', func: (args, pc) => { this.state.moveDown(args[0]); return pc + 1; } },
        { reg: /^向左 (\d+) 步$/, type: 'normal', func: (args, pc) => { this.state.moveLeft(args[0]); return pc + 1; } },
        { reg: /^向右 (\d+) 步$/, type: 'normal', func: (args, pc) => { this.state.moveRight(args[0]); return pc + 1; } },
        /* item manipulation */
        { reg: /^放下 (\d+) 个物品$/, type: 'normal', func: (args, pc) => { this.state.put(args[0]); return pc + 1; } },
        { reg: /^拿起 (\d+) 个物品$/, type: 'normal', func: (args, pc) => { this.state.pick(args[0]); return pc + 1; } },
        { reg: /^放下盘子$/, type: 'normal', func: (args, pc) => { this.state.putPlate(); return pc + 1; } },
        { reg: /^拿起盘子$/, type: 'normal', func: (args, pc) => { this.state.pickPlate(); return pc + 1; } },
        /* conditional jump */
        { reg: /^如果手上的物品大于等于 (\d+) 向上跳转 (\d+) 行$/, type: 'jump', func: (args, pc) => {
            if (this.state.getState().hand.count() >= args[0] /* n */) {
                return pc - args[1] /* linno */;
            } else {
                return pc + 1;
            }
        }},
        { reg: /^如果手上的物品大于等于 (\d+) 向下跳转 (\d+) 行$/, type: 'jump', func: (args, pc) => {
            if (this.state.getState().hand.count() >= args[0] /* n */) {
                return pc + args[1] /* linno */;
            } else {
                return pc + 1;
            }
        }},
    ]

    constructor(state: CyberCookState, recipe: Array<number>, executionSteps: number = 0) {
        this.state = state
        this.recipe = recipe
        this.executionSteps = executionSteps

        this.state.updateRecipe(this.recipe);
    }

    public info() {
        return {
            map: this.state.map.map(x => x.map(y => y.state())),
            recipe: this.state.getRecipe(),
            inventory: this.state.handStack.state(),
            posRow: this.state.x,
            posColumn: this.state.y,
        }
    }

    public verifyInstr(instr: string): boolean {
        // verify a single instruction
        for (let b of this.baseInstrs) {
            let m = b.reg.exec(instr);
            if (m) {
                return true;
            }
        }
        return false;
    }

    public executeInstr(pc: number, instr: string, ignoreJump: boolean = false): number {
        // execute a single instruction
        for (let b of this.baseInstrs) {
            let m = b.reg.exec(instr);
            if (m) {
                let args = m.slice(1).map(x => +x as number);
                if (ignoreJump && b.type == 'jump') {
                    return pc + 1;
                } else {
                    return b.func(args, pc);
                }
            }
        }
        throw new Error(`invalid instruction: ${instr}`);
    }

    public verifyInstrs(instrs: Array<string>) {
        // verify a sequence of instructions
        for (let i = 0; i < instrs.length; i++) {
            if (!this.verifyInstr(instrs[i])) {
                return {result: false, msg: `第 ${i} 行指令无法识别: ${instrs[i]}`};
            }
        }
        return {result: true, msg: "ok"};
    }

    public verifyPrograms(programs: string) {
        let lines = programs.split('\n');
        return this.verifyInstrs(lines);
    }

    public executeInstrs(instrs: Array<string>, ignoreJump: boolean = false): IRunResult {
        // execute a sequence of instructions
        let pc = 0;

        // clear state state
        this.state.clear();

        let log: Array<IRunLog> = [
            { pc: -1, action: '清理厨房' },
        ];


        while (0 <= pc && pc < instrs.length) {
            this.executionSteps += 1;
            log.push({ pc: pc, action: instrs[pc] });
            pc = this.executeInstr(pc, instrs[pc], ignoreJump);

            if (this.state.win()) {
                return { finished: false, win: true, msg: "You win!", log: log };
            }
            // exceeded max steps

            if (this.executionSteps > this.maxSteps) {
                return { finished: false, win: false, msg: "Execution steps exceeded", log: log };
            }
        }

        return { finished: true, win: false, msg: "finished", log: log };
    }

    public getInstrsHashes(programs: Array<string>) {
        let hashes = [];
        for (let i = 0; i < programs.length; i++) {
            const content = programs[i].trim();
            const hash = CryptoJS.SHA256(content).toString(CryptoJS.enc.Hex);
            hashes.push(hash);
        }
        let hashesConcat = hashes.join('\n');
        return CryptoJS.SHA256(hashesConcat).toString(CryptoJS.enc.Hex);
    }

    public getRandomRecipe(seed: string, range: number, length: number): Array<number> {
        let prng = seedrandom(seed);
        let recipe = [];
        for (let i = 0; i < length; i++) {
            let r = prng.int32() % range;
            recipe.push(r);
        }
        recipe = recipe.map(x => (x + range) % range);
        return recipe;
    }
}
