#!/bin/bash

# Logo resize script for LazyBoy
# Usage: ./resize-logo.sh path/to/your/lazyboy-logo.png

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-logo-image>"
    echo "Example: $0 lazyboy-logo.png"
    exit 1
fi

INPUT_IMAGE="$1"

if [ ! -f "$INPUT_IMAGE" ]; then
    echo "Error: Image file '$INPUT_IMAGE' not found!"
    exit 1
fi

echo "Resizing logo for Open WebUI..."
echo "Input image: $INPUT_IMAGE"

# Create backup of original logos
echo "Creating backups..."
cp static/logo.png static/logo.png.backup 2>/dev/null || true
cp static/favicon.png static/favicon.png.backup 2>/dev/null || true

# Main logo (500x500)
echo "Creating main logo (500x500)..."
sips -z 500 500 "$INPUT_IMAGE" --out static/logo.png
sips -z 500 500 "$INPUT_IMAGE" --out static/splash.png
sips -z 500 500 "$INPUT_IMAGE" --out backend/open_webui/static/logo.png

# Favicon sizes
echo "Creating favicon (32x32)..."
sips -z 32 32 "$INPUT_IMAGE" --out static/favicon.png
sips -z 32 32 "$INPUT_IMAGE" --out backend/open_webui/static/favicon.png

echo "Creating favicon-96x96 (96x96)..."
sips -z 96 96 "$INPUT_IMAGE" --out static/favicon-96x96.png
sips -z 96 96 "$INPUT_IMAGE" --out backend/open_webui/static/favicon-96x96.png

# Apple touch icon (180x180)
echo "Creating Apple touch icon (180x180)..."
sips -z 180 180 "$INPUT_IMAGE" --out static/apple-touch-icon.png

# Web app manifest icons
echo "Creating web app manifest icons..."
sips -z 192 192 "$INPUT_IMAGE" --out static/web-app-manifest-192x192.png
sips -z 512 512 "$INPUT_IMAGE" --out static/web-app-manifest-512x512.png

# Create ICO file (requires multiple sizes)
echo "Creating favicon.ico..."
# Create temporary files for ICO
mkdir -p temp_ico
sips -z 16 16 "$INPUT_IMAGE" --out temp_ico/16.png
sips -z 32 32 "$INPUT_IMAGE" --out temp_ico/32.png
sips -z 48 48 "$INPUT_IMAGE" --out temp_ico/48.png

# Combine into ICO (this requires iconutil on macOS)
if command -v iconutil &> /dev/null; then
    # Create iconset
    mkdir -p temp_ico/icon.iconset
    cp temp_ico/16.png temp_ico/icon.iconset/icon_16x16.png
    cp temp_ico/32.png temp_ico/icon.iconset/icon_32x32.png
    cp temp_ico/48.png temp_ico/icon.iconset/icon_32x32@2x.png
    
    # Convert to ICO
    iconutil -c icns temp_ico/icon.iconset
    mv temp_ico/icon.icns static/favicon.ico
    cp static/favicon.ico backend/open_webui/static/favicon.ico
else
    echo "Warning: iconutil not found. Copying PNG as ICO..."
    cp static/favicon.png static/favicon.ico
    cp static/favicon.png backend/open_webui/static/favicon.ico
fi

# Clean up
rm -rf temp_ico

# Create dark version (optional - same as regular for now)
echo "Creating dark theme splash..."
cp static/splash.png static/splash-dark.png

echo ""
echo "✅ Logo resize complete!"
echo ""
echo "Files created:"
echo "  - static/logo.png (500x500)"
echo "  - static/splash.png (500x500)"
echo "  - static/splash-dark.png (500x500)"
echo "  - static/favicon.png (32x32)"
echo "  - static/favicon-96x96.png (96x96)"
echo "  - static/favicon.ico"
echo "  - static/apple-touch-icon.png (180x180)"
echo "  - static/web-app-manifest-192x192.png (192x192)"
echo "  - static/web-app-manifest-512x512.png (512x512)"
echo "  - backend/open_webui/static/* (same files)"
echo ""
echo "Next steps:"
echo "1. Restart the application: npm run build && npm run dev"
echo "2. Optionally set WEBUI_NAME='LazyBoy' environment variable"
echo ""