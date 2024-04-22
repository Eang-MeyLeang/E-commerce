import 'dart:convert';

import 'package:e_commerce_app/model/search_product_model.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:e_commerce_app/view/product/search_product_detial.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Datum product = Datum();
  SearchProductModel searchProductModel = SearchProductModel();
  TextEditingController textController = TextEditingController();

  void OnSearch(String? title) async {
    var url = Uri.parse(
        'https://cms.istad.co/api/e-commerce-products?populate=%2A&filters%5Btitle%5D=' +
            title!);
    dynamic response = await http.get(url);
    setState(() {
      searchProductModel =
          SearchProductModel.fromJson(jsonDecode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [_buildSearchBar(), _buildResult()],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: SearchBar(
          elevation: MaterialStatePropertyAll(3),
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          hintText: 'Search name',
          trailing: [
            IconButton(
                onPressed: () => textController.clear(),
                icon: Icon(Icons.clear))
          ],
          controller: textController,
          onChanged: (value) => OnSearch(value),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ));
  }

  Widget _buildResult() {
    return Expanded(
      child: ListView(children: [
        Column(children: [
          if (searchProductModel.data != null)
            for (var item in searchProductModel.data!)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchProductDetailScreen(productModel: item),
                      ));
                },
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                topLeft: Radius.circular(12)),
                            child: Image.network(
                              "${item.attributes?.thumbnail!.data ?? ""}" != ""
                                  ? "https://cms.istad.co${item.attributes?.thumbnail?.data?.attributes?.url.toString()}"
                                  : "https://i.pinimg.com/564x/f4/33/5d/f4335d8ac749331aed1b9d7d272f3178.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Product : ',
                                      style: MyFont.textLabelStyle),
                                  Text(
                                    "${item.attributes!.title ?? ""}",
                                    style: MyFont.textTitleStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Price : ',
                                      style: MyFont.textLabelStyle),
                                  Text(
                                    "${item.attributes!.price ?? ""}\$",
                                    style: MyFont.textTitleStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RatingBarIndicator(
                                rating: double.tryParse(
                                        '${item.attributes!.rating}') ??
                                    0,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 19.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              )
        ])
      ]),
    );
  }
}
