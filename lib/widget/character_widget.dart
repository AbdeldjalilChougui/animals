import 'package:animals_app/pages/character_detail_screen.dart';
import 'package:animals_app/styleguide.dart';
import 'package:animals_app/widget/clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterWidget extends StatefulWidget {
  final Character? character;
  final PageController? pageController;
  final int? currentPage;

  CharacterWidget({this.character,this.pageController,this.currentPage});

  @override
  _CharacterWidgetState createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget>{
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context,_,__) => CharacterDetailScreen(widget.character!),
        ));
      },
      child: AnimatedBuilder(
        animation: widget.pageController!,
        builder: (context,child) {
          double value = 1;
          if (widget.pageController!.position.haveDimensions) {
            value = widget.pageController!.page! - widget.currentPage!;
            value = (1 - value.abs() * 0.6).clamp(0, 1);
          }
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: CharacterCardBGClipper(),
                  child: Hero(
                    tag: "background${widget.character!.name}",
                    child: Container(
                      height: 0.6 * screenHeight,
                      width: 0.9 * screenWidth,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.character!.colors!,
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0,0),
                child: Hero(
                  tag: "image${widget.character!.name}",
                  child: Image.asset(
                    widget.character!.imagePath!,
                    height: screenHeight * 0.4 * value,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48,right: 16,bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Hero(
                      tag: "name${widget.character!.name}",
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          child: Text(widget.character!.name!,style: kHeading,),
                        ),
                      ),
                    ),
                    Text("Tap to read more", style: kSubHeading,),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
