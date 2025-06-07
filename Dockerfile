FROM chatwoot/chatwoot:latest

# Copia o entrypoint
COPY entrypoint.sh /entrypoint.sh

# Corrige line endings e define permissões
RUN sed -i 's/\r$//' /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Usa o novo entrypoint
ENTRYPOINT ["/entrypoint.sh"]