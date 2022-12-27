#!/bin/bash

set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null \
	|| exit 1
source "../contrib/utils.sh" || exit 1
become_minecaft "./update.sh"


################################################################
# Download paper and prepare plugins

download_paper paper.jar

# Create plugins directory
mkdir -p plugins \
	|| die "Could not create directory 'plugins'"
# Create optional plugins directory
mkdir -p plugins/optional \
	|| die "Could not create directory 'plugins/optional'"


################################################################
# Download plugins

substatus "Downloading plugins"
for module in admin bedtime core enchantments permissions portals regions trifles; do
	download_latest_github_release "oddlama/vane" "vane-$module-{VERSION}.jar" "plugins/vane-$module.jar"
done

download_file "https://ci.dmulloy2.net/job/ProtocolLib/lastSuccessfulBuild/artifact/target/ProtocolLib.jar" plugins/ProtocolLib.jar
download_latest_github_release "BlueMap-Minecraft/BlueMap" "BlueMap-{VERSION}-spigot.jar" plugins/bluemap.jar
#download_file "https://dev.bukkit.org/projects/worldedit/files/latest" plugins/optional/worldedit.jar
download_file "https://mediafilez.forgecdn.net/files/4162/203/worldedit-bukkit-7.2.13.jar" plugins/optional/worldedit.jar
