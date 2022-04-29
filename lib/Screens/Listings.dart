import 'package:eauctionandroid/const.dart';
import 'package:flutter/material.dart';

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }
  List myListings = [];
  bool isLoaded = true;
  fetchData() async{
    for(int i=0;i<ProfileData.userData['myListings'].length;i++){
      var data = await listings.doc(ProfileData.userData['myListings'][i]).get();
      myListings.add(data);
    }
    setState(() {
      isLoaded = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoaded? const Center(child: CircularProgressIndicator()):Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20,),
            const Text("My Listings",style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
                itemCount: myListings.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/2 - 10,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              height:MediaQuery.of(context).size.height/5 - 90 ,
                              width: MediaQuery.of(context).size.width/2 - 10,
                              child: Image.network(myListings[index]['url'],fit: BoxFit.fill,)
                          ),
                          Center(
                            child: Text(
                                myListings[index]['Item Name'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '₹'+myListings[index]['Item Price'].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },),
            ),
            const Text("Marked Auctions",style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: MediaQuery.of(context).size.height/4,
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(

                  );
                },),
            ),
          ],
        ),
      ),
    );
  }
}
