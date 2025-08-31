import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/CustomDrawer.dart';
import '../../../Utils/app_colors.dart';
import '../../../controllers/RideCompletedController.dart';

class RideCompletedView extends StatelessWidget {
  const RideCompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final RideCompletedController controller = Get.find<RideCompletedController>();

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // Background Image (map)
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_background.png', // Ensure this path is correct in your project
              fit: BoxFit.cover,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 100), // Adjust top margin to fit the image
            decoration: const BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10 , top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "You've reached your destination!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headlineTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDriverDetails(),
                    const SizedBox(height: 15),
                    const Text(
                      "How was the trip?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    _buildRatingStars(controller),
                    const SizedBox(height: 10),
                    const Text(
                      "Support the driver",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    _buildTipButtons(controller, context),
                    const SizedBox(height: 20),
                    _buildCommentBox(),
                    const SizedBox(height: 30),
                    _buildActionButtons(controller),
                  ],
                ),
              ),
            ),
          ),

          // App Bar icons, positioned independently to be on top of the map
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Builder(
                builder: (BuildContext innerContext) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCircularIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: () => Get.back(),
                    ),
                    _buildCircularIconButton(
                      icon: Icons.menu_rounded,
                      onPressed: () { Scaffold.of(innerContext).openDrawer();},
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  // A reusable button with a circular background
  Widget _buildCircularIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: AppColors.primaryBlack,
        onPressed: onPressed,
      ),
    );
  }

  // Driver photo, name, and ETA
  Widget _buildDriverDetails() {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user.jpg'),
          radius: 40,
        ),
        const SizedBox(height: 10),
        const Text(
          'Chetan Patil',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.headlineTextColor,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.access_time_filled, size: 16, color: AppColors.subheadlineTextColor),
            SizedBox(width: 5),
            Text('23 min.', style: TextStyle(color: AppColors.subheadlineTextColor)),
          ],
        ),
      ],
    );
  }

  // Star rating section using Obx for reactivity
  Widget _buildRatingStars(RideCompletedController controller) {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              Icons.star_rounded,
              size: 50,
              color: index < controller.rating.value
                  ? AppColors.primaryYellow
                  : AppColors.dividerColor.withOpacity(0.5),
            ),
            onPressed: () {
              controller.setRating(index + 1);
            },
          );
        }),
      ),
    );
  }

  // Tip buttons with reactive state
  Widget _buildTipButtons(RideCompletedController controller, BuildContext context) {
    final tips = [0, 5, 10];
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...tips.map((tip) {
            return Expanded(
              child: _TipButton(
                amount: tip,
                isSelected: controller.tipAmount.value == tip,
                onPressed: () => controller.setTipAmount(tip),
              ),
            );
          }),
          Expanded(
            child: _TipButton(
              amount: -1,
              isSelected: controller.tipAmount.value == -1,
              onPressed: () {
                controller.tipAmount.value = -1;
                controller.showCustomTipDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Comment input box
  Widget _buildCommentBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Add a comment for the driver...",
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
        filled: true,
        fillColor: AppColors.textFieldBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: 3,
    );
  }


  Widget _buildActionButtons(RideCompletedController controller) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.completeRide(),
            style: ElevatedButton.styleFrom(
              shadowColor: AppColors.greenAccent,
              backgroundColor: AppColors.primaryYellow.withOpacity(0.1),
              foregroundColor: AppColors.buttonTextYellow,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Complete by paying online',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFD700), // A yellow color from the image
                  Color(0xFFEFBA03), // A slightly more orange-yellow
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              onPressed: () => controller.completeRide(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primaryBlack,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Already paid? Complete now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// A custom button widget for the tip amounts
class _TipButton extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onPressed;

  const _TipButton({
    required this.amount,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? AppColors.primaryYellow : AppColors.dividerColor,
            width: isSelected ? 2.0 : 1.0,
          ),
          backgroundColor: isSelected ? AppColors.primaryYellow.withOpacity(0.1) : Colors.white,
          foregroundColor: AppColors.primaryBlack,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          amount == -1 ? 'Custom' : '\$$amount',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
