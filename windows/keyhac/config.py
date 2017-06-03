from keyhac import *
# coding: utf-8

def configure(keymap):
    # グローバルキーマップの定義開始
    keymap_global = keymap.defineWindowKeymap()

    # 変換キーを モディファイアキー(U0)に登録
    HENKAN = "28"
    keymap.defineModifier(HENKAN, "User0") 
    # keymap_global["O-U0"] = "28"

    ## 無変換キーをSandSの代用にする
    # ワンショットモディファイアとしてShiftを無変換に定義
    MUHENKAN = "29"
    keymap_global["O-Shift"] = MUHENKAN
    # 無変換キーをShiftにする
    keymap.replaceKey(MUHENKAN, "Shift")

    # 範囲選択用に無変換キーをmodifierキーに定義
    keymap.defineModifier(MUHENKAN, "User1")
    #keymap.global["O-94"]="242"
    #keymap_global["242"] = "Apps"
    #eymap.defineModifier("242", "User2")
    #keymap.replaceKey("242", "Apps")
    #keymap_global["O-242", "94"]

    # カタカナひらがなキーをEscに割り当て
    keymap.replaceKey("242", "Esc")

    # Applicationキー（コンテキストキー、Menu Key）の無いキーボード用に右Altを割り当て
    keymap.replaceKey("RAlt", "Apps")

    # SpaceにCtrlをもたせる
    keymap.defineModifier( "Space", "User3") 
    keymap.replaceKey("Space", "RCtrl")
    keymap_global["O-RCtrl"]   = "Space"
    keymap_global["Alt-RCtrl"] = "Alt-Space"
    # カタカナひらがなキーをmodifierキーに設定
    #keymap.defineModifier(242, "User2")
    # enthumbleのEscとEnterの入力方式
    #keymap_global["U0-32"] = "Enter" # Space (32)
    keymap_global["U0-RCtrl"] = "Enter" # Space (32)
    #keymap_global["U0-LAlt"] = "Esc" # Shift (無変換)
    #keymap_global["U2-LShift"] = "Esc" # Shift (無変換)
    # 242: ひらがなかたかな
    # 94: Apps
    # 27: Esc
    # 29: 無変換
    # 28: 変換
    keymap_global["LCtrl-O-RCtrl"] = "Ctrl-Space"



    ### ここからキーの割り当て
    # Vimのカーソル移動
    keymap_global["U0-H"] = "Left"
    keymap_global["U0-J"] = "Down"
    keymap_global["U0-K"] = "Up"
    keymap_global["U0-L"] = "Right"

    keymap_global["U0-U"] = "PageUp"
    keymap_global["U0-Semicolon"] = "PageUp"
    keymap_global["U0-D"]     = "PageDown"
    keymap_global["U0-Slash"] = "PageDown"

    # EmacsのC-a, C-e
    keymap_global["U0-A"] = "Home"
    keymap_global["U0-E"] = "End"

    #keymap_global["U0-U1-U"] = "S-PageUp"
    #keymap_global["U0-U1-Semicolon"] = "S-PageUp"
    #keymap_global["U0-U1-D"] = "S-PageDown"
    #keymap_global["U0-U1-Slash"] = "S-PageDown"

    #keymap_global["U0-U1-A"] = "S-Home"
    #keymap_global["U0-U1-E"] = "S-End"

    # 表計算で端まで移動（未実装）
    #keymap_global["U0-C-H"] = "C-Left"
    #keymap_global["U0-C-J"] = "C-Down"
    #keymap_global["U0-C-K"] = "C-Up"
    #keymap_global["U0-C-L"] = "C-Right"

    # Deleteとタブ
    keymap_global["U0-N"] = "Back"
    keymap_global["U0-M"] = "Shift-Tab"
    keymap_global["U0-Comma"] = "Tab"
    keymap_global["U0-Period"] = "Delete"

    # よく使うキー
    keymap_global["U0-C"] = "Ctrl-C" # Copy
    keymap_global["U0-S"] = "Ctrl-S" # Save
    keymap_global["U0-V"] = "Ctrl-V" # Paste
    keymap_global["U0-U1-V"] = "Ctrl-Shift-V" 
    keymap_global["U0-X"] = "Ctrl-X" # Cut
    keymap_global["U0-W"] = "Ctrl-W" # Close Tab
    keymap_global["U0-F"] = "Ctrl-F" # Find
    keymap_global["U0-Z"] = "Ctrl-Z" # Undo
    keymap_global["U0-Y"] = "Ctrl-Y" # Redo

    # Appsキーを押しやすい位置にし、よく使うF2を定義
    keymap_global["U0-I"] = "F2"
    #keymap_global["O-Shift"] = MUHENKAN

    # 表計算ソフトのタブ切替。Webのタブ切替などにも有効
    keymap_global["U0-O"] = "Ctrl-PageUp"
    keymap_global["U0-P"] = "Ctrl-PageDown"
    keymap_global["LCtrl-U0-U"] = "Ctrl-PageUp"
    keymap_global["LCtrl-U0-D"] = "Ctrl-PageDown"

    #keymap_global["U1-Semicolon"] = "Ctrl-Smicolon"
    keymap_global["Alt-U0-K"] = "Alt-Up" # Exploreで1階層上に移動
    keymap_global["Alt-U0-J"] = "Alt-Down" # ドロップダウンリストを開く
    keymap_global["Alt-U0-H"] = "Alt-Left" # Alt-Tabで左右に画面移動
    keymap_global["Alt-U0-L"] = "Alt-Right" # 同上

    keymap_global["LCtrl-RCtrl"] = "LCtrl-Space" #  保護された空白で使用

## Ctrl+move: word move
    keymap_global["LCtrl-U0-K"] = "Ctrl-Up"
    keymap_global["LCtrl-U0-J"] = "Ctrl-Down"
    keymap_global["LCtrl-U0-H"] = "Ctrl-Left"
    keymap_global["LCtrl-U0-L"] = "Ctrl-Right"

## word delte
    keymap_global["LCtrl-U0-N"] = "Ctrl-Back"
    keymap_global["LCtrl-U0-Period"] = "Ctrl-Delete"

## Windowの最小化・最大化・配置
    keymap_global["LWin-Alt-U0-K"] = "LWin-Up"
    keymap_global["LWin-Alt-U0-J"] = "LWin-Down"
    keymap_global["LWin-Alt-U0-H"] = "LWin-Left"
    keymap_global["LWin-Alt-U0-L"] = "LWin-Right"

## Virtual Desktop for Win32の画面切り替え用
    keymap_global["Alt-S-U0-K"] = "Alt-Shift-Up"
    keymap_global["Alt-S-U0-J"] = "Alt-Shift-Down"
    keymap_global["Alt-S-U0-H"] = "Alt-Shift-Left"
    keymap_global["Alt-S-U0-L"] = "Alt-Shift-Right"

# [変換]
    keymap_global["O-"+HENKAN] = HENKAN            # [変換]で日本語入力
