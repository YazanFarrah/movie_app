import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/widgets/custom_form_field.dart';
import 'package:movie_app/core/widgets/slide_gallery_widget.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/features/auth/presentation/controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  bool _showButton = false;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        // Show the button if user typed something
        _showButton = nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1) Background slider of images
            SlideGalleryWidget(
              images: [
                "https://m.media-amazon.com/images/S/pv-target-images/3de84cca07fc963b66a01a5465c2638066119711e89c707ce952555783dd4b4f.jpg",
                "https://m.media-amazon.com/images/I/81NY04-QHrL._AC_UF1000,1000_QL80_.jpg",
                "https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10543523_p_v8_as.jpg",
              ],
            ),

            // 2) Blurred overlay with form & conditional button
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0.h),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(16.0.r),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues( alpha:  0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Prompt text
                            CustomTextWidget(
                              text: "Please enter your name",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.onSurface,
                            ),
                            SizedBox(height: 16.h),

                            // Text field
                            CustomFormField(
                              controller: nameController,
                              inputColor: Get.theme.colorScheme.onSurface,
                              contentPadding: 10.w,
                            ),

                            // Conditionally show button if text is not empty
                            if (_showButton) ...[
                              SizedBox(height: 16.h),
                              CustomButton(
                                onPressed: () {
                                  authController.signup(nameController.text);
                                },
                                text: "Continue",
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
