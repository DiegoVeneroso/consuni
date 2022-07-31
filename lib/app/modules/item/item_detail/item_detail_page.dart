import 'package:awesome_icons/awesome_icons.dart';
import 'package:consuni_mobile/app/core/ui/widgets/custom_appbar.dart';
import 'package:consuni_mobile/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './item_detail_controller.dart';

class ItemDetailPage extends GetView<ItemDetailController> {
  HomeController homeController =
      HomeController(itemRepositoryImpl: Get.find());

  ItemDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: LayoutBuilder(
          builder: (_, constrains) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constrains.maxHeight,
                  minWidth: constrains.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width,
                      height: context.heightTransformer(reducedBy: 75),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: homeController
                              .decodeImage(controller.item.image)
                              .image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        controller.item.title,
                        style: context.textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        controller.item.subtitle,
                        style: context.textTheme.bodyText2!,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.frown),
                  label: const Text('Desfavorável'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.smile),
                  label: const Text('Favorável'),
                ),
              ),
            ],
          ),
        ));
  }
}
