// import 'package:firebase_core/firebase_core.dart';
import 'package:anime_app_tv/app/core/common/utils/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:anime_app_tv/firebase_options.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;
  // late FirebaseApp firebaseApp;

  String? userUuid;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    // firebaseApp = await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    //initiation firebase

    userUuid = prefs.getString('userUuid');

    if (userUuid == null) {
      userUuid = Uuid.gen();
      await prefs.setString('userUuid', userUuid!);
    }
  }
}
