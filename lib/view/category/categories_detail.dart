import 'package:e_commerce_app/service/utility/status.dart';
import 'package:e_commerce_app/service/view_model/product_viewmodel.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:e_commerce_app/util/product_skeleton.dart';
import 'package:e_commerce_app/view/product/add_product_screen.dart';
import 'package:e_commerce_app/view/product/product_detail.screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CategoriesDetail extends StatefulWidget {
  CategoriesDetail({super.key});

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  ProductViewModel productViewModel = ProductViewModel();
  @override
  void initState() {
    super.initState();
    productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product', style: MyFont.TextContentStyle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(
                          isFromUpdate: false,
                        ),
                      ));
                },
                icon: Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ChangeNotifierProvider(
          create: (context) => productViewModel,
          child: Consumer<ProductViewModel>(
            builder: (context, productViewModel, _) {
              switch (productViewModel.response.status) {
                case Status.LOADING:
                  return GridView.builder(
                    itemCount: productViewModel.response.data?.data?.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => ProductSkeleton(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,    
                        crossAxisSpacing: 10,
                        mainAxisExtent: 262,
                        mainAxisSpacing: 10),
                  );

                case Status.COMPLETED:
                  return GridView.builder(
                    itemCount: productViewModel.response.data?.data?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 263,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var product =
                          productViewModel.response.data?.data?[index];
                      var productImage =
                          product!.attributes!.thumbnail!.data ?? "";
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productModel: product,
                                ),
                              ));
                        },
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProductScreen(
                                        productmodel: product,
                                        isFromUpdate: true,
                                      )));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Image.network(
                                        productImage != ""
                                            ? 'https://cms.istad.co${product.attributes!.thumbnail!.data!.attributes!.url}'
                                            : "https://i.pinimg.com/564x/f4/33/5d/f4335d8ac749331aed1b9d7d272f3178.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            product.attributes!.title ?? "",
                                            style: MyFont.textTitleStyle,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                              "${product.attributes!.price ?? ""}\$",
                                              style: MyFont.textLabelStyle),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                              "Rating : ${product.attributes!.rating ?? ""}",
                                              style: MyFont.textLabelStyle),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          FontAwesomeIcons.heart,
                                          size: 20,
                                          //color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  );

                case null:
                  return Text('null');
                case Status.ERROR:
                  return Text('error');
              }
            },
          ),
        ),
      ),
    );
  }
}
