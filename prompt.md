## Login Feature Implementation Prompt

## Feature Overview
Add a login page to the Union Shop app that is accessible via a person/profile icon in the app header. The login page should contain username and password input fields. Authentication functionality is not required at this stage.

## Feature Requirements

### FR-18: Login Page Access
- **FR-18.1**: Add a person/profile icon button to the app header (AppScaffold)
- **FR-18.2**: Icon should be positioned on the right side of the header
- **FR-18.3**: Icon color should match the app's primary color scheme (0xFF4d2963)
- **FR-18.4**: Icon should have a hover effect on desktop (slightly lighter color)
- **FR-18.5**: Clicking the icon should navigate to the login page route `/login`

### FR-19: Login Page UI
- **FR-19.1**: Create a new `LoginPage` widget in `lib/views/login_page.dart`
- **FR-19.2**: Page should display a centered login form container
- **FR-19.3**: Login form should have a white background with subtle shadow
- **FR-19.4**: Form should be responsive and work on both mobile and desktop
- **FR-19.5**: Page should include the AppScaffold wrapper with currentRoute set to `/login`

### FR-20: Login Form Fields
- **FR-20.1**: Add a "Username" text input field
- **FR-20.2**: Field should have a label and placeholder text
- **FR-20.3**: Field should have standard padding and spacing
- **FR-20.4**: Add a "Password" text input field
- **FR-20.5**: Password field should obscure text (hide input)
- **FR-20.6**: Password field should have a visibility toggle button (show/hide icon)
- **FR-20.7**: Both fields should have validation styling (e.g., border color on focus)

### FR-21: Login Form Actions
- **FR-21.1**: Add a "Login" button below the form fields
- **FR-21.2**: Button should use the app's primary color (0xFF4d2963)
- **FR-21.3**: Button should have a hover effect on desktop (darker color)
- **FR-21.4**: Button should have rounded corners matching the app's design system
- **FR-21.5**: Clicking the login button should show a placeholder message or toast (no actual authentication)
- **FR-21.6**: Add a "Forgot Password?" link below the login button (non-functional at this stage)

### FR-22: Route Configuration
- **FR-22.1**: Add the `/login` route to the routes map in `main.dart`
- **FR-22.2**: Route should return `const LoginPage()`

## User Actions & Expected Behavior

1. **User clicks the profile icon in the header**
   - App navigates to the login page
   - Login page displays with form fields ready for input

2. **User enters username/email**
   - Text field accepts input
   - Text displays in the field

3. **User enters password**
   - Text is hidden/obscured
   - User can toggle visibility with the eye icon to see the password

4. **User clicks the visibility toggle**
   - Password text becomes visible or hidden accordingly
   - Icon changes to reflect the current state

5. **User clicks the login button**
   - Button shows visual feedback (no actual authentication yet)
   - A placeholder message appears (e.g., "Login functionality coming soon")

6. **User clicks "Forgot Password?" or "Sign Up"**
   - Links are visible and clickable but non-functional at this stage