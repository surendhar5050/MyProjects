
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/providers/user_provider.dart';
import 'package:socialmedia/responsive/mobileScreen.dart';
import 'package:socialmedia/responsive/webScreen.dart';
import 'package:socialmedia/screen/login_page.dart';
import 'package:socialmedia/utils/colors.dart';

import 'responsive/reponsive_layout_screen.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
if (!kIsWeb){
     await Firebase.initializeApp();

}else{
  await Firebase.initializeApp(options: const FirebaseOptions( 
 apiKey: "AIzaSyA3jl5sB83cuAkjB3fiUsxRHIFX1hTupLI",
  authDomain: "socialmedia-b637b.firebaseapp.com",
  projectId: "socialmedia-b637b",
  storageBucket: "socialmedia-b637b.appspot.com",
  messagingSenderId: "992101630324",
  appId: "1:992101630324:web:0f5843d81412cbd0a2ac21"
  ));
}
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider() )
      ],
      child: MaterialApp(
        title: 'Sinstagram',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const Scaffold(body:ResponsiveLayout(WebScreen: WebScreen(), mobileScreen: MobileScreen())),
        // home: const LoginPage(),
    
        home: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() , builder:(context, snapshot) {
          if (snapshot.connectionState==ConnectionState.active) {
             if (snapshot.hasData) {
                    return const ResponsiveLayout(WebScreen: WebScreen(), mobileScreen: MobileScreen());
             }else if (snapshot.hasError){
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
             }
          }
          if (snapshot.connectionState==ConnectionState.waiting) {
                return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
          }
    
        return LoginPage();
        },),
    
    
    
      ),
    );
  }
}

