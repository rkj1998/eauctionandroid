import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauctionandroid/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children:  [
          SizedBox(height: MediaQuery.of(context).size.height/14),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Discover",style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: secondaryColor
            ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/35),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Auction Marketplace",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black
            ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LineIcon.search(
                color: secondaryColor,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width/1.25,
                child: TextFormField(
                    controller: search,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(hintText: 'Search Here',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    )
                ),
              )
            ],
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
              onPressed: () {

              },
              child: const Text(
                "Create New Listing",
                style: TextStyle(
                  color: Colors.white
                ),
              ),

            ) ,
          ),
          SizedBox(height: MediaQuery.of(context).size.height/20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "New Deals",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black
                ),
                ),
              ),
              LineIcon.fire(color: Colors.red,)
            ],
          )
        ],
      ),
    );
  }


  void createNewListing(context){
    XFile? courseImage;
    final picker = ImagePicker();
    List<int> imageData =[];
    TextEditingController itemName = TextEditingController();
    TextEditingController itemPrice = TextEditingController();
    TextEditingController itemCategory = TextEditingController();
    TextEditingController aboutItem = TextEditingController();

    Uint8List bytes;
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

                    const Text("Create New Listing",style: TextStyle(
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]"))
                        ],
                        style: TextStyle(color: Colors.grey,
                            fontSize:MediaQuery.of(context).size.width*.038
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Item Name",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),
                        ),
                        controller: itemName,
                      )
                  ),
                ),

                Container(
                  height: 70,
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
                  padding:const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                  alignment: Alignment.center,
                  child:Center(
                      child:TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.grey,
                            fontSize:10
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Item Category",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),

                        ),
                        controller: itemCategory,
                      )
                  ),
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
                        style: TextStyle(color: Colors.grey,
                            fontSize:MediaQuery.of(context).size.width*.038
                        ),
                        cursorColor: Colors.greenAccent[400],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "About Item",
                          hintStyle: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w100
                          ),

                        ),
                        controller: aboutItem,
                      )
                  ),
                ),

                StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                  return GestureDetector(
                      onTap: () async{
                        courseImage=await picker.pickImage(source: ImageSource.gallery);

                      },
                      child: Container(
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
                        margin: const EdgeInsets.only(top:18 ),
                        padding: const EdgeInsets.symmetric(horizontal:25,vertical: 5 ),
                        alignment: Alignment.center,
                        child:  const Text("Item Image",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),),

                      ));
                },),

                const SizedBox(height: 5,),
                GestureDetector(
                    onTap: () async{
                      SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false,duration: const Duration(seconds: 5));
                      _dialog.show(message: "Please wait...",indicatorColor: primaryColor,);
                      var reference = firebase_storage.FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString()+itemCategory.text+itemPrice.text+itemName.text).
                      child("image.jpg");
                      final metadata = firebase_storage.SettableMetadata(
                          contentType: 'image/jpeg',
                          customMetadata: {'picked-file-path': courseImage!.path});
                      var uploadTask = reference.putData(await courseImage!.readAsBytes(), metadata);
                      /*
                      final CollectionReference listings = FirebaseFirestore.instance.collection(
                          'Listings');
                      listings.doc(FirebaseAuth.instance.currentUser!.uid.toString()+itemCategory.text+itemPrice.text+itemName.text).set({
                        "Item Name":itemName.text,
                        "Item Category":itemCategory.text,
                        "Item Price":int.parse(itemPrice.text),
                        "About Item":aboutItem.text,

                      });

                       */

                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color:  Colors.black,
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
