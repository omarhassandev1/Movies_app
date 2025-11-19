import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';
import 'package:movies_app/data/models/user_model.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/main_layer/profile/cubit/profile_state.dart';
import 'package:movies_app/features/main_layer/profile/view/screens/reset_password.dart';

import '../../../../../gen/assets.gen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.user});
  static const String routeName = '/update_profile';
  final UserModel user;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late int selectedAvatar;

  final List<String> avatars = [
    'assets/common/avaters/avater1.png',
    'assets/common/avaters/avater2.png',
    'assets/common/avaters/avater3.png',
    'assets/common/avaters/avater4.png',
    'assets/common/avaters/avater5.png',
    'assets/common/avaters/avater6.png',
    'assets/common/avaters/avater7.png',
    'assets/common/avaters/avater8.png',
    'assets/common/avaters/avater9.png',
  ];

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.user.avaterId;
    nameController.text = widget.user.name;
    phoneController.text = widget.user.cellphone;
    emailController.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick Avatar',
          style: TextStyle(
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            Navigator.pop(context, true);
          }
        },
        builder:
            (context, state) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          GestureDetector(
                            onTap: _showAvatarPicker,
                            child: CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                'assets/common/avaters/avater$selectedAvatar.png',
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          CustomTextField(
                            controller: nameController,
                            prefixIcon: Assets.profile.person.svg(),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          CustomTextField(
                            controller: phoneController,
                            prefixIcon: Assets.profile.cellphone.svg(),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          CustomTextField(
                            controller: emailController,
                            prefixIcon: Assets.onboardingAuth.icons.email.svg(),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(ProfileResetPassword.routeName);
                              },
                              child: const Text(
                                'Reset Password',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
                // Buttons fixed at bottom
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: CustomMainButton(
                          text: 'Delete Account',
                          onPressed: () {},
                          fillColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: CustomMainButton(
                          text: 'Update Data',
                          onPressed: () {
                            context.read<ProfileCubit>().updateProfile({
                              "email": emailController.text,
                              "avaterId": selectedAvatar,
                              "name": nameController.text,
                              "phone": phoneController.text,
                            });
                          },
                          fillColor: AppColors.mainColor,
                          textColor: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.blackColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            height: screenHeight * 0.5,
            child: Column(
              children: [
                const Text(
                  'Pick Avatar',
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: GridView.builder(
                    itemCount: avatars.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: screenWidth * 0.03,
                      mainAxisSpacing: screenHeight * 0.02,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatar = index + 1;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  selectedAvatar == index + 1
                                      ? AppColors.mainColor
                                      : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              avatars[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
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
