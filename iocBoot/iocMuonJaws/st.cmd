#!../../bin/windows-x64/MuonJaws

## You may have to change MuonJaws to something else
## everywhere it appears in this file

# Increase this if you get <<TRUNCATED>> or discarded messages warnings in your errlog output
errlogInit2(65536, 256)

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/MuonJaws.dbd"
MuonJaws_registerRecordDeviceDriver pdbbase

# Configure lvDCOM interface
lvDCOMConfigure("lvfp", "frontpanel", "${TOP}/data/lv_MuonJaws.xml", "$(LVDCOM_HOST="")", $(LVDCOM_OPTIONS=2)")

##ISIS## Run IOC initialisation 
< $(IOCSTARTUP)/init.cmd

## Load record instances

##ISIS## Load common DB records 
< $(IOCSTARTUP)/dbload.cmd

dbLoadRecords("db/MuonJaws.db", "P=$(MYPVPREFIX)$(IOCNAME):")

##ISIS## Stuff that needs to be done after all records are loaded but before iocInit is called 
< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=hgv27692Host"

##ISIS## Stuff that needs to be done after iocInit is called e.g. sequence programs 
< $(IOCSTARTUP)/postiocinit.cmd
