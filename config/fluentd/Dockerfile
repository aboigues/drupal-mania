# Dockerfile personnalisé pour Fluentd avec plugin Elasticsearch
FROM fluent/fluentd:v1.16-1

# Passer en mode root pour installer les gems
USER root

# Installer le plugin Elasticsearch
RUN gem install fluent-plugin-elasticsearch

# Revenir à l'utilisateur fluent
USER fluent
