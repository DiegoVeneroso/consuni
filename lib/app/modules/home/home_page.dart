import 'package:consuni_mobile/app/core/constants/constants.dart';
import 'package:consuni_mobile/app/core/helpers/notification.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_drawer.dart';
import 'package:consuni_mobile/app/modules/home/home_controller.dart';
import 'package:consuni_mobile/app/modules/home/widgets/item_tile.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController(itemRepositoryImpl: Get.find());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final notificationTitle = 'No Title'.obs;
  final notificationBody = 'No Body'.obs;
  final notificationData = 'No Data'.obs;
  @override
  void initState() {
    controller.findAllItems();
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    super.initState();
  }

  _changeData(msg) => setState(() => notificationData.value = msg.TH);
  _changeBody(msg) => setState(() => notificationBody.value = msg);
  _changeTitle(msg) => setState(() {
        notificationTitle.value = msg;
        notificationBody.value = msg;
        // notificationData.value = msg.TH;
        Get.snackbar(
          notificationTitle.value,
          notificationBody.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('CONSUNI'),
        onSearch: (text) {
          controller.findAllItems(text);
        },
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: controller.refreshPage,
                child: ListView.builder(
                  itemCount: controller.listItem.length,
                  itemBuilder: (context, index) {
                    final _item = controller.listItem[index];
                    return ItemTile(
                      item: _item,
                    );
                  },
                ),
              ),
            ),
          ),
          //notification

          // Visibility(
          //   visible: notificationTitle.value == 'No Title' ? false : true,
          //   child: Text(
          //     notificationTitle.value,
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),

          // AnimatedOpacity(
          //   opacity: notificationTitle.value == 'No Title' ? 0.0 : 1.0,
          //   duration: const Duration(milliseconds: 500),
          //   child: Text(
          //     notificationTitle.value,
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),
          // Text(
          //   notificationBody,
          //   style: Theme.of(context).textTheme.headline6,
          // ),

          // Text(
          //   notificationData,
          //   style: Theme.of(context).textTheme.headline6,
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/additem');
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
