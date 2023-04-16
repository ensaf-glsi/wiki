# Rêgles

## Definition de l'URI
- L'URI de l'API est définie en utilisant le nom de l'objet ciblé **au pluriel** quelle que soit l'action effectuée par l'API : `/api/v1/cars` ou `/api/v1/persons`. Afin de conserver une cohérence entre le nom, la table et l'API, on évitera d'utiliser des abréviations ou des initiales sauf si c'est ainsi que la table a été définie.
- Pour séparer des mots, il faut des "-" et non des "_". L'utilisation "camelCase" (minuscule sans espace avec une majuscule en début de mot), ne doit pas être utilisée non plus: `/api/v1/gear-boxes`
- Il ne faut pas utiliser de verbe mais seulement des noms dans les URI. C'est la méthode HTTP qui permet de définir l'action qui est effectuée par l'API.

## Les méthodes HTTP
  - `POST` permet la création d'une donnée. Un **POST implique toujours qu'un nouvel enregistrement sera persisté**. En cas de sauvegarde réussie, l'URL permettant récupérer l'objet et l'objet tel qu'il a été persisté en base, c'est-à-dire avec son identifiant, doivent être retourné au client. En cas de succès, la méthode HTTP POST doit retourner un code HTTP **201** (= `Created`).
  - `PUT` permet la mise à jour complète d'un objet. Un code retour **200** (= `OK`) est retourné au client lorsque l'opération se passe correctement.  Il n'est pas obligatoire de retourner l'objet persisté puisqu'il est censé être égal à celui envoyé par le client mais il est possible de le faire.
  - `PATCH` permet la mise à jour partielle d'un objet. En cas de succès, le WS doit retourner un code **200**. Ici non plus il n'est pas obligatoire de retourner l'objet persisté.
  - `GET` permet de récupérer un objet ou une liste d'objets. Un code HTTP **200** est attendu lorsque la requête se déroule sans problème. Le GET ne doit servir qu'à la récupération de données. Une API avec une méthode **GET ne doit pas modifier d'enregistrement**.
  - `DELETE` permet la suppression d'un objet. Une suppression réussie retourne un code HTTP **204** (=`No Content`)


# Quelques exemples

Prenons un exemple s'articulant autour de 2 tables : `car` et `person`. Une personne pouvant posséder 0, 1 ou n voitures mais une voiture ne peut avoir qu'un seul propriétaire.

## Création d'une nouvelle voiture
`POST /v1/cars` 
- L'objet est passé dans le corps de la requête HTTP (`@RequestBody Car car`).

## Mise à jour complète d'une voiture
`PUT /v1/cars/{id}`
- L'identifiant de l'objet modifié est passé dans le path (`@PathVariable Long id`)
- L'objet contenant les données est passé dans le corps de la requête HTTP (`@RequestBody Car car`).

## Mise à jour partielle d'une voiture
`PATCH /v1/cars/{id}`
- L'identifiant de l'objet modifié est passé dans le path (`@PathVariable Long id`)
- Le(s) élément(s) à modifier est(sont) passé(s) dans le corps de la requête HTTP (`@RequestBody float length`). Il est possible de définir un DTO light pour passer plusieurs champs.

## Récupération d'une voiture

### Par son identifiant
`GET /v1/cars/{id}`
- L'identifiant de l'objet recherché est passé dans le path (`@PathVariable Long id`)
- le WS doit retourner un unique objet. Si l'objet n'est pas trouvé un code d'erreur **404** (=`Not found`) est retourné au client car une recherche par identifiant sous-entend que l'enregistrement est censé exister. 
**_Remarque:_** La classe `AbstractMuseController` (dont **tous les controller doivent hériter**) permet de gérer automatiquement une `ObjectNotFoundException` afin de la transformer en erreur 404.

On peut même aller plus loin:
`GET /v1/persons/{id}/cars/{carId}`
- Ici, on cherche une voiture avec un identifiant particulier liée à une personne particulière. On aura donc 2 informations à récupérer depuis le path : `@PathVariable Long id` et `@PathVariable Long carId`
- La non présence de la personne ou de la voiture dans la liste des voitures liées à la personne entraine une erreur **404**.

## Récupération d'une liste de voitures

### Toutes les voitures
`GET /v1/cars`
- Toutes les voitures présentes en base sont retournées.
- Si aucune voiture n'est présente, la réponse est vide mais le code HTTP reste **200**.

### Voitures par son nombre de places
`GET /v1/cars-by-seats`
- L'élement de filtre est passé paramètre HTTP (`@RequestParam int seats`).
- le WS doit retourner un code **200** et une liste d'objets `Car` contenant 0, 1 ou plusieurs entrées. Ici, le fait de ne pas trouver de résultat n'est pas considéré comme une erreur car il s'agit d'un critère de filtre et pas d'une récupération par identifiant. Le fait de ne trouver aucun résultat correspondant au critère n'est pas nécessairement une erreur.

### Voitures par propriétaire
Dans ce cas, il y a deux manières de faire:
#### Par l'API `cars`
`GET /v1/cars-by-owner-id`
- L'élement de filtre est passé paramètre HTTP (`@RequestParam Long ownerId`). Il est important que le nom du paramètre soit `ownerId` et non `id` afin qu'aucune confusion ne soit possible.
- le WS doit retourner un code **200** et une liste l'objets `Car` contenant 0, 1 ou plusieurs entrées.

#### Par l'API `persons`
`GET /v1/persons/{id}/cars/`
- L'identifiant de la personne est passé dans le path (`@PathVariable Long id`)
- le WS doit retourner un code d'erreur **404** si la personne n'existe pas.
