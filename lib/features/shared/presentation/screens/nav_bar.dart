import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/features/home/presentation/screens/home_screen.dart';
import 'package:movie_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:movie_app/features/shared/presentation/controllers/bottom_nav_bar_controller.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';
import 'package:movie_app/features/top_rated/presentation/screens/top_rated_screen.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    const TopRatedScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentUserController = Get.find<CurrentUserController>();

    return GetBuilder<BottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: _screens,
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: _buildBottomNavBar(
              context,
              controller,
              currentUserController,
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar(
      BuildContext context,
      BottomNavController controller,
      CurrentUserController currentUserController) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      selectedItemColor: Get.theme.colorScheme.inverseSurface,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.setIndex(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildNavItemIcon(
            controller,
            index: 0,
            iconData: Icons.home,
            selectedIconData: Icons.home_filled,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: _buildNavItemIcon(
            controller,
            index: 1,
            iconData: Icons.star_border,
            selectedIconData: Icons.star,
          ),
          label: "Top Rated",
        ),
        BottomNavigationBarItem(
          icon: _buildNavItemIcon(
            controller,
            index: 2,
            iconData: Icons.person_outline,
            selectedIconData: Icons.person,
          ),
          label: "My Profile",
        ),
      ],
    );
  }

  Widget _buildNavItemIcon(
    BottomNavController controller,
    {
    required int index,
    required IconData iconData,
    required IconData selectedIconData,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Icon(
        controller.currentIndex.value == index ? selectedIconData : iconData,
        size: 29.w,
        color: controller.currentIndex.value == index
            ? Get.theme.colorScheme.inverseSurface
            : Colors.grey,
        key: ValueKey<int>(controller.currentIndex.value),
      ),
    );
  }
}
