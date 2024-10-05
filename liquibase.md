## **Introduction à Liquibase avec Spring Boot**

### **Qu'est-ce que Liquibase ?**
- Liquibase est un outil de gestion de base de données open-source permettant de versionner et gérer les schémas de manière flexible.
- Il supporte de multiples formats pour décrire les changements de base de données : XML, YAML, JSON et SQL.

### **Pourquoi utiliser Liquibase ?**
- Versionner les schémas de base de données de manière similaire au code source.
- Gérer les migrations de manière automatique lors du déploiement d’applications Spring Boot.
- Maintenir un historique des changements avec des rollbacks faciles à gérer.

---

## **Liquibase avec Spring Boot**

1. **Intégration avec Spring Boot**
    - Liquibase peut être intégré facilement dans Spring Boot via les dépendances Maven ou Gradle.
    - Spring Boot détecte automatiquement les fichiers de migration et applique les changements à la base de données au démarrage.

   **Exemple de dépendance Maven :**
   ```xml
   <dependency>
       <groupId>org.liquibase</groupId>
       <artifactId>liquibase-core</artifactId>
   </dependency>
   ```

2. **Configurer les logs en XML**
   Vous pouvez configurer les logs dans un fichier `logback.xml` pour suivre les migrations appliquées par Liquibase.

   **Exemple de fichier `logback.xml` :**
   ```xml
   <configuration>
       <appender name="FILE" class="ch.qos.logback.core.FileAppender">
           <file>liquibase.log</file>
           <encoder>
               <pattern>%d{yyyy-MM-dd HH:mm:ss} - %msg%n</pattern>
           </encoder>
       </appender>

       <logger name="liquibase" level="INFO" additivity="false">
           <appender-ref ref="FILE" />
       </logger>

       <root level="INFO">
           <appender-ref ref="FILE" />
       </root>
   </configuration>
   ```

---

## **Formats de fichiers supportés par Liquibase**

### 1. **XML**
XML est le format par défaut de Liquibase, offrant une grande flexibilité et de nombreuses fonctionnalités.

**Exemple de fichier `db.changelog.xml` :**
   ```xml
   <databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
       http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd">

       <changeSet id="1" author="auteur">
           <createTable tableName="person">
               <column name="id" type="int">
                   <constraints primaryKey="true" />
               </column>
               <column name="nom" type="varchar(255)" />
           </createTable>
       </changeSet>
   </databaseChangeLog>
   ```

### 2. **SQL**
Liquibase permet également d'utiliser du SQL natif pour les changements.

**Exemple de fichier SQL `db.changelog.sql` :**
   ```sql
   --liquibase formatted sql
   --changeset auteur:1
   CREATE TABLE person (
       id INT PRIMARY KEY,
       nom VARCHAR(255)
   );
   ```

### 3. **YAML**
Liquibase supporte aussi YAML, un format léger et facile à lire.

**Exemple de fichier `db.changelog.yaml` :**
   ```yaml
   databaseChangeLog:
     - changeSet:
         id: 1
         author: auteur
         changes:
           - createTable:
               tableName: person
               columns:
                 - column:
                     name: id
                     type: int
                     constraints:
                       primaryKey: true
                 - column:
                     name: nom
                     type: varchar(255)
   ```

---

## **Commandes utiles de Liquibase**

1. **Appliquer les changements :**
   ```bash
   ./mvnw liquibase:update
   ```

2. **Rollback (annulation des derniers changements) :**
   ```bash
   ./mvnw liquibase:rollback -Dliquibase.rollbackCount=1
   ```

## **Balises XML les plus utilisées**

1. **`changeSet`**
    - Il s'agit de la balise de base qui regroupe les changements à apporter à la base de données. Chaque `changeSet` est identifié par un `id` unique et un `author`.
    - Liquibase applique chaque `changeSet` une seule fois.

   **Exemple :**
   ```xml
   <changeSet id="1" author="auteur">
       <!-- Contenu du changement -->
   </changeSet>
   ```

2. **`createTable`**
    - Crée une nouvelle table dans la base de données avec des colonnes définies.

   **Exemple :**
   ```xml
   <changeSet id="2" author="auteur">
       <createTable tableName="employee">
           <column name="id" type="int">
               <constraints primaryKey="true" nullable="false"/>
           </column>
           <column name="name" type="varchar(255)">
               <constraints nullable="false"/>
           </column>
       </createTable>
   </changeSet>
   ```

3. **`addColumn`**
    - Ajoute de nouvelles colonnes à une table existante.

   **Exemple :**
   ```xml
   <changeSet id="3" author="auteur">
       <addColumn tableName="employee">
           <column name="email" type="varchar(255)" />
       </addColumn>
   </changeSet>
   ```

4. **`dropTable`**
    - Supprime une table de la base de données.

   **Exemple :**
   ```xml
   <changeSet id="4" author="auteur">
       <dropTable tableName="obsolete_table"/>
   </changeSet>
   ```

5. **`renameTable`**
    - Renomme une table existante.

   **Exemple :**
   ```xml
   <changeSet id="5" author="auteur">
       <renameTable oldTableName="employee" newTableName="staff"/>
   </changeSet>
   ```

6. **`addForeignKeyConstraint`**
    - Ajoute une contrainte de clé étrangère entre deux tables.

   **Exemple :**
   ```xml
   <changeSet id="6" author="auteur">
       <addForeignKeyConstraint baseTableName="employee"
                                baseColumnNames="department_id"
                                referencedTableName="department"
                                referencedColumnNames="id"
                                constraintName="fk_employee_department"/>
   </changeSet>
   ```

7. **`createIndex`**
    - Crée un index sur une ou plusieurs colonnes d'une table.

   **Exemple :**
   ```xml
   <changeSet id="7" author="auteur">
       <createIndex tableName="employee" indexName="idx_employee_name">
           <column name="name"/>
       </createIndex>
   </changeSet>
   ```

8. **`dropColumn`**
    - Supprime une colonne d'une table.

   **Exemple :**
   ```xml
   <changeSet id="8" author="auteur">
       <dropColumn tableName="employee" columnName="middle_name"/>
   </changeSet>
   ```

9. **`modifyDataType`**
    - Modifie le type de données d'une colonne.

   **Exemple :**
   ```xml
   <changeSet id="9" author="auteur">
       <modifyDataType tableName="employee" columnName="salary" newDataType="decimal(10,2)"/>
   </changeSet>
   ```

10. **`insert`**
    - Insère une nouvelle ligne dans une table.

    **Exemple :**
    ```xml
    <changeSet id="10" author="auteur">
        <insert tableName="employee">
            <column name="id" value="1"/>
            <column name="name" value="John Doe"/>
            <column name="department_id" value="2"/>
        </insert>
    </changeSet>
    ```

11. **`update`**
    - Met à jour les valeurs existantes dans une table.

    **Exemple :**
    ```xml
    <changeSet id="11" author="auteur">
        <update tableName="employee">
            <column name="name" value="Jane Doe"/>
            <where>id=1</where>
        </update>
    </changeSet>
    ```

12. **`delete`**
    - Supprime des lignes spécifiques d'une table.

    **Exemple :**
    ```xml
    <changeSet id="12" author="auteur">
        <delete tableName="employee">
            <where>id=1</where>
        </delete>
    </changeSet>
    ```

13. **`sql`**
    - Permet d’exécuter directement des commandes SQL personnalisées.

    **Exemple :**
    ```xml
    <changeSet id="13" author="auteur">
        <sql>UPDATE employee SET salary = salary * 1.1 WHERE department_id = 2</sql>
    </changeSet>
    ```

14. **`rollback`**
    - Définit une action à effectuer en cas de rollback (annulation) d’un changement.

    **Exemple :**
    ```xml
    <changeSet id="14" author="auteur">
        <insert tableName="employee">
            <column name="id" value="2"/>
            <column name="name" value="Jane Roe"/>
        </insert>
        <rollback>
            <delete tableName="employee">
                <where>id=2</where>
            </delete>
        </rollback>
    </changeSet>
    ```
