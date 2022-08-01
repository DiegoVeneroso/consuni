import 'dart:convert';
import 'dart:io';

import 'package:consuni/app/core/bindings/application_bindings.dart';
import 'package:consuni/app/core/ui/app_ui.dart';
import 'package:consuni/app/routes/chat_room_routers.dart';
import 'package:consuni/app/routes/chat_routers.dart';
import 'package:consuni/app/routes/item/additem_routers.dart';
import 'package:consuni/app/routes/auth_routers.dart';
import 'package:consuni/app/routes/edititem_routers.dart';
import 'package:consuni/app/routes/home_routers.dart';
import 'package:consuni/app/routes/itemdetail_routers.dart';
import 'package:consuni/app/routes/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

Future<void> main() async {
  await init();
  await GetStorage
      .init(); //todo o projeto que utilizar o GetStorage deve incluir isso no Main
  runApp(const MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CONSUNI',
      theme: AppUI.theme,
      initialBinding: ApplicationBindings(),
      getPages: [
        ...SplashRoutes.routers,
        ...AuthRouters.routers,
        ...HomeRouters.routers,
        ...AdditemRouters.routers,
        ...ItemDetailRouters.routers,
        ...EdititemRouters.routers,
        ...ChatRouters.routers,
        ...ChatRoomRouters.routers,
      ],
    );
  }
}
