import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/CustomDrawer.dart';
import '../../../Utils/app_colors.dart';
import '../../../controllers/PaymentController.dart';


class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // Background Image (map)
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main content container with a rounded top and shadow.
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.13), // Responsive margin
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip details section
                   // _buildSectionTitle('Trip Details'),
                   // const SizedBox(height: 10),
                    _buildTripDetailRow(Icons.access_time, 'Trip Duration', '25 mins'),
                    _buildTripDetailRow(Icons.location_on, 'Distance', '5.2 km'),
                    const Divider(height: 30, color: AppColors.dividerColor),

                    // Fare breakdown section
                  //  _buildSectionTitle('Fare Details'),
                  //  const SizedBox(height: 10),
                    _buildFareRow('Base Fare', '\$5.00'),
                    _buildFareRow('Distance Charge', '\$8.00'),
                    _buildFareRow('Time Charge', '\$2.00'),
                    const SizedBox(height: 10),
                    _buildTotalAmountRow('Total Amount', '\$15.00'),
                    const Divider(height: 30, color: AppColors.dividerColor),

                    // Payment Methods section
                    _buildSectionTitle('Payment Methods'),
                    const SizedBox(height: 10),
                    _buildPaymentMethodOption(
                      icon: Icons.credit_card,
                      label: '•••• 4242',
                      subtitle: 'Expires 12/24',
                      index: 0,
                      controller: controller,
                      trailingIcon: Icons.check_circle,
                      isTrailingIconYellow: true,
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentMethodOption(
                      icon: Icons.add_circle_outline,
                      label: 'Add New Card',
                      index: 1,
                      controller: controller,
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentMethodOption(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Digital Wallet',
                      index: 2,
                      controller: controller,
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentMethodOption(
                      icon: Icons.attach_money_outlined,
                      label: 'Cash',
                      index: 3,
                      controller: controller,
                    ),
                    const SizedBox(height: 30),

                    // Pay button
                    _buildPayButton(controller),
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
                    _buildCircularIconButton(Icons.arrow_back_ios_new, () => Get.back()),
                    _buildCircularIconButton(Icons.menu_rounded, () {Scaffold.of(innerContext).openDrawer();}),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTripDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.subheadlineTextColor),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: AppColors.subheadlineTextColor),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTotalAmountRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption({
    required IconData icon,
    required String label,
    required int index,
    required PaymentController controller,
    String? subtitle,
    IconData? trailingIcon,
    bool isTrailingIconYellow = false,
  }) {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.selectPaymentMethod(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.backgroundLightGrey,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: controller.selectedPaymentMethod.value == index
                  ? AppColors.primaryYellow
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 24, color: AppColors.primaryBlack),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: AppColors.subheadlineTextColor),
                    ),
                  ],
                ],
              ),
              const Spacer(),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: isTrailingIconYellow ? AppColors.primaryYellow : AppColors.dividerColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayButton(PaymentController controller) {
    return  SizedBox(
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
          onPressed: () => controller.payNow(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primaryBlack,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Pay \$15.00',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularIconButton(IconData icon, VoidCallback onPressed) {
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
}


