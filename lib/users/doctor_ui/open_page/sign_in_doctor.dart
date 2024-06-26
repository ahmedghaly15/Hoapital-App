import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosptial_project/users/doctor_ui/doctor_profile/profile_of_doctor.dart';

import '../../../class/cubit/doctor_cubit.dart';
import '../../../class/cubit/doctor_states.dart';
import '../../../class/cubit/patient_cubit.dart';
import '../../../homelayout/home_layout.dart';
import '../../../sheared/components/comopnents.dart';
import '../doc_layout.dart';
import '../doctor_ui_new/home/home_doctor.dart';
import '../doctor_ui_new/home/main_doctor_home.dart';

class DocSignIn extends StatefulWidget {
  const DocSignIn({super.key});

  @override
  State<DocSignIn> createState() => _SignIn();
}

class _SignIn extends State<DocSignIn> {
  bool obscureText = true;
  bool obscureText1 = true;
  var formky = GlobalKey<FormState>();
  var FirstnameController = TextEditingController();
  var agecontroller = TextEditingController();
  final emailController = TextEditingController();
  var GenderController = TextEditingController();
  final passwordController = TextEditingController();
  var LastnameController = TextEditingController();
  final UsernameController = TextEditingController();
  final password_confirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitDoctorHosptial(),
      child: BlocConsumer<CubitDoctorHosptial, DoctorStates>(
        listener: (BuildContext context, state) {
          if (state is DoctorSignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('data possing'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.green.shade300,
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainHomeDoctor()));
          } else if (state is DoctorSignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                  'Please check the entered data'), //////////////////
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red.shade300,
            ));
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: defualtcolelr,
            body: Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.0, bottom: 3),
                        child: Text(
                          "Welcome to",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Barajil Healthera Hospital",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    width: double.infinity,
                    height: 750,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Form(
                        key: formky,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " Let's get Start by filling out the form below",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              defolttextformfild(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "username is required";
                                    }
                                    return null;
                                  },
                                  typekey: TextInputType.name,
                                  controller: UsernameController,
                                  prefexicon: Icons.person,
                                  labletext: 'username '),
                              const SizedBox(height: 30),
                              defolttextformfild(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "password is required";
                                    }
                                    return null;
                                  },
                                  typekey: TextInputType.name,
                                  controller: passwordController,
                                  suffixpressd: () {
                                    CubitPatientHosptial.get(context)
                                        .Cangepasswordvisibilty();
                                  },
                                  ispassword: CubitPatientHosptial.get(context)
                                      .isPassword,
                                  suffix:
                                      CubitPatientHosptial.get(context).suffix,
                                  prefexicon: Icons.lock,
                                  labletext: 'password '),
                              const SizedBox(
                                height: 40,
                              ),
                              ConditionalBuilder(
                                  condition: state is! DoctorSignInLoading,
                                  builder: (context) => Defultbotom(
                                      onPressed: () {
                                        if (formky.currentState!.validate()) {
                                          CubitDoctorHosptial.get(context)
                                              .SignInAPI(
                                            password: passwordController.text,
                                            email: UsernameController.text,
                                          );
                                        } else {
                                          return;
                                        }
                                      },
                                      text: 'Login'),
                                  fallback: (context) =>
                                      const CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
