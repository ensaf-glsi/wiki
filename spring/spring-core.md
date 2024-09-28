### **Spring Core - Présentation**

---

#### **1. Spring Conteneur Léger**
- **Qu'est-ce que c'est ?**
    - Spring est un **framework léger** qui fournit une infrastructure complète pour le développement d'applications Java.
    - Le **conteneur** Spring gère le cycle de vie des objets de l'application et les assemble à l'aide de l'injection de dépendances.

- **Pourquoi léger ?**
    - Il ne nécessite pas de conteneur d'application lourd (comme un serveur d'application Java EE).
    - Fonctionne de manière modulaire, tu ne charges que ce dont tu as besoin.

---

#### **2. Inversion of Control (IoC)**
- **Concept clé** : C’est un **design pattern** dans lequel l'exécution du flux de contrôle est inversée.
    - Au lieu que le code appelle les dépendances explicitement, c'est le **conteneur Spring** qui injecte les dépendances dans les classes.

- **Deux types d’IoC :**
    - **Injection de dépendances par constructeur**
    - **Injection de dépendances par setter**

---

#### **3. Injection de Dépendances (DI)**
- **Qu'est-ce que c'est ?**
    - Le framework Spring permet de **déléguer la création et la gestion des dépendances** à un conteneur.
    - L'injection de dépendances est réalisée soit via un **constructeur**, soit via des **setters** ou directement avec des annotations.

- **Avantages :**
    - Favorise une faible **couplage** entre les composants.
    - Facilite les tests unitaires en permettant de **mocker** facilement les dépendances.

---

#### **4. Les Annotations Clés : @Component, @Service, @Repository, @Controller**
- **@Component** : C’est l’annotation de base pour déclarer un **bean géré par Spring**. C'est un composant générique.

- **@Service** : Spécifique pour les **services métier**. Utilisé pour la couche de service de l'application.

- **@Repository** : Spécifique à la **couche d'accès aux données** (DAO). Il simplifie la gestion des exceptions.

- **@Controller** : Utilisé pour définir un **contrôleur** dans les applications Spring MVC.

> **Note :** Ces annotations permettent à Spring de découvrir et de gérer les beans automatiquement via le mécanisme de **scanning**.

---

#### **5. L'annotation @Bean**
- Utilisée dans une classe annotée avec `@Configuration` pour **définir un bean manuellement**.

```java
@Configuration
public class AppConfig {

    @Bean
    public MyService myService() {
        return new MyServiceImpl();
    }
}
```

- **Différence avec @Component** :
    - `@Component` est utilisé pour une découverte **automatique** de beans, tandis que `@Bean` permet de **déclarer explicitement** les beans dans une classe de configuration.

---

#### **6. L'annotation @Configuration**
- Utilisée pour marquer une classe qui **définit des beans** dans le conteneur Spring.

```java
@Configuration
public class MyConfig {
    
    @Bean
    public MyBean myBean() {
        return new MyBean();
    }
}
```

- Cette annotation indique que la classe contient une ou plusieurs méthodes annotées avec `@Bean`, qui seront gérées par le conteneur Spring.

---

#### **7. Cycle de Vie d’un Bean**
- Les étapes clés dans le cycle de vie d’un bean Spring :
    - **Instantiation** : Le conteneur crée une instance du bean.
    - **Injection des dépendances** : Le conteneur injecte les dépendances.
    - **Custom Initialization** : Si un bean implémente `InitializingBean`, la méthode `afterPropertiesSet()` est appelée.
    - **Destruction** : Si un bean implémente `DisposableBean`, la méthode `destroy()` est appelée avant sa destruction.

---

#### **8. Exemple de Code : Application avec Injection de Dépendances**
```java
@Component
public class MyService {
    public void performTask() {
        System.out.println("Task performed!");
    }
}

@Configuration
public class AppConfig {
    
    @Bean
    public MyService myService() {
        return new MyService();
    }
}

public class MainApp {
    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        MyService myService = context.getBean(MyService.class);
        myService.performTask();
    }
}
```

---

#### **9. Autowiring avec @Autowired**
- **@Autowired** permet d’injecter automatiquement une dépendance.

```java
@Service
public class MyService {
    
    private final MyRepository myRepository;
    @Autowired
    private MyRespository2 myRespository2;

    public MyService(MyRepository myRepository) {
        this.myRepository = myRepository;
    }
}

@Service
@RequiredArgsConstructor
public class MyService {

  private final MyRepository myRepository;
  private final MyRespository2 myRespository2;

}

```

- **Avantages** :
    - Simplifie l’injection des dépendances.
    - **Spring** analyse automatiquement les dépendances à injecter.

