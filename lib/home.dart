import 'package:flutter/material.dart';
import 'package:git/Pages/Following.dart';
import 'package:git/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controller = TextEditingController();

  void _getUser(){
    if (_controller.text == ''){
      Provider.of<UserProvider>(context).setMessage("Please use a valid username");
    } else{
      Provider.of<UserProvider>(context).fetchUser(_controller.text).then((value){
        if (value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Following()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children:[
              SizedBox(height: 100),
              Container(
                width: 80,
                height: 80,
                child:CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage('https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg')
                )
              ),
              SizedBox(height:30),

              Text("Github", style:TextStyle(color:Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: 150),

              Container(
                padding: EdgeInsets.symmetric(horizontal:15, vertical:10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.1)
                ),
                child: TextField(
                  onChanged: (value){
                    Provider.of<UserProvider>(context).setMessage(null);
                  },
                  controller: _controller,
                  enabled: !Provider.of<UserProvider>(context).isLoading(),
                  style: TextStyle(color:Colors.white),
                  decoration: InputDecoration(
                    errorText: Provider.of<UserProvider>(context).getMessage(),
                    border: InputBorder.none,
                    hintText: "Github username",
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                )
              ),

              SizedBox(height: 20),

              MaterialButton(
                onPressed: (){
                  _getUser();
                },
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Align(
                  child:
                  Provider.of<UserProvider>(context).isLoading() ?
                  CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2) :
                   Text("See those you follow", style: TextStyle(color: Colors.white),),
                ),
              )
            ]
          ),
          ),
      ),
    );
  }
}