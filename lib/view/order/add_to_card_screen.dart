import 'package:e_commerce_app/util/myfont.dart';
import 'package:e_commerce_app/view/order/payment_screen.dart';
import 'package:flutter/material.dart';

class AddToCardScreen extends StatefulWidget {
  const AddToCardScreen({super.key});

  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {
  int _n = 0;

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: MyFont.TextContentStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/image/dots.png',
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://i.pinimg.com/564x/72/0f/48/720f48566f7123f294f6b91af911faeb.jpg',
                                    ))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Warm Ladies's shirt",
                              style: MyFont.textTitleStyle,
                            ),
                            Text(
                              "\$14.00",
                              style: MyFont.textTitleStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              //color: Colors.amber,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 15,
                                      backgroundColor: Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          add();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Text('$_n',
                                        style: new TextStyle(fontSize: 20.0)),
                                  ),
                                  CircleAvatar(
                                      maxRadius: 15,
                                      backgroundColor: Colors.white,
                                      child: InkWell(
                                          onTap: () {
                                            minus();
                                          },
                                          child: Image.asset(
                                            'assets/image/minus.png',
                                            scale: 1.9,
                                            color: Colors.black87,
                                          ))),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Itemes : ($_n)',
                    style: MyFont.textLabelStyle,
                  ),
                  Text(
                    'Total : \$${14*_n}',
                    style: MyFont.textTitleStyle,
                  )
                ],
              ),
            ),
            Divider(
              endIndent: 10,
              indent: 10,
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: Text('Checkout'),
                )),
            SizedBox(
              height: 15,
            ),
            
          ],
        ),
      ),
    );
  }
}
