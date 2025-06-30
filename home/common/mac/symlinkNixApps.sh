#!/usr/bin/bash
set -euo pipefail

fromDir="$HOME/Applications/Home Manager Apps"
toDir="$HOME/Applications/NixApps"
mkdir -p "$toDir"

echo "🔧 Wrapping Nix apps from: $fromDir → $toDir"

# List contents for sanity check
echo "📂 Listing $fromDir: "
ls -l "$fromDir"

# Disable exit on error temporarily inside the loop
set +e

(
  cd "$fromDir" || exit 1
  for app in *.app; do
    [ -e "$app" ] || continue  # skip if no apps present

    echo "🔄 Processing app: $app"

    # Build AppleScript-based app wrapper
    if ! /usr/bin/osacompile -o "$toDir/$app" -e "do shell script \"open '$fromDir/$app'\""; then
      echo "❌ Failed to wrap $app"
      continue
    fi

    # Setup destination Resources dir
    resources_dir="$toDir/$app/Contents/Resources"
    mkdir -p "$resources_dir"

    # Resolve original app's Resources path
    original_resources="$fromDir/$app/Contents/Resources"
    echo "📂 Checking resources at $original_resources"

    # Check if resources directory exists
    if [ ! -d "$original_resources" ]; then
      echo "⚠️ Resources directory not found for $app"
      continue
    fi

    app_basename=$(basename "$app" .app)

    # Try to find the best icon (prioritize file size)
    best_icon=""

    # Find all .icns files, properly quoted to handle spaces
    find "$original_resources" -iname "*.icns" | while IFS= read -r icon; do
      # Ensure proper quoting for the icon path, especially with spaces
      icon_size=$(/usr/bin/sips -g pixelWidth -g pixelHeight "$icon" 2>/dev/null | grep -o 'pixelWidth: [0-9]*' | /usr/bin/awk '{print $2}')
      
      if [ $? -ne 0 ]; then
        echo "❌ Error processing icon: $icon"
        continue
      fi

      # If we find a valid icon larger than 128px, use it
      if [ -n "$icon_size" ] && [ "$icon_size" -gt 128 ]; then
        best_icon="$icon"
        break  # Stop after finding the first valid icon
      fi
    done
    
    # If no "best" icon found, just pick the first .icns file found
    if [ -z "$best_icon" ]; then
      best_icon=$(find "$original_resources" -iname "*.icns" | head -n 1)
    fi
    
    # If a valid icon is found, copy it
    if [ -n "$best_icon" ]; then
      cp "$best_icon" "$resources_dir/applet.icns"
      echo "🎨 Used icon: $(basename "$best_icon")"
    else
      echo "⚠️  No suitable icon found for $app"
    fi

  done
)

# Re-enable exit on error after loop
set -e

# Cleanup stale wrappers (no matching original)
(
  cd "$toDir" || exit 1
  echo "🔄 Cleaning up stale wrappers"
  for app in *.app; do
    if [ ! -d "$fromDir/$app" ]; then
      echo "🧹 Removing stale wrapper: $app"
      rm -rf "$toDir/$app"
    fi
  done
)

echo "✅ Finished processing apps!"
