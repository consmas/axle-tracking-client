# Axle Tracking CMS (Flutter)

Flutter frontend for Rails `cms_gateway_api` (API-only).

## What this app does

- Authenticates app users with backend JWT
- Stores JWT securely with `flutter_secure_storage`
- Calls CMS-backed APIs through gateway endpoints
- Handles `cms_unauthorized` centrally by:
  1. calling `POST /api/v1/cms/login`
  2. retrying original request once
- Provides pages for:
  - Login
  - Vehicles list
  - Vehicle detail (status + track by date range)
  - Alarms (admin only)

## Backend

- Base URL (local): `http://localhost:3001`
- Configure with `.env`

## Setup

1. Install dependencies:

```bash
flutter pub get
```

2. Create env file:

```bash
cp .env.example .env
```

3. Set API URL in `.env`:

```env
API_BASE_URL=http://localhost:3001
```

Notes:
- Android emulator usually needs: `http://10.0.2.2:3001`
- iOS simulator usually supports: `http://localhost:3001`

4. Generate code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

5. Run app:

```bash
flutter run
```

## API endpoints integrated

- `POST /api/auth/register`
- `POST /api/auth/login`
- `POST /api/v1/cms/login`
- `POST /api/v1/cms/login_diagnostic` (data layer support)
- `GET /api/v1/vehicles`
- `GET /api/v1/vehicles/:id/status`
- `GET /api/v1/vehicles/:id/track?from=YYYY-MM-DD HH:mm:ss&to=YYYY-MM-DD HH:mm:ss`
- `GET /api/v1/alarms?from=YYYY-MM-DD HH:mm:ss&to=YYYY-MM-DD HH:mm:ss`

## Error handling

Backend error format:

```json
{
  "error": {
    "code": "string",
    "message": "string"
  }
}
```

Mapped behaviors:
- `unauthorized` / `401`: logout + redirect to login
- `cms_unauthorized`: auto `cms/login` then retry once
- `cms_invalid_credentials`, `cms_error`, `cms_server_error`, `cms_timeout`: user-friendly message
- `invalid_range`: user-friendly range validation message

## Architecture

- Clean architecture style (data/domain/presentation)
- Riverpod state management
- Dio API client + interceptors
- Typed exceptions and centralized parser
- Feature modules for auth, vehicles, tracking, alarms
