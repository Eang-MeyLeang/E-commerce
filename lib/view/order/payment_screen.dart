import 'package:e_commerce_app/util/myfont.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
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
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            _buildPaymentCard(
                "Credit Card", Image.asset('assets/image/mastercard.png')),
            _buildPaymentCard("PayPal", Image.asset('assets/image/paypal.png')),
            _buildPaymentCard(
                "PayPal",
                Image.asset(
                  'assets/image/applepay.png',
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Card Number',
                style: MyFont.textTitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchBar(
                elevation: MaterialStatePropertyAll(0.8),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                hintText: '123456789010',
                trailing: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/image/mastercard.png'))
                ],
                //controller: textController,
                //onChanged: (value) => OnSearch(value),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'Expire Date',
                        style: MyFont.textTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: SearchBar(
                          elevation: MaterialStatePropertyAll(0.8),
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                          hintText: '04/11/2024',
                          //controller: textController,
                          //onChanged: (value) => OnSearch(value),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'CVC',
                        style: MyFont.textTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: SearchBar(
                          elevation: MaterialStatePropertyAll(0.8),
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                          hintText: '...........',
                          //controller: textController,
                          //onChanged: (value) => OnSearch(value),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Total : ',
                style: MyFont.textLabelStyle,
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
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 140),
                    child: Text('Payment'),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(String title, Image image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        elevation: 0.5,
        child: Row(
          children: [
            Container(
                height: 85,
                width: 80,
                decoration: BoxDecoration(
                    //color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topLeft: Radius.circular(12))),
                child: image),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyFont.textTitleStyle,
                ),
                Text('1234****56 TW')
              ],
            )
          ],
        ),
      ),
    );
  }
}
