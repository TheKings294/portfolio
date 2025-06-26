FROM node:20-alpine AS builder
LABEL authors="antoine"

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build

# Production image
FROM node:20-alpine

WORKDIR /app
RUN npm install -g serve

# Copy only built files
COPY --from=builder /app/dist ./dist

# Serve on dynamic port (passed by env)
ENV PORT=${APP_PORT:-3000}
EXPOSE ${PORT}

CMD ["serve", "-s", "dist", "-l", "3000"]
