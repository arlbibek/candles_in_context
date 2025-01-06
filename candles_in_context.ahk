#SingleInstance

wait_page_load := 5000

getScripts(filename) {
    FileRead := []  ; Initialize empty array

    try {
        Loop read filename {
            if (Trim(A_LoopReadLine) != "")  ; Skip empty or whitespace-only lines
                FileRead.Push(A_LoopReadLine)
        }
        return FileRead
    }
    catch as err {
        MsgBox("Error reading file: " err.Message)
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
    TrayTip("Opening " . SS_URL . "`nSearch starts after " . (wait_page_load / 1000) . " sec", "Candles in context - Search started", "Iconi 0x10")
    Run(SS_URL)
    Sleep(wait_page_load)
    MouseMove(A_ScreenWidth // 2, A_ScreenHeight // 2)
    Sleep(100)
    MouseClick("Left")
    Sleep(100)
    for stock_symbol in STOCKS_SYMBOLS {
        candles_in_context(stock_symbol)
    }
    MsgBox("Review completed successfully! `n`nMade with ❤️ by Bibek Aryal. ", "Candles in context  - completed! ")
}

SS_URL := "https://pro.sharesansar.com/technical/advanced-chart"
STOCKS_SYMBOLS := getScripts("scripts.txt")
TrayTip("Press {F2} starts search, make sure that you are logged into SS Pro. `n`nMade with ❤️ by Bibek Aryal. ", "Candles in context started (Total: " . (STOCKS_SYMBOLS.Length) . ")", "Iconi Mute")


2:: main()