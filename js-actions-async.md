# 1. Introduction aux Actions Asynchrones

## Définition de l'Asynchronisme en Programmation

L'asynchronisme, en programmation, fait référence à la capacité d'exécuter des tâches ou des opérations de manière non-séquentielle, ou sans bloquer l'exécution du programme principal. En d'autres termes, dans un environnement asynchrone, certaines opérations peuvent être lancées et se dérouler en arrière-plan, permettant au programme de continuer à s'exécuter sans attendre que ces opérations soient terminées.

Cette approche est cruciale dans des environnements où les temps de réponse sont incertains ou potentiellement longs, comme les requêtes de réseau, les opérations de lecture/écriture de fichiers, ou toute autre opération dépendant de ressources externes ou de processus lents.

### Caractéristiques Clés
- **Non-blocage** : Le programme principal continue de s'exécuter pendant que les opérations asynchrones se déroulent en parallèle.
- **Gestion des événements** : Les programmes asynchrones reposent souvent sur des mécanismes d'écoute et de réponse aux événements (event listeners and handlers).
- **Concurrence** : Plusieurs opérations peuvent se dérouler simultanément, améliorant potentiellement l'efficacité et la performance du programme.

## Exemples de Situations Asynchrones

1. **Requêtes Web (AJAX) :**
   - Lorsqu'une application web fait une requête à un serveur (par exemple, pour charger des données), elle utilise des appels AJAX asynchrones. Cela permet à l'utilisateur de continuer à interagir avec l'application pendant que la requête est en cours.

   ```js
   fetch('https://api.exemple.com/data')
     .then(response => response.json())
     .then(data => console.log(data));
   ```

2. **Lecture/Ecriture de Fichiers :**
   - En Node.js, par exemple, la lecture ou l'écriture de fichiers peut se faire de manière asynchrone pour éviter de bloquer le thread principal pendant que l'opération sur le fichier est réalisée.

   ```js
   const fs = require('fs');

   fs.readFile('/chemin/vers/le/fichier', (err, data) => {
     if (err) throw err;
     console.log(data);
   });
   ```

3. **Timers et Delais :**
   - Les fonctions comme `setTimeout` ou `setInterval` en JavaScript permettent d'exécuter du code après un certain délai ou à des intervalles réguliers, sans bloquer le reste du code.

   ```js
   setTimeout(() => {
     console.log("Exécuté après 2 secondes");
   }, 2000);
   ```

4. **Opérations sur les Bases de Données :**
   - Les requêtes vers les bases de données, surtout dans le cadre des bases de données distantes, sont souvent effectuées de manière asynchrone pour ne pas immobiliser l'application pendant l'attente des résultats.

En résumé, l'asynchronisme permet aux applications de rester réactives et efficaces, en évitant les blocages inutiles et en gérant efficacement les opérations qui prennent du temps. Dans les sections suivantes, nous explorerons les différentes manières de gérer l'asynchronisme en JavaScript, à travers des callbacks, des promesses, et l'utilisation de async/await.

# 2. Callbacks

## Qu'est-ce qu'un Callback?

Un callback en programmation, et particulièrement en JavaScript, est une fonction qui est passée en tant qu'argument à une autre fonction, et qui est exécutée à un certain moment du processus de cette dernière. C'est une manière basique de gérer les opérations asynchrones. Les callbacks sont souvent utilisés pour continuer l'exécution du code après qu'une opération asynchrone (comme une requête de réseau ou une lecture de fichier) soit terminée.

### Caractéristiques des Callbacks
- **Fonctions de Rappel** : Ils sont essentiellement des fonctions qui sont appelées en réponse à un certain événement ou une condition.
- **Passés en tant qu'arguments** : Les callbacks sont passés à une autre fonction en tant qu'arguments.
- **Exécution différée** : Ils ne sont exécutés qu'après l'achèvement d'une tâche asynchrone.

## Exemple Basique avec `setTimeout`

Un exemple simple de l'utilisation d'un callback est la fonction `setTimeout` en JavaScript :

```js
setTimeout(() => {
  console.log("Exécuté après 2 secondes");
}, 2000);
```
Ici, la fonction fléchée `() => console.log("Exécuté après 2 secondes")` est un callback qui est exécuté après un délai de 2 secondes.

## Problèmes avec les Callbacks (Callback Hell)

L'utilisation de multiples callbacks, en particulier pour des opérations asynchrones dépendantes les unes des autres, peut conduire à ce qu'on appelle le "Callback Hell" ou "Pyramide de Doom". Cela se produit lorsque plusieurs callbacks sont imbriqués les uns dans les autres, ce qui rend le code difficile à lire et à maintenir.

```js
fs.readFile('fichier1.txt', function(err, data1) {
  if (err) throw err;
  fs.readFile('fichier2.txt', function(err, data2) {
    if (err) throw err;
    // ... Plus d'opérations imbriquées
  });
});
```

Voici comment un callback peut être utilisé pour gérer une réponse de requête REST asynchrone :


```js
function makeRequest(url, callback) {
  const xhr = new XMLHttpRequest();
  xhr.open("GET", url);
  xhr.onload = function() {
    if (xhr.status === 200) {
      callback(null, xhr.responseText);
    } else {
      callback(new Error(xhr.statusText));
    }
  };
  xhr.onerror = function() {
    callback(new Error("Erreur réseau"));
  };
  xhr.send();
}

makeRequest('https://api.example.com/data1', function(error1, response1) {
  if (error1) {
    console.error("Erreur lors de la première requête:", error1);
  } else {
    // Traitement de la première réponse
    makeRequest('https://api.example.com/data2?param=' + response1, function(error2, response2) {
      if (error2) {
        console.error("Erreur lors de la seconde requête:", error2);
      } else {
        // Traitement de la seconde réponse
        makeRequest('https://api.example.com/data3?param=' + response2, function(error3, response3) {
          if (error3) {
            console.error("Erreur lors de la troisième requête:", error3);
          } else {
            // Traitement de la troisième réponse
            // Et ainsi de suite...
          }
        });
      }
    });
  }
});
```

# 3. Promises

## Introduction aux Promises

Une Promise en JavaScript est un objet qui représente la complétion éventuelle, ou l'échec, d'une opération asynchrone et sa valeur résultante. Contrairement aux callbacks, les Promises fournissent une meilleure gestion des opérations asynchrones, permettant d'écrire un code plus propre et plus lisible, notamment grâce à la chaîne de méthodes `.then()` et `.catch()`.

### Caractéristiques des Promises
- **État**: Une Promise peut se trouver dans l'un des trois états : en attente (pending), accomplie (fulfilled), ou rejetée (rejected).
- **Immutabilité**: Une fois qu'une Promise est résolue ou rejetée, son état ne peut plus changer.
- **Chaînage**: Les Promises permettent de chaîner plusieurs opérations asynchrones de manière plus lisible.

## Création d'une Promise

Voici comment on peut créer une Promise :

```js
const aPromise = new Promise((resolve, reject) => {
  const condition = true; // Remplacez ceci par une condition réelle

  if (condition) {
    resolve("La Promise est résolue.");
  } else {
    reject("La Promise est rejetée.");
  }
});
```

## Utilisation de `.then()` et `.catch()`

Une fois la Promise créée, vous pouvez utiliser `.then()` pour gérer le résultat en cas de réussite, et `.catch()` pour gérer les erreurs :

```js
aPromise
  .then(result => {
    console.log(result); // Exécuté si la Promise est résolue
  })
  .catch(error => {
    console.error(error); // Exécuté si la Promise est rejetée
  });
```

## Exemple de Transformation d'un `setTimeout` Imbriqué en Promises

Pour transformer un `setTimeout` imbriqué en Promises, vous pouvez procéder comme suit :

```javascript
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

sleep(2000)
  .then(() => {
    console.log("Terminé après 2 secondes");
    return sleep(1000); // Attente supplémentaire de 1 seconde
  })
  .then(() => {
    console.log("Terminé après 3 secondes au total");
  });
```

Dans cet exemple, la fonction `sleep` retourne une Promise qui se résout après un certain délai, permettant d'effectuer des actions en séquence sans créer une structure de code profondément imbriquée.

Les Promises sont un élément clé pour écrire du code asynchrone en JavaScript. Elles offrent une approche plus structurée et flexible que les callbacks. Dans la section suivante, nous explorerons comment `async` et `await` peuvent simplifier encore davantage la manipulation des Promises.


# 4. Async/Await

## Simplification du Code Asynchrone avec Async/Await

`async` et `await` sont des ajouts modernes à JavaScript qui simplifient la lecture et l'écriture de code asynchrone. Ils permettent de travailler avec des Promises de manière plus synchrone, rendant le code plus clair et plus facile à comprendre.

### Fonction `async`

- Une fonction déclarée avec le mot-clé `async` retourne toujours une Promise. Si la fonction renvoie une valeur qui n'est pas une Promise, elle est automatiquement enveloppée dans une Promise.
- À l'intérieur d'une fonction `async`, vous pouvez utiliser `await` pour attendre la résolution d'une Promise.

### Mot-clé `await`

- `await` ne peut être utilisé qu'à l'intérieur des fonctions `async`. Il met la fonction en pause jusqu'à ce que la Promise attendue soit résolue ou rejetée.
- Il rend le code asynchrone plus lisible, car il permet d'écrire des instructions asynchrones de manière séquentielle.

## Utilisation de `async` et `await` avec les Promises

Voici un exemple simple :

```js
async function loadData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json();
    console.log("Données chargées :", data);
    return data;
  } catch (error) {
    console.error("Erreur lors du chargement des données :", error);
  }
}
```

Dans cet exemple, `loadData` est une fonction `async`. Grâce à `await`, le code attend la réponse de `fetch(url)` avant de continuer. Si une erreur se produit, elle est capturée par le bloc `try...catch`.

## Exemple avec Requête REST Asynchrone

```js
async function fetchDataInSequence(urls) {
  let results = [];

  for (const url of urls) {
    const data = await fetch(url).then(response => response.json());
    console.log(`Données de ${url} chargées`);
    results.push(data);
  }

  return results;
}

const urls = [
  'https://api.example.com/data1',
  'https://api.example.com/data2'
];

fetchDataInSequence(urls).then(results => {
  console.log("Toutes les données ont été chargées en séquence", results);
});
```

Dans ce cas, les requêtes sont exécutées séquentiellement. Chaque `await` attend la fin de la requête courante avant de passer à la suivante.

## Avantages sur les Promises et Callbacks

- **Lisibilité améliorée** : Le code ressemble à des opérations synchrones classiques, ce qui le rend plus facile à comprendre.
- **Gestion des erreurs** : Les blocs `try...catch` permettent une gestion des erreurs similaire à celle du code synchrone.
- **Contrôle de flux** : `async`/`await` offre un contrôle de flux plus naturel, en particulier pour des séquences d'opérations asynchrones.

L'utilisation d'`async` et `await` est un moyen puissant de gérer l'asynchronisme en JavaScript, en particulier pour ceux qui préfèrent une approche plus linéaire et moins imbriquée que celle des Promises et des callbacks.

