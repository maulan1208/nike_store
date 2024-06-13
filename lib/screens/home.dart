import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:nike_shop/data/dummy_data.dart';
import 'package:nike_shop/screens/details.dart';
import 'package:nike_shop/service/database.dart';
import 'package:nike_shop/service/shared_pref.dart';
import 'package:nike_shop/widget/widget_support.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  String?  name;
  
  Stream? shoeItemStream;
  Stream? shoeMoreItemStream;

  getthename() async {
  name = await SharedPreferenceHelper().getUserName();
  setState(() {
    
  });
  }

  ontheload() async{
    shoeItemStream = await DatabaseMethod().getShoeItem("Shoe");
    shoeMoreItemStream = await DatabaseMethod().getShoeMoreItem("ShoeMore");
    await getthename();
    setState(() {
    });
  }

  @override
    void initState() {
      ontheload();
      super.initState();
    }
  
  Widget allItemsMore () {
    
    return StreamBuilder(stream: shoeMoreItemStream , builder: (context, AsyncSnapshot snapshot){
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index){
        DocumentSnapshot ds = snapshot.data.docs[index];
        return 
        GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Details(
                      name: ds["Name"],
                      price: ds["Price"],
                      image: ds["imgAddress"],)));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.0, bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              ds["imgAddress"],
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20.0,),
                          Column(children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text(
                                ds["Name"], 
                                style: AppWidget.semiBoldTextFeildStyle(),)),
                            SizedBox(height: 5.0,),
                            // Container(
                            // width: MediaQuery.of(context).size.width/2,
                            // child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
                            //   SizedBox(height: 5.0,),
                            Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text(
                              "\$" + ds["Price"], 
                              style: AppWidget.semiBoldTextFeildStyle(),))
                        ],)
                      ],
                    ),
                  ),
                ),
              ),
                    );
    }):CircularProgressIndicator();
    });
  }

  Widget allItems () {
    return StreamBuilder(stream: shoeItemStream , builder: (context, AsyncSnapshot snapshot){
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        DocumentSnapshot ds = snapshot.data.docs[index];
        return 
        GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> Details(
                            name: ds["Name"],
                            price: ds["Price"],
                            image: ds["imgAddress"],
                          )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      ds["imgAddress"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiBoldTextFeildStyle()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\$" + ds["Price"] ,
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    );
    }):CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, " + name!, 
                    style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.circle_notifications_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),


              SizedBox(
                height: 20.0,
              ),

              Text("Discover", style: AppWidget.HeadlineTextFeildStyle()),

              SizedBox(
                height: 20.0,
              ),

              
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay1.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("AIR-MAX",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     // Text("Fresh and Healthy",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Text(
              //                       "\$130",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),

              //       GestureDetector(
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay2.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("Veggie Taco Hash",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     // Text("Fresh and Healthy",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     Text(
              //                       "\$25",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),
      
              //       GestureDetector(
              //          onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay2.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("Mix Veg Salad",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     // Text("Spicy with Onion",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     Text(
              //                       "\$28",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),

              //       GestureDetector(
              //          onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay3.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("AIR-JORDAN MID",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     // Text("Spicy with Onion",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     Text(
              //                       "\$190",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),

              //       GestureDetector(
              //          onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay4.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("AIR JORDAN 1",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     // Text("Spicy with Onion",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     Text(
              //                       "\$160",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),

              //       GestureDetector(
              //          onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/giay5.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("AIR-JORDAN LOW",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     // Text("Spicy with Onion",
              //                     //     style: AppWidget.LightTextFeildStyle()),
              //                     // SizedBox(
              //                     //   height: 5.0,
              //                     // ),
              //                     Text(
              //                       "\$150",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                height: 260,
                child: allItems()),
              SizedBox(
                height: 30.0,
              ),

              
              Text("More", style: AppWidget.HeadlineTextFeildStyle()),
              SizedBox(
                height: 20.0,
              ),

              Container(
                height: 260,
                child: allItemsMore()),

              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/giay2.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(width: 20.0,),
              //           Column(children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Mediterranean Chickpea Salad", style: AppWidget.semiBoldTextFeildStyle(),)),
              //               SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
              //                 SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),))
              //           ],)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              //   SizedBox(
              //   height: 30.0,
              // ),

              
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/giay2.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(width: 20.0,),
              //           Column(children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Mediterranean Chickpea Salad", style: AppWidget.semiBoldTextFeildStyle(),)),
              //               SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
              //                 SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),))
              //           ],)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              //   SizedBox(
              //   height: 30.0,
              // ),

              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/giay2.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(width: 20.0,),
              //           Column(children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text(
              //                 "Veggie Taco Hash", 
              //                 style: AppWidget.semiBoldTextFeildStyle(),)),
              //               SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
              //                 SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),))
              //           ],)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

