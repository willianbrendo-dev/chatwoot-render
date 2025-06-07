#!/bin/bash

# Aguarda o banco de dados estar disponível (máximo 30 tentativas)
echo "⏳ Aguardando o banco de dados..."
for i in {1..30}; do
  pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USERNAME" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "✅ Banco de dados disponível."
    break
  fi
  echo "Tentando conexão ($i)..."
  sleep 2
done

# Executa migrações (e cria o banco se necessário)
echo "⚙️ Executando migrations..."
bundle exec rails db:prepare

# Inicia o servidor Rails na porta 3000
echo "🚀 Iniciando o servidor Chatwoot..."
bundle exec rails s -b 0.0.0.0 -p 3000