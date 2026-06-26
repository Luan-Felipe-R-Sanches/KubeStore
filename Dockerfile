# Estágio 1: Build
FROM python:3.9-slim AS builder
WORKDIR /app
# Alteramos aqui para buscar dentro de src/
COPY src/requirements.txt .
RUN pip install --user -r requirements.txt

# Estágio 2: Runtime
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
# Alteramos aqui para copiar o código da pasta src/
COPY src/ . 
ENV PATH=/root/.local/bin:$PATH
EXPOSE 8080
CMD ["python", "app.py"]