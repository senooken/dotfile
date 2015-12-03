#!/usr/bin/bash
# (File name: link.sh)
# Author: SENOO, Ken
# (Last update: 2015-05-01T12:57+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

ln -fs $script_dir/Charts $APPDATA/Microsoft/Templates/
ln -fs "$script_dir/Document Themes" $APPDATA/Microsoft/Templates/
ln -fs $script_dir/Normal.dotm $APPDATA/Microsoft/Templates/
ln -fs $script_dir/XLSTART/*.xltx $APPDATA/Microsoft/Excel/XLSTART/

ln -fs $script_dir/Office/*.officeUI $LOCALAPPDATA/Microsoft/Office/
