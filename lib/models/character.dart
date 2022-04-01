import 'package:flutter/material.dart';

class Character {
  final String? name;
  final String? imagePath;
  final String? description;
  final List<Color>? colors;
  final String? video;
  final String? audio;
  final String? number;
  final int? species;
  final String? weight;
  final String? topSpeed;
  final String? lifeSpan;

  Character({this.name, this.imagePath, this.description, this.video, this.audio, this.number,
    this.species, this.weight, this.topSpeed, this.lifeSpan, this.colors});


}

List<Character> characters= [
  Character(
    name: "Panther",
    imagePath: "assets/images/panther.png" ,
    description: "anthers are type of wild cats that inhabit America, Asia and Africa. "
        "They can be found in rainforests, swamps, savannas, mountains and even deserts. "
        "Panther looks like a leopard without dots. It has yellow or dark brown fur and emerald eyes. "
        "Panthers are endangered species because of excessive hunting, loss of natural habitat, "
        "environmental pollution and global warming." ,
    video: "assets/videos/panther.mp4",
    audio: "assets/audios/panther.mp3",
    number: "15000 - 30000",
    species: 31,
    weight: "36kg - 160kg",
    topSpeed: "114k/h",
    lifeSpan: "12 - 15 years",
    colors: [Colors.orange.shade200, Colors.deepOrange.shade400],
  ),
  Character(
    name: "Buffalo",
    imagePath: "assets/images/buffalo.png" ,
    description: "Buffalo are large members of the Bovidae family. There are two types of buffalo: "
        "the African or Cape buffalo and the Asian water buffalo. They are dark gray "
        "or black animals that look a lot like bulls.Buffalo are often confused with bison. "
        "Early American settlers called bison 'buffalo' because the animals are similar in appearance. "
        "However, while bison are also bovines (a subfamily of bovids), "
        "they are in a different genus from true buffalo. Other bovines include domestic cattle,"
        " oxen, yaks, four-horned antelopes, bongos and kudus, "
        "according to the Integrated Taxonomic Information System (ITIS)." ,
    video: "assets/videos/buffalo.mp4",
    audio: "assets/audios/buffalo.mp3",
    number: "130 millions - 158 millions",
    species: -1,
    weight: "300kg - 907kg",
    topSpeed: "35k/h",
    lifeSpan: "15 - 22 years",
    colors: [Colors.pink.shade200, Colors.redAccent.shade400],
  ),
];