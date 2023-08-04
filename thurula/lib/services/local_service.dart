import '../utils/shared_preferences.dart';

class LocalService{
  void setCurrentBabyId(String id){
    SharedPref.setString('currentBabyId', id);
  }
  Future<String> getCurrentBabyId() async{
    return SharedPref.getString('currentBabyId');
  }
}