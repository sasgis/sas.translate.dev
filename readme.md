Install [Git](https://git-scm.com/downloads).

Download this repository [as zip archive](https://github.com/sasgis/sas.translate.dev/archive/master.zip) and unpack it to any folder. 

Download and install [PoEdit 1.5.7](https://bitbucket.org/sas_team/sas.translate.dev/downloads/poedit-1.5.7-setup.exe)

Run script `update.cmd` to update translations from sources. 
This script will download SAS.Planet source files into `sas.sources` and existing translates into `sas.translate`.

Open `sas.translate\%your_lang_code%.po` file in `PoEdit` and update translation.

Send your updated `*.po` file to us:

  - create a new issue and attach your file here: [sas.translate](https://github.com/sasgis/sas.translate/issues)
  - or create a [pull-request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) with your 
    changes to the [sas.translate](https://github.com/sasgis/sas.translate) repository
