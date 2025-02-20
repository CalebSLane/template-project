#!/bin/sh
curl -f http://localhost:8080/v1/sys/health || exit 1
