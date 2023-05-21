import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/services/location.dart';

final locationProvider = Provider((ref) => LocationService(ref));

final allowedLocationProvider = StateProvider<bool>((ref) => false);

final currentLocation = StateProvider<Position?>((ref) => null);

final locationFProvider =
    FutureProvider((ref) => ref.watch(locationProvider).determinePosition());
