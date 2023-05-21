import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/core/validators/text_field_validators.dart';
import 'package:smart_home/features/auth/providers/auth_providers.dart';
import 'package:smart_home/features/home/screens/home_screen.dart';
import 'package:smart_home/lib.dart';
import 'package:smart_home/src/widgets/alert_dialog.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //text controllers
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final forgotPasswordEmailController = useTextEditingController();
    //remember me checkbox
    final rememberMe = useState(false);

    // auth provider
    final auth = ref.read(authServiceProvider);

    final GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            KText(
              'Welcome!',
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
            KText(
              'Glad to see you again! 👋',
              fontSize: 20.sp,
            ),
            SizedBox(
              height: 56.h,
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
                }
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: PasswordTextField(
                label: 'Password',
                controller: passwordController,
                emptyTextError: 'Password is required',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Checkbox(
                          value: rememberMe.value,
                          onChanged: (value) {
                            rememberMe.value = value!;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: const KText('Remember Me'),
                    )
                  ],
                ),

                ///FORGOT PASSWORD
                InkWell(
                  onTap: () async {
                    ///CONTACT FIREBASE HERE
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: 450.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 24.h),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(
                                          Icons.cancel,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: KText(
                                        'Enter your email address here to reset password',
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 24.h,
                                      ),
                                      child: DefaultTextFormField(
                                        label: 'Email address',
                                        hint: 'user@example.com',
                                        controller:
                                            forgotPasswordEmailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: FilledButton(
                                        onPressed: () async {
                                          String email =
                                              forgotPasswordEmailController.text
                                                  .trim();
                                          if (TextFieldValidator.emailExp
                                              .hasMatch(email)) {
                                            showLoadingDialog(context);
                                            await auth
                                                .forgotPassword(email)
                                                .then((value) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              showMessageAlertDialog(context,
                                                  text: value == true
                                                      ? 'Password reset link has been successfully 1sent to your email address'
                                                      : value);
                                            });
                                          } else {
                                            showMessageAlertDialog(context,
                                                text:
                                                    'Provide a valid email address to continue to password reset');
                                          }
                                        },
                                        child: const Text(
                                          'Reset password',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const KText(
                    'Forgot Password?',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),

            ///LOGIN BUTTON
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoadingDialog(context);
                      await auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text)
                          .then((value) {
                        Navigator.pop(context);
                        if (value is UserCredential) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else {
                          showMessageAlertDialog(context, text: value);
                        }
                      });
                    }
                  },
                  child: const KText('Login')),
            ),

            Row(
              children: const [
                Expanded(child: Divider()),
                KText('  Or Login with  '),
                Expanded(child: Divider())
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: OutlinedButton(
                  onPressed: () async {
                    showLoadingDialog(context);
                    await auth.googleSignIn().then((value) {
                      Navigator.pop(context);
                      if (value is User) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      }
                      else {
                        showMessageAlertDialog(context, text: value??'Failed to sign in with Google, try again');
                      }
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(AppAssets.googleIcon),
                      ),
                      const KText('Sign in with Google'),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen())),
              child: Text.rich(
                TextSpan(children: [
                  const TextSpan(text: 'Don\'t have an account?  '),
                  TextSpan(
                      text: 'Signup',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //no longer necessary
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                      style: AppStyle.textStyle
                          .copyWith(fontWeight: FontWeight.w500))
                ]),
                textAlign: TextAlign.center,
                style: AppStyle.textStyle.copyWith(fontSize: 18.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
