import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato_app/Helpers/homepagehelpers.dart';
import 'package:pizzato_app/Models/mapmodel.dart';
import 'package:pizzato_app/Views/selectionpage.dart';
import 'package:pizzato_app/Views/yourcartpage.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MapModel>(context,listen: false).getCurrentLocation();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
        },
        elevation: 15.0,
        backgroundColor: Color(0xFFFFC468),
        child: Consumer<CartList>(
          builder: (context, cl,child){
            return Stack(
              overflow: Overflow.visible,
              children:<Widget>[ 
                Icon(EvaIcons.shoppingCartOutline, color: Colors.black, size: 30,), 
                cl.cmodel.length != 0 ? 
                Positioned(
                  top: -20,
                  right: -10,
                  child: Container(    
                    padding: EdgeInsets.only(top: 0,left: 4,right: 5,bottom: 2),
                    width: 20,
                    height: 25,                
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: Center(child: Text(cl.cmodel.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w600),),),
                  ),
                ) : Positioned(
                  top: -20,
                  right: -10,
                  child: Container(    
                    padding: EdgeInsets.only(top: 0,left: 4,right: 5,bottom: 2),
                    width: 20,
                    height: 25,
                    color: Colors.transparent,
                  ),
                ),
              ],
            );
          }
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 30.0, color: Colors.black,),
                     SizedBox(width: 5,),
                    Row(
                     children: <Widget>[
                       Icon(EvaIcons.navigation2Outline, size: 30.0, color: Color(0xFFFFC468),),                       
                       Padding(
                         padding: const EdgeInsets.only(right:2.0),
                         child: Consumer<MapModel>(
                           builder: (context, mapmodel, child){
                            return Container(
                              color: Colors.blueGrey[50],
                             width: MediaQuery.of(context).size.width-140,
                             margin: EdgeInsets.only(right: 2),
                            child: mapmodel.getit == null ?  Text('Loading...') : Text(mapmodel.getit.first.addressLine,maxLines: 3,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[900], fontSize: 16.0, fontWeight: FontWeight.bold,wordSpacing: 2),)
                            );
                           },
                          ),
                       ),
                     ],
                      ),
                     SizedBox(width: 5,),
                    Icon(Icons.search, color: Colors.black, size: 30.0,),
                  ],
                ),
                SizedBox( height: 30.0),
                HeadingWidget(),
                SizedBox( height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OptionWidget(title: 'All Food', col1: Colors.red[200], col2: Color(0xFFFFC468),),
                    OptionWidget(title: 'Pizza', col1: Colors.lightBlue[400], col2: Colors.grey[100],),
                    OptionWidget(title: 'Pasta', col1: Colors.lightGreen[400],col2: Colors.grey[100],),
                  ],
                ),
                SizedBox(height: 30.0,),
                TopicWidget(topic: 'Favourite',sub: 'dishes',),
                SizedBox(height: 5.0,),

                StreamBuilder(
                  stream: _firestore.collection('favourite').snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator( backgroundColor: Colors.lightBlueAccent,),
                      );
                    }

                    return Container(
                      height: 300.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.documents.length, 
                        itemBuilder: (BuildContext context, int index) {                           
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SelectPage(select_name: snapshot.data.documents[index].data()['name'], 
                                select_url: snapshot.data.documents[index].data()['image'], 
                                select_category: snapshot.data.documents[index].data()['category'], 
                                select_rating: snapshot.data.documents[index].data()['rating'], 
                                select_price: snapshot.data.documents[index].data()['price'],),
                              ));
                            },
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Container(
                                 margin: EdgeInsets.symmetric(horizontal: 4.0),
                                 height: 300,
                                 width: 210,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20.0),
                                   color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey[50],
                                       offset: Offset(7, 9),
                                       blurRadius: 3,
                                       spreadRadius: 3,
                                     ),
                                   ],
                                 ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top:4.0, right: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(150.0),                                              
                                            ),
                                             height: 180,
                                             child: Image.network(snapshot.data.documents[index].data()['image'],fit:  BoxFit.fill,),
                                           ),
                                        ),
                                        Positioned(
                                          left: 150,
                                          child: IconButton(icon: Icon(EvaIcons.heart, color: Colors.red,), onPressed: (){}),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                                      child: Text(snapshot.data.documents[index].data()['name'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                                      child: Text(snapshot.data.documents[index].data()['category'], style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.redAccent,),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.0, left: 20.0),
                                      child: Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.star, color: Colors.yellow[700],),
                                              Text(snapshot.data.documents[index].data()['rating'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 80.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.rupeeSign, size: 15.0,),
                                                Text(snapshot.data.documents[index].data()['price'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                             ),
                          );
                        },
                      ),
                    );
                  }
                ),

                SizedBox(height: 30.0,),
                TopicWidget(topic: 'Business', sub: 'lunch',),
                SizedBox(height: 5.0,),

                StreamBuilder(
                  stream: _firestore.collection('business').snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
                      );
                    }

                    return Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SelectPage(select_name: snapshot.data.documents[index].data()['name'], 
                                select_url: snapshot.data.documents[index].data()['image'], 
                                select_category: snapshot.data.documents[index].data()['category'], 
                                select_rating: '4.5', 
                                select_price: snapshot.data.documents[index].data()['Price'],),
                              ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20.0),
                                   color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey[200],
                                       blurRadius: 20,
                                       spreadRadius: 20,
                                       offset: Offset(8, 5)
                                     ),
                                   ],
                                 ),
                              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              child: Stack(
                                overflow: Overflow.clip,
                                children: <Widget>[
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    left: 200,
                                   child: Container(
                                     decoration: BoxDecoration(
                                       boxShadow: [
                                         BoxShadow(
                                           color: Colors.grey[350],
                                           spreadRadius: 10,
                                           blurRadius: 6,
                                         ),
                                       ],
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data.documents[index].data()['image']),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0), topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                     ),
                                      width: 150,
                                      height: 150,
                                      //child: Image.network(snapshot.data.documents[index].data()['image'], fit: BoxFit.fill,),
                                    ),
                                  ),

                                  Positioned(
                                    left: 20,
                                    top: 20,
                                    right: 250,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(snapshot.data.documents[index].data()['name'], style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500),),
                                        SizedBox(height: 3.0,),
                                        Text(snapshot.data.documents[index].data()['category'], style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),),
                                        SizedBox(height: 15.0,),
                                        Row(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.rupeeSign, color: Colors.yellowAccent[700], size: 15,),
                                            Text(snapshot.data.documents[index].data()['noPrice'], style: TextStyle(color: Colors.yellowAccent[700], fontSize: 16.0, fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.rupeeSign, color: Colors.black, size: 20,),
                                            Text(snapshot.data.documents[index].data()['Price'], style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

