import 'package:after_layout/after_layout.dart';
import 'package:animals_app/models/character.dart';
import 'package:animals_app/styleguide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  final double expandedBottom = 0;
  final double collapsedBottom = -250;
  final double fullCollapsedBottom = -330;

  CharacterDetailScreen(this.character);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> with AfterLayoutMixin<CharacterDetailScreen>{
  double currentBottom = -330;
  bool isCollapsed = false;
  VideoPlayerController? videoController;

  List colors = [
    Colors.blue,
    Colors.redAccent,
    Colors.orange,
    Colors.lightBlueAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.purple,
  ];

  Path path = Path();

  @override
  void initState() {
    super.initState();

    videoController = VideoPlayerController.asset(
      widget.character.video!,
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "background${widget.character.name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.character.colors!,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 40,
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
                        setState(() {
                          currentBottom = widget.fullCollapsedBottom;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Hero(
                    tag: "image${widget.character.name}",
                    child: Image.asset(widget.character.imagePath!,height: screenHeight * 0.45,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                    child: Hero(
                      tag: "name${widget.character.name}",
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          child: Text(widget.character.name!,style: kHeading,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32,8,8,16),
                    child: Text(widget.character.description!,style: kSubHeading,),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              bottom: currentBottom,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentBottom = isCollapsed ? widget.expandedBottom : widget.collapsedBottom;
                          isCollapsed = !isCollapsed;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 80,
                        child: Text("Clips",style: kSubHeading.copyWith(color: Colors.black54),),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: clipsWidget(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget clipsWidget () {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          wholeColumn(colors[0], colors[1]),
          const SizedBox(width: 15,),
        ],
      ),
    );
  }

  Widget roundedContainer (Color color) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  Widget wholeColumn (Color color1,Color color2) {
    return Column(
      children: <Widget>[
        Center(
          child: videoController!.value.isInitialized ? AspectRatio(
            aspectRatio: videoController!.value.aspectRatio,
            child: VideoPlayer(videoController!),
          ): Container(),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              videoController!.value.isPlaying ? videoController!.pause() : videoController!.play();
            });
          },
          child: Icon(
            videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        currentBottom = widget.collapsedBottom;
      });
    });
  }
}