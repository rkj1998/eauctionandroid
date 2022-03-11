import 'package:eauctionandroid/const.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

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
          SizedBox(height: MediaQuery.of(context).size.height/14),
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
}
