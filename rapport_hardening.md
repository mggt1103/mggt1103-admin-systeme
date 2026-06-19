## 1. Hardening Index Lynis

Voici la capture du Hardening Index obtenu avec Lynis :

![Hardening Index Lynis](images/hardening.png)
## 2. Actions réalisées suite aux recommandations Lynis

Après l’analyse du système avec Lynis, plusieurs recommandations de sécurité ont été identifiées. Trois actions principales ont été appliquées afin d’améliorer la sécurité du système.

---

### 🔧 1. Mise à jour du système

**Problème détecté :** Le système contenait des paquets non à jour pouvant présenter des failles de sécurité.

**Commandes exécutées :**
```bash
sudo apt update
sudo apt upgrade -y
## 3. Différence entre SIGTERM (15) et SIGKILL (9)

SIGTERM (signal 15) est une demande d’arrêt propre envoyée à un processus. Le processus peut la recevoir, terminer ses tâches en cours et libérer correctement ses ressources avant de s’arrêter.

SIGKILL (signal 9) force l’arrêt immédiat du processus sans lui laisser le temps de réagir ou de sauvegarder ses données.

👉 En résumé : SIGTERM permet un arrêt propre, tandis que SIGKILL impose un arrêt brutal et immédiat.

---

## 4. Limitation dans le fichier limits.conf

Le fichier `/etc/security/limits.conf` permet de définir des restrictions sur les ressources système pour chaque utilisateur (comme le nombre de processus, l’utilisation de la mémoire ou le nombre de fichiers ouverts).

Cette limitation empêche un utilisateur ou un programme de consommer excessivement les ressources du système.

Elle contribue ainsi à améliorer la stabilité et la sécurité globale de la machine en évitant les abus ou les surcharges.

