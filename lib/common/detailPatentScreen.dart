import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/owner_controller/myPatent_owner_controller.dart';
import '../theme.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemName;
  final String itemOwner;
  final String image;
  final String itemDescription;
  final bool edit;

  const ItemDetailScreen({
    super.key,
    this.edit = false,
    required this.itemName,
    required this.itemOwner,
    required this.image,
    required this.itemDescription,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  MypatentOwnerController controller = Get.find<MypatentOwnerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ThemeColor.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: ThemeColor.white),
        ),
        title: Text('46'.tr,
            style: TextStyle(color: ThemeColor.white, fontSize: 23)),
        backgroundColor: ThemeColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '47'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.itemName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Item Owner

              const SizedBox(height: 16),

              // Images
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  )),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '30'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.itemOwner,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                '48'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.itemDescription,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
