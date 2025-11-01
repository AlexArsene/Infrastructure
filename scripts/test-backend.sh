#!/bin/bash
echo "Test backend blue (3001)..."
curl --fail http://localhost:3001/contacts || { echo "Eroare: backend blue"; exit 1; }
echo "Test backend green (3002)..."
curl --fail http://localhost:3002/contacts || { echo "Eroare: backend green"; exit 1; }
echo "Backend ok!"

