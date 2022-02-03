import 'package:flutter/material.dart';
import 'package:ticket_app_v2/custom_widgets/snackbar.dart';
import 'package:ticket_app_v2/screens/login_screen.dart';
import 'package:ticket_app_v2/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _firstnameController.clear();
    _lastnameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Navigator.of(context).pop,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Let's get you started",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 48,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        _firstnameController.text = value!;
                      },
                      controller: _firstnameController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{2,}$');
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                        if (!regex.hasMatch(value)) {
                          return "Must be at least 2 characters";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "First Name",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _lastnameController.text = value!;
                      },
                      controller: _lastnameController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{2,}$');
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                        if (!regex.hasMatch(value)) {
                          return "Must be at least 2 characters";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Last Name",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9_.]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _passwordController.text = value!;
                      },
                      controller: _passwordController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                        if (!regex.hasMatch(value)) {
                          return "Enter a valid password (Min. 6 Characters)";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Password",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        _confirmPasswordController.text = value!;
                      },
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          return "Password must match";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Confirm Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String res = "";
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          res = await AuthService().signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                          );

                          if (res == "success") {
                            setState(() {
                              _isLoading = false;
                            });
                            clearText();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                            snackBar(context, res);
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            snackBar(context, res);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                        primary: Colors.black,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            )
                          : const Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
