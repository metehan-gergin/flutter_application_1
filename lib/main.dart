import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/user_info_form_page.dart';
import 'firebase_options.dart'; // Firebase console'dan otomatik oluşan dosya

import 'theme/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/ready_programs_page.dart';
import 'pages/exercise_list_page.dart';
import 'pages/active_program_page.dart';
import 'package:flutter_application_1/datas/programs_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Uygulama zaten başlatılmışsa yeniden başlatma hatasını bastır
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow; // Başka bir hata varsa yine fırlat
    }
  }
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitCore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/ready-programs': (context) => const ReadyProgramsPage(),
        '/exercise-list': (context) => const ExerciseListPage(),
        '/active-program': (context) => ProgramDetailPage(program: sampleProgram),
        '/userinfo': (context) => const UserInfoFormPage()
      },
    );
  }
}
