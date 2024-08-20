# Base stage
FROM node:18-alpine AS base
# Set working directory
WORKDIR /app
# Install pnpm
RUN npm install -g pnpm
# Copy package.json and pnpm-lock.yaml (if exists)
COPY package.json pnpm-lock.yaml* ./

# Install dependencies stage
FROM base AS deps
# Install dependencies
RUN pnpm install --frozen-lockfile

# Development stage
FROM base AS dev
# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Expose the port the app runs on
EXPOSE 4321
# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=4321
ENV NODE_ENV=development
# Start the application in watch mode
CMD ["pnpm", "dev", "--host", "0.0.0.0"]

# Production stage
FROM base AS prod
# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# Build the application
RUN pnpm build
# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=4321
ENV NODE_ENV=production
# Expose the port the app runs on
EXPOSE 4321
# Start the application
CMD ["node", "dist/index.js"]