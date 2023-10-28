import 'package:field_scheduling/data/services/weather_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await dotenv.load();
  });

  group('Weather Services', () {
    test("Get data weather court A", () async {
      bool success = false;
      final response = await WeatherService().getData("A");
      if (response != null) {
        success = true;
      }
      expect(success, true);
    });

    test("Get data weather court B", () async {
      bool success = false;
      final response = await WeatherService().getData("B");
      if (response != null) {
        success = true;
      }
      expect(success, true);
    });

    test("Get data weather court C", () async {
      bool success = false;
      final response = await WeatherService().getData("C");
      if (response != null) {
        success = true;
      }
      expect(success, true);
    });
  });
}
