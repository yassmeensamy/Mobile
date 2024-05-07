import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app/Controllers.dart' as controller;
import 'package:app/Cubits/cubit/log_in_cubit.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Screens/ResturandScreen.dart';
import 'package:app/Screens/SignUp.dart';
import 'package:app/Widgets/Button.dart';
import 'package:app/Widgets/CustomFieldText.dart';
import 'package:app/Widgets/out.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:ui' as ui;
class Login extends StatelessWidget
 {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var output=Out();
  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  ontap() {}
  bool _isLoading=false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<LogInCubit, LogInState>(
          listener: (context, state) async {
            if(state is LogInloading)
            {
                       _isLoading=true; 
            }
            else if (state is LogInSuccess)
            {
              _isLoading=false;
              await output.showDialog(context,AlertType.success, 'Successful Registration'); 
         
          Future.delayed(Duration(seconds: 2), ()
          {
             BlocProvider.of<ResturantCubit>(context).FetchResturantData();
            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>ResturantScreen(),
                    ),
                  );
          });  
            }
            else if  (state is LogInFailer)
            { 
              _isLoading=false ;
                await output.showDialog(context,AlertType.error, 'Invalid credentials');   
            }
           
          },        
          builder: (context, state) =>
          ModalProgressHUD(inAsyncCall: _isLoading,
          child: 
          SingleChildScrollView(
        child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: FutureBuilder<ui.Image>(
                    future: loadImage(
                        "Assets/Log.jpg"), // Adjust the path to your image
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return CustomPaint(
                          painter: CurvePainter(
                              true,
                              snapshot
                                  .data!), // Now passing the image to the painter
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(top: 55),
                            alignment: Alignment.center,
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical:
                          70), // Adjusted padding for horizontal and vertical alignment
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome!",
                          style: TextStyle(
                              fontSize: 40, color: Color(0xff2F5C6D))),
                      SizedBox(height: 20),
                      CustomFieldText(
                        Label: "Email",
                        validator:(email)=>controller.validateEmail(email),
                        controller: emailController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20),
                      CustomFieldText(
                        validator: (pass)=>controller.validatepassword(pass),
                        Label: "Password",
                        controller: passwordController,
                        obscureText: true,
                      ),
                      TextButton(
                        onPressed: () {
                          // Add your logic here for when the button is pressed
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 210, top: 12),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      CustomeButton(
                        text: "LogIn",
                        onTap: () {
                          BlocProvider.of<LogInCubit>(context).LoginApi(emailController.text, passwordController.text);
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUP()),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize:
                                    18, // Adjusted font size for better aesthetics
                                 color:Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

}


class CurvePainter extends CustomPainter {
  bool outterCurve;
  ui.Image image; // Holds the image
  CurvePainter(this.outterCurve, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    // Define the rect in which the path is drawn, could be the whole canvas
    Rect pathRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Calculate the scale factor to fit the image into our path rect
    double scaleX = size.width / image.width;
    double scaleY = size.height / image.height;
    double scale = scaleX < scaleY ? scaleX : scaleY;

    // Calculate the offset to center the image
    double offsetX = (size.width - image.width * scale) / 2;
    double offsetY = (size.height - image.height * scale) / 2;

    // Use a matrix to scale and center the image
    final Matrix4 matrix4 = Matrix4.identity()
      ..translate(offsetX, offsetY+50)
      ..scale(scale);

    paint.shader = ImageShader(image, TileMode.clamp, TileMode.clamp, matrix4.storage);

    Path path = Path();
    //path.moveTo(0, 0);
    path.lineTo(0, size.height);   // بتتحدد الكيرف يبقي شكله ازاي رايح اتجاه ايه اكتر
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height); // كيرف الي هو دايره 
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class Animation extends StatelessWidget {
   Animation({super.key});
  Future<ui.Image> loadImage(String assetPath) async 
  {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            height: MediaQuery.of(context).size.height * 0.2,
            child: FutureBuilder<ui.Image>(
              future: loadImage("Assets/Log.jpg"), // Adjust the path to your image
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return CustomPaint(
                    painter: CurvePainter(true, snapshot.data!), // Now passing the image to the painter
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(top: 55),
                      alignment: Alignment.center,
                      
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
}
}