<?php
date_default_timezone_set("Asia/Shanghai");

function getflag()
{
    $flag = "flag{HUAQIANG!HUAQIANG!_";
    $flag .= substr(hash("sha256", "intOverF1owwww" . $_SESSION["token"]), 0, 10);
    $flag .= "}";
    return $flag;
}

function clearAccount()
{
    unset($_SESSION['account']);
}

function isExpired()
{
    $create = $_SESSION['create'];
    $now = time();
    $ten_min = 60 * 10;
    if ($create + $ten_min <= $now)
        return true;
    return false;
}

function init()
{
    if (!isset($_SESSION['account'])) {
        $_SESSION['account'] = substr(md5(mt_rand()), 0, 15);
        $_SESSION['create'] = time();
        $_SESSION['last_action'] = 0;
        $_SESSION['pool'] = 0;
    }
}

function showtime($t = null)
{
    if ($t == null)
        $t = time();
    echo "<!--DEBUG:" . intval($t) . "-->";
    return date("Y-m-d H:i:s", intval($t));
}

function showinfo($msg)
{
    return $msg;
}

function check_last_action()
{
    $two_sec = 2;
    $now = time();
    if ($_SESSION['last_action'] + $two_sec >= $now) {
        die('操作过快，请 2 秒钟后再试。点击<a href="/">这里</a>回到主页。');
    }
    $_SESSION['last_action'] = time();
}

function action()
{
    check_last_action();
    $bottle_6 = intval($_POST['b6']);
    $bottle_9 = intval($_POST['b9']);
    if ($bottle_6 < 0 || $bottle_9 < 0) {
        die('操作无效：不能放负数个瓜。点击<a href="/">这里</a>回到主页。');
    }
    $_SESSION['pool'] += intval($bottle_6 * 6 + $bottle_9 * 9);
    header('Location: /');
}

function main()
{
    init();
    if (isset($_GET['clear']) && $_GET['clear'] === 'y') {
        clearAccount();
        die('已经清空账号，请点击<a href="/">这里</a>重新开始。');
    }
    if (isExpired()) {
        clearAccount();
        die('账号已经过期，请点击<a href="/">这里</a>重新开始。');
    }
    if (isset($_POST['submit'])) {
        action();
    }
}

main();
?>

<html>

<head>
    <title>卖瓜</title>
    <style>
        body {
            font-family: arial, sans-serif;
        }

        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
        }

        td,
        th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        .app {
            width: 100%;
            max-width: 800px;
            padding: 15px;
            margin: auto;
            margin-top: 100px;
        }

        .number {
            max-width: 40px;
        }
    </style>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <script src="static/jquery.min.js"></script>

</head>

<body>
    <div class="app">
        <div class="card">
            <h5 class="card-header">卖瓜</h5>
            <div class="card-body">
                <p>有一个人前来买瓜。</p>
                <p>你拥有以下物品：</p>
                <ul>
                    <li>一个大棚，里面有许多 6 斤一个的瓜和许多 9 斤一个的瓜。</li>
                    <li>一个电子秤（最开始是空的）；</li>
                </ul>
                <p>你的任务是在电子秤上称出刚好 20 斤的瓜。</p>
                <hr>
                <h5>状态</h5>
                <? if ($_SESSION['pool'] === 20) : ?>
                    <div class="alert alert-success" role="alert">
                        恭喜你逃过一劫！The flag is: <code><?= getflag() ?></code>
                    </div>
                <? endif ?>
                <p>电子秤上已有 <?= $_SESSION['pool'] ?>/20 斤的瓜。</p>
                <form method="post">
                    <p>放上 6 斤的瓜 <input type="number" class="number" name="b6" value="0" min="0"> 个</p>
                    <p>放上 9 斤的瓜 <input type="number" class="number" name="b9" value="0" min="0"> 个</p>
                    <input class="btn btn-primary" type="submit" name="submit" value="操作！">
                </form>
                <hr>

                <p>有效时间 10 分钟，有效时间过后顾客将会掀掉你的大棚<!--撒日朗-->。你也可以立刻主动<a href="?clear=y">重新开始</a>。
                </p>
            </div>
        </div>
    </div>
</body>

</html>
