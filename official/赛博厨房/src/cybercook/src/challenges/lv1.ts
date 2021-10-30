import { EmptyItems, ItemFaucet, ItemStack, Pot } from '../models'
import { ITEMID } from '../const'
import { CyberCookState } from "../state";

/*
 * |  @  |  0  |
 * |  P  |  .  |
 */


export { state }

const lenX = 2, lenY = 2;
let state = CyberCookState.initEmpty(lenX, lenY,
    [0]
)
state.addStack(
    [
        { x: 0, y: 1, stack: new ItemFaucet(0) },
        { x: 1, y: 0, stack: new Pot([0], []) },
    ]
);
