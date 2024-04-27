import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/login_screen.dart';
import 'package:todo_app/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  signoutUser() async {
    await FirebaseAuth.instance.signOut().then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route) => false);
    });
  }

  Future<UserModel> getUserDetails() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("userId") ?? "";
    var userResponse =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    UserModel userModel = UserModel.fromDocumentSnapshot(userResponse);
    print(userModel.firstName);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: kIsWeb ? false : true,
          title: Text("Profile Screen"),
        ),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            onPressed: () {
              signoutUser();
            },
            child: Icon(Icons.logout_sharp)),
        body: FutureBuilder<UserModel>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProfileWidget(
                  userData: snapshot.data!,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.userData,
  });
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            child: Center(
                child: Text(
              userData.firstName![0],
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            userData.firstName!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userData.lastName!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userData.email!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
