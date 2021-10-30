<?php
// file under check directory shall be disallowed (403) by nginx
session_start();
require_once("/mnt/app/check/cert.php");

function checkToken()
{
    if (isset($_GET["token"])) {
        $token = $_GET["token"];
        $parsed_token = explode(":", $token, 2);
        if (count($parsed_token) !== 2) {
            return false;
        }
        $id = $parsed_token[0];
        $sig = $parsed_token[1];
        if ($id && $sig) {
            $sig = base64_decode($sig, true);
            if ($sig === false) {
                return false;
            }
            $res = openssl_verify($id, $sig, $GLOBALS['cert'], OPENSSL_ALGO_SHA256);
            if ($res === 1) {
                $_SESSION["token"] = $token;
                return true;
            }
            return false;
        } else {
            return false;
        }
    }
    if (!isset($_SESSION["token"])) {
        return false;
    } else {
        return true;
    }
}

if (!checkToken()) {
    http_response_code(403);
    $failed = true;
} else {
    $failed = false;
}

?><? if ($failed) : ?>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <link rel="stylesheet" href="static/error.css">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <title>Token 错误</title>
</head>

<body>
    <form class="form-token" action="">
        <h1>Error: Token 错误</h1>

        <p>Token 错误，题目没有加载，推荐使用比赛平台上的题目链接访问。</p>
        <p>或在以下输入框中粘贴你的完整 token（可以从比赛平台复制）:</p>

        <input type="text" style="width: 400px;" name="token" placeholder="">
        <input type="submit" value="开始做题" />
    </form>
    <script src="static/jquery.min.js"></script>

    <script type="text/javascript">
        $(function() {
            $('input[type="text"]').on('input', function() {
                this.value = $.trim(this.value);
            });
        });
    </script>
</body>

</html>

<? die() ?>

<? endif ?>