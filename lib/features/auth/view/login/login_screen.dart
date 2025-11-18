import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';
import 'package:movies_app/features/auth/view/signup/signup_screen.dart';
import '../../../../gen/assets.gen.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';
import '../forget_password/verify_email.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = 'loginScreen';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                spacing: 10,
                children: [
                  Icon(Icons.verified_outlined),
                  Text("Login Successful!"),
                ],
              ),
              backgroundColor: AppColors.greenColor,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                spacing: 10,
                children: [
                  const Icon(Icons.error_outline),
                  Text(state.errorMessage),
                ],
              ),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Assets.common.logo.image(height: 120),
                  const SizedBox(height: 64),
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailController,
                    prefixIcon: Assets.onboardingAuth.icons.email.svg(),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    prefixIcon: Assets.onboardingAuth.icons.password.svg(),
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(VerifyEmailScreen.routeName);
                        },
                        child: Text(
                          'Forget Password?',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.mainColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : CustomMainButton(
                        text: 'Login',
                        fillColor: Colors.amber,
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields"),
                              ),
                            );
                            return;
                          }
                          context.read<AuthCubit>().login(email, password);
                        },
                      ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(SignUpScreen.routeName);
                        },
                        child: const Text(
                          'Create one',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider(color: AppColors.mainColor, endIndent: 10,thickness: 2,)),
                        Text('OR'),
                        Expanded(child: Divider(color: AppColors.mainColor, indent: 10,thickness: 2,)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  CustomMainButton(onPressed: (){}, text: 'Login with Google',icon: Assets.onboardingAuth.icons.google.svg(),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
