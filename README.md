# Cisco-SCP
Quick bash script to use SCP to backup files


!-- CATALYST --!
!
!-- The required piece is aaa authentication & aaa authorization. Most of the basic configs don't have an authorization line. 
aaa new-model
!aaa authentication login VTY group tacacs+ group TACACS-GROUP local-case
!aaa authentication login CONSOLE group tacacs+ group TACACS-GROUP local-case
!aaa authorization exec default group tacacs+ group TACACS-GROUP local
!
!-- Also a certificate should be generated 
!crypto key generate rsa general-keys modulus 1024 exportable
!
!-- SSH must be configured
ip ssh time-out 30
ip ssh authentication-retries 2
ip ssh logging events
ip ssh version 2
ip ssh dscp 16
!
ip scp server enable
!
!
! User Credentials
! 
! username <username> privilege 15 password 7 <hash>
username <username> privilege 15 secret 9 <hash>
!
ip ssh pubkey-chain
  username mattcozzolino
   key-hash ssh-rsa AF9670696AD58A1AEE1B4365ACAD78A6 matt.cozzolino@Galactica.local
!
!
!-- MAC:
scp Username@XXX.XXX.XXX.XXX:running-config ~/SCP/SWITCHNAME.txt
scp file.bin Username@XXX.XXX.XXX.XXX:flash:/file.bin
scp filename.bin User@XXX.XXX.XXX.XXX:flash:/filename.bin

!-- NEXUS --!
feature scp-server
copy scp://user@scpserver/downloads/filename.bin bootflash:filename.bin
copy running-config scp://matt.cozzolino@XXX.XXX.XXX.XXX/Users/matt.cozzolino/SCP/SWITCHNAME.txt vrf default
