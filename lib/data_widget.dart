import 'package:auto_size_text/auto_size_text.dart';
import 'package:dashboard/dashboard.dart';
import 'package:loveboard/storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

const Color blue = Color(0xFF4285F4);
const Color red = Color(0xFFEA4335);
const Color yellow = Color(0xFFFBBC05);
const Color green = Color(0xFF34A853);

class DataWidget extends StatelessWidget {
  DataWidget({Key? key, required this.item}) : super(key: key);

  final ColoredDashboardItem item;

  final Map<String, Widget Function(ColoredDashboardItem i)> _map = {
    "welcome": (l) => const WelcomeWidget(),
    "resize": (l) => AdviceResize(size: l.layoutData.width),
    "description": (l) => const BasicDescription(),
    "transform": (l) => const TransformAdvice(),
    "add": (l) => const AddAdvice(),
    "buy_mee": (l) => const BuyMee(),
    "delete": (l) => const ClearAdvice(),
    "refresh": (l) => const DefaultAdvice(),
    "info": (l) => InfoAdvice(layout: l.layoutData),
    "github": (l) => const Github(),
    "twitter": (l) => const Twitter(),
    "linkedin": (l) => const LinkedIn(),
    "pub": (l) => const Pub(),
    "devphoto": (l) => const DevPhoto(),
    "devyoutube": (l) => const DevYoutube(),
    "devitemwithmenu": (l) => const DevItemWithMenu(),
  };

  @override
  Widget build(BuildContext context) {
    return _map[item.data]!(item);
  }
}

class Pub extends StatelessWidget {
  const Pub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString("https://pub.dev/packages/dashboard");
      },
      child: Container(
        color: Colors.white,
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/pub_dev.png")))),
      ),
    );
  }
}

class LinkedIn extends StatelessWidget {
  const LinkedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString("https://www.linkedin.com/in/mehmetyaz/");
      },
      child: Container(
        color: const Color(0xFF0A66C2),
        child: Row(
          children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Connect Me!", style: TextStyle(color: Colors.white)),
            )),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/linkedin.png")))),
            ),
          ],
        ),
      ),
    );
  }
}

class Twitter extends StatelessWidget {
  const Twitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString("https://twitter.com/smehmetyaz");
      },
      child: Container(
        color: const Color(0xFF1DA0F1),
        child: Row(
          children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Follow Me!", style: TextStyle(color: Colors.white)),
            )),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/twitter.png")))),
            ),
          ],
        ),
      ),
    );
  }
}

class Github extends StatelessWidget {
  const Github({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString("https://github.com/Mehmetyaz/dashboard");
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Create Issue!",
                style: TextStyle(color: Colors.black),
              ),
            )),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/github.png")))),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyMee extends StatelessWidget {
  const BuyMee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString("https://www.buymeacoffee.com/mehmetyaz");
      },
      child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/img.png")))),
    );
  }
}

class InfoAdvice extends StatelessWidget {
  const InfoAdvice({Key? key, required this.layout}) : super(key: key);

  final ItemLayout layout;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: blue,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            const Text("Example dimensions and locations. (showing this)",
                style: TextStyle(color: Colors.white)),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: DataTable(
                    dataRowHeight: 25,
                    headingRowHeight: 25,
                    border: const TableBorder(
                        horizontalInside: BorderSide(color: Colors.white)),
                    headingTextStyle: const TextStyle(color: Colors.white),
                    dataTextStyle: const TextStyle(color: Colors.white),
                    columns: const [
                      DataColumn(label: Text("startX")),
                      DataColumn(label: Text("startY")),
                      DataColumn(label: Text("width")),
                      DataColumn(label: Text("height"))
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(layout.startX.toString())),
                        DataCell(Text(layout.startY.toString())),
                        DataCell(Text(layout.width.toString())),
                        DataCell(Text(layout.height.toString())),
                      ])
                    ]),
              ),
            ),
          ],
        ));
  }
}

class DefaultAdvice extends StatelessWidget {
  const DefaultAdvice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: yellow,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.refresh,
              size: 30,
              color: Colors.white,
            ),
            Expanded(
              child: Text(
                "Your layout changes saved locally."
                " Set default with this button.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}

class ClearAdvice extends StatelessWidget {
  const ClearAdvice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: green,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.delete,
              size: 30,
              color: Colors.white,
            ),
            Text(
              "Delete all widgets.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}

class AddAdvice extends StatelessWidget {
  const AddAdvice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}

class TransformAdvice extends StatelessWidget {
  const TransformAdvice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: red,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Users can move widgets.",
              style: TextStyle(color: Colors.white, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const Text(
              "To try moving, hold (or long press) the widget and move.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "While moving, it shrinks if possible according to the "
                    "minimum width and height values.\n(This min w: 2 , h: 2)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
/*
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 30,
                )
*/
              ],
            ),
          ],
        ));
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: red,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    children: [
                  const TextSpan(text: "Welcome to "),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlString("https://pub.dev/packages/dashboard");
                        },
                      text: "dashboard",
                      style: const TextStyle(
                          decoration: TextDecoration.underline)),
                  const TextSpan(text: " online demo!"),
                ])),
          ],
        ));
  }
}

class BasicDescription extends StatelessWidget {
  const BasicDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: yellow,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const AutoSizeText(
                "Each widget on the screen is called \"DashboardItem\"",
                maxLines: 4,
                style: TextStyle(color: Colors.white, fontSize: 13),
                textAlign: TextAlign.center),
            const AutoSizeText("Each has a location and dimensions by slots.",
                maxLines: 3,
                style: TextStyle(color: Colors.white, fontSize: 13),
                textAlign: TextAlign.center),
            Row(
              children: [
                const Expanded(
                  child: AutoSizeText(
                      "You can switch to edit mode to see these slots.",
                      maxLines: 4,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: const [
                    Text("Tap: ",
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    Icon(Icons.edit, color: Colors.white),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class AdviceResize extends StatelessWidget {
  const AdviceResize({Key? key, required this.size}) : super(key: key);

  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: green,
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: double.infinity,
              width: 1,
              color: Colors.white,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                AutoSizeText("Users can resize widgets.",
                    maxLines: 2,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center),
                AutoSizeText(
                    "To try resizing, hold (or long press) the line on the left"
                    " and drag it to the left.",
                    maxLines: 5,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center),
                AutoSizeText("Don't forget switch to edit mode.",
                    maxLines: 3,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center),
              ],
            ))
          ],
        ));
  }
}

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

    return GestureDetector(
        onTap: () {
          launchUrlString("https://pub.dev/packages/dashboard");
        },
        child: Container(
            color: Colors.white,
            child: YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            )));
  }
}

class DevPhoto extends StatelessWidget {
  const DevPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          launchUrlString("https://pub.dev/packages/dashboard");
        },
        child: Container(
            color: Colors.white,
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://placekitten.com/200/300"))))));
  }
}

class DevItemWithMenu extends StatelessWidget {
  const DevItemWithMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        blurSize: 5.0,
        menuItemExtent: 45,
        menuBoxDecoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: const Duration(milliseconds: 100),
        animateMenuItems: true,
        blurBackgroundColor: Colors.black54,
        openWithTap: false, // Open Focused-Menu on Tap rather than Long Press
        menuOffset:
            10.0, // Offset value to show menuItem from the selected item
        bottomOffsetHeight:
            80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
        menuItems: [
          // Add Each FocusedMenuItem  for Menu Options
          FocusedMenuItem(
              title: const Text("Edit"),
              trailingIcon: const Icon(Icons.edit),
              onPressed: () {
                launchUrlString("https://pub.dev/packages/dashboard");
              }),
          FocusedMenuItem(
              title: const Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              trailingIcon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                //itemController.delete(item.identifier)
              }),
        ],
        onPressed: () {},
        child: Container(
            color: Colors.white,
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://placekitten.com/200/300"))))));
  }
}
