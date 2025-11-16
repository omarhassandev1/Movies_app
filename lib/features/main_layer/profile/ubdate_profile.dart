import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/common/widgets/custom_textfield.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String routeName = '/update_profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedAvatar = 'assets/common/avaters/avater1.png';

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

        return Container(
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
                          selectedAvatar = avatars[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedAvatar == avatars[index]
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pick Avatar',
          style: TextStyle(
            color: AppColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    GestureDetector(
                      onTap: _showAvatarPicker,
                      child: CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage(selectedAvatar),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomTextField(
                      hintText: 'John Safwat',
                      prefixIcon: const Icon(Icons.person, color: AppColors.whiteColor),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      hintText: '012000000000',
                      prefixIcon: const Icon(Icons.phone, color: AppColors.whiteColor),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
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
                    onPressed: () {},
                    fillColor: AppColors.mainColor,
                    textColor: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




