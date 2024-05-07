import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> 
{
  LogInCubit() : super(LogInInitial());

void SaveTokens(String access,String refresh)  async
{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access',access);
    prefs.setString('refresh',refresh);
    print(access);
}


Future<void>LoginApi( String Email,String Password) async
{
      emit(LogInloading());
  try 
  {
      http.Response response= await http.post(Uri.parse('https://student-affair2.duckdns.org/api/v1/login/'),
      body:{
          "email": Email,
          "password":Password,
        }
      );
    
      if(response.statusCode==200)
      {
        Map<String,dynamic> data=jsonDecode(response.body); 
        SaveTokens(data["access"], data["refresh"]);   
        emit(LogInSuccess("Sucess"));
      }
      else 
      {
        
        emit(LogInFailer("Invalid"));
      }
  }
  catch(e)
   {
    print(e);
    emit(LogInFailer("Faild"));
   }
}
}