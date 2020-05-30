#!/bin/sh


if [ ! -d /usr/local/Cellar/mint ]
then
brew install mint
fi

mint bootstrap
mint run Carthage carthage update --platform iOS --no-use-binaries --cache-builds
mint run xcodegen xcodegen generate
#mint run carting carting update
open Events.xcodeproj
