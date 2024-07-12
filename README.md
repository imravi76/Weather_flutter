# Flutter Weather App

A comprehensive weather application built using Flutter. This app fetches weather data from a weather API and displays it in a user-friendly manner with advanced features like multiple city management, offline caching, and unit settings.

## Features

- Current weather display
- 8-day weather forecast
- Hourly forecast for 48 hours
- Rain and snow details
- Weather alerts
- Multiple city management
- Offline cache for weather data
- Unit settings (metric and imperial)

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install)
- You have installed [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter and Dart plugins
- You have a connected device or emulator to run the app

### Installation

1. **Clone the repository**

   ```sh
   git clone https://github.com/imravi76/Weather_flutter.git
   cd Weather_flutter
   ```

2. **Get the dependencies**

   Run the following command to install the required dependencies:

   ```sh
   flutter pub get
   ```

### Setup

1. **API Key**

   This app uses a weather API. You need to get an API key from a weather service provider such as [OpenWeatherMap](https://openweathermap.org/).

2. **Configure API Key**

   Open `lib/fetch_weather.dart` and add your API key:

   ```dart
   String apiKey = 'YOUR_API_KEY_HERE';
   ```

### Running the App

1. **Run on Emulator**

   Start your emulator from Android Studio or using the command line:

   ```sh
   flutter emulators --launch [emulator_id]
   ```

2. **Run on Connected Device**

   Make sure your device is connected and debugging mode is enabled. Run the following command:

   ```sh
   flutter run
   ```

### Building the App

To build the app for release, run:

```sh
flutter build apk --release
```

This command will generate an APK file at `build/app/outputs/flutter-apk/app-release.apk`.

## Usage

- **Add and Manage Cities**: Use the city manager to add multiple cities and switch between them.
- **View Weather Details**: Check the current weather, 8-day forecast, and 48-hour hourly forecast.
- **Rain and Snow Details**: Get detailed information about rain and snow forecasts.
- **Weather Alerts**: Receive alerts for severe weather conditions.
- **Offline Cache**: Access weather data even when offline.
- **Unit Settings**: Switch between metric and imperial units.

## Contributing

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/featureName`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/featureName`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [OpenWeatherMap](https://openweathermap.org/)
