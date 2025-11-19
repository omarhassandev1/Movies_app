import 'package:flutter/material.dart';
import 'package:movies_app/common/widgets/custom_main_button.dart';
import 'package:movies_app/features/onboarding/view/onboarding_screen.dart';
import 'package:movies_app/gen/assets.gen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  static const String routeName = 'getStarted';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Assets.onboardingAuth.onboardingWallpapers.getStarted.image(
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Find Your Next Favorite Movie Here',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  CustomMainButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushNamed(OnboardingScreen.routeName);
                    },
                    text: 'Get Started',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
