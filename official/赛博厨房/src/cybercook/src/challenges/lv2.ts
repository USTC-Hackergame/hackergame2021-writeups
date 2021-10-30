import { EmptyItems, ItemFaucet, ItemStack, Pot } from '../models'
import { ITEMID } from '../const'
import { CyberCookState } from "../state";

/*
 * |  P  |  0  |  1  |  2  |  3  | ... | n-1  |
 */


export { state }

const lenX = 1, lenY = 33;
const n = 32;
const items = Array.from(Array(n).keys())
const faucet = []
for (let i = 0; i < n; i++) {
    faucet.push({
        x: 0,
        y: i + 1,
        stack: new ItemFaucet(i)
    })
}

const initRecipe = [0,1,2,3,4,5];
let state = CyberCookState.initEmpty(
    lenX, lenY,
    items
)
state.addStack(
    [
        ...faucet,
        { x: 0, y: 0, stack: new Pot(initRecipe, []) },
    ]
);
