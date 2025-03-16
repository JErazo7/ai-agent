#!/bin/bash

# Construir el frontend de Flutter
cd src/ai-agent-frontend
fvm flutter build web --release
cd ../..

# Desplegar el backend
dfx deploy ai-agent-backend

# Desplegar el frontend
dfx deploy ai-agent-frontend

# Mostrar las URLs de los canisters
echo "Backend canister ID: $(dfx canister id ai-agent-backend)"
echo "Frontend canister ID: $(dfx canister id ai-agent-frontend)"
echo "Frontend URL: http://$(dfx canister id ai-agent-frontend).ic0.app" 