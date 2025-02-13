#Requires AutoHotkey v2.0
#SingleInstance force
OnExit ForceClose
TraySetIcon "favicon.ico"
; TrayTip "coopw's Keybind Manager", "OwO", 4

Reset


; Create the main GUI window
MainGui := Gui()
MainGui.Title := 'Keybind Manager'
MainGui.SetFont("s8 cDefault Norm", "Tahoma")


; Create default bottom layout
MainGui.AddText("x29 y268", "Made by coopw <3")
MainGui.AddButton("x150 y260 w100 h30", "Reset").OnEvent("Click", Reset)
MainGui.AddButton("x260 y260 w100 h30", "Save").OnEvent("Click", Save)
MainGui.AddButton("x370 y260 w100 h30", "Finish").OnEvent("Click", Finish)

Tab := MainGui.AddTab3("x0 y0 w500 h250 -Wrap", ["Keybinds", "Weapons", "Settings"])


; Create the keybinds tab
Tab.UseTab(1)

; Dividing bars
MainGui.AddText("x5 y50 w480 h2 0x7")
MainGui.AddText("x37 y26 w1 h217 0x7")
MainGui.AddText("x152 y26 w1 h217 0x7")
MainGui.AddText("x355 y26 w1 h217 0x7")


; Grid Key
MainGui.AddText("x17 y29", "#")
MainGui.AddText("x85 y29", "Key")
MainGui.AddText("x230 y29", "Command")
MainGui.AddText("x390 y29", "Cooldown (ms)")

; Number Collumn
MainGui.AddText("x17 y61", "1")
MainGui.AddText("x17 y87", "2")
MainGui.AddText("x17 y113", "3")
MainGui.AddText("x17 y139", "4")
MainGui.AddText("x17 y165", "5")
MainGui.AddText("x17 y191", "6")
MainGui.AddText("x17 y217", "7")

; Key Collumn
MainGui.AddHotkey("x44 y58 w102 h20 vChosenHotkey1", Hotkeys[1])
MainGui.AddHotkey("w102 h20 vChosenHotkey2", Hotkeys[2])
MainGui.AddHotkey("w102 h20 vChosenHotkey3", Hotkeys[3])
MainGui.AddHotkey("w102 h20 vChosenHotkey4", Hotkeys[4])
MainGui.AddHotkey("w102 h20 vChosenHotkey5", Hotkeys[5])
MainGui.AddHotkey("w102 h20 vChosenHotkey6", Hotkeys[6])
MainGui.AddHotkey("w102 h20 vChosenHotkey7", Hotkeys[7])

; Keybind Collumn
MainGui.AddEdit("x159 y58 w190 h20 vChosenCommand1", Commands[1])
MainGui.AddEdit("w190 h20 vChosenCommand2", Commands[2])
MainGui.AddEdit("w190 h20 vChosenCommand3", Commands[3])
MainGui.AddEdit("w190 h20 vChosenCommand4", Commands[4])
MainGui.AddEdit("w190 h20 vChosenCommand5", Commands[5])
MainGui.AddEdit("w190 h20 vChosenCommand6", Commands[6])
MainGui.AddEdit("w190 h20 vChosenCommand7", Commands[7])

; Cooldown Collumn
CooldownLabel := Array()
MainGui.AddEdit("x362 y58 w80 h20 vChosenCooldown1", Cooldowns[1]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown2", Cooldowns[2]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown3", Cooldowns[3]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown4", Cooldowns[4]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown5", Cooldowns[5]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown6", Cooldowns[6]).OnEvent("Change", UpdateCooldownLabel)
MainGui.AddEdit("w80 h20 vChosenCooldown7", Cooldowns[7]).OnEvent("Change", UpdateCooldownLabel)

CooldownLabel.Push(MainGui.AddText("x450 y61 w40 h20", FormatMS(Cooldowns[1])))
CooldownLabel.Push(MainGui.AddText("x450 y87 w40 h20", FormatMS(Cooldowns[2])))
CooldownLabel.Push(MainGui.AddText("x450 y113 w40 h20", FormatMS(Cooldowns[3])))
CooldownLabel.Push(MainGui.AddText("x450 y139 w40 h20", FormatMS(Cooldowns[4])))
CooldownLabel.Push(MainGui.AddText("x450 y165 w40 h20", FormatMS(Cooldowns[5])))
CooldownLabel.Push(MainGui.AddText("x450 y191 w40 h20", FormatMS(Cooldowns[6])))
CooldownLabel.Push(MainGui.AddText("x450 y217 w40 h20", FormatMS(Cooldowns[7])))

; Create the settings tab
Tab.UseTab(3)

; exe groupbox
MainGui.AddGroupBox("x7 y26 w184 h68", "Discord Application")
MainGui.AddText("x18 y45", "Executable Title:")
MainGui.AddComboBox("x14 y65 w170 h200000 vChosenExecutableTitle", ["Discord.exe", "DiscordPTB.exe", "DiscordCanary.exe"]).Choose(ExecutableTitle)

MainGui.Show("w490 h300")

; Functions
ForceClose(ExitReason, ExitCode) {
    if (ExitReason = "Close") {
        if (MsgBox("Are you sure you want to close the keybind manager? Your changes will be saved.", , "YesNo") = "No") {
            MainGui.Show()
            return 1
        } else {
            Save()
            return 1
        }
    } else {
        ; MsgBox("Error: " ExitReason " (" ExitCode ")")
        return 0
    }

}

Save(*) {
    global

    ; Save keybinds
    IniWrite(MainGui["ChosenHotkey1"].Value, "config.ini", "Keybind1", "Hotkey")
    IniWrite(MainGui["ChosenCommand1"].Value, "config.ini", "Keybind1", "Command")
    IniWrite(MainGui["ChosenCooldown1"].Value, "config.ini", "Keybind1", "Cooldown")

    IniWrite(MainGui["ChosenHotkey2"].Value, "config.ini", "Keybind2", "Hotkey")
    IniWrite(MainGui["ChosenCommand2"].Value, "config.ini", "Keybind2", "Command")
    IniWrite(MainGui["ChosenCooldown2"].Value, "config.ini", "Keybind2", "Cooldown")

    IniWrite(MainGui["ChosenHotkey3"].Value, "config.ini", "Keybind3", "Hotkey")
    IniWrite(MainGui["ChosenCommand3"].Value, "config.ini", "Keybind3", "Command")
    IniWrite(MainGui["ChosenCooldown3"].Value, "config.ini", "Keybind3", "Cooldown")

    IniWrite(MainGui["ChosenHotkey4"].Value, "config.ini", "Keybind4", "Hotkey")
    IniWrite(MainGui["ChosenCommand4"].Value, "config.ini", "Keybind4", "Command")
    IniWrite(MainGui["ChosenCooldown4"].Value, "config.ini", "Keybind4", "Cooldown")

    IniWrite(MainGui["ChosenHotkey5"].Value, "config.ini", "Keybind5", "Hotkey")
    IniWrite(MainGui["ChosenCommand5"].Value, "config.ini", "Keybind5", "Command")
    IniWrite(MainGui["ChosenCooldown5"].Value, "config.ini", "Keybind5", "Cooldown")

    IniWrite(MainGui["ChosenHotkey6"].Value, "config.ini", "Keybind6", "Hotkey")
    IniWrite(MainGui["ChosenCommand6"].Value, "config.ini", "Keybind6", "Command")
    IniWrite(MainGui["ChosenCooldown6"].Value, "config.ini", "Keybind6", "Cooldown")

    IniWrite(MainGui["ChosenHotkey7"].Value, "config.ini", "Keybind7", "Hotkey")
    IniWrite(MainGui["ChosenCommand7"].Value, "config.ini", "Keybind7", "Command")
    IniWrite(MainGui["ChosenCooldown7"].Value, "config.ini", "Keybind7", "Cooldown")

    ; Save settings
    IniWrite(MainGui["ChosenExecutableTitle"].Text, "config.ini", "Settings", "ExecutableTitle")
}

Finish(*) {
    if (MsgBox("Are you sure you want to close the keybind manager? Your changes will be saved.", , "YesNo") = "Yes") {
        Save()
        MainGui.Hide()

    }
}


Reset(*) {
    global

    ; Check if config exists
    if !FileExist("config.ini") {
        FileAppend("", "config.ini")
    }

    Hotkeys := Array([], [], [], [], [], [], [])
    Cooldowns := Array([], [], [], [], [], [], [])
    Commands := Array([], [], [], [], [], [], [])

    ; Read config
    Hotkeys[1] := IniRead("config.ini", "Keybind1", "Hotkey", "del")
    Commands[1] := IniRead("config.ini", "Keybind1", "Command", "owob")
    Cooldowns[1] := IniRead("config.ini", "Keybind1", "Cooldown", "15000")

    Hotkeys[2] := IniRead("config.ini", "Keybind2", "Hotkey", "end")
    Commands[2] := IniRead("config.ini", "Keybind2", "Command", "owoh")
    Cooldowns[2] := IniRead("config.ini", "Keybind2", "Cooldown", "15000")

    Hotkeys[3] := IniRead("config.ini", "Keybind3", "Hotkey", "PgUp")
    Commands[3] := IniRead("config.ini", "Keybind3", "Command", "owo")
    Cooldowns[3] := IniRead("config.ini", "Keybind3", "Cooldown", "10000")

    Hotkeys[4] := IniRead("config.ini", "Keybind4", "Hotkey", "PgDn")
    Commands[4] := IniRead("config.ini", "Keybind4", "Command", "owobuy 1")
    Cooldowns[4] := IniRead("config.ini", "Keybind4", "Cooldown", "5000")

    Hotkeys[5] := IniRead("config.ini", "Keybind5", "Hotkey", "F12")
    Commands[5] := IniRead("config.ini", "Keybind5", "Command", "owocurse 434538030691254273")
    Cooldowns[5] := IniRead("config.ini", "Keybind5", "Cooldown", "300000")

    Hotkeys[6] := IniRead("config.ini", "Keybind6", "Hotkey", "")
    Commands[6] := IniRead("config.ini", "Keybind6", "Command", "")
    Cooldowns[6] := IniRead("config.ini", "Keybind6", "Cooldown", "")

    Hotkeys[7] := IniRead("config.ini", "Keybind7", "Hotkey", "")
    Commands[7] := IniRead("config.ini", "Keybind7", "Command", "")
    Cooldowns[7] := IniRead("config.ini", "Keybind7", "Cooldown", "")

    ExecutableTitle := IniRead("config.ini", "Settings", "ExecutableTitle", "Discord.exe")

}

FormatMS(ms) {
    if (ms = "") {
        return "0s"
    }
    ms := Integer(ms)
    if (ms = 0) {
        return "0s"
    }
    seconds := Round(ms / 1000, 1)

    if (seconds < 1) {
        return ms "ms"
    } else if (seconds < 60) {
        return seconds "s"
    } else if (seconds < 3600) {
        return Round(seconds / 60, 1) "m"
    } else {
        return Round(seconds / 3600, 1) "h"
    }
}

UpdateCooldownLabel(*) {
    i := 1
    while i < 7
    {
        cooldown := MainGui["ChosenCooldown" i].Value
        CooldownLabel[i].Text := FormatMS(cooldown)
        i++
    }
}