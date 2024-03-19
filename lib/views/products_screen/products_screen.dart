import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_finalproject/const/const.dart';
import 'package:seller_finalproject/controllers/loading_Indcator.dart';
import 'package:seller_finalproject/controllers/products_controller.dart';
import 'package:seller_finalproject/services/store_services.dart';
import 'package:seller_finalproject/views/products_screen/add_product.dart';
import 'package:seller_finalproject/views/products_screen/product_details.dart';
import 'package:seller_finalproject/views/widgets/appbar_widget.dart';
import 'package:seller_finalproject/views/widgets/text_style.dart';
import 'package:get/get.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductsController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryApp,
          onPressed: () async {
            await controller.getCollection(); 
            controller.populateCollectionList();
            Get.to(() => const AddProduct());
          },
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndcator();
              } else {
                var data = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        children: List.generate(data.length,
                            (index) => ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(data: data[index]));
                                  },
                                  leading: Image.network(data[index]['p_imgs'][0],
                                    width: 50,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGreyDark),
                                  subtitle: Row(children: [
                                    normalText(text: "${data[index]['p_price']}", color: fontGrey),
                                    10.widthBox,
                                    boldText(
                                        text: data[index]['is_featured'] == true ? "Featured" : '', color: primaryApp),
                                  ],),
                                  trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                      children: List.generate(
                                          popupMenuTitles.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(popupMenuIcons[i],
                                                    color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? primaryApp : fontGrey),
                                                    5.widthBox,
                                                    normalText(
                                                        text: popupMenuTitles[i],
                                                        color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? 'Remove feature' : fontGrey)
                                                  ],
                                                ).onTap(() {
                                                  switch (i) {
                                                    case 0:
                                                      if (data[index]['is_featured'] == true) {
                                                    controller.removeFeatured(data[index].id);
                                                    VxToast. show(context, msg: "Removed");
                                                  } else {
                                                    controller.addFeatured(data[index].id);
                                                    VxToast. show(context, msg: "Added");
                                                  }
                                                      break;
                                                      case 1:
                                                      break;

                                                      case 2:
                                                      controller.removeProduct(data[index].id);
                                                      VxToast.show(context, msg: "Product removed");
                                                      break;

                                                    default:
                                                  }
                                                }),
                                              )),
                                    ).box.white.rounded.width(200).make(),
                                    clickType: VxClickType.singleClick,
                                    child: const Icon(Icons.more_vert_rounded),
                                  ),
                                ))),
                  ),
                );
              }
            }));
  }
}
