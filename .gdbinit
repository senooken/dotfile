################################################################################
### \file .gdbinit
### \author SENOO, Ken
### \copyright CC0
################################################################################

set confirm off
set print pretty on
set history filename ~/.gdb_history
set history save
set history expansion

define skip
	if $argc != 1
		tbreak +1
		jump +1
	end

	if $argc == 1
		set $i = $arg0
		while $i > 0
			tbreak +1
			jump +1
			set $i = $i - 1
		end
	end
end
