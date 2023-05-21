import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/core/validators/text_field_validators.dart';
import 'package:smart_home/features/auth/models/user.dart';
import 'package:smart_home/features/auth/providers/providers.dart';
import 'package:smart_home/features/home/screens/home_screen.dart';
import 'package:smart_home/lib.dart';
import 'package:smart_home/src/widgets/alert_dialog.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final emailController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final passwordController = useTextEditingController();
    AutovalidateMode validateMode = AutovalidateMode.onUserInteraction;
    final auth = ref.read(authServiceProvider);
     return Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              KText(
                'Welcome!',
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
              KText(
                'Fill in the details below to create your account',
                fontSize: 18.sp,
              ),
              SizedBox(
                height: 56.h,
              ),
              DefaultTextFormField(
                label: 'Full name',
                hint: 'Type your full name here',
                controller: fullNameController,
                emptyTextError: 'Full name is required',
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Full Name is required';
                  } else if (value.isNotEmpty &&
                      !TextFieldValidator.nameExp.hasMatch(value)) {
                    return 'Full Name is not valid';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              DefaultTextFormField(
                label: 'Email address',
                hint: 'user@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Email address is required';
                  } else if (value.isNotEmpty &&
                      !TextFieldValidator.emailExp.hasMatch(value)) {
                    return 'Email address not valid';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: PasswordTextField(
                    label: 'Password',
                    controller: passwordController,
                    emptyTextError: 'Password is required',
                    isSignUp: true),
              ),
              SizedBox(
                height: 16.h,
              ),

              ///SIGNUP BUTTON
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        UserReqModel newUser = UserReqModel(
                          password: passwordController.text.trim(),
                          fullName: fullNameController.text.trim(),
                          email: emailController.text.trim(),
                        );
                        await auth
                            .signUpWithEmailAndPassword(user: newUser)
                            .then((value) {
                          Navigator.pop(context);
                          //if successful, take user to homeScreen
                          if (value is UserReqModel) {
                            //save user details
                            auth.storeUserDetails(value).then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (route) => false);
                              } else {
                                showMessageAlertDialog(context,
                                    text: 'Failed to store account details',
                                    actionText: 'Try again');
                              }
                            });
                          } else {
                            //else notify user that signUp failed
                            showMessageAlertDialog(context,
                                text: value, actionText: 'Try again');
                          }
                        });
                      } else {
                        validateMode = AutovalidateMode.always;
                      }
                    },
                    child: const KText('Create Account')),
              ),
              SizedBox(
                height: 16.h,
              ),
              /*Row(
                children: const [
                  Expanded(
                    child: Divider(),
                  ),
                  KText('  Or Signup with  '),
                  Expanded(
                    child: Divider(),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: OutlinedButton(
                    onPressed: () async {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(AppAssets.googleIcon),
                        ),
                        const KText('Sign Up with Google'),
                      ],
                    )),
              ),*/
            ],
          ),
        ),
      );
  }
}
