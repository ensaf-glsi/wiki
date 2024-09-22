### Introduction à Maven

#### 1. **Qu'est-ce que Maven ?**

Maven est un outil de gestion de projets Java principalement utilisé pour automatiser la construction (build) d'applications. Il permet de gérer les dépendances, de compiler le code, de tester, et de déployer les projets facilement. Maven utilise un fichier de configuration central, le `pom.xml` (Project Object Model), pour gérer toutes les phases de développement d’un projet.

#### 2. **Caractéristiques principales de Maven**
   - **Gestion des dépendances :** Maven télécharge automatiquement les bibliothèques externes nécessaires à votre projet à partir de dépôts comme Maven Central.
   - **Cycle de vie de construction (build lifecycle) :** Maven gère les différentes étapes de construction, comme la compilation, les tests, l'empaquetage (packaging), et le déploiement.
   - **Convention sur la configuration :** Avec Maven, le projet est structuré selon des conventions standard. Vous n'avez pas besoin de tout configurer manuellement.

#### 3. **Installation de Maven**


#### 4. **Structure d’un projet Maven**

   Voici la structure typique d'un projet Maven :
   ```
   my-app/
   ├── pom.xml
   └── src/
       ├── main/
       │   └── java/     # Code source principal
       └── test/
           └── java/     # Code source des tests
   ```

#### 5. **Le fichier `pom.xml`**

Le `pom.xml` est le cœur de Maven. Voici un exemple de base de `pom.xml` :
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    
    <dependencies>
        <!-- Exemple de dépendance, ici JUnit pour les tests -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```
   - **groupId** : Identifie l’organisation ou l’entreprise (ex : `com.example`).
   - **artifactId** : Nom unique du projet (ex : `my-app`).
   - **version** : Version du projet (ex : `1.0-SNAPSHOT`).
   - **dependencies** : Section pour déclarer les bibliothèques dont dépend votre projet.

#### 6. **Commandes Maven de base**

   - **Compiler le projet :** `mvn compile`
   - **Lancer les tests :** `mvn test`
   - **Construire le package (jar/war) :** `mvn package`
   - **Nettoyer le projet (supprimer les fichiers compilés) :** `mvn clean`
   - **Télécharger les dépendances :** `mvn dependency:resolve`

#### 7. **Cycle de vie de Maven**
   Maven possède plusieurs phases dans son cycle de vie de construction :
   - **validate** : Valider que le projet est correct et toutes les informations sont disponibles.
   - **compile** : Compiler le code source.
   - **test** : Exécuter les tests unitaires.
   - **package** : Emballer le code compilé dans un format redistribuable, comme un JAR.
   - **install** : Installer le package dans le dépôt local.
   - **deploy** : Copier le package final dans un dépôt distant.

#### 8. **Avantages de Maven**
   - Standardisation de la structure des projets.
   - Gestion automatique des dépendances.
   - Intégration facile avec des outils de CI/CD (Jenkins, GitLab CI, etc.).
   - Gestion des versions et des versions instantanées (SNAPSHOT).

#### 9. **Exemple de dépendances utiles**
Voici quelques exemples de bibliothèques couramment utilisées dans un projet Maven :
   - **Spring Boot** :
   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter</artifactId>
   </dependency>
   ```
   - **Hibernate** :
   ```xml
   <dependency>
       <groupId>org.hibernate</groupId>
       <artifactId>hibernate-core</artifactId>
       <version>5.4.32.Final</version>
   </dependency>
   ```

