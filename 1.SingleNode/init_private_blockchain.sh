#!/bin/bash

geth=${GETH:-geth}

$geth --datadir data --networkid 20180412 --rpc --rpccorsdomain "*" init ./genesis.json
