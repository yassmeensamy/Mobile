import 'package:app/Cubits/RristerStates.dart';
import 'package:app/Widgets/out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:app/Cubits/RegisterCubit.dart';
import 'package:app/Models/UserModel.dart';
import 'package:app/Screens/Login.dart';
import 'package:app/Widgets/Button.dart';
import 'package:app/Widgets/CustomFieldText.dart';
import 'package:app/Controllers.dart' as controller;
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUP extends StatelessWidget {
  SignUP({Key? key}) : super(key: key);

  bool _isLoading = false;
  var output=Out();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 25, right: 25),
          child: BlocConsumer<SignUpCubit, RegisterState>(
            listener: (context, state) async {
              if (state is RegisterLoading) {
                _isLoading = true;
              } 
              else if (state is RegisterSuccess) 
              {
                _isLoading = false;
                 await output.showDialog(context,AlertType.success, 'SucessFul Registration'); 
              Future.delayed(Duration(seconds: 3), ()
                          {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                                 );
                          }
              );
              } else if (state is RegisterFailure) {
                _isLoading = false;
                     await output.showDialog(context,AlertType.error, 'Failed Registration'); 
        } 
               
              
            },
            builder: (context, state) => ModalProgressHUD(
              inAsyncCall: _isLoading,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff2F5C6D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Already have an account"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text("Log In" ,style: TextStyle(color:Colors.orange,),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _gender = "";
  int _level = 0; // Assuming level is an integer in your UserModel
  var output=Out();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFieldText(
            Label: "Enter your Name",
            validator: (value) => controller.validateMadatory(value),
            obscureText: false,
            controller: _nameController,
          ),
          CustomFieldText(
            Label: "Enter your Email",
            validator: (value) => controller.validateEmail(value),
            obscureText: false,
            controller: _emailController,
          ),
          CustomFieldText(
            Label: "Enter your ID",
            validator: (value) => controller.validateMadatory(value),
            obscureText: false,
            controller: _studentIdController,
          ),
          CustomFieldText(
            Label: "Enter your Password",
            validator: (value) => controller.validatepassword(value),
            obscureText: true,
            controller: _passwordController,
          ),
          CustomFieldText(
            Label: "Confirm Password",
            validator: (value) => controller.validateConpassword(_passwordController.text, value),
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text("Female"),
                  leading: Radio(
                    value: "female",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value as String;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text("Male"),
                  leading: Radio(
                    value: "male",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value as String;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 69),
              DropDown(
                onLevelSelected: (int level) {
                  setState(() {
                    _level = level; // Update the _level variable with the selected value
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          CustomeButton(
            text: "Sign UP",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                UserModel user = UserModel(
                  name: _nameController.text,
                  email: _emailController.text,
                  studentId: _studentIdController.text,
                  password: _passwordController.text,
                  gender: _gender,
                  level: _level,
                );
           
                BlocProvider.of<SignUpCubit>(context).signUpUser(user, _confirmPasswordController.text);
              }
              else 
              {
                 await output.showDialog(context,AlertType.error, 'Failed Registration'); 
              }
            },
          ),
        ],
      ),
    );
  }
}

enum Level {
  one,
  two,
  three,
  four,
}
class DropDown extends StatefulWidget 
{
  final void Function(int level) onLevelSelected;
   int? intiallevel; // Callback function to receive selected level
  DropDown({Key? key, required this.onLevelSelected,  intiallevel, }) : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int? selectedLevel; 
 // Variable to store the selected level as an integer
   @override
  void initState() 
{
    super.initState();
    if(widget.intiallevel!=null) 
    {
      selectedLevel = widget.intiallevel; // Set the initial selected value in initState
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Set the width to your desired value
      child: DropdownButton<int>(
        value: selectedLevel,
        onChanged: (int? value) {
          setState(() {
            selectedLevel = value; // Update the selected level when changed
            widget.onLevelSelected(selectedLevel ?? 0); // Pass selected level to callback
          });
        },
        items: Level.values.map((level) 
        {
          int value = level.index + 1; 
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
