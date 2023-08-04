import '../utils/shared_preferences.dart';

class LocalService{
  static void setCurrentBabyId(String id){
    SharedPref.setString('currentBabyId', id);
  }
  static Future<String> getCurrentBabyId() async{
    return SharedPref.getString('currentBabyId');
  }
}