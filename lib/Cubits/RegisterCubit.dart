import 'dart:convert';

import 'package:app/Cubits/RristerStates.dart';
import 'package:app/Models/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignUpCubit extends Cubit<RegisterState> {
  SignUpCubit() : super(RegisterInitial());
  Future<void> signUpUser( UserModel user,String confirmpassword,) async
   {
        emit(RegisterLoading());
        print("offfff");
    try 
    {
      http.Response response = await http.post(
        Uri.parse("https://student-affair2.duckdns.org/api/v1/signup/"),
        body: {
          "email": user.email,
          "password": user.password,
          "password2": confirmpassword,
          "username": user.name,
          "gender": user.gender,
          "student_id": user.studentId,
          "level":  user.level.toString(), 
        },);
        print("off again with suc");
      if (response.statusCode == 201) 
      { 
         emit(RegisterSuccess("Registarion is Success ,Wellcome"));
        Map<String, dynamic>  data = jsonDecode(response.body);
         final user = data["user"];
          print('User Email: ${user['email']}');
          print('Username: ${user['username']}');
          print('Gender: ${user['gender']}');
          print('Student ID: ${user['student_id']}');
          print('Level: ${user['level']}');
      } 
    }
       catch (e) 
    {
      print('Error during sign-up: $e');
         emit(RegisterFailure("Failed"));
    }
  }
}
