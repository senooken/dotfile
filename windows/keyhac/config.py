from keyhac import *
# coding: utf-8

import os

def configure(keymap):
    if os.name == 'nt':
        windows(keymap)
    else:
        mac(keymap)

def windows(keymap):
    # グローバルキーマップの定義開始
    keymap_global = keymap.defineWindowKeymap()

    # 変換キーを モディファイアキー(User0)に登録
    HENKAN = "28"
    keymap.defineModifier(HENKAN, "User0") 
    # keymap_global["O-User0"] = "28"

    # [変換]
    keymap_global["O-"+HENKAN] = HENKAN            # [変換]で日本語入力

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
    #keymap_global["User0-32"] = "Enter" # Space (32)
    keymap_global["User0-RCtrl"] = "Enter" # Space (32)
    #keymap_global["User0-LAlt"] = "Esc" # Shift (無変換)
    #keymap_global["User2-LShift"] = "Esc" # Shift (無変換)
    # 242: ひらがなかたかな
    # 94: Apps
    # 27: Esc
    # 29: 無変換
    # 28: 変換
    keymap_global["LCtrl-O-RCtrl"] = "Ctrl-Space"



    ### ここからキーの割り当て
    # Vimのカーソル移動
    keymap_global["User0-H"] = "Left"
    keymap_global["User0-J"] = "Down"
    keymap_global["User0-K"] = "Up"
    keymap_global["User0-L"] = "Right"

    keymap_global["User0-U"] = "PageUp"
    keymap_global["User0-Semicolon"] = "PageUp"
    keymap_global["User0-D"]     = "PageDown"
    keymap_global["User0-Slash"] = "PageDown"

    # EmacsのC-a, C-e
    keymap_global["User0-A"] = "Home"
    keymap_global["User0-E"] = "End"

    #keymap_global["User0-User1-U"] = "Shift-PageUp"
    #keymap_global["User0-User1-Semicolon"] = "Shift-PageUp"
    #keymap_global["User0-User1-D"] = "Shift-PageDown"
    #keymap_global["User0-User1-Slash"] = "Shift-PageDown"

    #keymap_global["User0-User1-A"] = "Shift-Home"
    #keymap_global["User0-User1-E"] = "Shift-End"

    # 表計算で端まで移動（未実装）
    #keymap_global["User0-C-H"] = "C-Left"
    #keymap_global["User0-C-J"] = "C-Down"
    #keymap_global["User0-C-K"] = "C-Up"
    #keymap_global["User0-C-L"] = "C-Right"

    # Deleteとタブ
    keymap_global["User0-N"] = "Back"
    keymap_global["User0-M"] = "Shift-Tab"
    keymap_global["User0-Comma"] = "Tab"
    keymap_global["User0-Period"] = "Delete"

    # よく使うキー
    keymap_global["User0-C"] = "Ctrl-C" # Copy
    keymap_global["User0-S"] = "Ctrl-S" # Save
    keymap_global["User0-V"] = "Ctrl-V" # Paste
    keymap_global["User0-User1-V"] = "Ctrl-Shift-V" 
    keymap_global["User0-X"] = "Ctrl-X" # Cut
    keymap_global["User0-W"] = "Ctrl-W" # Close Tab
    keymap_global["User0-F"] = "Ctrl-F" # Find
    keymap_global["User0-Z"] = "Ctrl-Z" # Undo
    keymap_global["User0-Y"] = "Ctrl-Y" # Redo

    # Appsキーを押しやすい位置にし、よく使うF2を定義
    keymap_global["User0-I"] = "F2"
    #keymap_global["O-Shift"] = MUHENKAN

    # 表計算ソフトのタブ切替。Webのタブ切替などにも有効
    keymap_global["User0-O"] = "Ctrl-PageUp"
    keymap_global["User0-P"] = "Ctrl-PageDown"
    keymap_global["LCtrl-User0-U"] = "Ctrl-PageUp"
    keymap_global["LCtrl-User0-D"] = "Ctrl-PageDown"

    #keymap_global["User1-Semicolon"] = "Ctrl-Smicolon"
    keymap_global["Alt-User0-K"] = "Alt-Up" # Exploreで1階層上に移動
    keymap_global["Alt-User0-J"] = "Alt-Down" # ドロップダウンリストを開く
    keymap_global["Alt-User0-H"] = "Alt-Left" # Alt-Tabで左右に画面移動
    keymap_global["Alt-User0-L"] = "Alt-Right" # 同上

    keymap_global["LCtrl-RCtrl"] = "LCtrl-Space" #  保護された空白で使用

## Ctrl+move: word move
    keymap_global["LCtrl-User0-K"] = "Ctrl-Up"
    keymap_global["LCtrl-User0-J"] = "Ctrl-Down"
    keymap_global["LCtrl-User0-H"] = "Ctrl-Left"
    keymap_global["LCtrl-User0-L"] = "Ctrl-Right"

## word delte
    keymap_global["LCtrl-User0-N"] = "Ctrl-Back"
    keymap_global["LCtrl-User0-Period"] = "Ctrl-Delete"

## Windowの最小化・最大化・配置
    keymap_global["LWin-Alt-User0-K"] = "LWin-Up"
    keymap_global["LWin-Alt-User0-J"] = "LWin-Down"
    keymap_global["LWin-Alt-User0-H"] = "LWin-Left"
    keymap_global["LWin-Alt-User0-L"] = "LWin-Right"

## Virtual Desktop for Win32の画面切り替え用
    keymap_global["Alt-Shift-User0-K"] = "Alt-Shift-Up"
    keymap_global["Alt-Shift-User0-J"] = "Alt-Shift-Down"
    keymap_global["Alt-Shift-User0-H"] = "Alt-Shift-Left"
    keymap_global["Alt-Shift-User0-L"] = "Alt-Shift-Right"

def mac(keymap):
    # グローバルキーマップの定義開始
    keymap_global = keymap.defineWindowKeymap()

    EISU = "102" # 0x66
    LSS = EISU
    ## LSSをSandSの代用にする
    # LSSをShiftにする
    keymap.replaceKey(LSS, "Shift")
    # ワンショットモディファイアとしてLSSを元のキーに定義
    keymap_global["O-Shift"] = LSS

    # 変換キーを モディファイアキー(User0)に登録
    KANA = "104" # 0x68
    RSS = KANA
    keymap.defineModifier(RSS, "User0")
    # [変換]
    keymap_global["O-"+RSS] = RSS

    CC = "Cmd"
    # WindowsなどでSpaceにCmd=Winになると変換時にメニューが出て困るので断念。
    keymap_global["User0-Space"] = "Enter" # Space (32)
    # keymap_global["LCtrl-RCtrl"] = "LCtrl-Space" #  保護された空白で使用
    RRSS = "RCmd"
    keymap_global["O-{}".format(RRSS)] = "Esc"
    # LLSS = "LCmd"
    # [Accessibility]-[Alternate pointer actions]=on が必要。うまく機能しない。
    # keymap_global["O-{}".format(LLSS)] = "Fn-F12"

    ## Vim
    keymap_global["User0-H"] = "Left"
    keymap_global["User0-J"] = "Down"
    keymap_global["User0-K"] = "Up"
    keymap_global["User0-L"] = "Right"
    keymap_global["Shift-User0-H"] = "Shift-Left"
    keymap_global["Shift-User0-J"] = "Shift-Down"
    keymap_global["Shift-User0-K"] = "Shift-Up"
    keymap_global["Shift-User0-L"] = "Shift-Right"
    ## word move
    keymap_global["Alt-User0-K"] = "Alt-Up"
    keymap_global["Alt-User0-J"] = "Alt-Down"
    keymap_global["Alt-User0-H"] = "Alt-Left"
    keymap_global["Alt-User0-L"] = "Alt-Right"
    keymap_global["Shift-Alt-User0-K"] = "Shift-Alt-Up"
    keymap_global["Shift-Alt-User0-J"] = "Shift-Alt-Down"
    keymap_global["Shift-Alt-User0-H"] = "Shift-Alt-Left"
    keymap_global["Shift-Alt-User0-L"] = "Shift-Alt-Right"
    ## Alt-move
    #keymap_global["Alt-User0-K"] = "Alt-Up" # Exploreで1階層上に移動
    #keymap_global["Alt-User0-J"] = "Alt-Down" # ドロップダウンリストを開く
    #keymap_global["Alt-User0-H"] = "Alt-Left" # Alt-Tabで左右に画面移動
    #keymap_global["Alt-User0-L"] = "Alt-Right" # 同上

    keymap_global["User0-U"] = "PageUp"
    keymap_global["User0-D"] = "PageDown"
    keymap_global["User0-Semicolon"] = "PageUp"
    keymap_global["User0-Slash"] = "PageDown"
    keymap_global["Shift-User0-U"] = "Shift-PageUp"
    keymap_global["Shift-User0-D"] = "Shift-PageDown"
    keymap_global["Shift-User0-Semicolon"] = "Shift-PageUp"
    keymap_global["Shift-User0-Slash"] = "Shift-PageDown"
    # 表計算ソフトのタブ切替。Webのタブ切替などにも有効
    keymap_global["User0-O"] = "Ctrl-PageUp"
    keymap_global["User0-P"] = "Ctrl-PageDown"
    keymap_global["LCtrl-User0-U"] = "Ctrl-PageUp"
    keymap_global["LCtrl-User0-D"] = "Ctrl-PageDown"

    ## Emacs
    keymap_global["User0-A"] = "Home" # Home
    keymap_global["User0-E"] = "End" # End
    keymap_global["Shift-User0-A"] = "Shift-Home"
    keymap_global["Shift-User0-E"] = "Shift-End" # not work?
    # keymap_global["User0-A"] = "Cmd-Left" # Home
    # keymap_global["User0-E"] = "Cmd-Right" # End
    # keymap_global["Shift-User0-A"] = "Shift-Cmd-Left"
    # keymap_global["Shift-User0-E"] = "Shift-Cmd-Right" # not work?

    # 表計算で端まで移動
    keymap_global["{}-User0-H".format(CC)] = "{}-Left".format(CC)
    keymap_global["{}-User0-J".format(CC)] = "{}-Down".format(CC)
    keymap_global["{}-User0-K".format(CC)] = "{}-Up".format(CC)
    keymap_global["{}-User0-L".format(CC)] = "{}-Right".format(CC)
    keymap_global["Shift-{}-User0-H".format(CC)] = "Shift-{}-Left".format(CC)
    keymap_global["Shift-{}-User0-J".format(CC)] = "Shift-{}-Down".format(CC)
    keymap_global["Shift-{}-User0-K".format(CC)] = "Shift-{}-Up".format(CC)
    keymap_global["Shift-{}-User0-L".format(CC)] = "Shift-{}-Right".format(CC)

    # Deleteとタブ
    keymap_global["User0-M"] = "Shift-Tab"
    keymap_global["User0-Comma"] = "Tab"
    keymap_global["User0-N"] = "Back"
    keymap_global["User0-Period"] = "Delete"
    ## word delte
    keymap_global["Alt-User0-N"] = "Alt-Back"
    keymap_global["Alt-User0-Period"] = "Alt-Delete"

    # よく使うキー
    keymap_global["User0-C"] = "{}-C".format(CC) # Copy
    keymap_global["User0-S"] = "{}-S".format(CC) # Save
    keymap_global["User0-V"] = "{}-V".format(CC) # Paste
    keymap_global["User0-X"] = "{}-X".format(CC) # Cut
    keymap_global["User0-W"] = "{}-W".format(CC) # Close Tab
    keymap_global["User0-F"] = "{}-F".format(CC) # Find
    keymap_global["User0-Z"] = "{}-Z".format(CC) # Undo
    keymap_global["User0-Y"] = "{}-Y".format(CC) # Redo
    keymap_global["Shift-User0-C"] = "Shift-{}-C".format(CC) # Copy
    keymap_global["Shift-User0-S"] = "Shift-{}-S".format(CC) # Save
    keymap_global["Shift-User0-V"] = "Shift-{}-V".format(CC) # Paste
    keymap_global["Shift-User0-X"] = "Shift-{}-X".format(CC) # Cut
    keymap_global["Shift-User0-W"] = "Shift-{}-W".format(CC) # Close Tab
    keymap_global["Shift-User0-F"] = "Shift-{}-F".format(CC) # Find
    keymap_global["Shift-User0-Z"] = "Shift-{}-Z".format(CC) # Undo
    keymap_global["Shift-User0-Y"] = "Shift-{}-Y".format(CC) # Redo

    # Appsキーを押しやすい位置にし、よく使うF2を定義
    keymap_global["User0-I"] = "F2"
    #keymap_global["O-Shift"] = MUHENKAN

    ## Windowの最小化・最大化・配置
    # keymap_global["LWin-Alt-User0-K"] = "LWin-Up"
    # keymap_global["LWin-Alt-User0-J"] = "LWin-Down"
    # keymap_global["LWin-Alt-User0-H"] = "LWin-Left"
    # keymap_global["LWin-Alt-User0-L"] = "LWin-Right"

    ## Virtual Desktop for Win32の画面切り替え用
    # keymap_global["Alt-Shift-User0-K"] = "Alt-Shift-Up"
    # keymap_global["Alt-Shift-User0-J"] = "Alt-Shift-Down"
    # keymap_global["Alt-Shift-User0-H"] = "Alt-Shift-Left"
    # keymap_global["Alt-Shift-User0-L"] = "Alt-Shift-Right"
