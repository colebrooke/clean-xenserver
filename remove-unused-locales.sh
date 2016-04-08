#!/bin/bash

# Remove all unused locale files, tested on centos / xenserver

# Delete all except en_GB...
find /usr/lib/locale/ -maxdepth 1 -mindepth 1 -type d ! -iname \*en_GB\* -exec rm -Rf {} \;


# Remove the locales we are not using from the local archive...
localedef --delete-from-archive $(localedef --list-archive | grep -v -e "en_GB")

# keep old locale-archive in case there is a problem
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmp

# a locale.alias file is required by the build-locale-archive command
# test if the directory exsits, if not, create it
[ -d /usr/share/locale ] || mkdir /usr/share/locale
touch /usr/share/locale/locale.alias

build-locale-archive

# if that worked ok then remove the backup
if [ $? -eq 0 ]; then rm -f /usr/lib/locale/locale-archive.tmp; fi
