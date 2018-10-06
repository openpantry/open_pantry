#!/bin/bash

(
cd assets/ || exit
yarn
)
mix phx.server
