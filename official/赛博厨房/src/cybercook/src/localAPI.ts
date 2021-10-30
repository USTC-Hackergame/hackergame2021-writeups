import { CyberCookVM } from "./vm";
import { levels } from "./challenges/levels";

export { CyberCookLocalApi };

const CyberCookLocalApi = {
    levels: levels,
    maxProgram: 128,
    maxProgramLength: 72,
    maxExecution: 128,

    fakeVM: new CyberCookVM(levels[0].state, levels[0].state.getRecipe()),

    step(vm: CyberCookVM, program: string) {
        let nstate = vm.state.clone();
        let nvm = new CyberCookVM(nstate, vm.recipe, vm.executionSteps);
        const lines = program.trim().split("\n");
        let result = nvm.executeInstrs(lines);
        return { vm: nvm, ...result };
    },

    historyStep(vm: CyberCookVM, program: string) {
        program = program.trim();
        let nstate = vm.state.clone();
        let nvm = new CyberCookVM(nstate, vm.recipe, vm.executionSteps);
        const lines = program.split("\n");
        let result = nvm.executeInstrs(lines, true);
        return { vm: nvm, ...result };
    },

    genRandomState(level: number, programs: Array<string>) {
        let nhash = CyberCookLocalApi.fakeVM.getInstrsHashes(programs);
        let range = CyberCookLocalApi.levels[level].state.normalItems.length;
        let length = CyberCookLocalApi.levels[level].recipeLength;
        let nrecipe = CyberCookLocalApi.fakeVM.getRandomRecipe(nhash, range, length);
        return { nhash, nrecipe };
    },

    nextDay(level: number, programs: Array<string>) {
        const {nhash, nrecipe} = CyberCookLocalApi.genRandomState(level, programs);
        let nvm = new CyberCookVM(levels[level].state, nrecipe, 0);
        return nvm;
    },

    verifyProgram(program: string) {
        // ret: {result: boolean, msg: string}
        program = program.trim();
        let lines = program.split("\n");
        if (lines.length > CyberCookLocalApi.maxProgramLength) {
            return { result: false, msg: `程序太长（当前：${lines.length}，限制：${CyberCookLocalApi.maxProgramLength}）` };
        }
        return CyberCookLocalApi.fakeVM.verifyPrograms(program);
    }
}
