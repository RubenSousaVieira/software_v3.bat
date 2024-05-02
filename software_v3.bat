@echo off
setlocal enabledelayedexpansion
echo **O PROGRAMA DEVE SER INICIADO COMO ADMINISTRADOR**

echo .
echo .

REM Exibe o nome atual da máquina
echo **INFORMACOES DA MAQUINA**
echo Nome atual: %ComputerName%
echo Processador: %PROCESSOR_IDENTIFIER%
echo System type: %PROCESSOR_ARCHITECTURE%
echo .
echo .

pause

echo .
echo .


echo Insira a senha para o "adldmin" (nao sera possivel observar os caracteres inseridos abaixo)

set "username=administrador"
set "newusername=adldmin"
set "newpassword=ADL!5jmm"

net user %username% /active:no
net user %newusername% * /add /active:yes
net localgroup Administrators %newusername% /add

echo **RENOMEACAO REALIZADA PORFAVOR VERIFICAR AS INFORMACOES ACIMA**

echo .
echo .
pause
echo .
echo .

REM Instala as aplicações necessarias para o computador
echo *A instalar e atualiza as aplicacoes:*
echo - 7zip.7zip
echo - AnyDeskSoftwareGmbH.AnyDesk
echo - Mozilla.FireFox
echo - Google.Chrome
echo - Foxit.FoxitReader
echo - pdfforge.PDFCreator
echo - uvncbvba.UltraVnc
echo - VideoLAN.VLC
echo - Notepad++.Notepad++
echo - Microsoft.DotNet.Runtime.3_1
echo - Fortinet.FortiClientVPN

echo .
echo .

winget install 7zip.7zip
winget install AnyDeskSoftwareGmbH.AnyDesk
winget install Mozilla.FireFox
winget install Google.Chrome
winget install Foxit.FoxitReader
winget install pdfforge.PDFCreator
winget install uvncbvba.UltraVnc
winget install VideoLAN.VLC
winget install Notepad++.Notepad++
winget install Microsoft.DotNet.Runtime.3_1
winget install Fortinet.FortiClientVPN

pause

del /q "C:\Users\Public\desktop\*"

pause

netsh advfirewall add rule name="VNC Server" protocol=TCP dir=in localport=5800 action=allow
netsh advfirewall add rule name="VNC Server" protocol=TCP dir=in localport=5900 action=allow

echo .
echo .

netsh advfirewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall add rule name="ICMP Allow incoming V6 echo request" protocol=icmpv6:8,any dir=in action=allow

echo .
echo .

winget upgrade 7zip.7zip
winget upgrade AnyDeskSoftwareGmbH.AnyDesk
winget upgrade Mozilla.FireFox
winget upgrade Google.Chrome
winget upgrade Foxit.FoxitReader
winget upgrade pdfforge.PDFCreator
winget upgrade uvncbvba.UltraVnc
winget upgrade VideoLAN.VLC
winget upgrade Notepad++.Notepad++
winget upgrade Microsoft.DotNet.Runtime.3_1
winget upgrade Fortinet.FortiClientVPN

echo .
echo .

echo **WINGET CONCLUIDO PORFAVOR VERIFICAR AS INFORMACOES ACIMA**

echo .
echo . 

REM Solicita o novo nome da maquina
set /p new_name=Digite o novo nome da maquina:

pause

REM Renomeia a máquina
wmic computersystem where name="%ComputerName%" call rename name="!new_name!"

REM  Aguarda um momento para que a alteração do nome seja processada
ping localhost -n 5 >nul

REM Verifica se o nome foi alterado com sucesso
if "!new_name!"=="%ComputerName%" (
	echo O nome não foi alterado com sucesso. A maquina não será reiniciada.
) else ( 
	REM Exibe o novo nome da máquina
	echo Novo Nome da Maquina: !new_name!

		REM Reinicia a máquina
		shutdown /r /t 10 /f /d p:0:0

)

