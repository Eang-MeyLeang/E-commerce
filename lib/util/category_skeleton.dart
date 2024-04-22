import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        child:Column( 
          children: [
            CircleAvatar(
                    backgroundColor:
                        Colors.white,
                    maxRadius: 28,
                    child: IconButton(
                      onPressed: () {  },
                      icon: Image.network('https://i.pinimg.com/564x/63/08/00/6308002251a90ffd11e933552eff35d1.jpg'),
                    iconSize: 28,
                    )
                  ),
                  SizedBox(
                    height: 3,
                  ),
            Container(
              alignment: Alignment.center,
              //color: Colors.amber,
              width: 76,
              child: Text('computer' ,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap:true,
              style: TextStyle(color: Colors.black, fontSize: 17),),
            ),
            
          ],
        ),

));

  }
}