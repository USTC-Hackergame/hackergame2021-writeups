import * as cy from 'crypto';

export { genFlag };

const secretPrefix = "5c86e0fb";

const flags = [
     "flag{level0_9d132008f193_[hash]}",
     "flag{level1_212d794167df_[hash]}",
     "flag{level2_5d09255116ac_[hash]}",
     "flag{level3_067f267887a4_[hash]}"
];

function genFlag(level: number, token: string) {
    const hash = cy.createHash('sha256');
    hash.update(secretPrefix + token);
    const hex = hash.copy().digest('hex').slice(0, 10);
    return flags[level].replace('[hash]', hex);
}
