# Cisco-SCP
Quick bash script to use SCP to backup files


## CATALYST 

AAA is required to be setup. The piece that I find most often missing is the authorization line. 
> aaa new-model  
> aaa authentication login VTY local-case  
> aaa authentication login CONSOLE local-case  
> aaa authentication enable default enable  
> aaa authorization exec default local  

Set your hostname, domain name and generate a certificate.
> hostname \<hostname\>  
> ip domain name \<domain.com\>  
> !  
> crypto key generate rsa general-keys modulus 2048 exportable  

Configure SSH & SCP  
> ip ssh time-out 30  
> ip ssh authentication-retries 2  
> ip ssh logging events  
> ip ssh version 2  
> ip ssh dscp 16  
> !  
> ip scp server enable  

Make sure your user credentials are installed

> username username privilege 15 password 7 \<hash\>  
> ! or  
> username username privilege 15 secret 9 \<hash\>  

Put your public key on the device. It works well if you do this once and save the hash it's much smaller.
> ip ssh pubkey-chain  
> &nbsp; username username  
> &nbsp;&nbsp; key-string \<string\>  
> \! or  
> &nbsp;&nbsp; key-hash ssh-rsa \<hash\>  

Then you should be able to SCP the running config from the device. Or push a file to the device. 

> scp Username@XXX.XXX.XXX.XXX:running-config ~/SCP/SWITCHNAME.txt  
> scp file.bin Username@XXX.XXX.XXX.XXX:flash:/file.bin  
> scp filename.bin User@XXX.XXX.XXX.XXX:flash:/filename.bin  

I've run into weird issues trying to push firmware files. I find that copy http works better. 
> switch\# copy http://<ip>/folder/file.bin flash:/file.bin  

## Nexus
On the Nexus devices, I haven't had good luck requesting the config from the switch, rather I have to push it from the switch
> feature scp-server  
> copy scp://user@scpserver/downloads/filename.bin bootflash:filename.bin  
> copy running-config scp://matt.cozzolino@XXX.XXX.XXX.XXX/Users/matt.cozzolino/SCP/SWITCHNAME.txt vrf default  
