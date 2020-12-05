import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato_app/Models/cartmodel.dart';
import 'package:pizzato_app/Views/yourcartpage.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectPage extends StatefulWidget {
 // ignore: non_constant_identifier_names
  String select_name,select_url, select_category, select_rating, select_price;


  // ignore: non_constant_identifier_names
  SelectPage({Key key,@required this.select_name,@required this.select_url,@required this.select_category, @required this.select_rating, @required this.select_price, }) : super(key : key);
  @override
  _SelectPageState createState() => _SelectPageState(select_name,select_url, select_category, select_rating, select_price);
}

class _SelectPageState extends State<SelectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSelectedSmall = true;
  bool isSelectedMedium = false;
  bool isSelectedLarge = false;

  int cheeseCount = 0;

  bool optionOnion = false;
  bool optionBacon = false;

  // ignore: non_constant_identifier_names
  String select_name,select_url, select_category, select_rating, select_price;
  _SelectPageState(this.select_name, this.select_url, this.select_category, this.select_rating, this.select_price);

      void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      elevation: 3.0,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.amber[300],
      content: Text(message, style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Sorry!! You cannot delete this Item.', backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, fontSize: 16);
                    }),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
              height: MediaQuery.of(context).size.height/3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 30.0,
                  shadowColor: Colors.black,
                  child: Image.network(
                    select_url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  select_rating != null ? 
                  Text(
                    select_rating,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ) : Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ) , 
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Row(
                children: <Widget>[
                  Text(
                    select_name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    select_category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.rupeeSign,
                        size: 16.0,
                      ),
                      Text(
                        isSelectedSmall ? select_price : 
                        isSelectedMedium ? (int.parse(select_price)+20).toString() : (int.parse(select_price)+40).toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[100],
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: Offset(2, -3),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if(isSelectedSmall == false){
                              setState(() {
                                isSelectedSmall = true;
                                isSelectedMedium = false;
                                isSelectedLarge = false;
                              });                              
                            }
                            else{
                              setState(() {
                                isSelectedSmall = false;
                              }); 
                            }
                          },
                           child: Container(
                            margin: EdgeInsets.only(left: 100),
                            width: 45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelectedSmall ? Colors.amber[300] : Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelectedSmall? Colors.amber[50] : Colors.grey[100],
                                  spreadRadius: 8,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'S',
                                style: TextStyle(
                                    color: isSelectedSmall? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(isSelectedMedium == false){
                              setState(() {
                                isSelectedMedium = true;
                                isSelectedSmall = false;
                                isSelectedLarge = false;
                              });                              
                            }
                            else{
                              setState(() {
                                isSelectedMedium = false;
                              }); 
                            }
                          },
                            child: Container(
                            margin: EdgeInsets.only(left: 30),
                            width: 45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelectedMedium ? Colors.amber[300] : Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelectedMedium? Colors.amber[50] : Colors.grey[100],
                                  spreadRadius: 8,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'M',
                                style: TextStyle(
                                    color: isSelectedMedium? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(isSelectedLarge == false){
                              setState(() {
                                isSelectedLarge = true;
                                isSelectedMedium = false;
                                isSelectedSmall = false;
                              });                              
                            }
                            else{
                              setState(() {
                                isSelectedLarge = false;
                              }); 
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30),
                            width: 45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelectedLarge ? Colors.amber[300] : Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelectedLarge? Colors.amber[50] : Colors.grey[100],
                                  spreadRadius: 8,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'L',
                                style: TextStyle(
                                    color: isSelectedLarge? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Add more stuff',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Cheese',
                              style: TextStyle(
                                  color: cheeseCount>0 ? Colors.black : Colors.grey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            Row(
                              children: <Widget>[
                                Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        if(cheeseCount >0){
                                        setState(() {
                                              cheeseCount = cheeseCount - 1;
                                            });
                                        }
                                      },
                                     child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 30,
                                            top: 0,
                                            left: 2,
                                            right: 2),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[100],
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(2, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: -15,
                                        bottom: 20,
                                        right: -12,
                                        child: IconButton(
                                          icon: Icon(Icons.minimize, size: 25.0,),
                                          onPressed: () {                                            
                                          },
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    cheeseCount.toString(),
                                    style: TextStyle(
                                        color: cheeseCount>0 ? Colors.black : Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if(cheeseCount<6){
                                              cheeseCount = cheeseCount + 1;
                                          }
                                            });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 30,
                                            top: 0,
                                            left: 2,
                                            right: 2),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[100],
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: Offset(2, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: -8,
                                        bottom: 20,
                                        right: -12,
                                        child: IconButton(
                                          icon: Icon(Icons.add, size: 25,),
                                          onPressed: () {                                            
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Onion',
                              style: TextStyle(
                                  color: optionOnion ? Colors.black: Colors.grey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if(optionOnion == false){
                                    optionOnion = true;
                                  }
                                  else{
                                    optionOnion = false;
                                  }
                                });
                              },
                              elevation: 0.0,
                              focusElevation: 5.0,
                              color: Color(0xFFF9F9F9),
                              hoverElevation: 4.0,
                              focusColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(optionOnion ?
                                    Icons.close : Icons.add,
                                    size: 20,
                                    color: optionOnion ? Colors.red:Colors.black87,
                                  ),
                                  Text(optionOnion ?
                                    'Remove':'Add',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: optionOnion ? Colors.red: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Bacon',
                              style: TextStyle(
                                  color: optionBacon ? Colors.black: Colors.grey[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if(optionBacon == false){
                                  optionBacon = true;
                                }
                                else{
                                  optionBacon = false;
                                }
                                });                                
                              },
                              elevation: 0.0,
                              focusElevation: 5.0,
                              color: Color(0xFFF9F9F9),
                              hoverElevation: 4.0,
                              focusColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(optionBacon ?
                                    Icons.close : Icons.add,
                                    size: 20,
                                    color: optionBacon ? Colors.red:Colors.black87,
                                  ),
                                  Text(optionBacon ?
                                  'Remove':'Add',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: optionBacon ? Colors.red:Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    right: 120,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFFC468).withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 15,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          
                          CartModel cm = CartModel(furl: select_url, fname: select_name, fcategory: select_category,
                          fprice: isSelectedSmall ? select_price : isSelectedMedium ? (int.parse(select_price)+20).toString() : (int.parse(select_price)+40).toString() ,
                          fsize: isSelectedSmall? 'S' : isSelectedMedium ? 'M' : 'L',
                          fcheese: cheeseCount.toString() ,fonion: optionOnion ? '1' : '0',fbacon: optionBacon ? '1' : '0');
                          
                          Provider.of<CartList>(context, listen: false).addCartDetails(cm);

                           //Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
                           _showScaffold('Successfully added to the Cart !!');

                        },
                        elevation: 20.0,
                        focusElevation: 5.0,
                        color: Color(0xFFFFC468),
                        hoverElevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        child: 
                            Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
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
                    child: Center(child: Text(cl.cmodel.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w600),)),
                  ),
                ) :
                Positioned(
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
    );
  }
}

class CartList extends ChangeNotifier{

  List<CartModel> cmodel = [];
   int total = 0;
  addCartDetails(CartModel cm){
    cmodel.add(cm);
    total += int.parse(cm.fprice);
    notifyListeners();
  }
}

