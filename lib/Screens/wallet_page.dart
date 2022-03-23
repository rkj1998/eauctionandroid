import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      walletBalance=data["Balance"];
    });
  }

  DateTime date = DateTime.now();
  Future<void> _date(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  DateTime date2 = DateTime.now();
  Future<void> _date2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != date) {
      setState(() {
        date2 = picked;
      });
    }
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("WALLET",style: TextStyle(
              color: Colors.greenAccent[400],
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
                  children: [
                    const Icon(
                      Icons.account_balance_outlined,
                    ),
                    Text("Send Money To Bank",
                    style: TextStyle(
                      color: Colors.greenAccent[400],
                      fontSize: 15
                    ),),
                    const InkWell(
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
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_outlined,
                      ),
                      Text("Add Money To Wallet",
                        style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontSize: 15
                        ),),
                      const Icon(
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
                  children: [
                    const Icon(
                      Icons.account_balance,
                    ),
                    Text("Add/Edit Bank Account",
                      style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: 15
                      ),),
                    const InkWell(
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
                  color: Colors.greenAccent[400],
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



