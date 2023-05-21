import 'package:smart_home/lib.dart';

/*
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [],
      ),
    );
  }
}
*/

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController slideController;
  int _currentPage = 0;
  final _tween = Tween<Offset>(
    begin: const Offset(.0, .8),
    end: const Offset(.0, -.4),
  );

  @override
  void initState() {
    super.initState();
    slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = _tween.animate(slideController);
    slideController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    slideController.dispose();
  }

  void _onPageChanged(int index) {
    if (index != _currentPage) {
      setState(() {
        _currentPage = index;
      });
      slideController.reset();
      slideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F2FF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 720.h,
              child: PageView(
                onPageChanged: _onPageChanged,
                children: [
                  ...List.generate(
                      3,
                      (index) => Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              index == _currentPage
                                  ? SlideTransition(
                                      position: _animation,
                                      child: Image.asset(AppAssets.onboarding),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: 360.w,
                                height: 136.h,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(18.w),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Header',
                                          style: AppStyle.textStyle.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          'A couple of texts for description',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnboardingScreen()));
                    },
                    child: Text('Button'),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text('Button'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
