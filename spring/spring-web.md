### **Spring Web - Développement d'API REST (Spring 3)**

---

#### **1. Introduction à Spring Web et REST**
- **Spring Web** fournit un framework pour le développement d'applications web, notamment la création d'**API REST**.
- Une **API REST** (Representational State Transfer) permet la communication entre un client et un serveur via des **requêtes HTTP** (GET, POST, PUT, DELETE, PATCH), pour accéder et manipuler des ressources.

---

#### **2. Annotations Clés dans Spring Web**
À partir de **Spring 3**, de nouvelles annotations sont introduites pour simplifier le développement des API REST, notamment :

- **@RestController** :
    - Cette annotation combine **`@Controller` + `@ResponseBody`**.
    - Cela signifie que chaque méthode renvoie directement un objet Java qui sera automatiquement sérialisé en JSON ou XML, sans avoir besoin d'une vue (comme JSP ou Thymeleaf).

- **@PostMapping**, **@GetMapping**, **@PutMapping**, **@DeleteMapping**, @PatchMapping :
    - Ces annotations sont des raccourcis pour `@RequestMapping` avec un attribut `method` spécifique.
    - Par exemple, **`@PostMapping`** est équivalent à **`@RequestMapping(method = RequestMethod.POST)`**.

- **@RequestBody** :
    - Cette annotation permet de lier le **corps de la requête** (généralement au format JSON) à un objet Java.

- **@PathVariable** :
    - Utilisée pour capturer les variables dynamiques dans l'URL et les utiliser comme paramètres de méthode.

---

#### **3. Création d'une API REST avec Spring 3**

Voici un exemple de gestion des ressources **"Car"** :

##### **a. Déclaration du modèle**
```java
public class Car {
    private Long id;
    private String make;
    private String model;
    private int year;

    // Getters et Setters
}
```

##### **b. Création du contrôleur REST avec @RestController et @PostMapping, @GetMapping, ...**
```java
@RestController
@RequestMapping("/cars")
public class CarController {

    private Map<Long, Car> carDatabase = new HashMap<>();

    // Récupérer la liste de toutes les voitures
    @GetMapping
    public List<Car> getAllCars() {
        return new ArrayList<>(carDatabase.values());
    }

    // Récupérer une voiture par son ID
    @GetMapping("/{id}")
    public Car getCarById(@PathVariable("id") Long id) {
        return carDatabase.get(id);
    }

    // Créer une nouvelle voiture
    @PostMapping
    public Car createCar(@RequestBody Car car) {
        car.setId(new Random().nextLong());
        carDatabase.put(car.getId(), car);
        return car;
    }

    // Mettre à jour une voiture
    @PutMapping("/{id}")
    public Car updateCar(@PathVariable("id") Long id, @RequestBody Car car) {
        car.setId(id);
        carDatabase.put(id, car);
        return car;
    }

    // Supprimer une voiture
    @DeleteMapping("/{id}")
    public void deleteCar(@PathVariable("id") Long id) {
        carDatabase.remove(id);
    }
}
```

##### **Explication des points importants** :
- **@RestController** : Cette annotation combine les comportements de `@Controller` et `@ResponseBody`. Ainsi, toutes les méthodes du contrôleur retournent directement des objets qui seront automatiquement convertis en JSON (ou en XML) dans la réponse HTTP.
- **@GetMapping**, **@PostMapping**, **@PutMapping**, **@DeleteMapping** : Ces annotations sont des raccourcis pour définir les points d'accès aux méthodes HTTP spécifiques (GET, POST, PUT, DELETE) :
    - **@GetMapping** = `@RequestMapping(method = RequestMethod.GET)`
    - **@PostMapping** = `@RequestMapping(method = RequestMethod.POST)`
    - **@PutMapping** = `@RequestMapping(method = RequestMethod.PUT)`
    - **@DeleteMapping** = `@RequestMapping(method = RequestMethod.DELETE)`
- **@RequestBody** : Permet de lier le corps d'une requête (par exemple, les données JSON envoyées par le client) à un objet Java.
- **@PathVariable** : Capture une variable dans l'URL (comme l'ID d'une voiture) et la passe en paramètre à la méthode.

---

#### **4. Gestion des Méthodes HTTP dans Spring 3**

Spring 3 fournit des annotations spécifiques pour chaque méthode HTTP. Ces méthodes sont directement mappées aux opérations CRUD (Create, Read, Update, Delete) dans une API REST :

- **GET** : Pour récupérer une ou plusieurs ressources.
- **POST** : Pour créer une nouvelle ressource.
- **PUT** : Pour mettre à jour une ressource existante.
- **DELETE** : Pour supprimer une ressource.

##### Exemple d'utilisation :
```java
// Récupérer toutes les ressources
@GetMapping
public List<Car> getAllCars() {
    return carService.findAll();
}

// Créer une ressource
@PostMapping
public Car createCar(@RequestBody Car car) {
    return carService.save(car);
}

// Mettre à jour une ressource
@PutMapping("/{id}")
public Car updateCar(@PathVariable("id") Long id, @RequestBody Car car) {
    return carService.update(id, car);
}

// Supprimer une ressource
@DeleteMapping("/{id}")
public void deleteCar(@PathVariable("id") Long id) {
    carService.delete(id);
}
```

---

#### **5. Gestion des Exceptions dans une API REST**
Une API REST doit gérer les erreurs correctement et renvoyer des messages significatifs. Spring 3 permet d'ajouter des gestionnaires d'exceptions via l'annotation **@ExceptionHandler** :

```java
@RestController
@RequestMapping("/cars")
public class CarController {

    @ExceptionHandler(CarNotFoundException.class)
    public ResponseEntity<String> handleCarNotFound(CarNotFoundException ex) {
        return new ResponseEntity<>("Car not found: " + ex.getMessage(), HttpStatus.NOT_FOUND);
    }

    // Autres méthodes...
}
```

- **@ExceptionHandler** : Permet de capturer et de gérer les exceptions spécifiques (ici `CarNotFoundException`) et de retourner une réponse personnalisée avec un code d'erreur HTTP comme **404 Not Found**.

---

#### **6. Sérialisation en JSON**
Spring 3 utilise la bibliothèque **Jackson** pour convertir automatiquement les objets Java en **JSON**. Avec l'annotation **@RestController**, Spring 3 convertira automatiquement les objets retournés par les méthodes du contrôleur en JSON (si la dépendance Jackson est présente dans le classpath).

##### Exemple de dépendance Maven pour Jackson :
```xml
<dependency>
    <groupId>org.codehaus.jackson</groupId>
    <artifactId>jackson-mapper-asl</artifactId>
    <version>1.9.13</version>
</dependency>
```