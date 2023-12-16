import 'package:flutter/material.dart';
import 'package:teleplay/components/movie_tile.dart';

class MyChannelHome extends StatefulWidget {
  const MyChannelHome({super.key});

  @override
  State<MyChannelHome> createState() => _MyChannelHomeState();
}

class _MyChannelHomeState extends State<MyChannelHome> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Your Channel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/3237/3237447.png"),
                    ),
                    Text(
                      'Channel Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.video_collection,
                ),
                title: const Text('Content'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Analytics'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Feedback'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Earn'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [MovieTile()],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.upload_file,
            color: Colors.white,
          ),
        ));
  }
}
