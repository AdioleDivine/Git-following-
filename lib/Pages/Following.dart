import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:git/Models/User.dart';
import 'package:git/Providers/UserProvider.dart';
import 'package:git/Requests/GitRequests.dart';
import 'package:provider/provider.dart';

class Following extends StatefulWidget {
  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  User user;
  List<User> users;
  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUser();

      Github(user.login).fetchFollowing().then((following){
        Iterable list = json.decode(following.body);
        setState(() {
          users = list.map((model) => User.fromJson(model)).toList();
        });
      });
    });
    return Scaffold(
          body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color:Colors.grey)),
              backgroundColor:Colors.white,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(user.avatar_url),
                        )
                      ),
                      SizedBox(height: 20),
                      Text(user.login, style: TextStyle(fontSize: 20))
                    ],
                  ),
                )
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                height: 600,
                child:
                users != null ?
                ListView.builder(
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder:(context, index){
                    return Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(users[index].avatar_url),
                                ),
                              ),

                              SizedBox(width: 20),

                              Text(users[index].login, style: TextStyle(fontSize: 17),)
                          ]),

                          Text("Following", style:TextStyle(color: Colors.orange))
                        ],
                      ),
                    );
                  },
                  ) :
                 Container(child: Align(child: Text("Loading...")),)
              )
            ]))
          ]
        ),
      ),
    );
  }
}