# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Hogastos is a personal finance management Flutter application for tracking home expenses and income. The app features PIN-based authentication with optional biometrics, per-user encrypted SQLite databases, and offline-first operation with Spanish localization.

## Development Commands

### Build & Run
```bash
# Run in development mode
flutter run

# Build for Android
flutter build apk

# Build for Android (release bundle)
flutter build appbundle

# Run tests
flutter test

# Generate code (Drift database & localizations)
flutter pub run build_runner build

# Generate code with deletion of conflicting outputs
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and regenerate code
flutter pub run build_runner watch
```

### Linting & Analysis
```bash
# Run linter
flutter analyze

# Check for formatting issues
dart format --set-exit-if-changed .

# Fix formatting
dart format .
```

### Dependencies
```bash
# Install dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

## Architecture Overview

### Directory Structure

- **`lib/components/`** - UI components
  - `authenticated_pages/` - Pages requiring authentication (home, categories, movements, reports, files, settings)
  - `public_pages/` - Pre-auth pages (create_user, user_login)
  - `common/` - Reusable widgets (buttons, cards, dialogs)
  - `texts/` - Typography components (TitleText, BodyText, HintText)
  - `animations/` - Custom page transitions

- **`lib/configurations/`** - App-wide configuration
  - `authentication.dart` - AuthState singleton (PIN auth, biometric)
  - `user_settings.dart` - UserSettings singleton (app preferences)
  - `theme_notifier.dart` - ThemeNotifier (ChangeNotifier for themes)
  - `themes.dart` - Material 3 theme definitions
  - `routes.dart` - Named routes with custom transitions

- **`lib/services/`** - Business logic layer
  - `movement_service.dart` - Movement CRUD operations
  - `category_service.dart` - Category CRUD with soft delete
  - `excel_service.dart` - Excel import/export
  - `data/` - Database layer (Drift)

- **`lib/models/`** - Data models and entities

- **`lib/helpers/`** - Utility functions (navigation, localization, biometric, date, form validation)

### State Management

- **Provider**: Used only for `ThemeNotifier` (reactive theme changes)
- **Singletons**: `AuthState`, `UserSettings`, `DbConnect` manage application state
- **Streams**: Drift's `.watch()` methods provide reactive data updates for specific screens
- **Services**: Stateless service layer handles all database operations

This is a minimal state management approach - no global state containers (GetX/Riverpod).

### Database Architecture

**Technology**: Drift (type-safe SQLite ORM)

**Per-User Database Isolation**:
- Database name: `hogastos_db_<sha1(user_pin)>`
- Each user gets a separate encrypted database file
- Database name generated in `lib/services/data/db.dart` via `_getDbName()`
- Requires authenticated user (`AuthState().getUser()`) to open database

**Tables**:
- `Category` - Expense/income categories with soft delete (`deletedAt` field)
- `Movement` - Financial transactions with foreign key to Category

**Code Generation**:
- Drift requires running `build_runner` after schema changes
- Generated file: `lib/services/data/db.g.dart`
- Table definitions in `lib/services/data/tables/`

**Custom Column Types**:
- `ColorColumn` - Flutter Color ↔ SQLite integer
- `MovementTypeColumn` - MovementType enum ↔ SQLite text
- `HogastosIconColumn` - Custom icon ↔ SQLite text

**Migrations**:
- Current schema version: 2
- Migration logic in `lib/services/data/migrations/`

### Authentication Flow

1. **User Creation** (`lib/components/public_pages/create_user/`):
   - User enters PIN → SHA1 hash → Store in FlutterSecureStorage
   - Creates User object with token
   - Database created with user-specific name

2. **Login** (`lib/components/public_pages/user_login/`):
   - PIN entry → SHA1 hash → Compare with stored hash
   - Optional biometric auth (if enabled in settings)
   - On success: User object stored in `AuthState` singleton

3. **Security** (`lib/configurations/authentication.dart`):
   - PIN hashed with SHA1 before storage
   - FlutterSecureStorage uses Android encrypted SharedPreferences
   - Biometric auth wraps device fingerprint/face recognition

### Navigation Patterns

- **Centralized Routes**: All routes defined in `lib/configurations/routes.dart`
- **Custom Transitions**: Slide-from-bottom animation via `PageRouteBuilder`
- **Safe Navigation**: Always use `NavigatorHelper` (checks `context.mounted`)
- **Page Wrappers**:
  - `PageWithMenu` - Authenticated pages with app bar
  - `PageWithoutAppbar` - Public pages

### Localization

- **Framework**: Flutter's built-in `intl` + `flutter_localizations`
- **Template**: `lib/l10n/app_es.arb` (Spanish primary language)
- **Generated**: `lib/generated/i18n/app_localizations.dart` (auto-generated)
- **Configuration**: `l10n.yaml` in project root
- **Access**: Use `AppLocalizations.of(context)!.keyName` or `LocalizationHelper`

After adding new translations to `.arb` files, run: `flutter gen-l10n` or `flutter pub run build_runner build`

## Key Patterns & Conventions

### Service Layer Pattern
- All database operations go through service classes (`MovementService`, `CategoryService`)
- Services return `Future<T>` or `Stream<List<T>>` from Drift queries
- UI components never directly query the database

### Soft Delete for Categories
- Categories are never hard-deleted (preserves movement history)
- `deletedAt` timestamp field marks deleted categories
- Queries filter out soft-deleted items by default
- See `lib/services/category_service.dart` for implementation

### Model Inheritance
- Base models: `CreateMovement`, `CreateCategory` (for creation forms)
- Entity models: `Movement`, `Category` (extend base + add ID)
- Pattern enables form validation without requiring IDs

### Helper Usage
- `NavigatorHelper`: Always use for navigation (prevents unmounted context errors)
- `LocalizationHelper`: Centralized access to translations and currency symbols
- `BiometricHelper`: Abstracts platform-specific biometric auth
- `DateHelper`: Date manipulation utilities
- `FormValidatorHelper`: Form validation logic

### Theme Management
- `ThemeNotifier` is the only ChangeNotifier in the app
- Supports: Light, Dark, System, and Custom color themes
- Theme settings persist to secure storage via `UserSettings`
- Custom themes use Material 3 ColorScheme

## Common Development Tasks

### Adding a New Page
1. Create page component in appropriate `lib/components/` subdirectory
2. Add route to `lib/configurations/routes.dart` (both `RoutesNames` and `Routes.routes` map)
3. Use `PageWithMenu` wrapper for authenticated pages
4. Navigate using `NavigatorHelper.pushNamed(context, RoutesNames.yourRoute)`

### Adding a Database Table
1. Create table definition in `lib/services/data/tables/your_table.dart`
2. Add table to `@DriftDatabase` annotation in `lib/services/data/db.dart`
3. Update `schemaVersion` in `db.dart`
4. Create migration in `lib/services/data/migrations/`
5. Run `flutter pub run build_runner build --delete-conflicting-outputs`
6. Create service class in `lib/services/your_service.dart`

### Adding a Localized String
1. Add key-value to `lib/l10n/app_es.arb`
2. Run `flutter gen-l10n` or restart Flutter app (auto-generates)
3. Access via `AppLocalizations.of(context)!.yourKey`

### Modifying Authentication Logic
- User creation/login: `lib/configurations/authentication.dart`
- PIN encryption: SHA1 in `_AuthCrypto.encryptPin()`
- Biometric flow: `AuthState.localLogin()` method
- Storage: FlutterSecureStorage with Android encrypted preferences

## Testing

- Widget tests in `test/widget_test.dart`
- Use `flutter test` to run all tests
- For Drift database testing, use in-memory databases

## Important Notes

- **Always run `build_runner` after Drift schema changes** - The app will not compile without generated code
- **Database access requires authentication** - `AuthState().getUser()` must return a user before opening DB
- **Use `NavigatorHelper` for all navigation** - Prevents "setState on unmounted widget" errors
- **Soft delete categories** - Never hard delete; use `deletedAt` timestamp
- **Theme changes are reactive** - Use `Consumer<ThemeNotifier>` for theme-dependent widgets
- **Services return Futures/Streams** - Use `FutureBuilder` or `StreamBuilder` in UI
- **PIN is hashed with SHA1** - Never store or compare raw PINs
