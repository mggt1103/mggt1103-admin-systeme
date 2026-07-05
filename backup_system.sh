#!/usr/bin/env bash

# ==============================================================================
# SCRIPT DE SAUVEGARDE AUTOMATISÉE ET DURCIE - PRODUCTION
# Auteur : Master GGT - UE
# ==============================================================================

# 💡 Mode strict Bash
set -euo pipefail
LOG_TAG="BACKUP_ENGINE"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

# Fonction d'affichage et de journalisation des informations standard
log_info() {
    logger -t "${LOG_TAG}" "[INFO] $1"
    echo -e "\e[32m[INFO]\e[0m $1"
}

# Fonction d'affichage et de journalisation des erreurs critiques
log_error() {
    logger -t "${LOG_TAG}" -p user.err "[ERROR] $1"
    echo -e "\e[31m[ERROR]\e[0m $1" >&2
}
# 💡 NOTE PÉDAGOGIQUE : La gestion des signaux (Le Trap)
# La fonction "cleanup_on_failure" s'exécutera automatiquement si le script s'arrête
# brutalement suite à une erreur. C'est votre ceinture de sécurité !

cleanup_on_failure() {
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
        log_error "Le script a échoué prématurément à l'étape précédente avec le code d'erreur $exit_code. Nettoyage..."
trap cleanup_on_failure EXIT

# --- DÉBUT DES OPÉRATIONS ---
log_info "Démarrage de la sauvegarde de l'infrastructure..."

# 1. Vérification des droits d'exécution (Le script doit être lancé en ROOT)
if [ "${EUID}" -ne 0 ]; then
    log_error "Ce script de sauvegarde doit impérativement être exécuté en tant que ROOT (Sudo)."
    exit 1
fi

# 2. Création sécurisée du dossier de sauvegarde s'il n'existe pas
if [ ! -d "${BACKUP_DIR}" ]; then
    log_info "Création du répertoire de sauvegarde ${BACKUP_DIR}..."
    mkdir -p "${BACKUP_DIR}"

    # Sécurisation du dossier : Seul root peut lire et écrire à l'intérieur
    chmod 700 "${BACKUP_DIR}"
fi
# 3. Sauvegarde de l'état réseau (Spécifique GGT)
log_info "Sauvegarde de la configuration IP et de la table de routage..."

{
    echo "=== ADRESSAGE IP ET INTERFACES ==="
    ip -br addr show

    echo -e "\n=== TABLE DE ROUTAGE IPV4 ==="
    ip route show

    echo -e "\n=== TABLE DE ROUTAGE IPV6 ==="
    ip -6 route show
} > "${IP_INFO_FILE}"

# Seul root a le droit d'accéder à ce fichier d'informations
chmod 600 "${IP_INFO_FILE}"
        # Suppression des fichiers incomplets ou corrompus
        rm -f "${OUTPUT_FILE}" "${IP_INFO_FILE}"
    fi
}
trap cleanup_on_failure EXIT

# --- DÉBUT DES OPÉRATIONS ---
log_info "Démarrage de la sauvegarde de l'infrastructure..."

# 1. Vérification des droits d'exécution (Le script doit être lancé en ROOT)
if [ "${EUID}" -ne 0 ]; then
    log_error "Ce script de sauvegarde doit impérativement être exécuté en tant que ROOT (Sudo)."
    exit 1
fi

# 2. Création sécurisée du dossier de sauvegarde s'il n'existe pas
if [ ! -d "${BACKUP_DIR}" ]; then
    log_info "Création du répertoire de sauvegarde ${BACKUP_DIR}..."
    mkdir -p "${BACKUP_DIR}"

    # Sécurisation du dossier : Seul root peut lire et écrire à l'intérieur
    chmod 700 "${BACKUP_DIR}"
fi

# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.
# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.# 4. Compression des configurations système (/etc)
log_info "Compression des fichiers de configuration réseau et système (/etc)..."

# tar -czf crée un fichier archive compressé au format .tar.gz
tar -czf "${OUTPUT_FILE}" /etc 2>/dev/null

log_info "Sauvegarde réussie avec succès !"
log_info "Archive générée : ${OUTPUT_FILE}"
log_info "Fichier d'état IP généré : ${IP_INFO_FILE}"

# --- FIN DES OPÉRATIONS ---
Ensuite
Enregistrez le fichier :
Ctrl + X
Y
Entrée

Rendez le script exécutable :

chmod +x ~/backup_system.sh

Comme ce script vérifie que vous êtes root, exécutez-le avec :

sudo ~/backup_system.sh

ou

sudo bash ~/backup_system.sh
⚠️ Vérification importante

Avant d'exécuter le script, assurez-vous que les variables suivantes sont bien définies au début du fichier :

LOG_TAG="backup_system"
BACKUP_DIR="/var/backups/system"
OUTPUT_FILE="${BACKUP_DIR}/system_backup.tar.gz"
IP_INFO_FILE="${BACKUP_DIR}/ip_info.txt"

Si elles ne sont pas présentes, le script risque de ne pas fonctionner correctement.

📷 Si vous souhaitez que je vérifie votre script avant de l'exécuter, envoyez une capture d'écran de tout le fichier ou copiez-collez son contenu.
