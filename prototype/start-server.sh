#!/bin/bash
echo "Starting local server at http://localhost:8080..."
echo "You can now use this URL in Figma 'html.to.design' plugin."
echo "Press Ctrl+C to stop the server."
python3 -m http.server 8080