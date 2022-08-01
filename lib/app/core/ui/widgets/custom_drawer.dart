import 'package:consuni/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consuni/app/core/services/auth_services.dart';
import 'package:consuni/app/models/userDrawer_model.dart';

class CustomDrawer extends StatelessWidget {
  HomeController homeController =
      HomeController(itemRepositoryImpl: Get.find());
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<UserDrawerModel>(
        future: homeController.getUserDrawer(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xff764abc)),
                  accountName: Text(
                    snapshot.data!.name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    snapshot.data!.representante.toString() == 'false'
                        ? 'Representado'
                        : 'Representante',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: const FlutterLogo(),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Home Page'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.train,
                  ),
                  title: const Text('Sair'),
                  onTap: () {
                    Get.find<AuthServices>().logout();
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
