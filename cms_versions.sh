#!/bin/env bash

# Retrieve the version of the following CMSs:
#
# * Drupal
# * Joomla
# * Magento
# * WordPress
#
# Write the CMS version (if newer) to `cms_versions.json`.

update_version() {
  local name="$1"
  local url="$2"
  local pattern="$3"

  local current_version=$(jq -r ".versions.$name" cms_versions.json)
  local latest_version=$(curl -sSLv "$url" 2>&1 | grep -oP "$pattern" | head -1)

  if [[ "$latest_version" > "$current_version" ]]; then
    jq --arg version "$latest_version" ".versions.$name = \$version" cms_versions.json > tmp.json && mv tmp.json cms_versions.json
    echo "Updated cms_versions.json with $name version $latest_version"
  else
    echo "$name version $latest_version is not newer than the current version $current_version"
  fi
}

update_version "drupal_7" "https://www.drupal.org/project/drupal" '(?<=<h4>Drupal core )7\.[0-9\.]+(?=</h4>)'
update_version "drupal_8" "https://www.drupal.org/project/drupal" '(?<=<h4>Drupal core )9\.[0-9\.]+(?=</h4>)'
update_version "joomla" "https://downloads.joomla.org/" '(?<=Download Joomla! )[0-9\.]+'
update_version "magento" "https://github.com/magento/magento2/releases/latest" '(?<=location: https://github.com/magento/magento2/releases/tag/)[0-9\.]+'
update_version "wordpress" "https://wordpress.org/latest.zip" '(?<=filename=wordpress-)[0-9.]+(?=\.zip)'
