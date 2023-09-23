import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photobeats/pages/backgroundPlayer.dart';
import 'package:photobeats/splashScreen/splash_screen.dart';
import 'gallery.dart';

void main() {
  runApp(Demoapp());
}

class Demoapp extends StatefulWidget {
  @override
  State<Demoapp> createState() => _DemoappState();
}

class _DemoappState extends State<Demoapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Regular'),
      darkTheme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getStoredData();
  }

  void getStoredData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getName = prefs.getString('name');
      nameValue = getName ?? ' ';
    });
  }

  final screens = [const Gallary(), const AudioPlayerBackground()];
  String heading = 'Gallery';
  bool _enable = true;
  int currentIndex = 0;
  var nameValue = ' ';
  var temp = 0;
  var nameController = TextEditingController();
  String realName = '';
  String? name = stdin.readLineSync();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Colors.grey[400],
              indicatorColor: Colors.white70,
              height: 60,
              shadowColor: Colors.blue,
              elevation: 8,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              labelTextStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 15)),
              iconTheme: const MaterialStatePropertyAll(IconThemeData(size: 25))),
          child: NavigationBar(
              selectedIndex: currentIndex,
              animationDuration: Duration(seconds: 2),
              onDestinationSelected: (currentIndex) =>
                  setState(() {
                    if(currentIndex==1){
                      heading = 'Music Player';
                    }else{
                      heading ='Gallery';
                    }
                    this.currentIndex = currentIndex;
                  }),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.photo_library_outlined),
                    selectedIcon: Icon(Icons.photo_library),
                    label: 'Photos'),
                NavigationDestination(
                  icon: Icon(Icons.music_note_outlined),
                  selectedIcon: Icon(Icons.music_note),
                  label: 'Music',
                ),
              ]),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://www.vhv.rs/dpng/d/428-4287793_male-profile-round-circle-users-svg-png-icon.png'),
                      ),
                      Text('Welcome, $realName',
                          style: const TextStyle(fontSize: 20)),
                    ],
                  )),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        enabled: _enable,
                        onSubmitted: (value) {
                          _enable = false;
                          setState(() {});
                        },
                        onChanged: (value) async {
                          setState(() {});
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('name', realName);
                          realName = nameController.text.toString();
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          hintText: 'Enter Name here',
                        ),
                      )),
                  const ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                  ),
                  const ListTile(
                    title: Text('Contact'),
                    leading: Icon(Icons.phone),
                  ),
                  const ListTile(
                    title: Text('Email'),
                    leading: Icon(Icons.email),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          temp = Random().nextInt(100);
                        });
                      },
                      child: Text('Rendom number')),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                          radius: 40,
                          child:
                              Text('$temp', style: TextStyle(fontSize: 40)))),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          actions: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.search)),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.more_vert)),
          ],
          centerTitle: true,
          title: Text(heading,
              style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        body: screens[currentIndex]);
  }
}
