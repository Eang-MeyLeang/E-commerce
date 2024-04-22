import 'package:e_commerce_app/model/category_model.dart';
import 'package:e_commerce_app/service/view_model/category_viewmodel.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:e_commerce_app/view/category/categories_detail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesCard extends StatelessWidget {
  CategoriesCard({required this.category});

  CategoryModelDatum category;

  var categoryViewModel = CategoryViewModel();
  @override
  Widget build(BuildContext context) {
    String iconImage = '${category.attributes!.iconUrl ?? ""}';
    return Container(
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Colors.grey[100],
              maxRadius: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesDetail(),
                  ));
                },
                icon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network((iconImage != "")
                      ? iconImage
                      : 'https://i.pinimg.com/564x/82/5a/30/825a300c710ec5d5f3cf9da6519813a3.jpg'),
                ),
                // iconSize: 28,
              )),
          SizedBox(
            height: 3,
          ),
          Container(
            alignment: Alignment.center,
            //color: Colors.amber,
            width: 76,
            child: Text(category.attributes!.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: MyFont.textTitleStyle),
          ),
        ],
      ),
    );
  }
}
