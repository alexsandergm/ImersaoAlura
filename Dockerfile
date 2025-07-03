FROM python:3.11-slim-bullseye

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
# Isso garante que os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências.
# Copiamos este arquivo separadamente para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências do projeto.
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Etapa 6: Expor a porta em que o Uvicorn será executado.
EXPOSE 8000

# Etapa 7: Comando para executar a aplicação quando o contêiner iniciar.
# O host '0.0.0.0' é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]
