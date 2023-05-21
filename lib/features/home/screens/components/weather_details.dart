import 'package:smart_home/lib.dart';

class WeatherDetails extends StatelessWidget {
  final String title;
  final String body;
  const WeatherDetails({Key? key,required this.title,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      KText(body,fontWeight: FontWeight.w500,color: Colors.white,),
      SizedBox(height: 4.h,),
      KText(title,color: Colors.white54,)
    ],);
  }
}
