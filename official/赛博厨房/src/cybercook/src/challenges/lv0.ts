import { EmptyItems, ItemFaucet, ItemStack, Pot } from '../models'
import { ITEMID } from '../const'
import { CyberCookState } from "../state";

/*
 * |  @  |  0  |  1  |  .  |  .  |
 * |  P  |  .  |  .  |  .  |  .  |
 * |  .  |  .  |  .  |  .  |  .  |
 * |  .  |  .  |  .  |  .  |  .  |
 * |  .  |  .  |  .  |  .  |  .  |
 */


export { state }

const lenX = 5, lenY = 5;
let state = CyberCookState.initEmpty(lenX, lenY,
    [0,1]
)
state.addStack(
    [
        { x: 0, y: 1, stack: new ItemFaucet(0) },
        { x: 0, y: 2, stack: new ItemFaucet(1) },
        { x: 1, y: 0, stack: new Pot([0, 1], []) },
    ]
);
