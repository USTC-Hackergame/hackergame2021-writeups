"use strict";

let _ = require("lodash");
let seedrandom = require("seedrandom");
let process = require("process");
let split = require("split");


function getRandomRecipe(seed, range, length) {
    let prng = seedrandom(seed);
    let recipe = [];
    for (let i = 0; i < length; i++) {
        let r = prng.int32() % range;
        recipe.push(r);
    }
    recipe = recipe.map(x => (x + range) % range);
    return recipe;
}

// js is HORRIBLE !!
function my_main() {
    let stdin = process.stdin;
    stdin.setEncoding("utf-8");
    stdin.pipe(split()).on("data", (line) => {
        let [i, seed] = line.split("|")
        if (_.isEqual(
            getRandomRecipe(seed, 32, 6),
            [0, 1, 2, 3, 4, 5]
        )) {
            console.log(i);
            console.log(seed);
            process.exit(0);
        }
    })
}

my_main()
