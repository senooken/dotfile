script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
# script_dir=`dirname "${0}"`

## screen backlight brightness
# xbacklight -set 30
## key repeat speed.
xset r rate 200 40

## invalid repeat key for modifier key.
## 9: Escape, 23: Tab, 49: Zenkaku_Hankaku, 66: Eisu_toggle, 100; Henkan_Mode, 101: Hiragana_Katakana
modkeycode="9 23 49 66 100 101 102"
for i in $modkeycode; do xset -r $i; done


## Muhenkan -> Shift
#xmodmap -e "keycode 255=Muhenkan"
#xmodmap -e   "keycode 102=Shift_L"
#xcape -e "#102=Muhenkan" 

## Space -> Ctrl
#xmodmap -e "add control = space"
##xmodmap -e "keycode 254=space"
##xmodmap -e "keycode 65=Control_L"
#xcape -e "#65=space"
#
#
### 
#xmodmap -e "keycode 101 = Escape"
#
##xmodmap -e "remove mod1 = Alt_R"
## xmodmap -e "keycode 108=Menu"
#
#xcape -e "#108=Menu" &
#xmodmap -e "remove mod1 = Alt_R"
#
#xmodmap -e "keycode 253 = Henkan"
#xmodmap -e "keycode 100 = Mode_switch"
#xcape -e "#100=Henkan" &
#
#xmodmap - <<EOF
#keycode 43 = h H Left
#keycode 44 = j J Down
#keycode 45 = k K Up
#keycode 46 = l L Right
#
#
#EOF

#xkbcomp xkb.dump $DISPLAY

#xkbcomp ${script_dir}/xkb.dump $DISPLAY


#xcape -e "#102=Muhenkan" 
#xcape -e "#65=space"


xkbcomp ${script_dir}/my-xkb.dump $DISPLAY
