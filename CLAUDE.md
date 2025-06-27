# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Open WebUI is an extensible, feature-rich, and user-friendly self-hosted AI platform designed to operate entirely offline. It supports various LLM runners like Ollama and OpenAI-compatible APIs, with built-in inference engine for RAG.

## Architecture

### Frontend (SvelteKit)
- **Framework**: SvelteKit with TypeScript
- **Location**: `src/` directory
- **Main Layout**: `src/routes/(app)/+layout.svelte` - handles authentication, settings, keyboard shortcuts
- **Key Components**:
  - `src/lib/components/chat/` - Chat interface and message handling
  - `src/lib/components/layout/` - Sidebar, navbar, modals
  - `src/lib/components/workspace/` - Models, prompts, tools, knowledge management
  - `src/lib/apis/` - API client functions organized by feature
  - `src/lib/stores/` - Svelte stores for state management

### Backend (FastAPI + Python)
- **Framework**: FastAPI with Pydantic for data validation
- **Location**: `backend/open_webui/` directory
- **Main Entry**: `backend/open_webui/main.py` - FastAPI app with middleware, routes, configuration
- **Key Components**:
  - `routers/` - API endpoints organized by feature (chats, models, users, etc.)
  - `models/` - Database models and data access layer
  - `utils/` - Utility functions for auth, chat processing, middleware
  - `config.py` - Configuration management

### Database
- **ORM**: SQLAlchemy with Alembic migrations
- **Models**: Located in `backend/open_webui/models/`
- **Migrations**: `backend/open_webui/migrations/`

## Development Commands

### Frontend Development
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Start development server on port 5050
npm run dev:5050

# Build for production
npm run build

# Build and watch for changes
npm run build:watch

# Run type checking
npm run check

# Run type checking in watch mode
npm run check:watch
```

### Linting and Formatting
```bash
# Run all linting (frontend + backend + types)
npm run lint

# Run frontend linting only
npm run lint:frontend

# Run backend linting only
npm run lint:backend

# Run type checking
npm run lint:types

# Format frontend code
npm run format

# Format backend code
npm run format:backend
```

### Testing
```bash
# Run frontend tests
npm run test:frontend

# Run Cypress E2E tests
npm run cy:open

# Run Python backend tests
cd backend && python -m pytest

# Run specific test file
cd backend && python -m pytest open_webui/test/apps/webui/routers/test_chats.py

# Run tests with coverage
cd backend && python -m pytest --cov=open_webui
```

### Backend Development
```bash
# Navigate to backend directory
cd backend

# Install Python dependencies
pip install -r requirements.txt

# Start backend server
./start.sh  # or start_windows.bat on Windows

# Run backend with development script
./dev.sh
```

### Internationalization
```bash
# Parse and update translation files
npm run i18n:parse
```

### Docker Development
```bash
# Start with Docker Compose
make install  # or docker compose up -d

# Start and build containers
make startAndBuild

# Stop containers
make stop

# Update and rebuild
make update
```

### Other Scripts
```bash
# Fetch Pyodide dependencies
npm run pyodide:fetch

# Preview production build
npm run preview
```

## Key Configuration Files

- `package.json` - Node.js dependencies and scripts
- `pyproject.toml` - Python project configuration and dependencies
- `vite.config.ts` - Vite build configuration
- `svelte.config.js` - SvelteKit configuration
- `tailwind.config.js` - TailwindCSS configuration
- `tsconfig.json` - TypeScript configuration
- `backend/requirements.txt` - Python dependencies (legacy, use pyproject.toml)
- `backend/open_webui/config.py` - Backend configuration
- `Makefile` - Docker Compose shortcuts and development commands

## Development Environment Setup

### Prerequisites
- Node.js 18.13.0+ (up to 22.x.x)
- npm 6.0.0+
- Python 3.11+
- Docker (optional, for containerized development)

### Quick Start
1. Install frontend dependencies: `npm install`
2. Install backend dependencies: `cd backend && pip install -r requirements.txt`
3. Start backend: `./backend/start.sh`
4. Start frontend: `npm run dev`
5. Access at http://localhost:5173 (frontend) with backend at http://localhost:8080

## Important Directories

- `src/lib/components/` - Reusable Svelte components
- `src/routes/` - SvelteKit pages and API routes
- `backend/open_webui/routers/` - FastAPI route handlers
- `backend/open_webui/models/` - Database models
- `backend/open_webui/utils/` - Backend utility functions
- `backend/open_webui/test/` - Python test files organized by feature
- `static/` - Static assets (favicon, images, etc.)
- `cypress/` - E2E test files

## Features and Integrations

The application supports extensive configuration for:
- Multiple LLM providers (Ollama, OpenAI, etc.)
- RAG (Retrieval Augmented Generation) with various embedding models
- Audio processing (STT/TTS) with multiple engines
- Image generation with AUTOMATIC1111, ComfyUI, OpenAI DALL-E
- Web search integration with various providers
- Code execution and interpretation
- User authentication (local, OAuth, LDAP)
- Real-time chat with WebSocket support

## Code Style

- **Frontend**: Uses ESLint + Prettier for code formatting
- **Backend**: Uses Black for Python code formatting
- **TypeScript**: Strict type checking enabled
- **Imports**: Organized with clear separation between internal and external imports