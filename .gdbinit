#from https://github.com/KDE/kdevelop/tree/master/plugins/gdb/printers

python

from qt import register_qt_printers
register_qt_printers (None)

#from kde import register_kde_printers
#register_kde_printers (None)

end

set pagination off
#slooooooooooooooooooooooooooooooooooooooooooooooooow and 99.999999999% useless for what we do
set debuginfod enabled off
