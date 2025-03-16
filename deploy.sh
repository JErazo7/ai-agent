#!/bin/bash

# Build Flutter frontend
cd src/ai-agent-frontend
fvm flutter build web --release
cd ../..

# Deploy all canisters
dfx deploy