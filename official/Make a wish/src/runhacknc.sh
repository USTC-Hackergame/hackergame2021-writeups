#!/bin/bash
stty raw -echo; nc 127.0.0.1 10047; stty sane
