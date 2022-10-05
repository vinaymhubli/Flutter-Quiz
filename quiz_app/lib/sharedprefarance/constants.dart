import 'package:shared_preferences/shared_preferences.dart';

class Helperlogdetails{
  static String userlogin='Userlogin';
  static saveuserlogindetails({required bool isloggedin})async{
  SharedPreferences pref= await SharedPreferences.getInstance();
  pref.setBool(userlogin, isloggedin);
  }

  static Future<bool?> getuserlogindetails()async{
  SharedPreferences pref= await SharedPreferences.getInstance();
  return pref.getBool(userlogin);

  }
}