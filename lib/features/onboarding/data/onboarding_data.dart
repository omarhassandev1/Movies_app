import 'package:flutter/cupertino.dart';

import '../../../gen/assets.gen.dart';

class OnboardingItem {
  final String title;
  final String? description;
  final Widget image;

  const OnboardingItem({
    required this.title,
    this.description,
    required this.image,
  });

  static List<OnboardingItem> items = [
    OnboardingItem(
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      image: Assets.onboardingAuth.onboardingWallpapers.onboarding1.image(fit: BoxFit.cover),
    ),
    OnboardingItem(
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      image: Assets.onboardingAuth.onboardingWallpapers.onboarding2.image(fit: BoxFit.cover),
    ),
    OnboardingItem(
      title: "Create Watchlists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      image: Assets.onboardingAuth.onboardingWallpapers.onboarding3.image(fit: BoxFit.cover),
    ),
    OnboardingItem(
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      image: Assets.onboardingAuth.onboardingWallpapers.onboarding4.image(fit: BoxFit.cover),
    ),
    OnboardingItem(
      title: "Start Watching Now",
      image: Assets.onboardingAuth.onboardingWallpapers.onboarding5.image(fit: BoxFit.cover),
    ),
  ];
}
