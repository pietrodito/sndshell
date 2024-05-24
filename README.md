## Installation
+ Il faut d'abord installer le package suivant https://github.com/pietrodito/sndshare
+ Puis créez le fichier `sndshell.csv` :
```
setwd("~/sasdata1/sasuser/packages_R_externes/")
file.edit("sndshell.csv")
```
+ Copiez/collez le contenu de [`zzz_sndshell.csv`](https://raw.githubusercontent.com/pietrodito/sndshell/main/zzz_sndshell.csv) dans le fichier `sndshell.csv` puis sauvegardez.
+ Puis importez le projet :
```hell
sndshare::import_from_csv("sndshell.csv")
```
