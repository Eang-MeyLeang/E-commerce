import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/service/utility/status.dart';
import 'package:e_commerce_app/service/view_model/category_viewmodel.dart';
import 'package:e_commerce_app/service/view_model/product_viewmodel.dart';
import 'package:e_commerce_app/util/category_skeleton.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:e_commerce_app/util/product_skeleton.dart';
import 'package:e_commerce_app/view/category/category.dart';
import 'package:e_commerce_app/view/order/add_to_card_screen.dart';
import 'package:e_commerce_app/view/product/product_detail.screen.dart';
import 'package:e_commerce_app/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Datum? productmodel;
  CategoryModelDatum? categoryModelDatum;
  var _productViewModel = ProductViewModel();
  var _categoryViewModel = CategoryViewModel();

  @override
  void initState() {
    super.initState();
    _categoryViewModel.getAllCategory();
    _productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          _buildAppBar(),
          //home
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(40, 25),
                      topRight: Radius.elliptical(40, 25))),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 16),
                        child: Text(
                          'Categories',
                          style:MyFont.TextContentStyle  
                        ),
                      )),
                  SizedBox(
                    height: 123,
                    width: 500,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16, top: 18, right: 4),
                          child: ChangeNotifierProvider(
                            create: (context) => _categoryViewModel,
                            child: Consumer<CategoryViewModel>(
                              builder: (context, viewmodel, _) {
                                switch (viewmodel.response.status) {
                                  case Status.LOADING:
                                    return SizedBox(
                                      height: 500,
                                      width: MediaQuery.of(context).size.width *
                                          0.93,
                                      child: ListView.builder(
                                        itemCount: _categoryViewModel
                                            .response.data?.data?.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            CategorySkeleton(),
                                      ),
                                    );
                                  case Status.COMPLETED:
                                    return SizedBox(
                                      height: 500,
                                      width: MediaQuery.of(context).size.width *
                                          0.93,
                                      child: ListView.builder(
                                        itemCount: _categoryViewModel
                                            .response.data?.data?.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var category = viewmodel
                                              .response.data!.data![index];
                                          return CategoriesCard(
                                            category: category,
                                          );
                                        },
                                      ),
                                    );
                                  case Status.ERROR:
                                    return Text('Error');
                                  case null:
                                    return Text('null');
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: CarouselSlider(
                          items: [
                            _buildDiscountCard(),
                            _buildDiscountCard(),
                            _buildDiscountCard()
                          ],
                          options: CarouselOptions(
                            height: 180.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Best Selling',
                          style : MyFont.TextContentStyle  
                        )),
                  ),
                  _buildGrid()
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildDiscountCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        'https://i.pinimg.com/564x/40/c3/7e/40c37e7dae68017805ef7e888461870e.jpg',
        // scale: 4.4,
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ChangeNotifierProvider(
        create: (context) => _productViewModel,
        child: Consumer<ProductViewModel>(
          builder: (context, productViewModel, _) {
            switch (productViewModel.response.status) {
              case Status.LOADING:
                return GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => ProductSkeleton(),
                );
              case Status.COMPLETED:
                return GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: productViewModel.response.data?.data?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 260,
                      mainAxisSpacing: 10
                      ),
                  itemBuilder: (context, index) {
                    var product = productViewModel.response.data?.data?[index];
                    var productImage =
                        product!.attributes!.thumbnail!.data ?? "";
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    productModel: product)));
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (builder) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 10),
                                      child: Text(
                                        'Are you sure to remove this product?',
                                        style: MyFont.TextContentStyle,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _productViewModel
                                                  .deleteProduct(product.id);
                                              Navigator.of(builder).pop();
                                            },
                                            child: Text('Yes',style: TextStyle( color: Colors.blue),)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(builder).pop();
                                            },
                                            child: Text('No',style: TextStyle( color: Colors.red)))
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
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
                                        padding: const EdgeInsets.only(left: 8,top: 3),
                                        child: Text(
                                            product.attributes?.title != ""
                                                ? product.attributes!.title
                                                    .toString()
                                                : "", style: MyFont.textTitleStyle,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                            "${product.attributes?.price != "" ? product.attributes?.price : ""}\$",style: MyFont.textLabelStyle),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                            "Rating : ${product.attributes?.rating != "" ? product.attributes?.rating : ""}",style: MyFont.textLabelStyle),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 17,
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
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.blue[200],
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 23,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/0c/d0/8e/0cd08e8f8a5ded124cac69a3cefba6cb.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Welcome Jonh!',
              style: MyFont.TextContentStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToCardScreen(),
                        ));
                },
                icon: Icon(Icons.shopping_cart, color: Colors.black))
          ],
        ),
      ),
    );
  }
}
