# counter-frontend

## Available Endpoints

- `/` - Main counter page that displays the current counter value and hostname information
- `/api/livez` - Liveness probe endpoint (returns HTTP 200 with "OK")

## Configuration

- `API_ORIGIN` - Origin of the API server (default: `http://127.0.0.1:8000`)
- `FONT_COLOR` - Color of the counter text (default: `#000000`, black)
- `BACKGROUND_COLOR` - Color of the counter background (default: `#ffffff`, white)

## Images

- `ghcr.io/ondrejsika/counter-frontend`
