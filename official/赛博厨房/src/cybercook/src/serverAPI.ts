import express from "express";

import { ISolution, checkSolution } from "./check";
import { genFlag } from './secret'

const app = express();
const port = 80; // default port to listen
const host = "0.0.0.0";

app.use(express.json());
app.use('/', express.static('frontend'))

app.get("/help", (req, res, next) => {
    res.json({
        status: "ok",
        message: "There's only one api point `/verify` on this server to verify the solution is correct. \nYou should solve this challenge on your machine first. Please do not waste time brute forcing the api server."
    });
});

app.post("/verify", (req, res, next) => {
    // try to parse the solution, or throw an error
    console.log(req.body);
    const solution: ISolution = req.body;


    try {
        if (checkSolution(solution)) {
            const level = solution.level;
            const flag = genFlag(level, solution.token);
            res.json({
                status: "ok",
                message:  `Your solution is correct. The flag is ${flag}`
            });
        } else {
            res.json({
                status: "error",
                message: "Your solution is incorrect."
            });
        }
    } catch (e) {
        res.status(200).json({
            status: "error",
            message: e.message
        });
        return;
    }
});


// start the express server
app.listen( port, host, () => {
    // tslint:disable-next-line:no-console
    console.log( `server started at http://localhost:${ port }` );
} );
