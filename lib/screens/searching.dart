import 'package:flutter/material.dart';

class Searching extends StatelessWidget {
  const Searching({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B202D),
      body: Padding(
        padding: const EdgeInsets.only(left: 1.0, right: 5.0, top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context); // Pop the current screen
                    },
                  ),
                  Expanded(
                    child: SearchBar(
                      backgroundColor: MaterialStateProperty.all(const Color(
                          0xff1B202D)),
                      shadowColor: MaterialStateProperty.all(const Color(
                          0xff1B202D)),
                      hintText: 'Search...',

                      onTap: () {
                        // Handle tap on search bar if needed
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
