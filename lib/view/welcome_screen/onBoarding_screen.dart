import 'package:e_commerce_app/view/welcome_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        skipTextButton: Text('Skip'),
        trailing: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
          child: Text('Login')),

        background: [
          Image.network('https://i.pinimg.com/564x/f3/ee/2e/f3ee2ed8eae05696768373371a7356a7.jpg'),
          Image.network('https://i.pinimg.com/564x/05/9a/19/059a19e0fd1e8ac3a4050f53e61fd1b8.jpg'),
          Image.network('https://i.pinimg.com/564x/56/3b/3d/563b3d63577f621215a82aa2f45df7c7.jpg'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                //Text('Description Text 1'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                //Text('Description Text 2'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                //Text('Description Text 2'),
              ],
            ),
          ),
        ],
      ),
    );
  } 
}