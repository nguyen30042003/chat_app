
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.account_box,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Full name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Gmail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'User name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'You have account?',
                              style: TextStyle(
                                color: Color(0xffB81736),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      Container(
                        height: 80,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text('SignUp', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),),
                        ),
                      ),
                      SizedBox(height: 100),
                      // const Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       Text("Don't have account?", style: TextStyle(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey
                      //       ),),
                      //       Text("SignUp?", style: TextStyle(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.black
                      //       ),),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
