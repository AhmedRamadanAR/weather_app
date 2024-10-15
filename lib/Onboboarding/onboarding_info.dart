class OnboardingInfo {
 final String title;
 final String descriptions;
 final String image;
 final double width;
 final double height;

 OnboardingInfo({
  required this.title,
  required this.descriptions,
  required this.image,
  this.width = 250,  // Default width
  this.height = 250, // Default height
 });
}
