//import 'package:auto_size_text/auto_size_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Gender {
  String name;
  IconData icon;
  bool isSelected;
  StatelessWidget content;
  Gender(this.name, this.icon, this.isSelected, this.content);

  simulateRequest() {
    // first future holds family name
      return content;
/*
    if(content != null)
      return content;
    else
      return DevPhoto2();
*/

  }
}









const Color blue = Color(0xFF4285F4);
const Color red = Color(0xFFEA4335);
const Color yellow = Color(0xFFFBBC05);
const Color green = Color(0xFF34A853);

String myVideoId = 'AvhplYM46Fc';
// the full url: https://www.youtube.com/watch?v=PQSagzssvUQ&ab_channel=NASA
// it's an interesting video from NASA on Youtube

// Initiate the Youtube player controller
final YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: myVideoId,
  flags: const YoutubePlayerFlags(
    autoPlay: false,
    enableCaption: false,
    mute: false,
  ),
);

class DevYoutube extends StatelessWidget {
  const DevYoutube({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const ytid = 'AvhplYM46Fc';
    //const yturl = "https://img.youtube.com/vi/$ytid/maxresdefault.jpg";

    return Container(
            color: Colors.white,
            child: YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            ));
  }
}

class DevPhoto2 extends StatelessWidget {
  const DevPhoto2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://placekitten.com/200/300"))));
  }
}

class DevTextResize extends StatelessWidget {
  const DevTextResize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: blue,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            /*Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),*/
            Text(
              "Add own colored widget with custom sizes.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  } 
}

class Genders {
  /*
  static Gender youtube =
      Gender("Youtube", MdiIcons.youtube, false, Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/128px-YouTube_full-color_icon_%282017%29.svg.png")))));

  */

  static Gender youtube =
  Gender("Youtube", MdiIcons.youtube, false,const DevYoutube());

  /*
      static Gender image = Gender(
      "Image",
      MdiIcons.fileImage,
      false,
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage("https://placekitten.com/200/300")))));
                  */
  static Gender image = Gender(
      "Image",
      MdiIcons.fileImage,
      false,const DevPhoto2());
/*
  static Gender text = Gender(
      "Text",
      MdiIcons.text,
      false,
      Container(
          color: blue,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              Text(
                "Add own colored widget with custom sizes.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            ],
          )));
}*/


static Gender text = Gender(
      "Text",
      MdiIcons.text,
      false,
      const DevTextResize());
}

/*
List<Gender> genders = <Gender>[
  Gender("Youtube", MdiIcons.youtube, false),
  Gender("Image", MdiIcons.fileImage, false),
  Gender("Text", MdiIcons.text, false)
];
*/

class CustomRadio extends StatelessWidget {
  //final Gender _gender;

  final Gender genderunder;

  const CustomRadio({Key? key, required this.genderunder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: genderunder.isSelected ? const Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                genderunder.icon,
                color: genderunder.isSelected ? Colors.white : Colors.grey,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                genderunder.name,
                style: TextStyle(
                    color: genderunder.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}

class GenderSelector extends StatefulWidget {
  final Gender pickerItem;
  final ValueChanged<Gender> onItemChanged;

  const GenderSelector({
    Key? key,
    required this.pickerItem,
    required this.onItemChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemtypeSelectorState();
}

class _ItemtypeSelectorState extends State<GenderSelector> {
  List<Gender> genders = <Gender>[];

  @override
  void initState() {
    super.initState();
    genders.add(Genders.youtube);
    genders.add(Genders.image);
    genders.add(Genders.text);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: genders.length,
        itemBuilder: (context, index) {
          return InkWell(
            splashColor: Colors.pinkAccent,
            onTap: () {
              setState(() {
                for (var gender in genders) {
                  gender.isSelected = false;
                }
                genders[index].isSelected = true;
                widget.onItemChanged(genders[index]);
              });
            },
            child: CustomRadio(genderunder: genders[index]),
          );
        });
  }
}
