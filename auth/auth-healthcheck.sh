#!/bin/sh

timeout 10s bash -c ':> /dev/tcp/localhost/8080' || exit 1