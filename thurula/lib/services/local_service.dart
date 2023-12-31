import '../utils/shared_preferences.dart';

class LocalService{
  static void setCurrentBabyId(String id){
    SharedPref.setString('currentBabyId', id);
  }
  static Future<String> getCurrentBabyId() async{
    return SharedPref.getString('currentBabyId');
  }
  static void setCurrentUserId(String id){
    SharedPref.setString('currentUserId', id);
  }
  static Future<String> getCurrentUserId() async{
    return SharedPref.getString('currentUserId');
  }
  static void setCurrentUserToken(String token){
    SharedPref.setString('currentUserToken', token);
  }
  static Future<String> getCurrentUserToken() async{
    return SharedPref.getString('currentUserToken');
  }
  static void setDailyExerciseDuration(int duration){
    SharedPref.setInt('dailyExerciseDuration', duration);
  }
  static Future<int> getDailyExerciseDuration() async{
    return SharedPref.getInt('dailyExerciseDuration');
  }
}