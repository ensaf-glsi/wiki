# Découverte de React

---

## Sommaire

- Introduction à React
- Environnement de développement React
- **Création et imbrication de composants**
- **Rédaction de balisage avec JSX**
- **Ajout de styles**
- **Affichage de données**
- **Affichage conditionnel**
- **Affichage de listes**
- **Réaction aux événements**
- **Mise à jour de l'écran**
- **Utilisation des Hooks**
- **Partage de données entre composants**
- Cas pratiques – Projets en React
- Gestion de l'état global avec Redux et Context

---

## Introduction à React

1. Historique de React
2. Pourquoi React ?
3. La plateforme React et l'ecosysteme

----

### 1. Historique de React - 1/2

#### **Origines de React**

- Développé et introduit par Facebook en 2013.
- Créé pour améliorer la performance et la maintenabilité des interfaces utilisateur sur Facebook et Instagram.

#### **Evolution et croissance**

- Open-sourcé lors de la conférence JSConf US en mai 2013.
- Gain rapide en popularité en raison de son approche unique et performante pour construire des interfaces utilisateur.
- Adoption par de grandes entreprises et intégration dans des projets majeurs.
  
----

### 2. Pourquoi React?

#### **Modularité et composabilité**

- Construisez des applications en assemblant des composants réutilisables.

#### **Performances optimisées**

- Le DOM virtuel permet à React de rendre les mises à jour de manière plus efficace.

#### **Unidirectional Data Flow**

- Les données dans React suivent un flux unidirectionnel, rendant le code plus prévisible et facile à débugger.

#### **Communauté et écosystème**

- Une grande communauté active et un riche écosystème d'outils et de bibliothèques complémentaires.

----

### 3. La plateforme React et l'écosystème

#### **React DOM**

- Permet à React de se connecter et d'interagir avec le DOM du navigateur web.

#### **React Native**

- Construisez des applications mobiles natives pour iOS et Android en utilisant la même base de code React.

#### **Autres outils et bibliothèques**

- **Redux**: Pour la gestion de l'état global.
- **React Router**: Gestion du routage dans les applications React.
- **Next.js**: Framework pour le rendu côté serveur avec React.
- **Et plus encore**: L'écosystème React ne cesse de croître avec l'ajout de nouvelles bibliothèques et outils.

---

## Environnement de développement React

1. Configuration initiale
2. Outils essentiels
3. Création d'un nouveau projet avec Vite

----

### 1. Configuration initiale

#### **Installation de Node.js et NPM**

- **Node.js**: React utilise Node.js pour gérer les dépendances et exécuter différents scripts. Assurez-vous d'avoir la version LTS de Node.js installée. Vous pouvez télécharger Node.js depuis [leur site officiel](https://nodejs.org/).
- **NPM (Node Package Manager)** : Il est généralement installé avec Node.js. Il s'agit d'un gestionnaire de paquets utilisé pour installer des bibliothèques et des outils nécessaires.

Pour vérifier que tout est bien installé :

```bash
node -v
npm -v
```

----

### 2. Outils essentiels

#### **Navigateur web**

- Un navigateur moderne comme Google Chrome, Mozilla Firefox ou Microsoft Edge.

#### **Éditeur de code**

- **Visual Studio Code (VS Code)** : C'est un éditeur de code léger mais puissant avec un excellent support pour React et JSX. Il est conseillé d'installer l'extension "ES7+ React/Redux/React-Native snippets" pour faciliter le développement avec React et [autres extensions (Linter, Prettier, ...)](https://react.dev/learn/editor-setup)

#### **Outils de développement (DevTools)**

- **React DevTools**: Une extension de navigateur pour inspecter le rendu de vos composants React.

----

### 3. Création d'un nouveau projet avec Vite

Vite est un outil de construction qui offre un démarrage rapide et des performances optimales pour le développement. Il est particulièrement adapté aux applications React modernes.

1. Pour initialiser un nouveau projet React avec Vite, exécutez la commande :
```bash
npm create vite@latest
```
2. Suivez les instructions et sélectionnez "React" comme framework lorsqu'il vous est demandé.
3. Une fois que le processus est terminé, naviguez dans votre nouveau projet avec :
```bash
cd nom-du-projet
```
4. Pour démarrer le serveur de développement :
```bash
npm run dev
```

Absolument. Voici la même section avec le code en anglais mais le contenu explicatif traduit en points :

---

## Création et imbrication de composants - 1/2

- Les applications React sont composées de composants.
- Un composant est une partie de l'interface utilisateur (UI) ayant sa propre logique et apparence.
- Un composant peut être aussi petit qu'un bouton ou aussi grand qu'une page entière.

**Exemple de composant React :**

```js
function MyButton() {
  return (
    <button>I'm a button</button>
  );
}
```

- Une fois que vous avez déclaré `MyButton`, vous pouvez l'intégrer dans un autre composant.

----

## Création et imbrication de composants - 2/2

**Exemple d'imbrication de composants :**

```js
export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```

**Points clés à retenir :**

1. Remarquez que `<MyButton />` commence par une majuscule. C'est ainsi que vous savez que c'est un composant React.
2. Les noms des composants React doivent toujours commencer par une majuscule, tandis que les balises HTML doivent être en minuscules.
3. Les mots-clés `export default` spécifient le composant principal du fichier.

> 📝 **Remarque :** Si vous n'êtes pas familier avec certaines syntaxes de JavaScript, consultez [MDN](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export) et [javascript.info](https://javascript.info/import-export).


---

## Rédaction de balisage avec JSX 1/2

- La syntaxe de balisage que nous avons vue dans le slide précédent est appelée JSX.
- Bien qu'elle soit optionnelle, la majorité des projets React utilisent JSX pour sa commodité.
- Tous les outils que nous recommandons pour le développement local prennent en charge JSX nativement.

**Quelques spécificités de JSX :**

- JSX est plus strict que HTML. Par exemple, vous devez fermer certaines balises comme `<br />`.
- Un composant ne peut pas retourner plusieurs balises JSX à la racine. Vous devez les envelopper dans un parent commun, comme `<div>...</div>` ou un conteneur vide `<>...</>`.

----

## Rédaction de balisage avec JSX 2/2

**Exemple d'utilisation du conteneur vide :**

```javascript
function AboutPage() {
  return (
    <>
      <h1>About</h1>
      <p>Hello there.<br />How do you do?</p>
    </>
  );
}
```

> **Remarque :** Si vous avez beaucoup de HTML à convertir en JSX, vous pouvez utiliser [ce convertisseur](https://transform.tools/html-to-jsx).


D'accord, voici la traduction et la mise en forme en points pour l'intégrer à votre support :

---

## Ajout de styles

- Dans React, vous spécifiez une classe CSS avec `className`. Cela fonctionne de la même manière que l'attribut `class` en HTML :
  ```jsx
  <img className="avatar" />
  ```
- Ensuite, vous écrivez les règles CSS pour cette classe dans un fichier CSS séparé :
  ```css
  /* Dans votre fichier CSS */
  .avatar {
    border-radius: 50%;
  }
  ```
- React ne prescrit pas la manière dont vous ajoutez des fichiers CSS. Dans le cas le plus simple, vous ajouterez une balise `<link>` à votre HTML.
- Si vous utilisez un outil de construction ou un framework, consultez sa documentation pour savoir comment ajouter un fichier CSS à votre projet.


---

## Affichage des données 1/2

- JSX vous permet d'insérer du balisage dans JavaScript. Les accolades vous permettent de "revenir" à JavaScript afin d'intégrer une variable de votre code et de l'afficher à l'utilisateur. Par exemple, ceci affichera `user.name` :
  ```jsx
  return (
    <h1>
      {user.name}
    </h1>
  );
  ```
- Vous pouvez également "passer à JavaScript" depuis les attributs JSX, mais vous devez utiliser des accolades au lieu de guillemets. Par exemple, `className="avatar"` passe la chaîne "avatar" comme classe CSS, mais `src={user.imageUrl}` lit la valeur de la variable JavaScript `user.imageUrl`, puis passe cette valeur comme attribut `src` :
  ```jsx
  return (
    <img
      className="avatar"
      src={user.imageUrl}
    />
  );
  ```

----

## Affichage des données 2/2

- Vous pouvez également insérer des expressions plus complexes à l'intérieur des accolades JSX, par exemple, [une concaténation de chaînes](https://javascript.info/operators#string-concatenation-with-binary) :
  ```jsx
  const user = {
    name: 'Hedy Lamarr',
    imageUrl: 'https://i.imgur.com/yXOvdOSs.jpg',
    imageSize: 90,
  };

  export default function Profile() {
    return (
      <>
        <h1>{user.name}</h1>
        <img
          className="avatar"
          src={user.imageUrl}
          alt={'Photo de ' + user.name}
          style={{
            width: user.imageSize,
            height: user.imageSize
          }}
        />
      </>
    );
  }
  ```
- Dans l'exemple ci-dessus, `style={{}}` n'est pas une syntaxe spéciale, mais un objet `{}` ordinaire à l'intérieur des accolades JSX `style={ }`. Vous pouvez utiliser l'attribut `style` lorsque vos styles dépendent de variables JavaScript.
- **À propos de la syntaxe `style`** : Lors de l'utilisation de l'attribut `style` en JSX, il est important de noter que vous devez utiliser le camelCase pour les noms de propriétés CSS (background-color" -> "backgroundColor").

---

## Rendu conditionnel - 1/2

Dans React, il n'y a pas de syntaxe spéciale pour écrire des conditions. Au lieu de cela, vous utiliserez les mêmes techniques que vous utilisez lors de la rédaction de code JavaScript classique. Par exemple, vous pouvez utiliser une instruction [if](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/if...else) pour inclure conditionnellement du JSX :

```javascript
let content;
if (isLoggedIn) {
    content = <AdminPanel />;
} else {
    content = <LoginForm />;
}
return (
    <div>
        {content}
    </div>
);
```

Si vous préférez un code plus compact, vous pouvez utiliser [l'opérateur conditionnel `?`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator). Contrairement à `if`, il fonctionne à l'intérieur du JSX :

```jsx
<div>
    {isLoggedIn ? (
      <AdminPanel />
    ) : (
      <LoginForm />
    )}
</div>
```

----

## Rendu conditionnel - 2/2

Lorsque vous n'avez pas besoin de la branche `else`, vous pouvez également utiliser [une syntaxe logique `&&`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_AND#short-circuit_evaluation) plus courte :

```jsx
<div>
    {isLoggedIn && <AdminPanel />}
</div>
```

---

## Rendu de listes

Pour le rendu de listes dans React, vous vous baserez sur des fonctionnalités JavaScript telles que [la boucle `for`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for) et [la fonction `map()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) des tableaux pour afficher des listes de composants.

- Imaginons que vous ayez un tableau de produits :
```javascript
const products = [
    { title: 'Chou', id: 1 },
    { title: 'Ail', id: 2 },
];
```
- À l'intérieur de votre composant, utilisez la fonction `map()` pour transformer un tableau de produits en un tableau d'éléments `<li>` :

```jsx
const listItems = products.map(product =>
    <li key={product.id}>
      {product.title}
    </li>
);
return (
    <ul>{listItems}</ul>
);
```

- Remarquez comment l'élément `<li>` possède un attribut `key`. Pour chaque élément d'une liste, vous devez passer une chaîne ou un nombre qui identifie de manière unique cet élément parmi ses frères et sœurs. En général, une clé devrait provenir de vos données, comme un ID de base de données. React utilise vos clés pour savoir ce qui s'est passé si vous insérez, supprimez ou réorganisez les éléments ultérieurement.

---

## Répondre aux événements

- Dans React, vous pouvez répondre aux événements en déclarant des fonctions de gestion des événements à l'intérieur de vos composants.
- Voici un exemple d'un bouton qui affiche une alerte lorsqu'il est cliqué :

```jsx
function MyButton() {
    function handleClick() {
      alert('Vous m'avez cliqué !');
    }

    return (
      <button onClick={handleClick}>
        Cliquez-moi
      </button>
    );
}
```

- Notez bien la syntaxe `onClick={handleClick}` : elle n'a pas de parenthèses à la fin ! Ne pas appeler la fonction de gestion de l'événement directement ; vous devez uniquement la passer en tant que référence. React se chargera d'appeler votre gestionnaire d'événement lorsque l'utilisateur cliquera sur le bouton.
