import 'package:chat_project/screens/homepage.dart';
import 'package:flutter/material.dart';
import '../domains/usecase/login.dart';
import '../requests/signin_request.dart';
import '../service_locator.dart';
import '../services/auth_service_impl.dart'; // Import your AuthServiceImpl

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _controllerMessage1 = TextEditingController();
  final TextEditingController _controllerMessage2 = TextEditingController();
  bool _isLoading = false; // Track loading state
  String? _errorMessage; // To display error messages

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
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _controllerMessage1,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _controllerMessage2,
                        obscureText: true, // Hide password input
                        decoration: const InputDecoration(
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
                      if (_errorMessage != null) // Show error message if exists
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                            color: Color(0xffB81736),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      GestureDetector(
                        onTap: _isLoading ? null : _handleLogin,
                        child: Container(
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
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator
                                : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Sign Up?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _handleLogin() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = null; // Clear previous error
    });

    String username = _controllerMessage1.text;
    String password = _controllerMessage2.text;
    SigninRequest signinRequest = SigninRequest(username: username, password: password);
    final result = await sl<Login>().call(params: signinRequest);

    result.fold(
          (error) {
        // Handle error
        setState(() {
          _isLoading = false; // Stop loading
          _errorMessage = error; // Display error message
        });
      },
          (user) {
        // Handle successful login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage()));
      },
    );
  }
}