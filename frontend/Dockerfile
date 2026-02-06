FROM node:20-alpine

WORKDIR /app

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Copiar archivos de dependencias primero (para cache de Docker)
COPY package.json ./
# Copiar lockfile si existe (opcional para primera vez)
COPY pnpm-lock.yaml* ./

# Instalar dependencias
RUN pnpm install --frozen-lockfile || pnpm install

# Copiar el resto del código fuente
COPY . .

# Exponer puerto de desarrollo
EXPOSE 5173

# El comando real lo sobreescribe docker-compose.yml:
# command: pnpm dev --host 0.0.0.0
CMD ["pnpm", "dev", "--host", "0.0.0.0"]
