**GESCOM**

Installation Environnement


**Installation**

1. Git
1. Oh-my-zsh
1. Docker et docker-compose 
1. Postgres (en utilisant docker-compose)
1. SDKMAN
1. Java 15 ou supérieur
1. Maven 3.8.5 ou supérieura
1. Eclipse
1. Postman
1. Nodejs/nvm
1. Visual studio code

1. # **GIT**
**Pour Windows :** 

- Cliquez sur le lien suivant pour télécharger git sur votre machine : <https://github.com/git-for-windows/git/releases/download/v2.36.0.windows.1/Git-2.36.0-64-bit.exe>
- Lancez l’installation du ***Git*** et Cochez la case « Git Bash Here » pour installer ***Git Bash***   

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.001.png) 
1. # **Oh-my-zsh**
**Pour Windows :**

1. Téléchargez-le package ZSH : <https://mirror.msys2.org/msys/x86_64/zsh-5.8-5-x86_64.pkg.tar.zst>
1. Extrayez le contenu dans votre répertoire d'installation Git : **C:\Program Files\Git**

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.002.png)

1. Testez-le et configurez ZSH : 
- Ouvrez Git Bash et tapez **zsh**

1. En installant **oh-my-zsh**, exécutez la commande suivante sur **Git Bash** :

sh -c " $( curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh ) "

1. Modifiez le **~/.bashrc** fichier. (Créez-le s'il n'existe pas) et ajouter les lignes suivantes à la fin du fichier

\# Launch Zsh

if [ -t 1 ]; then

exec zsh

fi

1. Fermez Git Bash.
1. Activez les plugins suivants :
- Mvn 
- Npm 
- Yarn 
- Docker 
- Kubectl 

Pour activez les plugins lancer le terminal et tapez **.zshrc** et ajouter les plugins au tableau plugins de votre fichier « .zshrc »

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.003.png)
1. # **Docker / Docker compose**
Installez docker pour Windows : <https://docs.docker.com/desktop/windows/release-notes/>

Télécharger le fichier suivant https://github.com/innovds/gescom-wiki/blob/development/.attachments/docker-compose.yaml,

Pour lancer les containers configurés dans le fichier docker-compose.yaml exécutez la commande suivante

docker-compose up
1. # **Postgres use docker compose**
Ajouter ce fichier dans un répertoire https://github.com/innovds/gescom-wiki/blob/development/.attachments/docker-compose.yaml 

Ouvrir le répertoire dans l’invite de commande et exécutez la commande 

docker-compose up
1. # **SDKMAN**
Exécutez la commande suivante sur **Git Bash** pour installez SDKMAN  

curl -s "https://get.sdkman.io" | bash

- Si vous rencontrez un problème de type :

` `Please install zip on your system using your favourite package manager.

` `Restart after installing zip.

Solution : 

1. Lancer PowerShell en tant qu’administrateur  
1. Exécutez la commande suivante pour installer le package Chocolatey sur votre machine

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

1. Après l’installation de Chocolatey exécutez la commande suivante depuis la ligne de commande ou depuis PowerShell :

choco install gow

- Le package Gow permet d’installer plusieurs commandes comme la commande **zip**, **vim…**
1. Fermez et ouvrez à nouveau le git bash.
1. Exécutez la commande qui install SDKMAN

curl -s "https://get.sdkman.io" | bash

1. Fermez git bash.
1. # **Java**
1. Lancez Git Bash 
1. Utilisez Sdk list java pour afficher l’ensemble des versions de Java qui peuvent être téléchargées. ![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.004.png)

Il existe de nombreux “candidats” (dans le langage de SDKMAN) pour Java, ils se répartissent selon le distributeur (Vendor) et la version.

1. Pour installer java 

Tapez la commande suivante **sdk i java (identifier)** voir l’exemple suivant :

Je choisis d’installer le JDK17, avec Java Oracle, le candidat correspondant (selon le tableau) est donc 17.0.3-oracle, La commande pour installer ce candidat est :

sdk i java 17.0.3-oracle

*NB : Installez java 15 ou supérieur*

Toutes les installations de sdk est situé dans le dossier caché **.sdkman** dans votre répertoire personnel. Ex (c:/utilisateurs/pc/.sdkman).

Les candidats sont installés dans c:/utilisateurs/pc/.sdkman/candidates/.

1. Définir la variable **JAVA\_HOME** du java
- Tapez « variable d’environnement » dans la zone de recherche de Windows et cliquez sur **Modifier variable d’environnement**

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.005.png)

- Sélectionnez variables d’environnement

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.006.png)

- Cliquez sur nouvelle pour ajouter une nouvelle JAVA\_HOME variable 

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.007.png)

- Remplir les champs de la nouvelle variable :
- Nom de la variable : **JAVA\_HOME**
- Valeur de la variable : votre version java se trouve à l’emplacement suivant ->  **${HOME}/.sdkman/candidates/java/current**
- Cliquez sur OK

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.008.png)

- Dans variables système sélectionnez **Path** puis cliquez sur modifier 
- Cliquez sur le bouton nouvelle et Ajouter ceci **%JAVA\_HOME%\bin**

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.009.png)

- Pour tester, ouvrir une invite de commande et tapez **java -version**

` `![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.010.png)
1. # **Maven**
Lancez git bash et Exécutez la commande suivante pour installer Maven

sdk install maven

*NB : installez Maven 3.8.5 ou supérieur*

Pour tester tapez **mvn -v**

![](images/Aspose.Words.8b4d2ceb-f566-4c6b-8c7c-c62ca769a2d5.011.png)

- Sur votre ligne de commande, exécutez la commande Maven suivante :

mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

- Dans le dossier **.m2** Ajouter le fichier settings.xml
1. # **Eclipse**
Cliquez sur ce lien pour installez la dernière version Eclipse : <https://eclipse.mirror.rafal.ca/oomph/epp/2022-03/R/eclipse-inst-jre-win64.exe>

Plugins a installer : [Plugins Eclipse](https://github.com/innovds/gescom-wiki/blob/development/eclipse/README.md)
1. # **Postman**
Pour installez Postman cliquez sur ce lien : <https://dl.pstmn.io/download/latest/win64>
1. # ` `**NodeJs / Nvm**
- Installez Nodejs sur Windows :  [NodejsCurrent](https://nodejs.org/dist/v18.0.0/node-v18.0.0-x64.msi)

- Installez **nvm** sur Windows : [nvm.zip](https://github.com/coreybutler/nvm-windows/releases/download/1.1.9/nvm-setup.zip)

Exécuter cette commande pour installer la dernière version nvm : 

nvm install latest
1. # ` `**Visual studio code**
Lien d’installation du vscode : <https://az764295.vo.msecnd.net/stable/dfd34e8260c270da74b5c2d86d61aee4b6d56977/VSCodeUserSetup-x64-1.66.2.exe>


