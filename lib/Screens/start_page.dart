import 'package:eauctionandroid/Screens/login_page.dart';
import 'package:eauctionandroid/Screens/sign_up.dart';
import 'package:eauctionandroid/const.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(length: 2, child: Container(
        padding:  EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .01),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .03,
                right: MediaQuery.of(context).size.width * .03,
                top: MediaQuery.of(context).size.height * .02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 8, left: 0, right: 0),
                    height: 40,
                    child: TabBar(
                      indicatorColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      labelColor: primaryColor,
                      isScrollable: true,
                      tabs: tabList.map((String value) {
                        return Tab(
                          text: value,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - (80 + 60 + 56),
                    child: TabBarView(
                      children: tabList.map((String value) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: getBody(value, context),
                        );
                      }).toList(),
                    )),
              ),
            ),
          ],
        ),
      ),),
    );
  }
  final List<String> tabList=["Login","Signup"];
  getBody(String value,context){

    if(value=="Login") {
      return const LoginPage();
    } else if(value=="Signup") {
      return const Signup();
    }

  }
}


