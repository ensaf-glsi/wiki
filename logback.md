### Introduction à Logback

#### 1. **Qu'est-ce que Logback ?**

**Logback** est un framework de journalisation (logging) pour les applications Java. Il est couramment utilisé dans les projets Spring Boot et est le successeur de **log4j**. Logback est optimisé pour la performance, la flexibilité, et propose une gestion fine des logs grâce à des configurations avancées. Il est intégré par défaut dans Spring Boot, ce qui le rend simple à utiliser sans configuration supplémentaire.

#### 2. **Pourquoi utiliser un système de journalisation ?**

Voici les principaux avantages d'utiliser un système de journalisation comme Logback par rapport à l'utilisation de simples instructions `System.out.print` :

1. **Contrôle des niveaux de log** : Avec Logback, tu peux définir des niveaux de journalisation (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`) pour filtrer les informations selon leur importance. Par exemple, tu peux activer les logs détaillés en phase de développement, et les désactiver ou les limiter à l'essentiel en production. `System.out.print` ne propose pas cette gestion fine des niveaux.

2. **Redirection des logs vers plusieurs destinations** : Logback permet d'envoyer les logs vers différentes destinations (console, fichiers, bases de données, systèmes distants comme Logstash, etc.). `System.out.print`, en revanche, ne gère que la sortie sur la console.

3. **Performance** : Logback est conçu pour être plus performant. Par exemple, il peut écrire les logs de manière asynchrone, ce qui minimise l'impact sur les performances. À l'inverse, `System.out.print` effectue une écriture immédiate sur la console, ce qui peut ralentir ton application, surtout si elle génère beaucoup de logs.

4. **Formatage flexible des logs** : Logback permet de configurer des formats personnalisés pour les messages de log à l'aide de *patterns*. Par exemple, tu peux inclure la date, le niveau de log, le thread, etc. Avec `System.out.print`, tu dois formater chaque message manuellement.

5. **Gestion des exceptions (stack traces)** : Logback gère automatiquement les exceptions avec leurs traces complètes (`stack traces`), facilitant le diagnostic des erreurs. Avec `System.out.print`, cette gestion est plus compliquée et manuelle.

6. **Rotation et archivage des logs** : Logback peut archiver et faire tourner les fichiers de logs automatiquement lorsqu'ils atteignent une certaine taille ou après un certain temps. Cela permet de maintenir une taille raisonnable des logs sans effort manuel. `System.out.print` ne prend pas en charge cette fonctionnalité.

7. **Intégration avec des systèmes de supervision** : Logback peut s'intégrer facilement avec des solutions comme ELK (Elasticsearch, Logstash, Kibana) pour analyser et centraliser les logs. Cette intégration est cruciale pour superviser et diagnostiquer des problèmes dans des environnements complexes comme les microservices. Avec `System.out.print`, il faut ajouter des couches supplémentaires pour atteindre ce niveau d'intégration.

### Différences principales entre Logback et `System.out.print`

| **Caractéristique**               | **Logback**                                          | **System.out.print**                              |
|-----------------------------------|------------------------------------------------------|---------------------------------------------------|
| **Niveaux de log**                | Prise en charge des niveaux (INFO, DEBUG, ERROR, etc.) | Pas de gestion des niveaux                        |
| **Destinations multiples (appenders)** | Console, fichiers, systèmes distants                 | Uniquement la console                             |
| **Rotation des logs**             | Automatique, configurable (par taille, date, etc.)    | Doit être gérée manuellement                      |
| **Gestion des exceptions**        | Gestion native des exceptions avec stack trace       | Nécessite une gestion manuelle                    |
| **Performance**                   | Optimisé pour la performance                         | Plus lent en raison de l'écriture synchrone       |
| **Intégration avec d'autres outils** | Intégration facile avec ELK, Logstash, etc.          | Pas d'intégration native                          |
| **Formatage flexible**            | Formatage hautement configurable avec des patterns   | Formatage basique, manuel                         |

---

#### 3. **Installation de Logback**

Si tu utilises **Spring Boot**, Logback est déjà intégré par défaut, et il n'est pas nécessaire de l'ajouter manuellement dans ton projet.

Pour un projet Java sans Spring Boot, tu peux inclure Logback en ajoutant les dépendances dans le fichier `pom.xml` :

```xml
<dependencies>
    <!-- SLF4J avec Logback -->
    <dependency>
        <groupId>ch.qos.logback</groupId>
        <artifactId>logback-classic</artifactId>
        <version>1.2.3</version>
    </dependency>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
        <version>1.7.30</version>
    </dependency>
</dependencies>
```

#### 4. **Configuration de Logback**

La configuration de Logback se fait généralement à l’aide d’un fichier `logback.xml` placé dans `src/main/resources`. Voici un exemple de configuration basique :

```xml
<configuration>

    <!-- Définition d'un appender console -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- Définition d'un appender fichier -->
    <appender name="FILE" class="ch.qos.logback.core.FileAppender">
        <file>logs/myapp.log</file>
        <append>true</append>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- Configuration du logger racine -->
    <root level="info">
        <appender-ref ref="STDOUT" />
        <appender-ref ref="FILE" />
    </root>

</configuration>
```

##### Explication des éléments :
   - **Appender** : Un appender est une destination où les logs sont envoyés (console, fichier, etc.). Ici, on a un appender console (`STDOUT`) et un appender fichier (`FILE`).
   - **Pattern** : Définit le format des logs. Par exemple, `%d` pour la date, `%level` pour le niveau de log, `%msg` pour le message, etc.
   - **Root Logger** : Le logger racine, qui capture tous les logs de l'application, est configuré avec un niveau de log `INFO` et référence les appenders console et fichier.

#### 5. **Niveaux de journalisation (Logging Levels)**

Logback prend en charge plusieurs niveaux de journalisation. Voici les niveaux les plus courants :
   - **TRACE** : Niveau le plus détaillé, utilisé pour suivre le flux d’exécution.
   - **DEBUG** : Informations détaillées sur le comportement du programme.
   - **INFO** : Informations générales (niveau par défaut).
   - **WARN** : Avertissements, situations potentiellement problématiques.
   - **ERROR** : Erreurs graves nécessitant une attention particulière.
   - **OFF** : Désactive la journalisation.

#### 6. **Configurer un appender de fichier rotatif**

Logback permet de configurer des fichiers de log qui tournent ou s'archivent automatiquement. Par exemple, pour créer un fichier de log journalier avec une conservation de 30 jours :

```xml
<appender name="ROLLING" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <file>logs/myapp.log</file>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <fileNamePattern>logs/myapp-%d{yyyy-MM-dd}.log</fileNamePattern>
        <maxHistory>30</maxHistory>
    </rollingPolicy>
    <encoder>
        <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
    </encoder>
</appender>

<root level="info">
    <appender-ref ref="ROLLING" />
</root>
```

#### 7. **Utilisation dans le code**

Logback est utilisé via l'API **SLF4J**, qui permet une flexibilité d'utilisation. Exemple simple de journalisation dans une classe Java :

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyApp {
    private static final Logger logger = LoggerFactory.getLogger(MyApp.class);

    public static void main(String[] args) {
        logger.info("Application started");
        logger.debug("Debugging information");
        logger.warn("Warning message");
        logger.error("Error message", new Exception("Sample exception"));
    }
}
```
