import 'package:consuni/app/modules/item/item_detail/item_detail_bindings.dart';
import 'package:consuni/app/modules/item/item_detail/item_detail_page.dart';
import 'package:get/get.dart';

class ItemDetailRouters {
  ItemDetailRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/itemdetail',
      binding: ItemDetailBindings(),
      page: () => ItemDetailPage(),
    ),
  ];
}
