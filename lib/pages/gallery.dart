import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class Gallary extends StatefulWidget {
  const Gallary({Key? key}) : super(key: key);

  @override
  State<Gallary> createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  File? _image;
  List<XFile> _imageFileList = [];

  Future getImage(bool isCamara) async {
    XFile? image;
    List<XFile>? selectedImages;
    if (isCamara) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
      _image = File(image!.path);
    } else {
      contHieght = 550;
      selectedImages = await ImagePicker().pickMultiImage();
      _imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

  int axis = 1;
  double gHight = 550.0;
  double contHieght = 550;
  double _cHeight = 550;

  var _hight = 200.0;
  var _width = 300.0;
  var time = DateTime.now();
  var number = 0;
  String imgUrl = '';
  bool flag = true;
  var index = 0;
  var num = 0;
  List gridviewImages = [
    'https://c4.wallpaperflare.com/wallpaper/304/257/249/toothless-night-fury-how-to-train-your-dragon-how-to-train-your-dragon-2-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/392/664/919/toothless-night-fury-how-to-train-your-dragon-how-to-train-your-dragon-2-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/609/10/542/how-to-train-your-dragon-hiccup-toothless-animated-movies-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/137/171/630/how-to-train-your-dragon-how-to-train-your-dragon-2-dragon-toothless-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/926/506/361/movie-how-to-train-your-dragon-2-toothless-how-to-train-your-dragon-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/928/19/616/how-to-train-your-dragon-how-to-train-your-dragon-the-hidden-world-hiccup-how-to-train-your-dragon-toothless-how-to-train-your-dragon-hd-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/797/486/383/movie-how-to-train-your-dragon-2-toothless-how-to-train-your-dragon-wallpaper-preview.jpg',
  ];
  NetworkImage image = const NetworkImage(
      'https://e0.pxfuel.com/wallpapers/444/581/desktop-wallpaper-2019-how-to-train-your-dragon-the-hidden-world-movie-dragons.jpg');
  List indexedImages = [
    'https://c4.wallpaperflare.com/wallpaper/109/1015/743/how-to-train-your-dragon-how-to-train-your-dragon-the-hidden-world-dragon-night-fury-toothless-how-to-train-your-dragon-hd-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/108/214/347/movie-how-to-train-your-dragon-2-hiccup-how-to-train-your-dragon-toothless-how-to-train-your-dragon-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/650/986/485/digital-art-fantasy-art-black-background-dark-dragon-yellow-eyes-minimalism-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/780/341/142/anime-sharingan-red-eyes-naruto-shippuuden-wallpaper-preview.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          backgroundColor: Colors.brown[200],
          activeIcon: Icons.add,
          icon: Icons.add,
          animatedIcon: AnimatedIcons.list_view,
          direction: SpeedDialDirection.up,
          spaceBetweenChildren: 10,
          spacing: 15,
          children: [
            SpeedDialChild(
                onTap: () => getImage(true),
                label: 'Camara',
                child: const Icon(Icons.camera_alt)),
            SpeedDialChild(
              onTap: () => getImage(false),
              label: 'Gallary',
              child: const Icon(Icons.image_search_outlined),
            )
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          _image == null && _imageFileList.isEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 600,
                  width: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Create Album 📸',
                            style: TextStyle(color: Colors.grey, fontSize: 20)),
                        Image.asset('assets/images/add_photo.png')
                      ]),
                )
              : _image == null
                  ? Container()
                  : Column(children: [
                      Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            image: DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.contain)),
                        margin: const EdgeInsets.only(top: 30),
                        height: 550,
                        width: 320,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {_image = null;
                            });
                          },
                          style: const ButtonStyle(
                              foregroundColor:
                              MaterialStatePropertyAll(Colors.black54)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.delete), Text('Delete Photo')],
                          ))
                    ]),
          _imageFileList.isEmpty
              ? Container()
              : Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[100]),
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        margin: const EdgeInsets.only(top: 30),
                        height: contHieght,
                        width: 320,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: PageScrollPhysics(),
                            itemCount: _imageFileList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: gHight,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisCount: axis),
                            itemBuilder: (context, index) => InkWell(
                                  enableFeedback: true,
                                  onTap: () {
                                    setState(() {
                                      if (axis == 1) {
                                        axis = 3;
                                        gHight = 100;
                                      } else {
                                        gHight = 550;
                                        axis = 1;
                                      }
                                    });
                                  },
                                  child: InteractiveViewer(
                                    minScale: 1,
                                    maxScale: 3,
                                    scaleEnabled: true,
                                    child: Image.file(
                                      File(_imageFileList[index].path),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ))),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _imageFileList.removeRange(
                                0, _imageFileList.length);
                          });
                        },
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black54)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.delete), Text('Delete Album')],
                        )),
                  ],
                ),
          
          //From here extra practice work.......
          const Divider(height: 20,thickness: 2),
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text('Practice work',style: TextStyle(color: Colors.grey,fontSize: 20,letterSpacing:10,wordSpacing: 10,decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.dotted)),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: (BorderRadius.circular(20)))),
            margin: const EdgeInsets.only(top: 40),
            height: 200,
            width: 300,
            child: Column(
              children: [
                IndexedStack(
                    index: number,
                    children: indexedImages.map((value) {
                      return Image.network(
                        value,
                        fit: BoxFit.fill,
                        height: 200,
                      );
                    }).toList()),
              ],
            ),
          ),

          ButtonBar(mainAxisSize: MainAxisSize.min, children: [
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (number == 0) {
                          number = 3;
                        } else {
                          number = number - 1;
                        }
                      });
                    },
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(8),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black45),
                        shape: MaterialStatePropertyAll(StarBorder(
                            points: 3,
                            rotation: 30,
                            innerRadiusRatio: 0.5,
                            squash: 0.4,
                            pointRounding: 0.3))),
                    child: const Text('')),
                const Text('Prev.',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (number == 3) {
                          number = 0;
                        } else {
                          number = number + 1;
                        }
                      });
                    },
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(8),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black45),
                        shape: MaterialStatePropertyAll(StarBorder(
                            points: 3,
                            rotation: 90,
                            innerRadiusRatio: 0.5,
                            squash: 0.4,
                            pointRounding: 0.3))),
                    child: null),
                const Text('Next',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ]),

          // Spacer(flex: 1),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 200,
            width: 300,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              color: Colors.black,
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.only(left: 1, right: 1),
                          child: Image.network(imgUrl));
                    }
                  }),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(StarBorder(
                      innerRadiusRatio: 1.0,
                      pointRounding: 1.0,
                      points: 8,
                      squash: 0.8,
                      valleyRounding: 0))),
              child: const Icon(Icons.restart_alt)),

          AnimatedContainer(
            curve: Curves.elasticIn,
            duration: const Duration(seconds: 2),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                image: DecorationImage(image: image, fit: BoxFit.fill)),
            height: _hight,
            width: _width,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
              onPressed: () {
                setState(() {
                  if (flag) {
                    _hight = 300;
                    _width = 200;
                    image = const NetworkImage(
                        'https://e0.pxfuel.com/wallpapers/969/642/desktop-wallpaper-so-cute-how-train-your-dragon-toothless-how-to-train-dragon-hiccup-and-astrid.jpg');
                    flag = false;
                  } else {
                    _hight = 200;
                    _width = 300;
                    image = const NetworkImage(
                        'https://e0.pxfuel.com/wallpapers/444/581/desktop-wallpaper-2019-how-to-train-your-dragon-the-hidden-world-movie-dragons.jpg');
                    flag = true;
                  }
                });
              },
              child: const Text(
                'Animation',
              )),

          Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            height: 200,
            width: 300,
            child: GridView(
                physics:
                    const PageScrollPhysics(parent: BouncingScrollPhysics()),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisExtent: 200,
                    crossAxisCount: 1),
                children: gridviewImages.map((value) {
                  return Image.network(
                    value,
                    fit: BoxFit.fill,
                  );
                }).toList()),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.flash_on),
            tooltip: 'jaadu',
            splashColor: Colors.yellow,
            highlightColor: Colors.orange,
            splashRadius: 6000,
          ),
        ]),
      ),
    );
  }

  Future<String> getData() async {
    await Future.delayed(const Duration(seconds: 2));
    imgUrl =
        'https://c4.wallpaperflare.com/wallpaper/28/479/638/dragon-how-to-train-your-dragon-2-toothless-digital-art-wallpaper-preview.jpg';
    return imgUrl;
  }
}
