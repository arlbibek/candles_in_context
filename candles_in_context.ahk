#SingleInstance

SS_URL := "https://pro.sharesansar.com/technical/advanced-chart"
STOCKS_SYMBOLS := ["ADBL", "w.MKCL", "d.MKCL", "w.KBL", "d.KBL", "d.PRVU", "w.PRVU", "w.LSL", "d.LSL"]

TrayTip("Press {F2} starts search, make sure that you are logged into SS Pro. `n`nMade with ❤️ by Bibek Aryal. ", "Candles in context started (Total: " . (STOCKS_SYMBOLS.Length) . ")", "Iconi Mute")

wait_pageload := 5000

caldles_in_context(stock_symbol) {
    Send(".")
    Sleep(1000)
    Send(stock_symbol)
    Sleep(300)
    Send("{DOWN}{ENTER}")
    Sleep(200)
    Send("{Esc}")
    Sleep(3000)
    Send("!r")
    Sleep(5000)
}


main() {
    TrayTip("Opening " . SS_URL . "`nSearch starts after " . (wait_pageload / 1000) . " sec", "Candles in context - Search started", "Iconi 0x10")
    Run(SS_URL)
    Sleep(wait_pageload)
    Send("{TAB}")
    for stock_symobl in STOCKS_SYMBOLS {
        caldles_in_context(stock_symobl)
    }
    MsgBox("Review completed sucessfully!!`n`nMade with ❤️ by Bibek Aryal. ", "Candles in context  - completed!")
}


f2:: main()