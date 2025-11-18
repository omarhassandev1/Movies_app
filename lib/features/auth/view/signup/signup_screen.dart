import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';
import 'package:movies_app/features/auth/view/login/login_screen.dart';
import 'package:movies_app/features/auth/view/signup/widgets/avatar_picker.dart';

import '../../../../gen/assets.gen.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = 'registerScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  int selectedAvatarIndex = 5;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Row(
            spacing: 10,
            children: [
              Icon(Icons.verified_outlined),
              Text("Login Successful!"),
            ],
          )));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Row(
            spacing: 10,
            children: [
              const Icon(Icons.error_outline),
              Text(state.errorMessage),
            ],
          )));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                AvatarPicker(
                  onAvatarSelected: (index) {
                    setState(() {
                      selectedAvatarIndex = index;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Name',
                        controller: nameController,
                        prefixIcon: Assets.onboardingAuth.icons.name.svg(),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: 'confirm Password',
                        controller: confirmPasswordController,
                        prefixIcon: Assets.onboardingAuth.icons.password.svg(),
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: 'PhoneNumber',
                        controller: cellPhoneController,
                        prefixIcon: Assets.onboardingAuth.icons.cellphone.svg(),
                      ),

                      const SizedBox(height: 30),
                      isLoading
                          ? const CircularProgressIndicator()
                          : CustomMainButton(
                            text: 'Create Account',
                            fillColor: Colors.amber,
                            onPressed: () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final confirmPassword =
                                  confirmPasswordController.text.trim();
                              final cellPhone = cellPhoneController.text.trim();
                              final name = nameController.text.trim();

                              final int finalAvatarId = selectedAvatarIndex + 1;

                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  cellPhone.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill all fields"),
                                  ),
                                );
                                return;
                              }

                              if (cellPhone.length < 11) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Phone must be at least 11 characters",
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Passwords do not match"),
                                  ),
                                );
                                return;
                              }

                              context.read<AuthCubit>().register(
                                name: name,
                                email: email,
                                cellphone: cellPhone,
                                avatarNo: finalAvatarId,
                                password: password,
                                confirmPassword: confirmPassword,
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
