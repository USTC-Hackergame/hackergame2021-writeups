export { ISolution, checkSolution }
import { CyberCookLocalApi } from "./localAPI";
import * as f from 'fs';
import * as cr from 'crypto';

interface ISolution {
    level: number;
    seed: string;
    token: string;
    programs: Array<string>;
    executions: Array<number>;
}

function checkToken(token: string): boolean {
    try {
        const tokensp = token.split(":");
        const id = tokensp[0];
        const sig = tokensp[1];

        const pem = f.readFileSync('./cert.pem');
        let publicKey = pem.toString('ascii');
        const verifier = cr.createVerify('RSA-SHA256');

        verifier.update(id, 'ascii');
        const publicKeyBuf = Buffer.from(publicKey, 'ascii');
        const signatureBuf = Buffer.from(sig, 'base64');
        const result = verifier.verify(publicKeyBuf, signatureBuf);

        return result;
    } catch(e) {
        console.log(e);
        return false;
    }
    return false;
}

function checkSolution(solution: ISolution): boolean {
    // token check
    if (!checkToken(solution.token)) {
        throw new Error("Token 错误，请清理缓存后刷新页面或重新从比赛平台进入。");
    }

    // level check
    if (solution.level < 0 || solution.level >= CyberCookLocalApi.levels.length) {
        throw new Error("Level out of range");
    }

    // programs length & quantity check
    if (solution.programs.length > CyberCookLocalApi.maxProgram) {
        throw new Error(`Too many programs (current: ${solution.programs.length},limit: ${CyberCookLocalApi.maxProgram})`);
    }
    if (solution.executions.length > CyberCookLocalApi.maxExecution) {
        throw new Error(`Too many executions (current: ${solution.executions.length},limit: ${CyberCookLocalApi.maxExecution})`);
    }
    for (let i = 0; i < solution.programs.length; i++) {
        const lines = solution.programs[i].trim().split("\n");
        if (lines.length > CyberCookLocalApi.maxProgramLength) {
            throw new Error(`Program ${i} too long (current: ${lines.length}, limit: ${CyberCookLocalApi.maxProgramLength})`);
        }
    }

    // seed check
    const {nhash, nrecipe} = CyberCookLocalApi.genRandomState(solution.level, solution.programs);
    if (solution.seed != nhash) {
        throw new Error(`Seed is not correct, should be ${nhash}.`);
    }

    let vm = CyberCookLocalApi.nextDay(solution.level, solution.programs);

    for (let i = 0; i < solution.executions.length; i++) {
        const programId = solution.executions[i];
        const program = solution.programs[programId];
        const result = CyberCookLocalApi.step(vm, program);
        if (result.win) {
            return true;
        }
        if (!result.finished) {
            throw new Error(`Execution ${i} not finished`);
        }
        vm = result.vm;
    }
    throw new Error(`No win. The recipe should be [${nrecipe}].`);
}
