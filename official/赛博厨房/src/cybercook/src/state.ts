import { EmptyItems, Stack, ItemStack, ItemFaucet, Pot } from './models'
export { CyberCookState }

interface IStackWithPosition {
    x: number,
    y: number,
    stack: Stack
}

class CyberCookState {
    public map: Array<Array<Stack>>;
    public handStack: ItemStack;
    public x: number;
    public y: number;
    public normalItems: Array<number> = [];

    constructor(
        map: Array<Array<Stack>>,
        handStack: ItemStack,
        x: number,
        y: number,
        normalItems: Array<number>
    ) {
        this.map = map.map(x => x.map(y => y.clone()));
        this.handStack = handStack.clone();
        this.x = x;
        this.y = y;
        this.normalItems = [...normalItems];
    }

    clone() {
        return new CyberCookState(
            this.map,
            this.handStack,
            this.x,
            this.y,
            this.normalItems
        );
    }

    static initEmpty (
        lenX: number,
        lenY: number,
        normalItems: Array<number>,
    ) {
        // initialize position
        let x = 0;
        let y = 0;

        // initialize an empty map
        let map = new Array<Array<Stack>>();
        for (let x = 0; x < lenX; x++) {
            map[x] = new Array<Stack>();
            for (let y = 0; y < lenY; y++) {
                map[x][y] = new ItemStack(EmptyItems(), false);
            }
        }

        return new CyberCookState(
            map,
            new ItemStack(EmptyItems(), true),
            x,
            y,
            normalItems
        )
    }

    public addStack(points: Array<IStackWithPosition>)
    {
        for (let p of points) {
            this.map[p.x][p.y] = p.stack.clone();
        }
    }

    private move(dx: number, dy: number) {
        // keep in the map
        let x = this.x + dx;
        let y = this.y + dy;
        if (x < 0) {
            x = 0;
        } else if (x >= this.map.length) {
            x = this.map.length - 1;
        }
        if (y < 0) {
            y = 0;
        } else if (y >= this.map[0].length) {
            y = this.map[0].length - 1;
        }
        this.x = x;
        this.y = y;
    }

    private getPosition() {
        return { x: this.x, y: this.y };
    }

    private hand() {
        return this.handStack;
    }

    private ground() {
        return this.map[this.x][this.y];
    }

    /*
     * public interfaces
     */

    public getState() {
        return {
            position: this.getPosition(),
            hand: this.hand(),
            map: this.map,
            normalItems: this.normalItems
        }
    }

    public clear() {
        this.x = 0;
        this.y = 0;
        // clear the kitchen (drop all food) and get a new plate
        this.handStack = new ItemStack(EmptyItems(), true);
        for (let x = 0; x < this.map.length; x++) {
            for (let y = 0; y < this.map[x].length; y++) {
                this.map[x][y].clear();
            }
        }
    }

    public updateRecipe(recipe: Array<number>) {
        for (let x = 0; x < this.map.length; x++) {
            for (let y = 0; y < this.map[x].length; y++) {
                if (this.map[x][y] instanceof Pot) {
                    (this.map[x][y] as Pot).updateRecipe(recipe);
                }
            }
        }
    }

    public getRecipe(): Array<number> {
        for (let x = 0; x < this.map.length; x++) {
            for (let y = 0; y < this.map[x].length; y++) {
                if (this.map[x][y] instanceof Pot) {
                    return (this.map[x][y] as Pot).getRecipe();
                }
            }
        }
        return [];
    }

    public win(): boolean {
        for (let x = 0; x < this.map.length; x++) {
            for (let y = 0; y < this.map[x].length; y++) {
                if (this.map[x][y] instanceof Pot) {
                    if((this.map[x][y] as Pot).win()) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /* movement */
    public moveUp(n: number) { this.move(-n, 0); }
    public moveDown(n: number) { this.move(n, 0); }
    public moveLeft(n: number) { this.move(0, -n); }
    public moveRight(n: number) { this.move(0, n); }

    /* item manipulation */

    public pick(n: number) {
        // ground to hand
        let items = this.ground().tryTake(n);
        if (items.count > 0 && this.hand().tryPut(items)) {
            this.ground().take(n);
            this.hand().put(items);
        }
    }

    public put(n: number) {
        // hand to ground
        let items = this.hand().tryTake(n);
        if (items.count > 0 && this.ground().tryPut(items)) {
            this.hand().take(n);
            this.ground().put(items);
        }
    }

    public pickPlate() {
        // ground to hand
        if (this.ground().tryTakePlate() && this.hand().tryPutPlate()) {
            this.ground().takePlate();
            this.hand().putPlate();
            let items = this.ground().take(this.ground().count());
            this.hand().put(items);
        }
    }

    public putPlate() {
        // hand to ground
        if (this.hand().tryTakePlate() && this.ground().tryPutPlate()) {
            this.hand().takePlate();
            this.ground().putPlate();
            let items = this.hand().take(this.hand().count());
            this.ground().put(items);
        }
    }
}
