import { EmptyItems, ItemFaucet, ItemStack, Pot } from '../models'
import { ITEMID } from '../const'
import { CyberCookState } from "../state";

/*
 * |  0  |  1  |  2  |  3  | ... | n-1 |
 * |  .  |  .  |  .  |  .  |  .  | P   |
 */


export { state }

const lenX = 2, lenY = 128;
const n = lenY;
const items = Array.from(Array(n).keys());
const faucet = [];
const initRecipe = [0,1,2,3,4,5,6,7];

for (let i = 0; i < n; i++) {
    faucet.push({
        x: 0,
        y: i,
        stack: new ItemFaucet(i)
    })
}
const pots = [];
for (let i = 56; i < n; i++) {
    pots.push({
        x: 1,
        y: i,
        stack: new Pot(initRecipe, []),
    })
}
let state = CyberCookState.initEmpty(
    lenX, lenY,
    items
)
state.addStack([
    ...faucet,
    ...pots
])
