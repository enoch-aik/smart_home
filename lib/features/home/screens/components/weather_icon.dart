import 'dart:typed_data';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:smart_home/lib.dart';

class WeatherIconImage extends StatelessWidget {
  final String iconPath;
  final bool x2Size;

  const WeatherIconImage(
      {Key? key, required this.iconPath, this.x2Size = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image:
          'https://openweathermap.org/img/wn/$iconPath${x2Size ? '@2x' : ''}.png',
      imageErrorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.cloud_off_sharp,
          size: 60,
          color: Colors.black12,
        ); //do something
      },
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .fade(duration: 4000.ms);
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);
