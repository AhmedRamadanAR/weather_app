import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_pro/Components/color.dart';
import 'package:weather_pro/Data/Model/onboarding_items.dart';
import 'package:weather_pro/Presentation/screens/location_screen.dart';

class onboarding_screen extends StatefulWidget {
  const onboarding_screen({super.key});

  @override
  State<onboarding_screen> createState() => _onboarding_screenState();
}

class _onboarding_screenState extends State<onboarding_screen> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Skip Button
            TextButton(
                onPressed: () => pageController.jumpToPage(controller.items.length - 1),
                child: const Text("Skip")),

            // Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: primaryColor,
              ),
            ),

            // Next Button
            TextButton(
                onPressed: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child: const Text("Next")),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            final onboardingInfo = controller.items[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Wrapping the image in a Flexible widget to prevent overflow
                Flexible(
                  child: Image.asset(
                    onboardingInfo.image,
                    width: onboardingInfo.width,  // Use custom width
                    height: onboardingInfo.height,  // Use custom height
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  onboardingInfo.title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  onboardingInfo.descriptions,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Get started button
  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", false);

          // Navigate to LocationScreen
          if (!mounted) return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationScreen()));
        },
        child: const Text("Get started", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
