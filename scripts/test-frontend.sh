#!/bin/bash
echo "Test frontend blue (4001)..."
curl --fail http://localhost:4001 || { echo "Eroare: frontend blue"; exit 1; }
echo "Test frontend green (4002)..."
curl --fail http://localhost:4002 || { echo "Eroare: frontend green"; exit 1; }
echo "Frontend ok!"

