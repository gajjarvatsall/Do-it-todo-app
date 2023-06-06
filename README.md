# Doit - Todo App

Doit is a simple and intuitive Todo app developed using Flutter and Firebase. It follows the BLoC (Business Logic Component) design pattern and utilizes Google Firebase Authentication for user authentication and Firebase Firestore as the backend database.

## Features

- User authentication using Google Firebase Auth.
- Create, read, update, and delete (CRUD) operations for Todo items.
- Real-time data synchronization using Firebase Firestore.
- Responsive and user-friendly UI design.
- BLoC pattern for efficient state management.

## Installation

To run the Doit app locally on your development environment, follow these steps:

1. Make sure you have Flutter SDK and Dart installed on your machine. Refer to the official Flutter documentation for installation instructions: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. Clone the repository:

```bash
git clone https://github.com/gajjarvatsall/Do-it-todo-app.git
```

3. Navigate to the project directory:

  
```bash
cd doit-app
```

4. Install the required dependencies:

  
```bash
flutter pub get
```

5. Configure Firebase:

- Create a new Firebase project on the [Firebase Console](https://console.firebase.google.com).
- Enable Google Firebase Authentication and Firestore for your project.
- Download the `google-services.json` file from the Firebase project settings.
- Place the `google-services.json` file in the `android/app` directory of the project.

6. Run the app:

  
```bash
flutter run
```

## Configuration

The configuration files for Firebase Authentication and Firestore are already included in the project. However, if you want to use your own Firebase project, follow these steps:

1. Firebase Authentication:

- Replace the `google-services.json` file with your own file obtained from the Firebase Console.
- Update the `android/app/build.gradle` file with your Firebase Authentication dependencies.

2. Firestore:

- Update the `google-services.json` file with your own file obtained from the Firebase Console.

## BLoC Architecture

The Doit app follows the BLoC (Business Logic Component) architectural pattern for managing the state of the application. The key components of the BLoC pattern used in this app are:

- `TodoBloc`: Manages the state and business logic related to Todo items.
- `TodoEvent`: Defines the events that can occur in the app, such as adding a new Todo item or deleting an existing item.
- `TodoState`: Represents the various states of the Todo items, such as loading, success, or error states.

## Dependencies

The following dependencies are used in the Doit app:

- `flutter_bloc`: Implements the BLoC pattern for state management.
- `firebase_auth`: Provides authentication services using Google Firebase.
- `cloud_firestore`: Integrates Firebase Firestore as the backend database.
- `google_sign_in`: Allows Google Sign-In functionality for Firebase Authentication.
- `fluttertoast`: Displays toast messages for user feedback.

These dependencies are specified in the `pubspec.yaml` file and will be automatically installed when running `flutter pub get`.

## Contributing

Contributions to the Doit app are welcome! If you find any bugs, have suggestions for improvements, or want to add new features, please submit a pull request. Make sure to follow the existing code style and conventions.

## License

The Doit app is released under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

For any questions or inquiries, please contact the project maintainer:

- Name: Vatsal Gajjar
- Email: vatsalgajjar84@gmail.com

Thank you for using Doit!
