import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import 'add_money.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  double walletBalance=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWalletBalance();
  }

  void fetchWalletBalance()async {
    var data = await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      walletBalance=data["Balance"].toDouble();
    });
  }


  @override
  Widget build(BuildContext context) {
    if(walletBalance==-1){
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MaterialApp(
      title: "Wallet",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("WALLET",style: TextStyle(
              color: primaryColor,
              fontSize: 20
          ),),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Available Balance",
                  style: TextStyle(
                    fontSize: 14,
                  ),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Text(
                  "₹ "+walletBalance.toString(),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.account_balance_outlined,
                    ),
                    Text("Send Money To Bank",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15
                    ),),
                    InkWell(
                      child: Icon(
                        Icons.navigate_next
                      ),
                    )
                  ],

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMoney(walletBalance)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                      ),
                      Text("Add Money To Wallet",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 15
                        ),),
                      Icon(
                          Icons.navigate_next
                      )
                    ],

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.account_balance,
                    ),
                    Text("Add/Edit Bank Account",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15
                      ),),
                    InkWell(
                      child: Icon(
                          Icons.navigate_next
                      ),
                    )
                  ],

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                ),
                Container(
                  color: Colors.deepPurple,
                  height: 7,
                ),
                Container(
                  color: primaryColor,
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



