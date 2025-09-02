import 'package:car_travel/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';


// A custom reusable drawer widget for the app.
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use Get.width to make the drawer width responsive
    // Drawer width should be about 75% of the screen width for mobile.
    final double drawerWidth = Get.width * 0.75;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        // The drawer's background color is white.
        child: Container(
          color: AppColors.primaryWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer header with user profile details
              const SizedBox(height: 20),
              _buildDrawerHeader(),
              const SizedBox(height: 10),
              // List of menu items with correct spacing and alignment
              _buildDrawerItem(
                icon: Icons.person_outline,
                text: 'Edit Profile',
                onTap: () {
                  Get.back(); // Close the drawer
                  // Navigate to Edit Profile screen
                  // Get.toNamed('/edit_profile');
                },
              ),
              _buildDrawerItem(
                icon: Icons.history,
                text: 'History',
                onTap: () {
                  Get.back(); // Close the drawer
                  Get.toNamed(AppRoutes.allRidesPage);
                },
              ),
              _buildDrawerItem(
                icon: Icons.error_outline,
                text: 'Complaint',
                onTap: () {
                  Get.back();
                  // Navigate to Complaint screen
                  // Get.toNamed('/complaint');
                },
              ),
              _buildDrawerItem(
                icon: Icons.people_outline,
                text: 'Referral',
                onTap: () {
                  Get.back();
                  // Navigate to Referral screen
                  // Get.toNamed('/referral');
                },
              ),
                Divider(color: AppColors.dividerColor),
              _buildDrawerItem(
                icon: Icons.info_outline,
                text: 'About Us',
                onTap: () {
                  Get.back();
                  // Navigate to About Us screen
                  // Get.toNamed('/about_us');
                },
              ),
              _buildDrawerItem(
                icon: Icons.settings_outlined,
                text: 'Setting',
                onTap: () {
                  Get.back();
                  // Navigate to Setting screen
                  // Get.toNamed('/setting');
                },
              ),
              _buildDrawerItem(
                icon: Icons.help_outline,
                text: 'Help & Support',
                onTap: () {
                  Get.back();
                  // Navigate to Help & Support screen
                  // Get.toNamed('/help_and_support');
                },
              ),
              _buildDrawerItem(
                icon: Icons.logout,
                text: 'Log Out',
                onTap: () {
                  Get.back();
                  // Perform logout action
                  // controller.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the drawer header with user info.
  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/images/user.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            'Chetan Patil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.headlineTextColor,
            ),
          ),
          Text(
            'patilc146@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.subheadlineTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build each menu item in the drawer.
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryBlack,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryBlack,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
