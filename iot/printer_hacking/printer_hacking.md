# Printer Hacking 

## Exploiting Printers Locally 

The Printer Exploitation Toolkit is a handy tool that is used for both local targeting and exploitation. You can install it by running the following commands:

1. git clone https://github.com/RUB-NDS/PRET && cd PRET
2. python2 -m pip install colorama pysnmP

## Locating Printers to Target
Simply running: 

	python2 pret.py 

Will start an automatic printer discovery in your local network. It is also possible by running an Nmap scan on your whole network, but unfortunately, it might take a longer time. This is because the pret.py scan is focused on the ports which printer communication on by default, thus making it immensely faster.

## Enumerating
Exposed CUPS servers on port 631 can be exploited by accessing them over http if they aren't properly protected. The details of certain functions can be read about here in CUP's documentation: https://www.cups.org/doc/network.html#TABLE2

## Exploiting Printers on a Local Network
There are exactly three options you need to try when exploiting a printer using PRET:
1. ps (Postscript)
2. pjl (Printer Job Language)
3. pcl (Printer Command Language)

You need to try out all three languages just to see which one is going to be understood by the printer. For example:

1. python2 pret.py {IP} pjl
2. python2 pret.py laserjet.lan ps
3. python2 pret.py /dev/usb/lp0 pcl (Last option works if you have a printer connected to your computer already)

After running this command, you are supposed to get shell-alike output with different commands. Run help to see them.

As you can see, PRET allows us to interact with the printer as if we were working with a remote directory. We can now store, delete, or add information on the printer. (For more commands and examples read the project's GitHub) Here's a nice cheatsheet http://hacking-printers.net/wiki/index.php/Printer_Security_Testing_Cheat_Sheet

