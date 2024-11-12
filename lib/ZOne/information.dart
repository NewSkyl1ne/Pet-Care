import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';



//custom bar for information
class CustomAppBar extends StatelessWidget {


  AnimationController animationController;
  Animation colorsTween, homeTween, yTween, iconTween,drawerTween;
  Function()? onPressed ;

  CustomAppBar({Key? key,
    required this.animationController,
    required this.colorsTween,
    required this.drawerTween,
    required this.homeTween,
    required this.iconTween,
    required this.onPressed,
    required this.yTween
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context,child)=>AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.pets ,
              size: 30.0,
              color: drawerTween.value,
            ),
            onPressed: () {
              Navigator.pop(context); // pop current screen
            },
          ),
          backgroundColor: colorsTween.value,
          elevation: 0,
          title: Row(
            children: [
              Text("Blog " , style: TextStyle(
                  color: homeTween.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
              Text("Centre", style: TextStyle(
                  color: yTween.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),)
            ],
          ),

        ),
      ),
    );
  }
}











class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);


  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: non_constant_identifier_names
  late Animation _colorTween, _InformationPageTween, _yTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white70)
        .animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _InformationPageTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    super.initState();
  }

  bool scrollListner(ScrollNotification scrollNotification) {
    bool scroll = false;
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);
      return scroll = true;
    }
    return scroll;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: Drawer(),
      // backgroundColor: Colors.white,
      body: NotificationListener(
        onNotification: scrollListner,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(13),
                                      bottomLeft: Radius.circular(13))),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  // Column(
                                  //   children: const [
                                  //     Text(
                                  //       "By 2050",
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 18),
                                  //     ),
                                  //     Text("More plastic than \nfish in ocean",
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 10))
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: const [
                                  //     Text(
                                  //       "91%",
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 20),
                                  //     ),
                                  //     Text("Breathe \nbad air",
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 11))
                                  //   ],
                                  // ),
                                  // Column(
                                  //   children: const [
                                  //     Text(
                                  //       "2015-2021",
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 20),
                                  //     ),
                                  //     Text("7 warmest years\n for the ocean",
                                  //         style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 10))
                                  //   ],
                                  // )
                                ],
                              ),
                            ),






                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container(

                                      padding : const EdgeInsets.only(bottom: 15),
                                      width: MediaQuery.of(context).size.width,

                                      child: const Text("-- Info" , style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), )),




                                  InkWell(
                                    // onTap: () async {
                                    //   if(await canLaunch('https://www.reddit.com/r/environment/new/')){
                                    //     await launch('https://www.reddit.com/r/environment/new/',
                                    //       forceSafariVC: true,
                                    //       forceWebView: true,
                                    //       enableJavaScript: true,);
                                    //   }else{
                                    //     throw 'could not launch';
                                    //   }
                                    // },
                                    //
                                    // onLongPress: () async {
                                    //   if(await canLaunch('https://www.reddit.com/r/environment/new/')){
                                    //     await launch('https://www.reddit.com/r/environment/new/',
                                    //       forceSafariVC: true,
                                    //       // forceWebView: true,
                                    //       enableJavaScript: true,);
                                    //   }else{
                                    //     throw 'could not launch';
                                    //   }
                                    // },

                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(

                                        children: [

                                          Container(

                                            height: 170,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/3.png"))),
                                          ),
                                          Container(

                                            height: 170,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 5,

                                            child: Text("r" , style: TextStyle(
                                                color: Colors.white,fontWeight: FontWeight.bold,
                                                fontSize: 25
                                            ),),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 12,
                                            top: 40,

                                            child: Text("aaaaaa." ,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),



                                  InkWell(
                                    onTap: () async {
                                      if(await canLaunch('https://www.thewildest.com/')){
                                        await launch('https://www.thewildest.com/',
                                          forceSafariVC: true,
                                          forceWebView: true,
                                          enableJavaScript: true,);
                                      }else{
                                        throw 'could not launch';
                                      }
                                    },

                                    onLongPress: () async {
                                      if(await canLaunch('https://www.thewildest.com/')){
                                        await launch('https://www.thewildest.com/',
                                          forceSafariVC: true,
                                          // forceWebView: true,
                                          enableJavaScript: true,);
                                      }else{
                                        throw 'could not launch';
                                      }
                                    },

                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(

                                        children: [
                                          Container(

                                            height: 170,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/images/wild.png"))),
                                          ),
                                          Container(

                                            height: 170,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 7,

                                            child: Text("" , style: TextStyle(
                                                color: Colors.white,fontWeight: FontWeight.bold,
                                                fontSize: 22
                                            ),),
                                          ),
                                          // const Positioned(
                                          //   right: 25,
                                          //   left: 10,
                                          //   top: 123,
                                          //
                                          //   child: Text("\nThe destination that helps you keep your cool in the wild world of pet parenting. "
                                          //       "" ,
                                          //     style: TextStyle(
                                          //         color: Colors.white,
                                          //         fontSize: 10
                                          //     ),),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),





                                  InkWell(
                                    onTap: () async {
                                      if(await canLaunch('https://www.rover.com/blog/')){
                                        await launch('https://www.rover.com/blog/',
                                          forceSafariVC: true,
                                          forceWebView: true,
                                          enableJavaScript: true,);
                                      }else{
                                        throw 'could not launch';
                                      }
                                    },

                                    onLongPress: () async {
                                      if(await canLaunch('https://www.rover.com/blog/')){
                                        await launch('https://www.rover.com/blog/',
                                          forceSafariVC: true,
                                          // forceWebView: true,
                                          enableJavaScript: true,);
                                      }else{
                                        throw 'could not launch';
                                      }
                                    },

                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(

                                        children: [
                                          Container(

                                            height: 170,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/3.png"))),
                                          ),
                                          Container(

                                            height: 170,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 5,

                                            child: Text("Dog People" , style: TextStyle(
                                                color: Colors.white,fontWeight: FontWeight.bold,
                                                fontSize: 25
                                            ),),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 12,
                                            top: 97,

                                            child: Text("1 \nc3,"
                                                "\n o3" , style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),







                                  InkWell(
                                  //   onTap: () async {
                                  //   if(await canLaunch('https://www.worldometers.info/#c23')){
                                  //     await launch('https://www.worldometers.info/#c23/',
                                  //       forceSafariVC: true,
                                  //       forceWebView: true,
                                  //       enableJavaScript: true,
                                  //
                                  //     );
                                  //
                                  //   }else{
                                  //     throw 'could not launch';
                                  //   }
                                  // },

                                    // onLongPress: () async {
                                    //   if(await canLaunch('https://www.worldometers.info/#c23')){
                                    //     await launch('https://www.worldometers.info/#c23/',
                                    //       forceSafariVC: true,
                                    //       // forceWebView: true,
                                    //       enableJavaScript: true,
                                    //
                                    //     );
                                    //
                                    //   }else{
                                    //     throw 'could not launch';
                                    //   }
                                    // },

                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Stack(

                                        children: [
                                          Container(

                                            height: 170,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/3.png"))),
                                          ),
                                          Container(

                                            height: 170,
                                            color: Colors.black26,
                                          ),
                                          const Positioned(
                                            right: 20,
                                            left: 10,
                                            top: 10,

                                            child: Text("4" , style: TextStyle(
                                                color: Colors.white,fontWeight: FontWeight.bold,
                                                fontSize: 22
                                            ),),
                                          ),
                                          const Positioned(
                                            right: 30,
                                            left: 12,
                                            top: 98,

                                            child: Text("---------."
                                              , style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12
                                              ),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),


                                  // Container(
                                  //
                                  //     padding : const EdgeInsets.only(bottom: 15),
                                  //     width: MediaQuery.of(context).size.width,
                                  //
                                  //     child: const Text("Go green Initiatives" , style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), )),
                                  //
                                  //

                                  // InkWell(
                                  //   onTap: () async {
                                  //     if(await canLaunch('https://www.grow-trees.com/')){
                                  //       await launch('https://www.grow-trees.com/',
                                  //         forceSafariVC: true,
                                  //         forceWebView: true,
                                  //         enableJavaScript: true,);
                                  //     }else{
                                  //       throw 'could not launch';
                                  //     }
                                  //   },
                                  //
                                  //   onLongPress: () async {
                                  //     if(await canLaunch('https://www.grow-trees.com/')){
                                  //       await launch('https://www.grow-trees.com/',
                                  //         forceSafariVC: true,
                                  //         // forceWebView: true,
                                  //         enableJavaScript: true,);
                                  //     }else{
                                  //       throw 'could not launch';
                                  //     }
                                  //   },
                                  //
                                  //   child: Container(
                                  //     margin: const EdgeInsets.only(bottom: 20),
                                  //     child: Stack(
                                  //
                                  //       children: [
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           decoration: const BoxDecoration(
                                  //               image: DecorationImage(
                                  //                   fit: BoxFit.cover,
                                  //                   image: AssetImage(
                                  //                       "lib/assets/images/png/grow.png"))),
                                  //         ),
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           color: Colors.black26,
                                  //         ),
                                  //         const Positioned(
                                  //           right: 20,
                                  //           left: 10,
                                  //           top: 10,
                                  //
                                  //           child: Text("Grow-Trees" , style: TextStyle(
                                  //               color: Colors.white,fontWeight: FontWeight.bold,
                                  //               fontSize: 23
                                  //           ),),
                                  //         ),
                                  //         const Positioned(
                                  //           right: 30,
                                  //           left: 12,
                                  //           top: 38,
                                  //
                                  //           child: Text("We aim to inculcate the practice amongst companies and individuals worldwide to plant "
                                  //               "trees in public lands through the web to greet or honor someone by means of an e-certificate with a personalized message. "
                                  //             , style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 10
                                  //             ),),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),





                                  //
                                  //
                                  // InkWell(
                                  //   onTap: () async {
                                  //   if(await canLaunch('https://teamtrees.org/')){
                                  //     await launch('https://teamtrees.org/',
                                  //       forceSafariVC: true,
                                  //       forceWebView: true,
                                  //       enableJavaScript: true,);
                                  //   }else{
                                  //     throw 'could not launch';
                                  //   }
                                  // },
                                  //
                                  //   onLongPress: () async {
                                  //     if(await canLaunch('https://teamtrees.org/')){
                                  //       await launch('https://teamtrees.org/',
                                  //         forceSafariVC: true,
                                  //         // forceWebView: true,
                                  //         enableJavaScript: true,);
                                  //     }else{
                                  //       throw 'could not launch';
                                  //     }
                                  //   },
                                  //
                                  //   child: Container(
                                  //     margin: const EdgeInsets.only(bottom: 20),
                                  //     child: Stack(
                                  //
                                  //       children: [
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           decoration: const BoxDecoration(
                                  //               image: DecorationImage(
                                  //                   fit: BoxFit.cover,
                                  //                   image: AssetImage(
                                  //                       "lib/assets/images/jpeg/TT2.jpg"))),
                                  //         ),
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           color: Colors.black26,
                                  //         ),
                                  //         const Positioned(
                                  //           right: 20,
                                  //           left: 10,
                                  //           top: 10,
                                  //
                                  //           child: Text("#teamtrees" , style: TextStyle(
                                  //               color: Colors.white,fontWeight: FontWeight.bold,
                                  //               fontSize: 22
                                  //           ),),
                                  //         ),
                                  //         const Positioned(
                                  //           right: 30,
                                  //           left: 12,
                                  //           top: 38,
                                  //
                                  //           child: Text("Team Trees, stylized as \n#TEAMTREES,\n is a collaborative fundraiser that raised 20 million U.S. dollars "
                                  //               "\n before the start of 2020 to plant 20 million trees."
                                  //             , style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 10
                                  //             ),),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //
                                  // InkWell(
                                  //   onTap: () async {
                                  //     if(await canLaunch('https://www.ishaoutreach.org/en/cauvery-calling')){
                                  //       await launch('https://www.ishaoutreach.org/en/cauvery-calling',
                                  //         forceSafariVC: true,
                                  //         forceWebView: true,
                                  //         enableJavaScript: true,);
                                  //     }else{
                                  //       throw 'could not launch';
                                  //     }
                                  //   },
                                  //
                                  //   onLongPress: () async {
                                  //     if(await canLaunch('https://www.ishaoutreach.org/en/cauvery-calling')){
                                  //       await launch('https://www.ishaoutreach.org/en/cauvery-calling',
                                  //         forceSafariVC: true,
                                  //         // forceWebView: true,
                                  //         enableJavaScript: true,);
                                  //     }else{
                                  //       throw 'could not launch';
                                  //     }
                                  //   },
                                  //
                                  //   child: Container(
                                  //     margin: const EdgeInsets.only(bottom: 20),
                                  //     child: Stack(
                                  //
                                  //       children: [
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           decoration: const BoxDecoration(
                                  //               image: DecorationImage(
                                  //                   fit: BoxFit.cover,
                                  //                   image: AssetImage(
                                  //                       "lib/assets/images/png/cav.png"))),
                                  //         ),
                                  //         Container(
                                  //
                                  //           height: 150,
                                  //           color: Colors.black26,
                                  //         ),
                                  //         const Positioned(
                                  //           right: 20,
                                  //           left: 10,
                                  //           top: 10,
                                  //
                                  //           child: Text("Cauvery Calling" , style: TextStyle(
                                  //               color: Colors.white,fontWeight: FontWeight.bold,
                                  //               fontSize: 25
                                  //           ),),
                                  //         ),
                                  //         const Positioned(
                                  //           right: 30,
                                  //           left: 12,
                                  //           top: 88,
                                  //
                                  //           child: Text("Cauvery Calling is a first of its kind campaign, setting the standard for how India’s rivers – "
                                  //               "the country’s lifelines – can be revitalized."
                                  //             , style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 10
                                  //             ),),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),





                                ],
                              ),
                            ),


                          ],
                        )
                      ],
                    ),
                  ),
                  CustomAppBar(
                      animationController: _animationController,
                      colorsTween: _colorTween,
                      drawerTween: _drawerTween,
                      homeTween: _InformationPageTween,
                      iconTween: _iconTween,
                      onPressed: () {

                      },
                      yTween: _yTween)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
