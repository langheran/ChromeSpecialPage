UrlProtocol(Key, Command, Description = "") {
	RegWrite, REG_SZ, HKCR, % Key, % "URL Protocol"
	RegWrite, REG_SZ, HKCR, % Key "\shell\open\command",, % Command
	RegWrite, REG_SZ, HKCR, % Key,, % Description
}

; Example
UrlProtocol("chrome", """C:\Users\langh\Utilities\Autohotkey\chromespecialpage\chromespecialpage.exe""  ""%1""", "Run Chrome Special Page")
Run, chrome://settings