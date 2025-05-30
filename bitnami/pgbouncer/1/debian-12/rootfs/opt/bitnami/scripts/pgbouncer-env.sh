#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# Environment configuration for pgbouncer

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-pgbouncer}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
pgbouncer_env_vars=(
    PGBOUNCER_LOG_FILE
    PGBOUNCER_DATABASE
    PGBOUNCER_PORT
    PGBOUNCER_LISTEN_ADDRESS
    PGBOUNCER_AUTH_USER
    PGBOUNCER_AUTH_QUERY
    PGBOUNCER_AUTH_TYPE
    PGBOUNCER_AUTH_HBA_FILE
    PGBOUNCER_AUTH_IDENT_FILE
    PGBOUNCER_STATS_USERS
    PGBOUNCER_POOL_MODE
    PGBOUNCER_INIT_SLEEP_TIME
    PGBOUNCER_SERVER_FAST_CLOSE
    PGBOUNCER_INIT_MAX_RETRIES
    PGBOUNCER_QUERY_WAIT_TIMEOUT
    PGBOUNCER_MAX_CLIENT_CONN
    PGBOUNCER_MAX_DB_CONNECTIONS
    PGBOUNCER_IDLE_TRANSACTION_TIMEOUT
    PGBOUNCER_SERVER_IDLE_TIMEOUT
    PGBOUNCER_SERVER_RESET_QUERY
    PGBOUNCER_DEFAULT_POOL_SIZE
    PGBOUNCER_MIN_POOL_SIZE
    PGBOUNCER_RESERVE_POOL_SIZE
    PGBOUNCER_RESERVE_POOL_TIMEOUT
    PGBOUNCER_IGNORE_STARTUP_PARAMETERS
    PGBOUNCER_STATS_PERIOD
    PGBOUNCER_MAX_PREPARED_STATEMENTS
    PGBOUNCER_EXTRA_FLAGS
    PGBOUNCER_FAIL_ON_INVALID_DSN_FILE
    PGBOUNCER_SERVER_ROUND_ROBIN
    PGBOUNCER_APPLICATION_NAME_ADD_HOST
    PGBOUNCER_CLIENT_TLS_SSLMODE
    PGBOUNCER_CLIENT_TLS_CA_FILE
    PGBOUNCER_CLIENT_TLS_CERT_FILE
    PGBOUNCER_CLIENT_TLS_KEY_FILE
    PGBOUNCER_CLIENT_TLS_CIPHERS
    PGBOUNCER_SERVER_TLS_SSLMODE
    PGBOUNCER_SERVER_TLS_CA_FILE
    PGBOUNCER_SERVER_TLS_CERT_FILE
    PGBOUNCER_SERVER_TLS_KEY_FILE
    PGBOUNCER_SERVER_TLS_PROTOCOLS
    PGBOUNCER_SERVER_TLS_CIPHERS
    PGBOUNCER_LOG_CONNECTIONS
    PGBOUNCER_LOG_DISCONNECTIONS
    PGBOUNCER_LOG_POOLER_ERRORS
    PGBOUNCER_LOG_STATS
    PGBOUNCER_SERVER_LIFETIME
    PGBOUNCER_SERVER_CONNECT_TIMEOUT
    PGBOUNCER_SERVER_LOGIN_RETRY
    PGBOUNCER_CLIENT_LOGIN_TIMEOUT
    PGBOUNCER_AUTODB_IDLE_TIMEOUT
    PGBOUNCER_QUERY_TIMEOUT
    PGBOUNCER_CLIENT_IDLE_TIMEOUT
    POSTGRESQL_USERNAME
    POSTGRESQL_PASSWORD
    POSTGRESQL_DATABASE
    POSTGRESQL_HOST
    POSTGRESQL_PORT
    PGBOUNCER_SET_DATABASE_USER
    PGBOUNCER_SET_DATABASE_PASSWORD
    PGBOUNCER_USERLIST
    PGBOUNCER_CONNECT_QUERY
    PGBOUNCER_FORCE_INITSCRIPTS
    PGBOUNCER_SOCKET_DIR
    PGBOUNCER_SOCKET_MODE
    PGBOUNCER_SOCKET_GROUP
    PGBOUNCER_DAEMON_USER
    PGBOUNCER_DAEMON_GROUP
)
for env_var in "${pgbouncer_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset pgbouncer_env_vars

# Paths
export PGBOUNCER_BASE_DIR="${BITNAMI_ROOT_DIR}/pgbouncer"
export PGBOUNCER_CONF_DIR="${PGBOUNCER_BASE_DIR}/conf"
export PGBOUNCER_LOG_DIR="${PGBOUNCER_BASE_DIR}/logs"
export PGBOUNCER_TMP_DIR="${PGBOUNCER_BASE_DIR}/tmp"
export PGBOUNCER_PID_FILE="${PGBOUNCER_TMP_DIR}/pgbouncer.pid"
export PGBOUNCER_CONF_FILE="${PGBOUNCER_CONF_DIR}/pgbouncer.ini"
export PGBOUNCER_AUTH_FILE="${PGBOUNCER_CONF_DIR}/userlist.txt"
export PGBOUNCER_VOLUME_DIR="${BITNAMI_VOLUME_DIR}/pgbouncer"
export PGBOUNCER_MOUNTED_CONF_DIR="${PGBOUNCER_VOLUME_DIR}/conf"
export PGBOUNCER_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"

# General PgBouncer settings
export PGBOUNCER_LOG_FILE="${PGBOUNCER_LOG_FILE:-}"
export PGBOUNCER_DATABASE="${PGBOUNCER_DATABASE:-postgres}"
export PGBOUNCER_PORT="${PGBOUNCER_PORT:-6432}"
export PGBOUNCER_LISTEN_ADDRESS="${PGBOUNCER_LISTEN_ADDRESS:-0.0.0.0}"
export PGBOUNCER_AUTH_USER="${PGBOUNCER_AUTH_USER:-}"
export PGBOUNCER_AUTH_QUERY="${PGBOUNCER_AUTH_QUERY:-}"
export PGBOUNCER_AUTH_TYPE="${PGBOUNCER_AUTH_TYPE:-scram-sha-256}"
export PGBOUNCER_AUTH_HBA_FILE="${PGBOUNCER_AUTH_HBA_FILE:-}"
export PGBOUNCER_AUTH_IDENT_FILE="${PGBOUNCER_AUTH_IDENT_FILE:-}"
export PGBOUNCER_STATS_USERS="${PGBOUNCER_STATS_USERS:-}"
export PGBOUNCER_POOL_MODE="${PGBOUNCER_POOL_MODE:-}"
export PGBOUNCER_INIT_SLEEP_TIME="${PGBOUNCER_INIT_SLEEP_TIME:-10}"
export PGBOUNCER_SERVER_FAST_CLOSE="${PGBOUNCER_SERVER_FAST_CLOSE:-0}"
export PGBOUNCER_INIT_MAX_RETRIES="${PGBOUNCER_INIT_MAX_RETRIES:-10}"
export PGBOUNCER_QUERY_WAIT_TIMEOUT="${PGBOUNCER_QUERY_WAIT_TIMEOUT:-}"
export PGBOUNCER_MAX_CLIENT_CONN="${PGBOUNCER_MAX_CLIENT_CONN:-}"
export PGBOUNCER_MAX_DB_CONNECTIONS="${PGBOUNCER_MAX_DB_CONNECTIONS:-}"
export PGBOUNCER_IDLE_TRANSACTION_TIMEOUT="${PGBOUNCER_IDLE_TRANSACTION_TIMEOUT:-}"
export PGBOUNCER_SERVER_IDLE_TIMEOUT="${PGBOUNCER_SERVER_IDLE_TIMEOUT:-}"
export PGBOUNCER_SERVER_RESET_QUERY="${PGBOUNCER_SERVER_RESET_QUERY:-}"
export PGBOUNCER_DEFAULT_POOL_SIZE="${PGBOUNCER_DEFAULT_POOL_SIZE:-}"
export PGBOUNCER_MIN_POOL_SIZE="${PGBOUNCER_MIN_POOL_SIZE:-}"
export PGBOUNCER_RESERVE_POOL_SIZE="${PGBOUNCER_RESERVE_POOL_SIZE:-}"
export PGBOUNCER_RESERVE_POOL_TIMEOUT="${PGBOUNCER_RESERVE_POOL_TIMEOUT:-}"
export PGBOUNCER_IGNORE_STARTUP_PARAMETERS="${PGBOUNCER_IGNORE_STARTUP_PARAMETERS:-extra_float_digits}"
export PGBOUNCER_STATS_PERIOD="${PGBOUNCER_STATS_PERIOD:-60}"
export PGBOUNCER_MAX_PREPARED_STATEMENTS="${PGBOUNCER_MAX_PREPARED_STATEMENTS:-}"
export PGBOUNCER_EXTRA_FLAGS="${PGBOUNCER_EXTRA_FLAGS:-}"
export PGBOUNCER_FAIL_ON_INVALID_DSN_FILE="${PGBOUNCER_FAIL_ON_INVALID_DSN_FILE:-false}"
export PGBOUNCER_SERVER_ROUND_ROBIN="${PGBOUNCER_SERVER_ROUND_ROBIN:-0}"
export PGBOUNCER_APPLICATION_NAME_ADD_HOST="${PGBOUNCER_APPLICATION_NAME_ADD_HOST:-}"

# Client TLS settings
export PGBOUNCER_CLIENT_TLS_SSLMODE="${PGBOUNCER_CLIENT_TLS_SSLMODE:-disable}"
export PGBOUNCER_CLIENT_TLS_CA_FILE="${PGBOUNCER_CLIENT_TLS_CA_FILE:-}"
export PGBOUNCER_CLIENT_TLS_CERT_FILE="${PGBOUNCER_CLIENT_TLS_CERT_FILE:-}"
export PGBOUNCER_CLIENT_TLS_KEY_FILE="${PGBOUNCER_CLIENT_TLS_KEY_FILE:-}"
export PGBOUNCER_CLIENT_TLS_CIPHERS="${PGBOUNCER_CLIENT_TLS_CIPHERS:-fast}"

# Server TLS settings
export PGBOUNCER_SERVER_TLS_SSLMODE="${PGBOUNCER_SERVER_TLS_SSLMODE:-disable}"
export PGBOUNCER_SERVER_TLS_CA_FILE="${PGBOUNCER_SERVER_TLS_CA_FILE:-}"
export PGBOUNCER_SERVER_TLS_CERT_FILE="${PGBOUNCER_SERVER_TLS_CERT_FILE:-}"
export PGBOUNCER_SERVER_TLS_KEY_FILE="${PGBOUNCER_SERVER_TLS_KEY_FILE:-}"
export PGBOUNCER_SERVER_TLS_PROTOCOLS="${PGBOUNCER_SERVER_TLS_PROTOCOLS:-secure}"
export PGBOUNCER_SERVER_TLS_CIPHERS="${PGBOUNCER_SERVER_TLS_CIPHERS:-fast}"

# Logging settings
export PGBOUNCER_LOG_CONNECTIONS="${PGBOUNCER_LOG_CONNECTIONS:-}"
export PGBOUNCER_LOG_DISCONNECTIONS="${PGBOUNCER_LOG_DISCONNECTIONS:-}"
export PGBOUNCER_LOG_POOLER_ERRORS="${PGBOUNCER_LOG_POOLER_ERRORS:-}"
export PGBOUNCER_LOG_STATS="${PGBOUNCER_LOG_STATS:-}"

# Timeout settings
export PGBOUNCER_SERVER_LIFETIME="${PGBOUNCER_SERVER_LIFETIME:-}"
export PGBOUNCER_SERVER_CONNECT_TIMEOUT="${PGBOUNCER_SERVER_CONNECT_TIMEOUT:-}"
export PGBOUNCER_SERVER_LOGIN_RETRY="${PGBOUNCER_SERVER_LOGIN_RETRY:-}"
export PGBOUNCER_CLIENT_LOGIN_TIMEOUT="${PGBOUNCER_CLIENT_LOGIN_TIMEOUT:-}"
export PGBOUNCER_AUTODB_IDLE_TIMEOUT="${PGBOUNCER_AUTODB_IDLE_TIMEOUT:-}"
export PGBOUNCER_QUERY_TIMEOUT="${PGBOUNCER_QUERY_TIMEOUT:-}"
export PGBOUNCER_CLIENT_IDLE_TIMEOUT="${PGBOUNCER_CLIENT_IDLE_TIMEOUT:-}"

# PostgreSQL backend settings
export POSTGRESQL_USERNAME="${POSTGRESQL_USERNAME:-postgres}"
export POSTGRESQL_PASSWORD="${POSTGRESQL_PASSWORD:-}"
export POSTGRESQL_DATABASE="${POSTGRESQL_DATABASE:-${PGBOUNCER_DATABASE}}"
export POSTGRESQL_HOST="${POSTGRESQL_HOST:-postgresql}"
export POSTGRESQL_PORT="${POSTGRESQL_PORT:-5432}"
export PGBOUNCER_SET_DATABASE_USER="${PGBOUNCER_SET_DATABASE_USER:-no}"
export PGBOUNCER_SET_DATABASE_PASSWORD="${PGBOUNCER_SET_DATABASE_PASSWORD:-no}"
export PGBOUNCER_USERLIST="${PGBOUNCER_USERLIST:-}"
export PGBOUNCER_CONNECT_QUERY="${PGBOUNCER_CONNECT_QUERY:-}"
export PGBOUNCER_FORCE_INITSCRIPTS="${PGBOUNCER_FORCE_INITSCRIPTS:-false}"

# Socket settings
export PGBOUNCER_SOCKET_DIR="${PGBOUNCER_SOCKET_DIR:-/tmp/}"
export PGBOUNCER_SOCKET_MODE="${PGBOUNCER_SOCKET_MODE:-0777}"
export PGBOUNCER_SOCKET_GROUP="${PGBOUNCER_SOCKET_GROUP:-}"

# System settings
export PGBOUNCER_DAEMON_USER="${PGBOUNCER_DAEMON_USER:-pgbouncer}"
export PGBOUNCER_DAEMON_GROUP="${PGBOUNCER_DAEMON_GROUP:-pgbouncer}"
export NSS_WRAPPER_LIB="/opt/bitnami/common/lib/libnss_wrapper.so"

# Custom environment variables may be defined below
