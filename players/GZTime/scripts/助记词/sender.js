const axios = require('axios');

const debug = false;

let token_param = '?token=your_token'

let url = 'http://202.38.93.111:10048/phrases'

if(debug) url = 'http://localhost:8080/phrases'

axios({
    method: 'delete',
    url: debug ? url : url + token_param,
}).then(res => console.log(res.data));

function dotest(data_) {
    setTimeout(() => {
        start = Date.now()
        console.log(start)
        axios({
            method: 'post',
            url: debug ? url : url + token_param,
            data: data_,
            headers: {
                'Content-Type': 'application/json',
            }
        }).then(res => {
            console.log(res.data);
            let diff = Date.now() - start;
            console.log(diff);
            if(!res.data.flag2)
            axios({
                method: 'delete',
                url: debug ? url : url + token_param,
            }).then(_ => dotest(data1));
        })
        .catch(err => console.log(err.data));
    }, (parseInt(Date.now()/1000) + 1) * 1000 - Math.random() * 500 - Date.now());
}

function get(){
    axios({
        method: 'get',
        url: use_token_ ? url + token_param : url,
    }).then(res => console.log(res.data));
}

data1 = '['

// 681972554 0
data += '"anything text drive bottom", "author basis instance inflation", "category scene paper fact", "charge spot being finding", "company page dealer product", "competition county garden couple", "demand choice skill support", "department safety hold wait", "desire line model green", '
// 681972553 1
data += '"data model temperature fail", "activity gift science inside", "black black writing beginning", "brown demand ground number", '
// 681972552 2
data += '"animal complex rent visit", "anything check government while", "design effect decision context", '
// 681972551 3
data += '"amount credit pair game", "benefit attention user press", '
// 681972550 4
data += '"appearance savings boat turn", "pair face task bank", '
// 681972549 5
data += '"anything advantage broad reading", "area board tonight reference", '
// 681972548 6
data += '"apartment room pressure produce", "charge advice kind deal", '
// 681972547 7
data += '"attention army heart cell", "benefit beginning form alternative", '
// 681972546 8
data += '"account training community minute", "advertising move average shopping", '
// 681972545 9
data += '"beyond display visit course", "camera individual active government", "function president history common"'
data += ']'


dotest(data)
