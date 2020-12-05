import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato_app/Views/mapview.dart';
import 'package:pizzato_app/Views/selectionpage.dart';
import 'package:provider/provider.dart';
import 'package:pizzato_app/Models/mapmodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  num totalamt;

  Razorpay _razorpay ;

   @override
  void initState() {
    _razorpay = Razorpay();
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


  void openCheckOut() {
    var options = {
      'key' : 'rzp_test_NDGg3issFaT27L',
      'amount' : totalamt * 100,
      'name' : 'G. Ravi Teja Reddy',
      'description' : 'Pay n enjoy your pizza',
      'externals' : {
        'wallets' : ['paytm']
      }
    };

    try{
      _razorpay.open(options);
    } catch(e){
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'Payment Successfull'+ response.paymentId,backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_LONG, fontSize: 16);
    setState(() {
      Provider.of<CartList>(context, listen: false).cmodel.clear();
      Provider.of<CartList>(context,listen: false).total = 0;
    });
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Error :'+ response.message.toString(),backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, fontSize: 16);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'External Wallet : '+ response.walletName,backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, fontSize: 16);
  }
  

  @override
  Widget build(BuildContext context) {
    return Consumer<CartList>(
        builder: (context, cl, child){
          cl.total != 0 ? totalamt = cl.total + 20 : totalamt = 0;
        return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                            text: 'Your\n',
                            style: TextStyle(
                              shadows: [
                                BoxShadow(color: Colors.grey, blurRadius: 0),
                              ],
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 22.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Cart',
                                style: TextStyle(
                                  shadows: [
                                    BoxShadow(color: Colors.black, blurRadius: 1),
                                  ],
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 36.0,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 0.2),
                  ),

                child: Consumer<CartList>(
                  builder: (context, cl, child){
                    return  cl.cmodel.length != 0 ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cl.cmodel.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 0.1),
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child:  Stack(
                          overflow: Overflow.clip,
                          children: <Widget>[
                            Positioned(
                              left: 5,
                              top: 10,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.black, width: 0.1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 8.0,
                                      shadowColor: Colors.white60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          cl.cmodel[index].furl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 1),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Size : ',
                                          style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: cl.cmodel[index].fsize,
                                              style: TextStyle(
                                                color: Colors.redAccent[400],
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      cl.cmodel[index].fname + '  ' + cl.cmodel[index].fcategory,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      cl.cmodel[index].fcheese != '0' ?
                                      'x' + cl.cmodel[index].fcheese + ' cheese' : '',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                     Text(cl.cmodel[index].fonion != '0' ?
                                      'x'+'1'+' Onion' : '', style: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600),),
                                    SizedBox(
                                      height: 2,
                                    ),
                                     Text(cl.cmodel[index].fbacon != '0' ?
                                      'x'+'1'+' bacon'  : '', style: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      color: Color(0xFF222222),
                                      size: 16,
                                    ),
                                    Text(
                                      cl.cmodel[index].fprice,
                                      style: TextStyle(
                                          color: Color(0xFF222222),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cl.total -= int.parse(cl.cmodel[index].fprice); 
                                    cl.cmodel.removeWhere((element) => element.fname == cl.cmodel[index].fname);
                                  });                                  
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14 , vertical: 10),
                    child: Image.asset('animations/empty_cart.png', color: Colors.black,),
                  ),
                );
                },
              ),
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black26,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Consumer<MapModel>(
                  builder: (context, mapmodel, child){
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey[800],
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  mapmodel.getit != null ?
                                  Container(
                                    width: MediaQuery.of(context).size.width-160,
                                    margin: EdgeInsets.only(left: 2,right: 2, top: 4),
                                    child: Text( 
                                       mapmodel.getit.first.addressLine+', '+mapmodel.getit.first.countryName,
                                       maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                      ),
                                  ) :
                                    Text( 
                                     'Loading ...',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
                                    )
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapView()));
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    EvaIcons.clockOutline,
                                    color: Colors.grey[800],
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '25 - 30 min',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: 'Right now, this option is not editable', backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, fontSize: 16);
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    color: Colors.grey[800],
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Cash',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: 'Right now, this option is not editable', backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, fontSize: 16);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                 }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20,bottom: 10),
                child:  Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Subtotal',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: Color(0xFFA4A4A4),
                              size: 17,
                            ),
                                Text(
                                  cl.total.toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Delivery fee',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: Colors.black54,
                              size: 17,
                            ),
                            Text(
                              cl.total == 0 ? ' 0' : ' 20',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: Colors.black,
                              size: 20,
                            ),
                            Text(
                              cl.total != 0 ?(cl.total+20).toString() : '0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFC468).withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      if(cl.total == 0){
                        Fluttertoast.showToast(msg: 'Your Cart Is Empty. Cannot Place Order.',backgroundColor: Colors.blueGrey[900], textColor: Colors.white, toastLength: Toast.LENGTH_LONG, fontSize: 16);
                      }
                      else{
                      openCheckOut();
                      }
                    },
                    elevation: 20.0,
                    focusElevation: 5.0,
                    color: Color(0xFFFFC468),
                    hoverElevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
     }
    );
  }
}

