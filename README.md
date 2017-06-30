Présentation:
Ce projet est un mini prototype d'un projet de fin d'études http://labs.redlean.io/project/perio-machine-learning/ proposé par la société Redlean http://redlean.io/eng/ .

Ce projet consiste à prédire les codes de traitements médicaux à partir d’un arbre de décision, dans le but d'aider les médecins à prendre leurs décisions et avoir une prévision sur les traitements à réaliser pour un état de santé et une infection bien déterminés du patient en consultation.
En général, un arbre de décision est un graphique qui permet de représenter les choix et leurs résultats sous la forme d'un arbre. Les nœuds du graphique représentent un événement ou un choix et les bords du graphique représentent les règles ou les conditions de décision. 

 Ce projet contient trois fichiers :
 
-	Le modèle de données : est un fichier de type csv et représente la  base de connaissance qui contient le code médicaux à prédire, l’infection, l’âge du patient ainsi que d’autres données collectées de son bilan médical qui ont une grande influence sur le choix de l’acte telles-que le diabète, l’hypertension, le pacemaker, les crises, le dialyse, la pathologie, la thyroïdienne, la spasmophilie, la dermatologie, le saignement spontané, les problèmes cardiaques, le rhumatisme, l’asthme, la pathologie de foie, l’hypatie.

-	Le fichier « ctree.R » : est un script R permettant d’avoir un arbre de décision en utilisant la commande« ctree»

-	Le fichier « rpart.R » : est un script R permettant d’avoir un arbre de décision en utilisant  la commande« rpart»

Etapes d’exécution

-	Télecharger et installer R: The R Project for Statistical Computing https://cran.r-project.org/.

-	Ouvrir l’environnement R.

-	Récupérer les scripts « ctree.R », « rpart.R » et le modele de données.

-	Exécuter le script R en tapant la commande « source ("schéma/rpart.R") » ou « source ("schéma/ctree.R") »

-	 Exécuter le script R étape par étape :

•	Installer le package « party» pour créer l’arbre de décision avec ctree ou le package « rpart » et « rpart. Plot » pour créer l’arbre de décision avec rpart en tapant la commande « install.packages("party") » ou « install.packages("rpart") » puis « install.packages("rpart.plot") »

•	Accéder au modèle de données en exécutant la commande suivante DataAct<-read.csv(file.choose(),header=T,sep=','), la commande file.choose () de R permet d’ouvrir le fichier CSV, l'en-tête ici est vraie car le fichier CSV possède une en-tête et sep = "," spécifie que les données sont séparées par des virgules.

•	Afficher les données de la variable « DataAct » contenant le modèle de données avec la commande « str(DataAct) ».

![1](https://user-images.githubusercontent.com/29728117/27640810-1f411204-5c12-11e7-8544-ad08c3571c88.PNG)

•	Créer l’arbre de décision en tapant la commande :

model<-rpart(CODE_Medical~., DataAct,method="class") 
Ou 
model <- ctree(CODE_Medical ~ ., data=DataAct, control=ctree_control())

La syntaxe de base pour créer un arbre de décision avec « ctree » est « ctree(formula, data) » et la description des paramètres utilisés  est comme suit : formula est une formule décrivant le prédicteur et les variables de réponse, data est le modèle de données utilisé.

La syntaxe de base pour créer un arbre de décision avec « rpart » est « rpart (formula , data = , method =, control =) » où Formula = résultat ~ predictor1 + predictor2 + predictor3 + ect, data = spécifie le modèle de données, On spécifie method = "Classe" pour un arbre de classification et "anova" pour un arbre de régression,  control = spécifie des paramètres optionnels pour contrôler la croissance de l'arbre. Par exemple, control = rpart.control (minsplit = 30, cp = 0.001) exige que le nombre minimal d'observations dans un noeud soit 30 avant de tenter une division et qu'une division doit diminuer le manque global d'ajustement d'un facteur de 0,001 (Facteur de complexité des coûts) avant d'être tenté.

•	Afficher l’arbre de décision (texte) avec la commande « print(model)»

![2](https://user-images.githubusercontent.com/29728117/27641152-f7b8238e-5c12-11e7-872b-8adf66df7032.PNG)

•	Afficher l’arbre de décision (graphique) avec la commande « plot(model,uniform=TRUE,main="Classification Tree with rpart")»
Ou « plot(model,uniform=TRUE,main="Classification Tree with ctree")»

![4](https://user-images.githubusercontent.com/29728117/27641401-986b40b8-5c13-11e7-8b12-60ec601eb4d4.PNG)

uniform : si TRUE, arbre avec arêtes verticales toutes de même longueur, sinon, en fonction de l'erreur liée au split (défaut = FALSE).

•	Examiner les résultats ou le bon nombre de feuilles avec la validation croisée grâce à la fonction « printcp »  pour le script « rpart.R» (texte)

![3](https://user-images.githubusercontent.com/29728117/27641552-1db49c74-5c14-11e7-804f-72e660d7a2d9.png)

•	Examiner les résultats ou le bon nombre de feuilles avec la validation croisée grâce à la fonction « plotcp »  pour le script « rpart.R» (graphique)

![5](https://user-images.githubusercontent.com/29728117/27641670-73c78a9a-5c14-11e7-9be0-2c4654ee758a.PNG)

La courbe indique le taux de mauvaises classifications relativement au score d'origine (dans un arbre réduit à une seule feuille dans laquelle la décision correspond à la classe majoritaire), estimé par la validation croisée. Les barres d'erreur autour de chaque estimation sont aussi obtenues par validation croisée. L'axe des abscisses indique la complexité de l'arbre par l'intermédiaire du nombre de feuilles.

•	Le package rpart propose des fonctions d'affichage relativement limitées. On préfère donc s'appuyer sur rpart.plot, en particulier sur sa fonction prp. La figure ci-dessous est obtenue par le simple appel suivant : prp(model,extra=1)

![6](https://user-images.githubusercontent.com/29728117/27641739-a8095428-5c14-11e7-88f6-cfcf5a49e938.PNG)

•	Réaliser des prévisions sur de nouvelles données, en s'appuyant sur la fonction predict. Par défaut, la fonction estime les probabilités d'appartenance aux classes pour chaque observation (simplement par le ratio dans la feuille correspondante), en tapant la commande suivante : « predict(model, type="class")»

![7](https://user-images.githubusercontent.com/29728117/27641790-d5738546-5c14-11e7-954c-ce67b3b7c9d0.PNG)

•	Evaluer les performances de l'arbre simplifié en utilisant la procédure de type validation croisée intégrée dans rpart pour choisir la complexité de l'arbre. Le principe est de s'appuyer sur la fonction predict et sur la fonction table pour obtenir une matrice de confusion, comme suit « table(DataAct$CODE_Medical, predict(model, type="class"))»

![8](https://user-images.githubusercontent.com/29728117/27641843-f52f1bb6-5c14-11e7-9fe7-226f3ac62615.PNG)
