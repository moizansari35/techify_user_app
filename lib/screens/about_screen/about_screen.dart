import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.blackColor,
          ),
        ),
        title: const Text(
          "About Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Center(
            child: Text(
              "- **App Name**: Techify-\n**Purpose**: Easily order tech items and gadgets-\n**Features**:\n- Browse a wide range of tech products\n- Add items to your cart with a single tap\n- Track your order status in real-time\n- Simple and user-friendly interface\n- Secure checkout for a hassle-free experience\n- Quick access to order history and details",
            ),
          )
        ],
      ),
    );
  }
}
