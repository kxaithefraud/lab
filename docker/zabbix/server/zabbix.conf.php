<?php
// Zabbix GUI configuration file.
global $DB, $HISTORY;

$DB['TYPE']     = getenv('DB_SERVER_TYPE');
$DB['SERVER']   = getenv('DB_SERVER_HOST');
$DB['PORT']     = getenv('DB_SERVER_PORT');
$DB['DATABASE'] = getenv('DB_SERVER_DBNAME');
$DB['USER']     = (! getenv('VAULT_TOKEN') || ! getenv('ZBX_VAULTURL')) ? getenv('DB_SERVER_USER') : '';
$DB['PASSWORD'] = (! getenv('VAULT_TOKEN') || ! getenv('ZBX_VAULTURL')) ? getenv('DB_SERVER_PASS') : '';

// Schema name. Used for PostgreSQL.
$DB['SCHEMA'] = getenv('DB_SERVER_SCHEMA');

if (getenv('ZBX_SERVER_HOST')) {
    $ZBX_SERVER      = getenv('ZBX_SERVER_HOST');
    $ZBX_SERVER_PORT = getenv('ZBX_SERVER_PORT');
}
$ZBX_SERVER_NAME = getenv('ZBX_SERVER_NAME');

// Used for TLS connection.
$DB['ENCRYPTION']               = getenv('ZBX_DB_ENCRYPTION') == 'true' ? true: false;
$DB['KEY_FILE']                 = getenv('ZBX_DB_KEY_FILE');
$DB['CERT_FILE']                = getenv('ZBX_DB_CERT_FILE');
$DB['CA_FILE']                  = getenv('ZBX_DB_CA_FILE');
$DB['VERIFY_HOST']              = getenv('ZBX_DB_VERIFY_HOST') == 'true' ? true: false;
$DB['CIPHER_LIST']              = getenv('ZBX_DB_CIPHER_LIST') ? getenv('ZBX_DB_CIPHER_LIST') : '';

// Vault configuration. Used if database credentials are stored in Vault secrets manager.
$DB['VAULT']                    = getenv('ZBX_VAULT');
$DB['VAULT_URL']                = getenv('ZBX_VAULTURL');
$DB['VAULT_DB_PATH']            = getenv('ZBX_VAULTDBPATH');
$DB['VAULT_TOKEN']              = getenv('VAULT_TOKEN');

if (file_exists('/etc/zabbix/web/certs/vault.crt')) {
   $DB['VAULT_CERT_FILE'] = '/etc/zabbix/web/certs/vault.crt';
}
elseif (file_exists(getenv('ZBX_VAULTCERTFILE'))) {
   $DB['VAULT_CERT_FILE'] = getenv('ZBX_VAULTCERTFILE');
}
else {
   $DB['VAULT_CERT_FILE'] = '';
}

if (file_exists('/etc/zabbix/web/certs/vault.key')) {
   $DB['VAULT_KEY_FILE'] = '/etc/zabbix/web/certs/vault.key';
}
elseif (file_exists(getenv('ZBX_VAULTKEYFILE'))) {
   $DB['VAULT_KEY_FILE'] = getenv('ZBX_VAULTKEYFILE');
}
else {
   $DB['VAULT_KEY_FILE'] = '';
}

$DB['VAULT_CACHE']              = getenv('ZBX_VAULTCACHE') == 'true' ? true: false;

// Use IEEE754 compatible value range for 64-bit Numeric (float) history values.
// This option is enabled by default for new Zabbix installations.
// For upgraded installations, please read database upgrade notes before enabling this option.
$DB['DOUBLE_IEEE754']           = getenv('DB_DOUBLE_IEEE754') == 'true' ? true: false;


$IMAGE_FORMAT_DEFAULT  = IMAGE_FORMAT_PNG;

// Elasticsearch url (can be string if same url is used for all types).
$history_url = str_replace("'","\"",getenv('ZBX_HISTORYSTORAGEURL'));
$HISTORY['url']   = (json_decode($history_url)) ? json_decode($history_url, true) : $history_url;
// Value types stored in Elasticsearch.
$storage_types = str_replace("'","\"",getenv('ZBX_HISTORYSTORAGETYPES'));

$HISTORY['types'] = (json_decode($storage_types)) ? json_decode($storage_types, true) : array();

// Used for SAML authentication.
$SSO['SP_KEY'] = '/etc/zabbix/web/certs/entra.cer';



$sso_settings = str_replace("'","\"",getenv('ZBX_SSO_SETTINGS'));
$SSO['SETTINGS'] = (json_decode($sso_settings)) ? json_decode($sso_settings, true) : array();
$SSO['SETTINGS']['use_proxy_headers'] = true;

$ALLOW_HTTP_AUTH = getenv('ZBX_ALLOW_HTTP_AUTH') == 'true' ? true: false;