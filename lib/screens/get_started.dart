import 'package:chat_project/screens/register.dart';
import 'package:chat_project/screens/signin.dart';
import 'package:flutter/material.dart';

import '../configuation/app_vectors_and_images.dart';
import '../widgets/button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset(
                      AppVectorsAndImages.getLinkImage('icon_app'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'CHATTING APP',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'The best user experience is our team\'s pleasure',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Button(title: 'Login',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Signin()
                              )
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: Button(title: 'Register',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Register()
                              )
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
