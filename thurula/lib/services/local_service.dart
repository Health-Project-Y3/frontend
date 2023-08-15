import '../utils/shared_preferences.dart';

class LocalService{
  void setCurrentBabyId(String id){
    SharedPref.setString('currentBabyId', id);
  }
  Future<String> getCurrentBabyId() async{
    return SharedPref.getString('currentBabyId');
  }
  void setCurrentUserId(String id){
    SharedPref.setString('currentUserId', id);
  }
  Future<String> getCurrentUserId() async{
    return SharedPref.getString('currentUserId');
  }
}