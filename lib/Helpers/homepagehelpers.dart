import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OptionWidget extends StatelessWidget {
 final String title;
 final Color col1;
 final Color col2;
  const OptionWidget({
    Key key, this.title, this.col1,this.col2, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: col1,width: 2),
          boxShadow: [
            BoxShadow(
              color: col2,
              blurRadius: 16,
            ),
          ],
          borderRadius: BorderRadius.circular(50.0),
          color: col2,
        ),
        width: 100.0,
        height: 40.0,
        child: Center(
          child: Text('$title', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}

class TopicWidget extends StatelessWidget {

  final String topic, sub;
  const TopicWidget({
    Key key, this.topic, this.sub
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: RichText(
        text: TextSpan(
          text: '$topic ',
          style: TextStyle(
            shadows: [BoxShadow(color: Colors.black, blurRadius: 1),],
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 36.0,
          ),
          children: <TextSpan> [
            TextSpan(
              text: '$sub',
              style: TextStyle(
            shadows: [BoxShadow(color: Colors.grey, blurRadius: 0),],
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            fontSize: 22.0,
          ),
            ),
          ],
        ),
      ),
    );
  }
}



class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      width: 300.0,
      child: RichText(
        text: TextSpan(
          text: 'What would you like ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 30.0,
          ),
          children: <TextSpan> [
            TextSpan(
              text: 'to eat ?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 45.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]
        ),
      ),
    );
  }
}
