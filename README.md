# Collision-des-satellites

**Auteurs** : 
Jaouahar BEN OUIRANE

Adjanie KENGNI

Sylviane LY

Soumaia TOUIL

                                  Nous remercions notre encadrant Virgile Dubos.

Description : 
--------------
Notre projet <collision des satellites > consiste à  la réalisation d’un logiciel permettant d’estimer le risque de collision entre deux objets célestes dont la trajectoire est une ellipse. En considérant principalement deux critères, le critère spatiale, qui permet d’estimer une distance critique entraînant une collision , et le critère temporelle qui permet d’étudier en temps ce risque de collision. 

Contenu : 
--------------
*=> Dans un terminal* : (facultatif, voici comment nous avons obtenu le fichier data.txt)

**projet1.py** : permet de traiter le catalogue et récupérer seulement les paramètres qui nous intéressent. Le catalogue provient du site Neodys qui recense des objets célestes sur lequel nous allons appliquer notre algorithme. 
(source : http://newton.dm.unipi.it/neodys/index.php?pc=5)

**data.txt** : notre version du catalogue avec seulement les ellipses et des paramètres ciblés.


*=> Dans Matlab*: 

Il faut importer le fichier data.txt qui fournit des données aux algorithmes ci-dessous. Pour cela dans Matlab > Import data > Output type : numeric matrix 

**MOID.m** : calcule le MOID de manière naïve 

**dSat.m, progSat.m** : programmes pour le calcul du MOID entre la Terre et Eros (avec Direct Optimization)

**dCat.m** : fonction nécessaire à d’autres programmes comme Direct Optimization

**Direct.m** : définition de Direct et de ses fonctions internes 
(source : https://ctk.math.ncsu.edu/Finkel_Direct/ )

**MOID_CATALOGUE.m** : calcule le MOID sur le catalogue en faisant appel à Direct
temps.m : programme qui calcule tc1 et tc2 (temps de passage des objets 1 et 2 à la conjonction) ainsi que dc1 et dc2 (temps de possible collision) et recalcule la distance entre les objets

**temps.m** : programme qui calcule tc1 et tc2 (temps de passage des objets 1 et 2 à la conjonction) ainsi que dc1 et dc2 (temps de possible collision) et recalcule la distance entre les objets

