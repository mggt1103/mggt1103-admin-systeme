# Rapport – Séance 3

## Différence entre l'approche déclarative et l'approche impérative de l'Infrastructure as Code (IaC)
L’approche déclarative en Infrastructure as Code consiste à décrire le résultat final souhaité, sans préciser toutes les étapes pour l’obtenir. L’outil se charge automatiquement de mettre l’infrastructure dans l’état demandé. À l’inverse, l’approche impérative exige que l’utilisateur indique chaque action à exécuter dans un ordre précis. En résumé, l’approche déclarative définit ce qu’il faut obtenir, tandis que l’approche impérative décrit comment y parvenir.

L'approche déclarative consiste à décrire l'état final souhaité de l'infrastructure sans préciser toutes les étapes nécessaires pour y parvenir. L'outil se charge ensuite de créer ou de modifier les ressources afin d'atteindre cet état.

À l'inverse, l'approche impérative demande de spécifier les instructions à exécuter une par une pour construire l'infrastructure. Dans ce cas, c'est l'utilisateur qui définit la séquence exacte des actions à réaliser.

En résumé, l'approche déclarative indique **ce que l'on veut obtenir**, tandis que l'approche impérative explique **comment y parvenir**.
Le fichier d’état terraform.tfstate est extrêmement sensible car il contient des informations complètes sur l’infrastructure gérée par Terraform, notamment les adresses IP, les identifiants de ressources, les noms de services et parfois des secrets comme des mots de passe ou des clés d’accès. Le publier sur un dépôt public expose donc directement la configuration interne du système à toute personne extérieure. Cela peut permettre à un attaquant de cartographier l’infrastructure, d’identifier des failles et même d’obtenir des accès non autorisés. Pour cette raison, le fichier d’état doit toujours être protégé, stocké de manière sécurisée (par exemple dans un backend distant sécurisé) et exclu du versionnement Git via .gitignore.
