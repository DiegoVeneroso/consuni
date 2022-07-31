import 'package:consuni_mobile/app/modules/item/edit_item/edit_item_bindings.dart';
import 'package:consuni_mobile/app/modules/item/edit_item/edit_item_page.dart';
import 'package:get/get.dart';

class EdititemRouters {
  EdititemRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/edititem',
      binding: EditItemBindings(),
      page: () => const EditItemPage(),
    ),
  ];
}
