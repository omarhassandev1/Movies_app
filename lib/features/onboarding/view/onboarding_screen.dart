import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/features/onboarding/view/widgets/custom_outlined_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/view/login/login_screen.dart';
import '../data/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    OnboardingItem onboardingItem = OnboardingItem.items[currentPage];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            controller: _controller,
            itemCount: OnboardingItem.items.length,
            itemBuilder: (context, index) {
              return onboardingItem.image;
            },
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24,
                ),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      onboardingItem.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    if (onboardingItem.description != null)
                      Text(
                        onboardingItem.description!,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    CustomMainButton(
                      onPressed: () {
                        if (currentPage < OnboardingItem.items.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          setState(() {
                            currentPage++;
                          });
                        } else {
                          completeOnboarding();
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                        }
                      },
                      text:
                          currentPage == OnboardingItem.items.length - 1
                              ? 'Finish'
                              : 'Next',
                    ),
                    if (currentPage != 0)
                      CustomOutlinedButton(
                        onPressed: () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                          setState(() {
                            currentPage--;
                          });
                        },
                        text: 'Back',
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
