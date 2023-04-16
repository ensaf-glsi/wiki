# Généralité

## Variables, constantes et enum : nommage

- variable : minuscules en "camel case". Exemples : `status`, `humanResource`, `code` ou `technicalDocument`
- constantes et enum : majuscules avec des "_". Exemples : `STATUS`, `HUMAN_RESOURCE`, `CODE` ou `TECHNICAL_DOCUMENT`

On peut ainsi avoir 
```java
public static final String HUMAN_RESOURCE = "humanResource";
public static final String STATUS = "status";
```

## Aggrégation de chaînes de caractères
En Java, les chaînes de caractères sont **inaltérables**. Cela signifie que toute opération de concaténation faite avec l'opérateur `+` ou `+=` aboutie à la création d'une nouvelle instance de `String`. Pas de soucis lorsqu'il s'agit de faire l'opération un petit nombre de fois mais lorsque le nombre de concaténations augmente, la dégradation de performance est énorme.

### La classe `StringBuilder`
Prenons l'exemple du tableau suivant :
```java
String[] stringArray = new String[number];
for (int i = 0; i < number; i++) {
    stringArray[i] = "The value of the number is " + i + ".\n";
}
```
On cherche à concaténer toutes les valeurs du tableau. Le code suivant fonctionne mais est à **proscrire** :
```java
for (int i = 0; i < number; i++) {
    result += stringArray[i]; // Not correct
}
```
Afin de concaténer des chaînes de caractères, il faut utiliser la classe `StringBuilder` (ou `StringBuffer` si risque d'accès concurrent ce qui est assez rare). Ainsi, notre code devient :
```java
StringBuilder build = new StringBuilder(number);
for (int i = 0; i < number; i++) {
    builder.append(stringArray[i]); // Correct
}
```
Une fois les concaténations terminées, un appel à la méthode `toString()` permet de récupérer le résultat depuis le `StringBuilder`

### Petit test de performances

J'ai fait quelques tests pour mesurer l'écart de performances que l'on obtient en partant du code précédent. Les valeurs ne sont pas très précises et elles varient évidemment en fonction de la machine et de sa charge au moment du test, mais elles donnent une idée de l'écart qui existe entre les deux façons de faire :

| Nombre d'occurrences de la boucle | Temps pour `+` en **µs** | Temps pour `append` en **µs** | Conclusion |
|--|--|--|--|
| 150 | 997 | 0 | Avec un temps inférieur à la microseconde, les temps de la méthode `+` sont aléatoires mais restent compris entre 0 et 1ms alors que pour `append` on reste toujours à 0|
| 1000 | 23 935 | 0 | Le temps du `+` a nettement augmenté alors que pour le `append` cela reste non mesurable |
| 5000| 455 782 | 998,6 | Le temps du `append` apparait de façon aléatoire, comme cela était le cas pour le `+` avec 150 occurrences. On peut estimer le ratio de performances entre les deux méthodes à au moins 450 à ce moment du traitement |
| 10 000| 1 055 307| 997 | Le temps du `+` ne cesse de grimper et atteint la seconde alors que le `append` reste autour de la milliseconde |
| 20 000 | 3 033 925| 995 | 3 secondes pour le `+` contre moins d'une milliseconde pour le `append` |
| 30 000 | 6 092 791 | 2 993 | On est désormais à 6 secondes pour le `+` alors que le `append` est à environ 3 ms soit un ratio de 2 000 |


### Pour aller plus loin
- Un `StringBuilder` est par défaut initialiser avec une taille de 16 caractères. Lorsque la concaténation nécessite une taille supérieur, l'objet est réalloué automatiquement avec une taille plus importante. C'est pourquoi il est utile de spécifier une taille au constructeur afin de limiter ces réaffectations. Et il est préférable de prévoir un peu trop grand (sans exagérer) qu'un peu trop petit.
- Le `StringBuilder` permet d'autres opérations sur une chaîne de caractères comme 
  - supprimer une partie d'une chaine de caractères : `delete(int start, int end)`
  - supprimer un caractère : `deleteCharAt(int index)`
  - insérer une String ou un type primitif à une position donnée : `insert(int offset, String str)`, `insert(int offset, long l)`...
  - remplacer : `replace​(int start, int end, String str)`
- Il ne faut pas faire de concaténation de chaînes à l'aide de `+` à l'intérieur d'un `append`. 

### D'autres concaténations
- Lorsqu'il s'agit de concaténer les éléments d'un tableau avec un séparateur, il existe d'autres façon de procéder notamment `String result = String.join(separator, stringArray);`. Mais cette manière reste sensiblement moins performante que le `StringBuilder` (environ 5 fois plus lent).
- La méthode `String.format` peut être utiliser pour formater des messages avec des arguments :
  - le résultat de `String.format("The code of this object is '%s'", code)` est "The code of this object is 'object.code'"
  - le résultat de `String.format("The price of this object is %d €", 12500)` est "The price of this object is 12500 €"




## string.contains() / string.startWith() / string.endWith()


## Autoboxing/unboxing

L’autoboxing consiste à transformer un type primitif en objet wrapper équivalent et l’inboxing fait l’inverse. L’autoboxing transforme par exemple un `int` en `Integer`, un `char` en `Character`, un `boolean` en `Boolean` ou un `long` en `Long`. Pour plus d’explication, voir [ici](https://docs.oracle.com/javase/tutorial/java/data/autoboxing.html).
Il vaut néanmoins rester prudent car il existe une différence fondamentale entre les types primitifs et les objets : les objets peuvent être nuls alors qu’un type primitif a obligatoirement une valeur. Ainsi, le code suivant ne posera aucun problème de compilation mais causera systématiquement un NullPointerException.
```java
Long longObj = null;
long longPrimitif = longObj;
```
Pas de risque de ce type avec l’unboxing, mais il faut garder à l’esprit que cette opération aboutie à l’instanciation d’un objet ce qui, à force, peut avoir un impact sur les performances. Par exemple, le code suivant fonctionne mais n’est pas pertinent car impose d’initialiser un Integer qui ne sert à rien.
```java
Integer varA = 7899;
int varB = 225;
int result = varB + varA;
```
De même, il faut faire attention lors de la déclaration des paramètres d'une méthode : 
```java
public long sum(Long a, Long b) {
    return a + b;
}
```
Dans la méthode ci-dessus, il y a risque de `NullPointerException` puisque `a` et `b` sont des `Long` et peuvent donc être nuls alors qu'il n'y a aucun risque dans la méthode suivante :
```java
public long sum(long a, long b) {
    return a + b;
}
```

# Repository

## Méthodes countByXxx()
On a parfois besoin de compter le nombre d'occurrences en base en fonction de certains critères. Lorsqu'on a pas besoin d'accéder aux objets, il ne faut jamais utiliser un `findByXxx` pour compter. A cette fin, il est possible de définir des méthodes `countByXxx`. Elles permettent de récupérer le nombre d'occurrences présentes en base en fonction des critères adéquats. Ces méthodes doivent **retourner un `long` et non un `Long`** car la valeur n'est jamais égale à `null`.

## Méthodes existsByXxx()
Il est parfois nécessaire de s'assurer de la présence en base d'une occurrence en fonction de certains critères sans avoir besoin de l'objet en lui-même. Dans ce cas, il est hors de question d'utiliser un `findByXxx` qui va instancier un objet qui ne servira pas. Il faut utiliser une méthode `existsByXxx` qui retourne directement un `boolean` parfaitement adapté à notre besoin.
Par exemple, la méthode `public boolean existsById(ID);` est automatiquement définie dans toutes les classes repository. Il est possible d'en ajouter selon le même principe que le méthodes `findByXxx()`

A COMPLETER

# Service

A COMPLETER

# Controller

## Création d'objet
Ces appels sont réservés aux créations en base de données et doivent être exécuté avec le verbe HTTP **POST**. Dans le cas d'une sauvegarde OK, le code HTTP de retour attendu est 201 (created) et non 200 (OK).

## Object non trouvé
Lorsqu'une action (récupération via un **GET**, mise à jour via un **PUT** / **PATCH** ou suppression via un **DELETE**) est demandée sur un objet, il faut retourner un code erreur HTTP **404** si l'objet n'est pas présent en base.

A COMPLETER