# Découverte de Java

---

## Sommaire

- Introduction à Java
- Environnement de développement Java
- Les bases de Java
- Les structures de contrôle en Java
- Programmation orientée objet en Java
- La gestion des exceptions en Java
- Multithreading en Java
- La programmation réseau avec Java
- L'accès aux bases de données avec JDBC
- Les nouveautés de Java (dernières versions)
- Cas pratiques – Projets en Java

---

## Introduction à Java

1. Historique de Java
2. Les principes fondamentaux
3. La plateforme Java (JRE, JDK, JVM)

----

### 1. Historique de Java

- Apparu en 1995, Java a été développé par Sun Microsystems.
- L'objectif était de créer un langage de programmation portable pouvant être exécuté sur n'importe quel appareil avec une machine virtuelle.
- Originairement appelé "Oak", il a été renommé "Java" en référence à l'île de Java, en Indonésie, connue pour son café.

Exemple de code (pas directement lié à l'histoire mais un rappel nostalgique) :
```java
// Java 1.0
public class AppletHelloWorld extends java.applet.Applet {
    public void paint(java.awt.Graphics g) {
        g.drawString("Hello, world!", 5, 25);
    }
}
```
----

### 2. Les principes fondamentaux

- "Write Once, Run Anywhere" (WORA) : Indépendance de la plateforme grâce à la JVM.
- Java est à la fois compilé (en bytecode) et interprété par la JVM.
- Conçu comme un langage orienté objet (OOP), Java encourage la modularité et l'organisation du code.

Exemple de code montrant la syntaxe de base et l'OOP:
```java
public class Animal {
    private String name;

    public Animal(String name) {
        this.name = name;
    }

    public void makeSound() {
        System.out.println("Some sound!");
    }

    public static void main(String[] args) {
        Animal cat = new Animal("Cat");
        cat.makeSound(); // Output: Some sound!
    }
}
```
----

### 3. La plateforme Java (JRE, JDK, JVM)

- **JVM (Java Virtual Machine)** : L'entité d'exécution du bytecode Java, garantissant la portabilité.
- **JDK (Java Development Kit)** : Kit complet pour développer des applications Java, inclut le JRE.
- **JRE (Java Runtime Environment)** : Nécessaire pour exécuter des applications Java, contient la JVM et les bibliothèques de classe standard.

Exemple de code (pour démontrer la compilation et l'exécution) :
```java
// Save as HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}

// Commande pour compiler:
// javac HelloWorld.java
// Commande pour exécuter:
// java HelloWorld
```

---

## Environnement de développement Java

1. Installation du JDK et du JRE
2. Les IDE populaires : IntelliJ IDEA, Eclipse
3. Premier programme "Hello, World!"
4. Introduction à Maven et Gradle pour la gestion des dépendances

---

## Les bases de Java

1. Variables et types de données
2. Opérateurs en Java
3. Saisie et sortie console
4. Structures de données de base : List, Set, Map

---

## Les structures de contrôle en Java

1. Structures conditionnelles (`if`, `switch`)
2. Boucles (`for`, `while`, `do-while`)
3. `break` et `continue`

---

## Programmation orientée objet en Java

1. Introduction à l'OOP
2. Classes et objets
3. Héritage et polymorphisme
4. Encapsulation
5. Abstraction et interfaces
6. Paquets (Packages) et la visibilité
7. Les principes SOLID

---

## La gestion des exceptions en Java

1. Introduction aux exceptions
2. Bloc `try-catch`
3. La clause `finally`
4. Création d'exceptions personnalisées

---

## Multithreading en Java

1. Introduction au multithreading
2. Création de threads
3. Synchronisation des threads
4. Communication entre threads

---

## L'accès aux bases de données avec JDBC

1. Introduction à JDBC
2. Connexion à une base de données
3. Exécution de requêtes SQL
4. Gestion des transactions

---

## La programmation réseau avec Java

1. Notions de réseau
2. Sockets en Java
3. Programmation client-serveur
4. Les URL et la classe `URLConnection`

---

## Les nouveautés de Java (dernières versions)

1. Les nouveautés de Java 8 à Java 17
2. Les expressions lambda et les streams
3. Modules en Java
4. Enregistrements, types d'union scellés, classes d'instance locale

---

## Cas pratiques – Projets en Java

1. Création d'une application de gestion de bibliothèque
   - Objectif : Apprendre à gérer des données et des utilisateurs
2. Application de gestion de tâches avec base de données
   - Objectif : Connexion à une base de données et gestion des données

---

## Ressources supplémentaires

- [Oracle Java Documentation](https://docs.oracle.com/en/java/)
- [Java Tutorials by Oracle](https://docs.oracle.com/javase/tutorial/)
- [Effective Java by Joshua Bloch](https://www.oreilly.com/library/view/effective-java/9780134686097/)
- [Java Brains Tutorials](https://javabrains.io/)
- [Java Programming for Complete Beginners](https://www.udemy.com/course/java-programming-for-complete-beginners/)
- [Stack Overflow - Java Section](https://stackoverflow.com/questions/tagged/java)
