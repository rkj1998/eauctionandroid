import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../const.dart';
import 'add_money.dart';

class PaymentDialog extends StatefulWidget {
  final amount;
  final description;
  const PaymentDialog(this.amount,this.description, {Key? key}) : super(key: key);
  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {

  double walletBalance = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var data = await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      walletBalance=data["Balance"].toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height/5,
            child: Column(
              children: <Widget>[
                const Text("Exam Academy Wallet",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: primaryColor),),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Available Balance",style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),
                    Text("₹ "+walletBalance.toString(),style: const TextStyle(fontSize: 15),textAlign: TextAlign.center,)
                  ],
                ),
                const SizedBox(height: 22,),
                walletBalance>=widget.amount?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LoginButton(text: "Cancel",press: () async {
                          Navigator.of(context).pop();
                        },),
                        LoginButton(text: "Pay",press: () async {
                          SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
                          _dialog.show(message: "Please wait...",indicatorColor: primaryColor);
                          await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).
                              update({
                            "Balance":walletBalance-widget.amount
                          });
                           _dialog.hide();
                           Navigator.of(context).pop();

                        },)
                      ],
                    ):
                    Row(
                      children: [
                        LoginButton(text: "Cancel",press: () async {

                          Navigator.of(context).pop();

                        },),
                        LoginButton(text: "Add Money",press: () async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => AddMoney(widget.amount-walletBalance)),
                          );}
                            ),
                      ],
                    )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}


class LoginButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final textColor = Colors.white;

  const LoginButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height*.08,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          color: Colors.purple,
          child: TextButton(
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

