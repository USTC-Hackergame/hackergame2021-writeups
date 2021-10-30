export { IItems, Stack, EmptyItems, ItemStack, ItemFaucet, Pot }

interface IItems {
    itemId: number;
    count: number;
}

const EmptyItems = (): IItems => ({
    itemId: -1,
    count: 0,
})

class StackState {
    readonly type: string;
    readonly items?: IItems;
    readonly withPlate: boolean;
    readonly extra?: any;

    constructor(type: string, items?: IItems, withPlate: boolean = false, extra?: any) {
        this.type = type;
        this.items = items;
        this.withPlate = withPlate;
        this.extra = extra;
    }

    toString() {
        return JSON.stringify(this);
    }
}

abstract class Stack {
    abstract state(): StackState;
    abstract tryPut(items: IItems): boolean;
    abstract tryTake(n: number): IItems;
    abstract tryPutPlate(): boolean;
    abstract tryTakePlate(): boolean;
    abstract put(items: IItems): void;
    abstract take(n: number): IItems;
    abstract putPlate(): void;
    abstract takePlate(): void;
    abstract clear(): void;
    abstract clone(): Stack;

    empty() {
        if (!this.state().items) { return true; }
        return this.state().items!.count === 0;
    }

    match(itemId: number) {
        if (!this.state().items) { return false; }
        return this.state().items!.itemId === itemId;
    }

    count(): number {
        if (!this.state().items) { return 0; }
        return this.state().items!.count;
    }

    withPlate() {
        return this.state().withPlate;
    }
}

/*
 * An ItemFaucet is a machine with infinite items<id>, without plate.
 */
class ItemFaucet extends Stack {
    private _itemId: number;

    constructor(itemId: number) {
        super();
        this._itemId = itemId;
    }

    state(): StackState {
        return new StackState("ItemFaucet", { itemId: this._itemId, count: -1 }, false, undefined);
    }

    tryPut(items: IItems): boolean { return true; }

    tryTake(n: number): IItems { return { itemId: this._itemId, count: n }; }

    tryPutPlate(): boolean { return false; }

    tryTakePlate(): boolean { return false; }

    put(items: IItems) { }

    take(n: number) { return { itemId: this._itemId, count: n }; }

    putPlate() { }

    takePlate() { }

    clear() { }

    clone() { return new ItemFaucet(this._itemId); }
}

/*
 * An ItemStack is a object with finite items<id>, with or without plate.
 *  - Items can be put into the stack, and taken out.
 *  - Items can be empty.
 *  - ItemStack can be on the hand or on the floor.
 */
class ItemStack extends Stack {
    private _items: IItems;
    private _plate: boolean;

    constructor(items: IItems, plate: boolean) {
        super();
        this._items = items;
        this._plate = plate;
    }

    state(): StackState {
        return new StackState("ItemStack", this._items, this._plate, undefined);
    }

    tryPut(items: IItems): boolean {
        return this.empty() || this._items.itemId === items.itemId;
    }

    tryTake(n: number): IItems {
        return this._items.count >= n ? { itemId: this._items.itemId, count: n } : EmptyItems();
    }

    tryPutPlate(): boolean { return !this._plate; }

    tryTakePlate(): boolean { return this._plate; }

    put(items: IItems) {
        if (this.tryPut(items)) {
            if (this._plate) {
                this._items.itemId = items.itemId;
                this._items.count += items.count;
            }
            // items will be wasted if there's no plate
        }
    }

    take(n: number) {
        const items = this.tryTake(n);
        if (items.count > 0) {
            this._items.count -= items.count;
        }
        return items;
    }

    putPlate() { this._plate = true; }

    takePlate() { this._plate = false; }

    clear() { this._items = EmptyItems(); }

    clone() { return new ItemStack(this._items, this._plate); }
}

/*
 * A Pot is a object with infinite capacity, without plate.
 * - Items can be put into the pot, but can NOT be taken out.
 */
class Pot extends Stack {
    private itemsInPot: Array<number> = [];
    private recipe: Array<number>;

    constructor(recipe: Array<number>, itemsInPot: Array<number>) {
        super();
        this.recipe = recipe;
        this.itemsInPot = itemsInPot;
    }

    state(): StackState {
        return new StackState("Pot", EmptyItems(), false, {
            recipe: this.recipe,
            itemsInPot: this.itemsInPot
        }
        )
    }

    tryPut(items: IItems): boolean { return true; }

    tryTake(n: number): IItems { return EmptyItems(); }

    tryPutPlate(): boolean { return false; }

    tryTakePlate(): boolean { return false; }

    put(items: IItems) { this.itemsInPot.push(items.itemId); }

    take(n: number) {
        return EmptyItems();
    }

    putPlate() { }

    takePlate() { }

    clear() { this.itemsInPot = []; }

    public win(): boolean {
        if (this.itemsInPot.length === 0) {
            return false
        }

        if (this.itemsInPot.length === this.recipe.length) {
            // check if the recipe is correct
            for (let i = 0; i < this.recipe.length; i++) {
                if (this.recipe[i] !== this.itemsInPot[i]) {
                    return false;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    public updateRecipe(recipe: Array<number>) {
        this.recipe = recipe;
    }

    public getRecipe() {
        return this.recipe;
    }

    clone() {
        return new Pot([...this.recipe], [...this.itemsInPot]);
    }
}
