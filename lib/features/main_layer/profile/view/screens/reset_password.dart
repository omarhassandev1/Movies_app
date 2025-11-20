import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/cubit/auth_state.dart';
import '../../../../../common/widgets/custom_main_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../../gen/assets.gen.dart';

class ProfileResetPassword extends StatefulWidget {
  const ProfileResetPassword({super.key});
  static const String routeName = 'resetPassword';

  @override
  State<ProfileResetPassword> createState() => _ProfileResetPasswordState();
}

class _ProfileResetPasswordState extends State<ProfileResetPassword> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthPassUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully")),
            );
            Navigator.pop(context); 
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Column(
                spacing: 24,
                children: [
                  Assets.onboardingAuth.forgetPassword.newPassword.svg(height: 400),
            
                  CustomTextField(
                    hintText: 'Current password',
                    isPassword: true,
                    controller: currentPassController,
                  ),
            
                  CustomTextField(
                    hintText: 'New password',
                    isPassword: true,
                    controller: newPassController,
                  ),
            
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    CustomMainButton(
                      onPressed: () {
                        final data = {
                          "oldPassword": currentPassController.text.trim(),
                          "newPassword": newPassController.text.trim(),
                        };
            
                        context.read<AuthCubit>().resetPassword(data);
                      },
                      text: 'Change password',
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
