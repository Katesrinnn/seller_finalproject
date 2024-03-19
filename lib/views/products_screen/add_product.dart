import 'package:get/get.dart';
import 'package:seller_finalproject/const/const.dart';
import 'package:seller_finalproject/controllers/loading_Indcator.dart';
import 'package:seller_finalproject/controllers/products_controller.dart';
import 'package:seller_finalproject/views/products_screen/component/product_dropdown.dart';
import 'package:seller_finalproject/views/products_screen/component/product_images.dart';
import 'package:seller_finalproject/views/widgets/custom_textfield.dart';
import 'package:seller_finalproject/views/widgets/text_style.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(() => Scaffold(
        appBar: AppBar(
          title: boldText(text: "Product title", color: fontGreyDark, size: 16.0),
          actions: [
            controller.isloading.value ? loadingIndcator(circleColor: fontLightGrey) : TextButton(onPressed: () async {
              controller.isloading(true);
              await controller.uploadImages();
              await controller.uploadProduct(context);
              Get.back();
            }, child: boldText(text: save, color: fontGrey))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. BMW", label: "Product name", controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg. about", label: "About product", controller: controller.pabproductController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product", label: "Description", isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product", label: "Size & Fit",isDesc: true,controller: controller.psizeController),
                10.heightBox,
                customTextField(
                    hint: "eg. 10,000.00", label: "Price", controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg. 20", label: "Quantity", controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Collection", controller.collectionsList, controller.collectionsvalue, controller),
                10.heightBox,
                productDropdown("Subcollection", controller.subcollectionList, controller.subcollectionvalue, controller),
                10.heightBox,
                boldText(text: "Choose product images", color: fontGrey),20.heightBox,
                Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3, 
                        (index) => controller.pImagesList[index]!= null 
                        ? Image.file(controller.pImagesList[index],width: 100,).onTap(() {controller.pickImage(index, context);}) 
                        : productImages(label: "${index + 1}").onTap(() {
                          controller.pickImage(index, context) ;
                        })),
                  ),
                ),
                10.heightBox,
                normalText(
                    text: "First image will be your sidplay image",
                    color: fontGrey),
                25.heightBox,
                boldText(text: "Choose product colors", color: fontGrey),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomPrimaryColor)
                                    .roundedFull
                                    .size(55, 55)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(Icons.done, color: whiteColor)
                                    : const SizedBox(),
                              ],
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
