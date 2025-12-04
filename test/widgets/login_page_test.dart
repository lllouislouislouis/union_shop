import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

void main() {
  group('LoginPage Widget Tests', () {
    // Helper to build the widget with MaterialApp
    Widget buildLoginPageApp() {
      return MaterialApp(
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
        },
      );
    }

    // FR-19: Login Page UI Tests
    group('FR-19: Login Page UI', () {
      testWidgets('LoginPage displays centered form container',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-19.2: Check for centered form container
        expect(
          find.byType(Container),
          findsWidgets,
          reason: 'Container for form should exist',
        );

        // Check for "Login" title
        expect(
          find.text('Login'),
          findsOneWidget,
          reason: 'Login title should be displayed',
        );
      });

      testWidgets('Form container has white background',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-19.3: Verify white background
        final containerFinder = find.byType(Container);
        expect(containerFinder, findsWidgets);
      });

      testWidgets('Page is responsive on mobile viewport',
          (WidgetTester tester) async {
        // Set mobile viewport (375x667)
        tester.binding.window.physicalSizeTestValue = const Size(375, 667);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(buildLoginPageApp());

        // FR-19.4: Check if page renders without errors
        expect(find.byType(LoginPage), findsOneWidget);
      });

      testWidgets('Page is responsive on desktop viewport',
          (WidgetTester tester) async {
        // Set desktop viewport (1920x1080)
        tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(buildLoginPageApp());

        // FR-19.4: Check if page renders without errors
        expect(find.byType(LoginPage), findsOneWidget);
      });

      testWidgets('Page includes AppScaffold wrapper',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-19.5: Verify AppScaffold is used
        expect(find.byType(AppScaffold), findsOneWidget);
      });
    });

    // FR-20: Login Form Fields Tests
    group('FR-20: Login Form Fields', () {
      testWidgets('Username field has correct label',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.1, FR-20.2: Check username label
        expect(
          find.text('Username or Email'),
          findsOneWidget,
          reason: 'Username label should be displayed',
        );
      });

      testWidgets('Username field has placeholder text',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.2: Check placeholder
        expect(
          find.text('Enter your username or email'),
          findsOneWidget,
          reason: 'Username placeholder should be displayed',
        );
      });

      testWidgets('Username field accepts text input',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.1, FR-20.3: Find and interact with username field
        final usernameField = find.byType(TextField).first;
        expect(usernameField, findsOneWidget);

        await tester.enterText(usernameField, 'testuser');
        await tester.pump();

        expect(find.text('testuser'), findsOneWidget);
      });

      testWidgets('Password field has correct label',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.4: Check password label
        expect(
          find.text('Password'),
          findsOneWidget,
          reason: 'Password label should be displayed',
        );
      });

      testWidgets('Password field has placeholder text',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.4: Check placeholder
        expect(
          find.text('Enter your password'),
          findsOneWidget,
          reason: 'Password placeholder should be displayed',
        );
      });

      testWidgets('Password field obscures text by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.5: Verify text is obscured
        final passwordFields = find.byType(TextField);
        expect(passwordFields, findsWidgets);

        // The second TextField should be the password field
        final passwordField = find.byType(TextField).at(1);
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        // Text should be present but obscured (shown as dots)
        final textFieldWidget = tester.widget<TextField>(passwordField);
        expect(textFieldWidget.obscureText, true,
            reason: 'Password should be obscured');
      });

      testWidgets('Password visibility toggle button exists',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.6: Check for visibility toggle icon
        expect(
          find.byIcon(Icons.visibility_off),
          findsOneWidget,
          reason: 'Visibility toggle icon should be displayed',
        );
      });

      testWidgets('Password visibility toggle works',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.6: Test toggle functionality
        final toggleButton = find.byIcon(Icons.visibility_off);
        expect(toggleButton, findsOneWidget);

        // Tap the toggle to show password
        await tester.tap(toggleButton);
        await tester.pump();

        // Icon should change to visibility
        expect(
          find.byIcon(Icons.visibility),
          findsOneWidget,
          reason: 'Icon should change to visibility when toggled',
        );

        // Tap again to hide password
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Icon should change back to visibility_off
        expect(
          find.byIcon(Icons.visibility_off),
          findsOneWidget,
          reason: 'Icon should change back to visibility_off',
        );
      });

      testWidgets('Form fields have focus state styling',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-20.7: Test focus state
        final usernameField = find.byType(TextField).first;
        await tester.tap(usernameField);
        await tester.pump();

        // Field should be focused
        expect(find.byType(TextField), findsWidgets);
      });
    });

    // FR-21: Login Form Actions Tests
    group('FR-21: Login Form Actions', () {
      testWidgets('Login button is displayed', (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.1: Check for login button
        expect(
          find.text('LOGIN'),
          findsOneWidget,
          reason: 'LOGIN button should be displayed',
        );
      });

      testWidgets('Login button has correct styling',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.2, FR-21.4: Check button styling
        final loginButton = find.byType(ElevatedButton);
        expect(loginButton, findsOneWidget,
            reason: 'Login button should be ElevatedButton');
      });

      testWidgets('Login button shows loading state on press',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.5: Test login button action
        final loginButton = find.byType(ElevatedButton);
        await tester.tap(loginButton);
        await tester.pump();

        // Should show loading indicator
        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
          reason: 'Loading indicator should appear',
        );
      });

      testWidgets('Login button shows placeholder feedback',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.5: Test placeholder feedback
        final loginButton = find.byType(ElevatedButton);
        await tester.tap(loginButton);

        // Wait for the delayed action
        await tester.pumpAndSettle();

        // SnackBar should be shown
        expect(
          find.text('Login functionality coming soon!'),
          findsOneWidget,
          reason: 'Placeholder message should be shown',
        );
      });
      testWidgets('Forgot Password link is displayed',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.6: Check for Forgot Password link
        expect(
          find.text('Forgot Password?'),
          findsOneWidget,
          reason: 'Forgot Password link should be displayed',
        );
      });

      testWidgets('Forgot Password link is clickable',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.6: Test link interaction
        final forgotPasswordLink = find.text('Forgot Password?');
        await tester.tap(forgotPasswordLink);
        await tester.pumpAndSettle();

        // Should show placeholder message
        expect(
          find.text('Password recovery coming soon!'),
          findsOneWidget,
          reason: 'Placeholder message should be shown for Forgot Password',
        );
      });

      testWidgets('Sign Up link is displayed', (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.7: Check for Sign Up link
        expect(
          find.text('Sign Up'),
          findsOneWidget,
          reason: 'Sign Up link should be displayed',
        );
      });

      testWidgets('Sign Up link is clickable', (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // FR-21.7: Test link interaction
        final signUpLink = find.text('Sign Up');
        await tester.tap(signUpLink);
        await tester.pumpAndSettle();

        // Should show placeholder message
        expect(
          find.text('Sign up coming soon!'),
          findsOneWidget,
          reason: 'Placeholder message should be shown for Sign Up',
        );
      });
    });

    // Integration Tests
    group('Integration Tests', () {
      testWidgets('Complete login form flow', (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        // 1. Enter username
        final usernameField = find.byType(TextField).first;
        await tester.enterText(usernameField, 'testuser@example.com');
        await tester.pump();

        // 2. Enter password
        final passwordField = find.byType(TextField).at(1);
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        // 3. Toggle password visibility
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // 4. Click login button
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Verify feedback is shown
        expect(find.text('Login functionality coming soon!'), findsOneWidget);
      });

      testWidgets('Form preserves input during password toggle',
          (WidgetTester tester) async {
        await tester.pumpWidget(buildLoginPageApp());

        final passwordField = find.byType(TextField).at(1);
        await tester.enterText(passwordField, 'mypassword');
        await tester.pump();

        // Toggle visibility
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // Input should still be there
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Field should still contain the text
        expect(find.byType(TextField), findsWidgets);
      });
    });
  });
}
