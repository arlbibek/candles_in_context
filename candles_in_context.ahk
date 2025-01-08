#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent(true)

wait_page_load := 5000

getScripts(filename) {
    FileRead := []  ; Initialize empty array

    if FileExist(filename) {
        try {
            Loop read filename {
                if (Trim(A_LoopReadLine) != "")  ; Skip empty or whitespace-only lines
                    FileRead.Push(A_LoopReadLine)
            }
            return FileRead
        }
        catch as err {
            MsgBox("File not found: " err.Message "`nPlease make sure to update the file and re-run the script. `n`nMade with ❤️ by Bibek Aryal.", "Candles in context - error")
            ExitApp()
        }
    } else {
        MsgBox("File not found: " filename "`nPlease make sure the file exists and re-run the script. `n`nMade with ❤️ by Bibek Aryal.", "Candles in context - error")
        ExitApp()
    }


}

candles_in_context(stock_symbol) {
    Send(".")
    Sleep(3000)
    Send(stock_symbol)
    Sleep(1000)
    Send("{DOWN}{ENTER}")
    Sleep(300)
    Send("{Esc}")
    Sleep(3000)
    Send("!r")
    Sleep(5000)
}

main() {
    Sleep(500)
    TrayTip("Opening " . SS_URL . "`nSearch starts after " . (wait_page_load / 1000) . " sec. `nSit back, relax and enjoy :)", "Candles in context - search started", "Iconi 0x10")
    Run(SS_URL)
    Sleep(wait_page_load)
    MouseMove(A_ScreenWidth // 2, A_ScreenHeight // 2)
    Sleep(100)
    MouseClick("Left")
    Sleep(100)
    for stock_symbol in STOCKS_SYMBOLS {
        candles_in_context(stock_symbol)
    }
    MsgBox("Review completed successfully! `n`nMade with ❤️ by Bibek Aryal. ", "Candles in context  - completed ")
}

trayIconPath := "candlestick.ico"

if FileExist(trayIconPath) {
    TraySetIcon(trayIconPath)
}

SS_URL := "https://pro.sharesansar.com/technical/advanced-chart"
STOCKS_SYMBOLS := getScripts("scripts.txt")

MsgBox("TOTAL SCRIPTS: " . (STOCKS_SYMBOLS.Length) . "`n`nPress {F2} to starts search, make sure that you are logged into SS Pro before starting. `n`nTo exit press {Ctrl + Shift + E} `n`nMade with ❤️ by Bibek Aryal. `n`n", "Candles in context - started")

F2:: main()
^+e::
{
    MsgBox("App exited by user.`n`nMade with ❤️ by Bibek Aryal", "Candles in context - exiting", "T2")
    ExitApp()
}