import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:smart_home/features/home/providers/location.dart';

final weatherProvider =
    Provider((ref) => OpenWeather(apiKey: 'ef20ca67059671c54e16e76cc6d972e6'));

final weatherFProvider = FutureProvider<WeatherData>((ref) {
  Position? current = ref.watch(currentLocation);
  if (current != null) {
    return ref.read(weatherProvider).currentWeatherByLocation(
        latitude: current.latitude, longitude: current.longitude,weatherUnits: WeatherUnits.METRIC);
  } else {
    return ref
        .read(weatherProvider)
        .currentWeatherByCityName(cityName: 'Stockholm',weatherUnits: WeatherUnits.METRIC);
  }
});
