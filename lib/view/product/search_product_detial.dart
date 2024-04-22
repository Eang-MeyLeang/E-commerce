import 'package:e_commerce_app/model/search_product_model.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class SearchProductDetailScreen extends StatelessWidget {
  SearchProductDetailScreen({required this.productModel});
  Datum productModel;
  @override
  Widget build(BuildContext context) {
    var productImage = productModel.attributes!.thumbnail!.data ?? "";
    var _rating = double.tryParse(productModel.attributes!.rating ?? "");
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  image: DecorationImage(
                    image: NetworkImage(
                      productImage != ""
                          ? 'https://cms.istad.co${productModel.attributes!.thumbnail!.data!.attributes!.url!}'
                          : "https://i.pinimg.com/564x/f4/33/5d/f4335d8ac749331aed1b9d7d272f3178.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 13,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 30,
                left: 25,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.attributes!.title!,
                    style: MyFont.TextContentStyle,
                  ),
                  Text(
                    '${productModel.attributes!.price!}\$',
                    style: MyFont.TextContentStyle,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: RatingBarIndicator(
                rating: _rating ?? 0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 23.0,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              child: Text(
                productModel.attributes!.description!,
                style: MyFont.textLabelStyle,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue[200])),
                  onPressed: () {},
                   child: Text('Add to card', style: MyFont.textTitleStyle,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    
    
    );
  }
}
