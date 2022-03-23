import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauctionandroid/Screens/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../const.dart';

class PaymentProvider extends StatefulWidget {
  final double currentAmount;
  final double amount;

  const PaymentProvider(this.amount,this.currentAmount, {Key? key}) : super(key: key);
  @override
  _PaymentProviderState createState() => _PaymentProviderState();
}


class _PaymentProviderState extends State<PaymentProvider> {
  var _razorpay;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.greenAccent[400]
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Payment Page'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                  padding: const EdgeInsets.all(20),
                    child: Text(
                      "You are about to pay ₹"+widget.amount.toString() ,
                      style: const TextStyle(
                          fontSize: 25,
                          fontFamily: "Quando",
                          color: primaryColor
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      maxLines: 5,
                    ),
                ),
                const SizedBox(height: 20,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Center(
                          child: Container(
                            width: 150.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              gradient:LinearGradient(
                                  colors: <Color>[
                                    primaryColor,
                                    secondaryColor,
                                  ]
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ) ,
                              color: Colors.blue,
                            ),
                            margin: const EdgeInsets.all(10.0),
                            child: const Center(
                              child: Text(
                                "Proceed",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          openCheckout();
                        },

                      )
                    ]),
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'amount':widget.amount*100,
      //'key':'rzp_live_cGlZvDGFOLznzN',    // For Live purposes
      'key':'rzp_test_T6SVk250w6bA0I',    // For testing purposes
      'name': 'EAuction ',
      'description': 'Add Money To Wallet',
      'prefill': {'contact': '', 'email': ''},
      'theme':{
        "color":"#800080",
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
    _dialog.show(message: "Please wait...",indicatorColor: Colors.greenAccent[400]);
    await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).
    update({
      "Balance":widget.currentAmount+widget.amount
    });

    _dialog.hide();

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, timeInSecForIosWeb: 4);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const WalletPage()),
    );
  }








  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "We don't support external Wallets now, if you made the payment please contact customer care.",
        timeInSecForIosWeb: 10);
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4);
  }

}
