SocialHub App
<p align="center"> <img src="assets/icons/app_icon.png" alt="SocialHub Logo" width="120"/> </p>

📱 About
SocialHub is a feature-rich Flutter social media application developed as part of NeuroApp Internship - Week 06 tasks. This app demonstrates comprehensive REST API integration, state management with Provider, and modern Flutter development practices using clean architecture principles.

🎯 Project Overview
Project	SocialHub App
Week	Week 06 - API Integration & Networking
Platform	Android / iOS
Framework	Flutter 3.x
Architecture	Clean Architecture
State Management	Provider
✅ Tasks Completed
Task 6.1: HTTP GET Requests & JSON Parsing (4 hours)
✅ Added Dio package for HTTP networking
✅ Created Post model class with fromJson() factory
✅ Implemented ApiService class for API operations
✅ Fetched data from JSONPlaceholder public API
✅ Parsed JSON response and mapped to List<Post>
✅ Displayed posts in ListView.builder()
✅ Handled loading states with shimmer effects
✅ Handled error states with retry functionality
Task 6.2: POST, PUT, DELETE Requests (4 hours)
✅ Implemented createPost() with HTTP POST
✅ Implemented updatePost() with HTTP PUT
✅ Implemented deletePost() with HTTP DELETE
✅ Added request headers and JSON body encoding
✅ Created PostFormPage for add/edit operations
✅ Added TextFormFields with validation
✅ Showed SnackBar for success/error messages
✅ Implemented delete with confirmation dialog
Task 6.3: API with Provider (5 hours)
✅ Created User model with fromJson() and toJson()
✅ Created UserProvider extending ChangeNotifier
✅ Managed API states (loading, loaded, error)
✅ Used notifyListeners() for state updates
✅ Created UsersPage with Consumer widget
✅ Implemented RefreshIndicator with pull-to-refresh
✅ Added pagination with ScrollController
✅ Implemented search filtering functionality
Task 6.4: Image Upload & Multipart Requests (4 hours)
✅ Added image_picker package
✅ Created ImagePickerService for image operations
✅ Implemented pickImage() from gallery/camera
✅ Created MultipartRequest for image upload
✅ Showed upload progress with LinearProgressIndicator
✅ Displayed uploaded image from returned URL
✅ Compressed large images before upload
✅ Handled errors with appropriate messages
🏗️ Architecture
🔧 Tech Stack
Category	Technology
Framework	Flutter 3.x
Language	Dart
State Management	Provider
HTTP Client	Dio
Routing	GoRouter
Local Storage	SharedPreferences, Hive
Authentication	Firebase Auth, Google Sign-In
Image Handling	image_picker
UI Components	Google Fonts, Flutter Animate, Shimmer
Architecture	Clean Architecture
🌐 API Integration
Base URL: https://jsonplaceholder.typicode.com

Endpoint	Method	Description
/posts	GET	Fetch all posts
/posts/{id}	GET	Fetch single post
/posts	POST	Create new post
/posts/{id}	PUT	Update existing post
/posts/{id}	DELETE	Delete post
/users	GET	Fetch all users
/users/{id}	GET	Fetch single user
Image Upload API: https://api.imgbb.com/1/upload

📦 Dependencies
🚀 Getting Started
Prerequisites
Flutter SDK 3.x
Dart SDK
Android Studio / VS Code
Firebase project setup
Installation
Clone the repository

Install dependencies

Configure Firebase

Add your google-services.json (Android)
Add your GoogleService-Info.plist (iOS)
Run the app

📸 Features
🔐 Authentication - Google Sign-In & Guest mode
📝 Posts CRUD - Create, Read, Update, Delete posts
👥 Users List - Browse users with search & pagination
🔄 Pull-to-Refresh - Refresh data with swipe gesture
📜 Infinite Scroll - Load more data on scroll
🔍 Search - Filter users by name/email
🖼️ Image Upload - Pick & upload images with progress
🌙 Dark Mode - Theme switching support
✨ Animations - Smooth UI transitions
📁 Key Files Reference
Task	File	Description
6.1	post_model.dart	Post model with fromJson()
6.1	post_remote_data_source.dart	API service for posts
6.2	create_edit_post_screen.dart	CRUD form
6.3	users_provider.dart	Provider with states
6.3	users_screen.dart	Users with pagination
6.4	image_picker_service.dart	Image upload service
👨‍💻 Developer
NeuroApp Internship Program - Week 06

📄 License
This project is developed for educational purposes as part of the NeuroApp Internship Program.

<p align="center"> <b>Built with ❤️ using Flutter</b> </p>

Copy this entire content to your README.md file.

Claude Opus 4.5 • 3x