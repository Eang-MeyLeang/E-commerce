import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)
              ),
              width: MediaQuery.of(context).size.width * 0.1,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: Image.network("https://i.pinimg.com/564x/f4/33/5d/f4335d8ac749331aed1b9d7d272f3178.jpg",
                       fit: BoxFit.cover, ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text('dress'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text("10\$"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text("Rating : 10"),
                              )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:  17, ),
                          child: IconButton(onPressed: () {
                            
                          }, icon: Icon(Icons.favorite),
                          ),
                        ) 
                      ],
                    )
                ],
              )             
                                ),
          );
  }
}