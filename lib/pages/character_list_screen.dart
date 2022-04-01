
import 'package:animals_app/models/character.dart';
import 'package:animals_app/styleguide.dart';
import 'package:animals_app/widget/character_widget.dart';
import 'package:flutter/material.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  PageController? _pageController;
  int currentPage = 0;
  double textFieldHeghit = 0;
  bool isSearchOn = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController (
      viewportFraction: 1,
      initialPage: currentPage,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, size: 0,),
        actions: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            width: textFieldHeghit,
            transform: Matrix4.translationValues(0, 1, 0),
            child: const TextField(
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue,
              ),
              decoration: InputDecoration(
                hintText: "Search"
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearchOn = !isSearchOn;
                  isSearchOn ? textFieldHeghit = 200 : textFieldHeghit = 0;
                });
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 8),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Animals Kingdom", style: display1,),
                      TextSpan(text: "\n"),
                      TextSpan(text: "Characters", style: display2,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  children:
                    charactersItems(),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  charactersItems() {
    List<Widget> list  = [];
    for(var i = 0;i < characters.length; i++) {
      list.add(CharacterWidget(character: characters[i],
        pageController: _pageController!,
        currentPage: i,));
    }
    return list;
  }
}