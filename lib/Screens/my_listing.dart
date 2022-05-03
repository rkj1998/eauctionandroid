import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../const.dart';

class MyListing extends StatefulWidget {
  var listing;
  String listingName;
  MyListing({Key? key,required this.listing,required this.listingName}) : super(key: key);

  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing> {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.75,
                  child:ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        )
                    ),
                    onPressed: () async {
                      if(widget.listing['isActive']==true){
                        Fluttertoast.showToast(
                            msg: "Cannot Delete an active listing.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else{
                        SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
                        _dialog.show(message: "Deleting");
                        List data = ProfileData.userData['myListings'];
                        data.remove(widget.listingName);
                        await FirebaseFirestore.instance.collection("User Info").doc(
                            FirebaseAuth.instance.currentUser!.uid).update({"myListings":data});
                        await FirebaseFirestore.instance.collection("Listings").doc(
                            widget.listingName).delete();
                        var data2 = await FirebaseFirestore.instance.collection("User Info").doc(FirebaseAuth.instance.currentUser!.uid).get();
                        ProfileData.assignData(data2);
                        listings = await FirebaseFirestore.instance.collection("Listings").get();
                        _dialog.hide();
                        Fluttertoast.showToast(
                            msg: "Deleted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.of(context).pop();
                      }

                    },
                    child: const Text(
                      "Delete Listing",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                  ) ,
                ),

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
                      if(widget.listing['isActive']==true){
                        Fluttertoast.showToast(
                            msg: "Cannot start an active listing.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else{
                        startAuction(context);
                      }
                    },
                    child: const Text(
                      "Start Auction",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                  ) ,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        const Text("Item Price",style: TextStyle(
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

              ],
            ),
          ),
        ));
  }
  void startAuction(context){

    TextEditingController itemPrice = TextEditingController();
    itemPrice.text=widget.listing['Item Price'].toString();
    TextEditingController duration = TextEditingController();

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height/1.35,
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

                    const Text("Start Auction",style: TextStyle(
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
                  margin: const EdgeInsets.only(top:8  ),
                  padding: const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                  alignment: Alignment.center,
                  child:Center(
                      child:TextField(

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                        style: TextStyle(color: Colors.grey,
                            fontSize:MediaQuery.of(context).size.width*.038
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Item Price",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),
                        ),
                        controller: itemPrice,
                      )
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
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
                  margin: const EdgeInsets.only(top:8  ),
                  padding: const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                  alignment: Alignment.center,
                  child:Center(
                      child:TextField(

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                        style: TextStyle(color: Colors.grey,
                            fontSize:MediaQuery.of(context).size.width*.038
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Duration in Hours",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),
                        ),
                        controller: duration,
                      )
                  ),
                ),
                const SizedBox(height: 5,),
                GestureDetector(
                    onTap: () async {

                      if(itemPrice.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Enter Item Price",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }


                      if(duration.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Enter Duration",
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
                        _dialog.show(message: "Please wait...",
                          indicatorColor: primaryColor,);
                        await FirebaseFirestore.instance.collection("Listings").doc(
                            widget.listingName).update({
                          "isActive":true,
                          "duration":int.parse(duration.text),
                          "fees":int.parse(itemPrice.text),
                          "startTime":DateTime.now(),
                          "endTime":DateTime.now().add(Duration(hours: int.parse(duration.text))),
                        });
                        _dialog.hide();

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
                      child:  const Text("Save",
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

