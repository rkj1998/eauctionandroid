import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../const.dart';

class AuctionScreen extends StatefulWidget {
  var listing;
  String listingName;
  AuctionScreen({Key? key,required this.listing,required this.listingName}) : super(key: key);

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  Timer? countdownTimer;
  late Duration myDuration;

  void initDuration(){
    myDuration = widget.listing['endTime'].toDate().difference(widget.listing['startTime'].toDate());
  }
  @override
  void initState() {
    super.initState();
    initDuration();
    startTimer();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopTimer();
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.01),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),

                Container(
                  height: 168,
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                        image: NetworkImage(widget.listing['url']),
                        fit: BoxFit.contain
                    ),
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border:Border.all(width: .2,color: Colors.grey.withOpacity(.6)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        blurRadius: 15.0,
                        spreadRadius: -5.5,
                      ),
                    ],
                  ),
                ),
               const SizedBox(height: 20,),
                const Text('Item Name',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),),
                const SizedBox(height: 5,),
                Text( widget.listing['Item Name'],style: const TextStyle(
                    color: Colors.grey,
                    fontSize:14
                ),),
                const SizedBox(
                  height: 20,
                ),
                const Text('About Item',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),),
                const SizedBox(height: 5,),
                Text( widget.listing['About Item'],style: const TextStyle(
                    color: Colors.grey,
                    fontSize:14
                ),),
                const SizedBox(
                  height: 20,
                ),
                const Text('Item Category',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18
                ),),
                const SizedBox(height: 5,),
                Text( widget.listing['Item Category'],style: const TextStyle(
                    color: Colors.grey,
                    fontSize:14
                ),),
                const SizedBox(
                  height: 20,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        const Text("Current Bid",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),),
                        Text(widget.listing['Item Price'].toString(),style: const TextStyle(
                            color: Colors.grey,
                            fontSize:14
                        ),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        const Text("Current Highest Bidder:",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.listing["highestBidder"][0],style: const TextStyle(
                            color: Colors.grey,
                            fontSize:14
                        ),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        const Text("Time Remaining:",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("$days Days:$hours Hrs:$minutes Mins:$seconds Secs",style: const TextStyle(
                            color: Colors.green,
                            fontSize:20
                        ),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.75,
                  child:ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        )
                    ),
                    onPressed: () async {
                      placeBid(context);
                    },
                    child: const Text(
                      "Place Bid",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                  ) ,
                ),


              ],
            ),
          ),
        ));
  }

  void placeBid(context){
    TextEditingController bid = TextEditingController();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height/3,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:ListView(
              children: <Widget>[

                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    const Text("Place Bid",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 19
                    ),),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:
                      Container(
                        width:20,
                        height: 20,
                        decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),

                        child:const Icon(Icons.clear,size: 12,color: Colors.white,),

                      ),

                    ),

                  ],
                ),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius:  BorderRadius.circular(20.0),
                    border:Border.all(width: .2,color: Colors.grey.withOpacity(.6)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        blurRadius: 15.0,
                        spreadRadius: -5.5,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top:20  ),
                  padding: const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                  alignment: Alignment.center,
                  child:Center(
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.grey,
                            fontSize:MediaQuery.of(context).size.width*.038
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Bid Amount",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),
                        ),
                        controller: bid,
                      )
                  ),
                ),

                const SizedBox(height: 5,),
                GestureDetector(
                    onTap: () async{
                      if(bid.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Enter Bid Amount",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else if(int.parse(bid.text)<=widget.listing['Item Price']){
                        Fluttertoast.showToast(
                            msg: "Bid Amount Needs to be higher than current bid.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else if(int.parse(bid.text)>ProfileData.userData['Balance']){
                        Fluttertoast.showToast(
                            msg: "Not Enough money in the wallet.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else {
                        SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
                            context: context,
                            barrierDimisable: false,
                            duration: const Duration(seconds: 5));
                      //  _dialog.show(message: "Please wait...",
                        //  indicatorColor: primaryColor,);
                        if(widget.listing['highestBidder'][0]=="NA"){
                         await FirebaseFirestore.instance.collection("Listings").doc(widget.listingName).update({
                            "Item Price":int.parse(bid.text),
                            "highestBidder":[ProfileData.userData['FirstName']+" "+ProfileData.userData['LastName'],FirebaseAuth.instance.currentUser!.uid]
                          });
                          await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).update({
                            "Balance": ProfileData.userData['Balance']-int.parse(bid.text),
                          });
                          var data = await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).get();
                          setState(() {
                            ProfileData.assignData(data);
                          });
                        }
                        else{

                          await FirebaseFirestore.instance.collection("User Info").doc(widget.listing['highestBidder'][1]).update({
                            "Balance": ProfileData.userData['Balance']+widget.listing["Item Price"],
                          });
                          await FirebaseFirestore.instance.collection("Listings").doc(widget.listingName).update({
                            "Item Price":int.parse(bid.text),
                            "highestBidder":[ProfileData.userData['FirstName']+" "+ProfileData.userData['LastName'],FirebaseAuth.instance.currentUser!.uid]
                          });
                          await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).update({
                            "Balance": ProfileData.userData['Balance']-int.parse(bid.text),
                          });
                           var data = await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).get();
                          setState(() {
                            ProfileData.assignData(data);
                          });
                        }
                        _dialog.hide();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color:  primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border:Border.all(width: .2,color: Colors.grey.withOpacity(.6)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            blurRadius: 15.0,
                            spreadRadius: -5.5,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(top:10,bottom: 18  ),
                      padding: const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                      alignment: Alignment.center,
                      child:  const Text("Bid Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),),
                    )),
              ],
            ),
          );
        }
    );
  }


}

