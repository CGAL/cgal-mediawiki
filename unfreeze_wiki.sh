#!/bin/bash

exec bash -$- ${0/unfreeze/freeze} --unfreeze "$@"
