# Set app version from Git
# git describe --always
NUXWS_VERSION=`git describe --always`
NUXWS_VERSION.chomp!
NUXWS_VERSION="unknown rev" if NUXWS_VERSION.empty?
