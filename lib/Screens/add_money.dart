import 'package:eauctionandroid/Screens/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const.dart';


class AddMoney extends StatelessWidget {
  final double currentAmt;
  AddMoney(this.currentAmt, {Key? key}) : super(key: key);
  late double amt;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Add Money",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.08,),
                const Text("Add Money To Wallet",style: TextStyle(
                  fontSize: 25,
                ),),
                SizedBox(height: MediaQuery.of(context).size.height*.15,),
                TextFormField(
                  onChanged: (value){
                    amt = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: primaryColor,
                  decoration: const InputDecoration(
                    hintText: "₹ Amount",
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: (primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.08,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        )
                    ),
                    onPressed: () {
                      if (amt == 0) {
                        Fluttertoast.showToast(
                            msg: "Enter Amount greater than 0",
                            timeInSecForIosWeb: 4,
                          backgroundColor: primaryColor
                        );
                      }
                      else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentProvider(amt, currentAmt)),
                        );
                      }
                    },
                    child: Text("Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width*0.05,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
