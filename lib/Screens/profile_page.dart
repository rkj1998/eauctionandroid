import 'package:eauctionandroid/Screens/start_page.dart';
import 'package:eauctionandroid/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [primaryColor,Colors.white]
                    ),
                    borderRadius:  BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ProfileData.userData['FirstName']+" "+ProfileData.userData['LastName'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(ProfileData.userData["ProfPic"]),
                )
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children:  [
                  const Align(
                      child: Icon(Icons.person,color:primaryColor,),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    ProfileData.userData['FirstName']+" "+ProfileData.userData['LastName'],
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20
                    ),
                  ),

                ],
              ),
            ),
            const Divider(thickness: 3,),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children:  [
                  const Align(
                    child: Icon(Icons.calendar_today_outlined,color:primaryColor,),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    ProfileData.userData['DOB'],
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20
                    ),
                  ),

                ],
              ),
            ),
            const Divider(thickness: 3,),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children:  [
                  const Align(
                    child: Icon(Icons.phone_android_outlined,color:primaryColor,),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    ProfileData.userData['Mobile'],
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20
                    ),
                  ),

                ],
              ),
            ),
            const Divider(thickness: 3,),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children:  [
                  const Align(
                    child: Icon(Icons.mail_outline,color:primaryColor,),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 30,),
                  Text(
                    ProfileData.userData['Email'],
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20
                    ),
                  ),

                ],
              ),
            ),
            const Divider(thickness: 3,),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.25,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    )
                ),
                onPressed: (){
                  }, child:  const Text(
                "Edit Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),),
            ),
            const Divider(thickness: 3,),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.25,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    )
                ),
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const StartPage()));
                }, child:  const Text(
                "Logout",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
