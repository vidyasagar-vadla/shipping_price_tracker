# Shipping Price Tracker

## Overview
This project is a Flutter-based mobile application that allows users to book a shipment by entering pickup and delivery addresses, selecting a courier service, and receiving an estimated price for the delivery. The backend is powered by Flask, which serves the estimated price data. The app works across all devices as long as the Flask server is running.

## Features
- **User Input:** Pickup and delivery address fields.
- **Courier Selection:** Dropdown to select courier (e.g., Delhivery, DTDC, Bluedart, etc.).
- **Price Calculation:** Estimated price is fetched from the Flask server.
- **Cross-Device Compatibility:** Works on Android devices when Flask server is active.

## Tech Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Flask (Python)
- **IDE:** Android Studio (for Flutter development)
- **API Communication:** REST API (Flask-RESTful)
- **Data Storage:** JSON (stored directly in the Flask server)

## Installation & Setup
### Prerequisites
- Install **Flutter** and **Dart SDK**
- Install **Android Studio**
- Install **Python 3.x** and **Flask**
- Install required Python packages: `pip install flask flask-restful flask-cors`

### Backend (Flask) Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/book-a-shipment.git
   cd book-a-shipment/backend
   ```
2. Run the Flask server:
   ```sh
   python app.py
   ```
   The Flask server should start on `http://127.0.0.1:5000/`.

### Frontend (Flutter) Setup
1. Navigate to the Flutter app directory:
   ```sh
   cd book-a-shipment/flutter_app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Modify `baseUrl` in `main.dart` to match the Flask server's IP address (your computer's local IP):
   ```dart
   final String baseUrl = "http://YOUR_COMPUTER_IP:5000";
   ```
4. Run the app on an emulator or a connected device:
   ```sh
   flutter run
   ```

## Implementation
1. **Start the Flask Server:**
   ```sh
   python app.py
   ```
2. **Run the Flutter App:**
   ```sh
   flutter run
   ```
3. **Ensure that the IP Address in `main.dart` is updated to your computer's local IP** (e.g., `http://192.168.1.100:5000`).
4. **Test the app by entering pickup and delivery addresses and selecting a courier to get the estimated price.**
5. **Add internet permissions in androidManifest.xml**
6. **Or u can directly install it apk provided but the flask server should run on my computer if it wants to work**

## Notes
- Ensure that the Flask server is running before launching the Flutter app.
- Modify `baseUrl` in the Flutter app to match the Flask server address if running on a different machine.
- The UI includes smooth animations and Material Design components for a seamless experience.

---
