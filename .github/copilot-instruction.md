# Copilot Instructions – ConnectSphere

You are assisting in building a Flutter application named
"ConnectSphere" using Clean Architecture principles.

## Architecture Rules

- Follow Clean Architecture strictly:
  Presentation → Domain → Data
- Use feature-based folder structure.
- No business logic inside widgets.
- Use manual dependency injection with GetIt.
- Use Dio for networking.
- Use GoRouter for navigation.

## State Management

- Use ChangeNotifier for feature state.
- Do not use third-party state management unless required.
- Separate ephemeral UI state from app state.

## Networking

- Use Dio client inside core/services/dio.
- All API calls must go through a RemoteDataSource.
- Do not call Dio directly inside UI.

## JSON Serialization

- Use json_serializable.
- Always annotate models properly.
- Use snake_case mapping if required.

## UI Guidelines

- Use Material 3.
- Use ColorScheme.fromSeed.
- Follow spacing system (8, 16, 24).
- Keep build() methods small.
- Extract reusable widgets.

## Navigation

- Use GoRouter.
- Handle authentication redirects.
- No Navigator.push unless temporary screens.

## Logging

- Use dart:developer log().
- Do not use print().

## Error Handling

- Always wrap API calls with try-catch.
- Convert Dio errors to custom exceptions.

## Testing

- Write unit tests for:
  - UseCases
  - Repositories
  - Notifiers
- Follow Arrange-Act-Assert pattern.

## Performance

- Do not perform API calls inside build().
- Use compute() for heavy JSON parsing if needed.
- Use ListView.builder for lists.
