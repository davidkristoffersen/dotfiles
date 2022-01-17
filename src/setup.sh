#!/usr/bin/bash

pushd . >/dev/null

cd "$(dirname ${BASH_SOURCE[0]})"
eval "$(register-python-argcomplete ./setup.py)"

popd >/dev/null
