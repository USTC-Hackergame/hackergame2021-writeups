<?php
    $GLOBALS['cert'] = openssl_x509_read(file_get_contents("/mnt/app/check/cert.pem"));
?>