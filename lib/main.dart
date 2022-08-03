import 'dart:async';
import 'dart:math';

import 'package:dashboard/dashboard.dart';
import 'package:loveboard/storage.dart';

import 'package:flutter/material.dart';

import 'add_dialog.dart';
import 'data_widget.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:url_launcher/url_launcher_string.dart';

///
void main() {
  ///
  runApp(const MyApp());
}

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({Key? key}) : super(key: key);

  ///
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///
  Color getRandomColor() {
    var r = Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Board Editor demo',
      onGenerateInitialRoutes: (r) {
        return r == "/dashboard"
            ? [
                MaterialPageRoute(builder: (c) {
                  return const DashboardWidget();
                })
              ]
            : [
                MaterialPageRoute(builder: (c) {
                  return const MainPage();
                })
              ];
      },
      initialRoute: "/",
      routes: {
        "/": (c) => const MainPage(),
        "/dashboard": (c) => const DashboardWidget()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("LoveBoard alpha preview developer sample...",
              textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/dashboard");
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: Text("Try the board editor demo"),
                )),
          )
        ],
      ),
    );
  }
}

class DashboardWidget extends StatefulWidget {
  ///
  const DashboardWidget({Key? key}) : super(key: key);

  ///
  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  ///
  final ScrollController scrollController = ScrollController();

  ///
  late var itemController =
      DashboardItemController<ColoredDashboardItem>.withDelegate(
          itemStorageDelegate: storage);

  bool refreshing = false;

  var storage = MyItemStorage();

  int? slot;

  setSlot() {
    var w = MediaQuery.of(context).size.width;
    setState(() {
      slot = w > 600
          ? w > 900
              ? 8
              : 6
          : 4;
    });
  }

  List<String> d = [];

  ///
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    slot = w > 600
        ? w > 900
            ? 8
            : 6
        : 4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4285F4),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await storage.clear();
                setState(() {
                  refreshing = true;
                });
                storage = MyItemStorage();
                itemController = DashboardItemController.withDelegate(
                    itemStorageDelegate: storage);
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
                  setState(() {
                    refreshing = false;
                  });
                });
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                itemController.clear();
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                add(context);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                itemController.isEditing = !itemController.isEditing;
                setState(() {});
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: SafeArea(
        child: refreshing
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Dashboard<ColoredDashboardItem>(
                shrinkToPlace: false,
                slideToTop: true,
                absorbPointer: false,
                padding: const EdgeInsets.all(8),
                horizontalSpace: 8,
                verticalSpace: 8,
                slotAspectRatio: 1,
                animateEverytime: true,
                dashboardItemController: itemController,
                slotCount: slot!,
                errorPlaceholder: (e, s) {
                  return Text("$e , $s");
                },
                itemStyle: ItemStyle(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                physics: const RangeMaintainingScrollPhysics(),
                editModeSettings: EditModeSettings(
                    paintBackgroundLines: true,
                    resizeCursorSide: 15,
                    curve: Curves.easeInOutCirc,
                    duration: const Duration(milliseconds: 300),
                    backgroundStyle: const EditModeBackgroundStyle(
                        lineColor: Colors.black38,
                        lineWidth: 0.5,
                        dualLineHorizontal: true,
                        dualLineVertical: true)),
                itemBuilder: (ColoredDashboardItem item) {
                  var layout = item.layoutData;

                  if (item.data != null) {
                    return DataWidget(
                      item: item,
                    );
                  }

                  return Stack(children: [
                    FocusedMenuHolder(
                        menuWidth: MediaQuery.of(context).size.width * 0.50,
                        blurSize: 5.0,
                        menuItemExtent: 45,
                        menuBoxDecoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        duration: const Duration(milliseconds: 100),
                        animateMenuItems: true,
                        blurBackgroundColor: Colors.black54,
                        openWithTap:
                            false, // Open Focused-Menu on Tap rather than Long Press
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
                                launchUrlString(
                                    "https://anoringa.win");
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
                                      itemController.delete(item.identifier);
                              }),
                        ],
                        onPressed: () {},
                        child: Stack(children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Text(
                                  "ID: ${item.identifier}\n${[
                                    "x: ${layout.startX}",
                                    "y: ${layout.startY}",
                                    "w: ${layout.width}",
                                    "h: ${layout.height}",
                                    if (layout.minWidth != 1)
                                      "minW: ${layout.minWidth}",
                                    if (layout.minHeight != 1)
                                      "minH: ${layout.minHeight}",
                                    if (layout.maxWidth != null)
                                      "maxW: ${layout.maxWidth}",
                                    if (layout.maxHeight != null)
                                      "maxH : ${layout.maxHeight}"
                                  ].join("\n")}",
                                  style: const TextStyle(color: Colors.white),
                                )),
                          ),
                          if (itemController.isEditing)
                            Positioned(
                                right: 5,
                                top: 5,
                                child: InkResponse(
                                    radius: 20,
                                    onTap: () {
                                      itemController.delete(item.identifier);
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 20,
                                    )))
                        ]))
                  ]);
                },
              ),
      ),
    );
  }

  Future<void> add(BuildContext context) async {
    var res = await showDialog(
        context: context,
        builder: (c) {
          return const AddDialog();
        });

    if (res != null) {
      itemController.add(ColoredDashboardItem(
          color: res[6],
          width: res[0],
          height: res[1],
          identifier: (Random().nextInt(100000) + 4).toString(),
          minWidth: res[2],
          minHeight: res[3],
          maxWidth: res[4] == 0 ? null : res[4],
          maxHeight: res[5] == 0 ? null : res[5]));
    }
  }
}
