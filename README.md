

---

# Grocery App 🛒

A **Grocery App** built with **Flutter** and powered by **GetX** state management, providing a seamless user experience with features like browsing categories, adding products to the cart, favoriting items, and purchasing products based on user demand. The app integrates with a **Laravel API** for backend services and uses **MySQL** (via **phpMyAdmin**) for database storage.

---

## 📱 Features

- **User Authentication** (optional): Secure login/signup via Laravel API.
- **Category Browsing**: View categories of grocery products.
- **Product Management**: Add products to the cart or favorites.
- **Cart System**: Customize product quantity and proceed to checkout.
- **Favorites List**: Manage a list of favorite items.
- **Seamless UI**: Modern, responsive, and attractive UI for a great user experience.
- **Real-time State Management**: Implemented using GetX for better performance and easy state handling.

---

## 🗂️ Folder Structure

The project follows a modular structure for scalability and better maintainability. Below is the structure of the `lib` folder:

```
lib/
│
├── controllers/    # State management and logic controllers
├── models/         # Data models used across the app
├── repositories/   # Communication with backend API (Laravel)
├── routes/         # Application routes
├── services/       # Utility services (e.g., API calls, shared preferences)
├── ui/             # All UI screens and widgets
├── utils/          # Helper classes and utility functions
└── main.dart       # Entry point of the application
```

---

## 🛠️ Technologies Used

### **Frontend**:  
- **Flutter**: Dart-based UI toolkit for building natively compiled applications.
- **GetX**: Lightweight state management for better performance.
  
### **Backend**:
- **Laravel**: Handles API services and user authentication.
  
### **Database**:
- **MySQL**: Storage for products, categories, user data, etc.
- **phpMyAdmin**: Database management system for MySQL.

---

## 🚀 Installation & Setup

### Prerequisites:
1. Flutter SDK installed: [Get Flutter](https://flutter.dev/docs/get-started/install)
2. Laravel backend: Make sure your Laravel API is running.
3. MySQL database setup: Ensure your database is accessible via **phpMyAdmin**.

### Steps to Run:
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/grocery_app.git
   cd grocery_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Connect to Backend API**:
   - Update the API base URL in your service layer to match your Laravel backend:
     ```dart
     ApiService(
      baseUrl: 'http://10.0.2.2:8000/api',
      commonHeaders: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },;
     ```

4. **Run the App**:
   ```bash
   flutter run
   ```

---

## 🖼️ UI Screenshots

_(Add screenshots of your app here for better visualization)_

| Home Screen           | Categories Screen      | Cart Screen           |
|-----------------------|------------------------|-----------------------|
| ![Home](./screenshots/home.png) | ![Categories](./screenshots/categories.png) | ![Cart](./screenshots/cart.png) |

---

## 📌 API Endpoints (Laravel)

Ensure your Laravel API provides these endpoints:

- **User Authentication**:  
  - `POST /api/login`
  - `POST /api/register`
    
- **User Information**:
  - `GET  /api/user`
  
- **Product Management**:  
  - `GET /api/categories`
  - `GET /api/categories/2/products`
  - `GET /api/products`
 
 - **Cart Management**:
  - `POST /api/cart/pay`
  - `POST /api/cart`
  - `GET /api/cart`


- **Favorites Management**:
- `GET /api/favorites`   

---

## 📋 Contribution

Contributions are welcome! If you have any suggestions, feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙌 Acknowledgements

- [Flutter](https://flutter.dev)
- [GetX](https://pub.dev/packages/get)
- [Laravel](https://laravel.com)
- [phpMyAdmin](https://www.phpmyadmin.net/)

---

Let me know if you need further customization or tweaks!
