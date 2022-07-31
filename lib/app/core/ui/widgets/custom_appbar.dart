import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends AppBar {
  bool? IconBackNavigator;

  CustomAppbar({Key? key, double elevation = 2, this.IconBackNavigator = false})
      : super(
          leading: IconBackNavigator == true
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                )
              : null,
          key: key,
          backgroundColor: Colors.white,
          elevation: elevation,
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        );
}
