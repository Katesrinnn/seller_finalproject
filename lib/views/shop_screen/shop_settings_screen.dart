import 'package:seller_finalproject/const/const.dart';
import 'package:seller_finalproject/controllers/loading_Indcator.dart';
import 'package:seller_finalproject/controllers/profile_controller.dart';
import 'package:seller_finalproject/views/widgets/custom_textfield.dart';
import 'package:seller_finalproject/views/widgets/text_style.dart';
export 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Obx(() => Scaffold(
        appBar: AppBar(
          title: boldText(text: shopSettings, color: fontGreyDark, size: 16.0),
          actions: [
            controller.isloading.value ? loadingIndcator(circleColor: fontGrey) :
            TextButton(
                onPressed: () async {
                  controller.isloading(true);
                  await controller.updateShop(
                    shopaddress: controller.shopAddressController.text,
                    shopname: controller.shopNameController.text,
                    shopmobile: controller.shopMobileController.text,
                    shopwebsite: controller.shopWebsiteController.text,
                    shopdesc: controller.shopDescController.text
                  );
                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Shop updated");
                },
                child: normalText(text: save, color: fontGreyDark))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            customTextField(label: shopName, controller: controller.shopNameController),
            10.heightBox,
            customTextField(label: address, controller: controller.shopAddressController),
            10.heightBox,
            customTextField(label: mobile, controller: controller.shopMobileController),
            10.heightBox,
            customTextField(label: website, controller: controller.shopWebsiteController),
            10.heightBox,
            customTextField(isDesc: true, label: website, controller: controller.shopDescController),
          ]),
        ),
      ),
    );
  }
}
