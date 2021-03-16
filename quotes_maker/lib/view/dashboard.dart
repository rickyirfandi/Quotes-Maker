import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class Dashboard extends StatelessWidget {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<QuoteCubit>();
    bool isBold = true;
    bool isCredit = true;
    bool isBW = true;
    bool isBlur = true;
    bool isItalic = true;
    bool isShadow = true;
    double fontSize = 22;
    TextEditingController caps = new TextEditingController();

    double footerSize = 16;
    TextEditingController footer = new TextEditingController();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    actions: <Widget>[
                      Container(
                        height: 60,
                        width: size.width,
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      actions: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextField(
                                            controller: caps,
                                            onChanged: (text) {
                                              cubit.changeCaption(text);
                                            },
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              focusColor: Colors.blue,
                                              filled: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                              labelText: "Your Quotes:)",
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                Text('Text Size',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                Expanded(
                                                  child: Slider(
                                                      value: fontSize,
                                                      min: 10,
                                                      max: 50,
                                                      divisions: 20,
                                                      label: "$fontSize",
                                                      onChanged: (size) {
                                                        cubit.changeTextSize(
                                                            size.toInt());
                                                        fontSize = size;
                                                        setState(() {});
                                                      }),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isBold,
                                            leading: Icon(Icons.format_bold,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isBold = value;
                                              cubit.changeBoldProps(value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Bold Text',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isItalic,
                                            leading: Icon(Icons.format_italic,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isItalic = value;
                                              cubit.changeItalicProps(value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Italic Text',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isShadow,
                                            leading: Icon(
                                                Icons
                                                    .supervised_user_circle_rounded,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isShadow = value;
                                              cubit.changeShadowProps(value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Text Shadow',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                });
                          },
                          child: ListTile(
                            leading: new Icon(Icons.text_fields,
                                size: 26, color: Colors.blue),
                            title: new Text("Caption",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue)),
                            trailing: new Icon(Icons.arrow_right_outlined,
                                size: 28, color: Colors.blue),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      actions: <Widget>[
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isBW,
                                            leading: Icon(Icons.image_outlined,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isBW = value;
                                              cubit.updateBlackWhiteBackground(
                                                  value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Black & White',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isBlur,
                                            leading: Icon(Icons.broken_image,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isBlur = value;
                                              cubit.updateBlurBackground(value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Blur Image',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTileSwitch(
                                            value: isCredit,
                                            leading: Icon(
                                                Icons
                                                    .supervised_user_circle_rounded,
                                                color: Colors.blue),
                                            onChanged: (value) {
                                              isCredit = value;
                                              cubit.changeIsCreditProps(value);
                                              setState(() {});
                                            },
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            switchType: SwitchType.cupertino,
                                            switchActiveColor: Colors.indigo,
                                            title: Text('Photo Footer',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextField(
                                            controller: footer,
                                            onChanged: (text) {
                                              cubit.changeFooter(text);
                                            },
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(color: Colors.blue),
                                              focusColor: Colors.blue,
                                              filled: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                              labelText: "Custom Footer",
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                Text('Footer Size',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                Expanded(
                                                  child: Slider(
                                                      value: footerSize,
                                                      min: 10,
                                                      max: 50,
                                                      divisions: 20,
                                                      label: "$footerSize",
                                                      onChanged: (size) {
                                                        cubit.changeFooterSize(
                                                            size.toInt());
                                                        footerSize = size;
                                                        setState(() {});
                                                      }),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  });
                                });
                          },
                          child: ListTile(
                            leading: new Icon(Icons.image,
                                size: 26, color: Colors.blue),
                            title: new Text("Image",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue)),
                            trailing: new Icon(Icons.arrow_right_outlined,
                                size: 28, color: Colors.blue),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            isBW = true;
                            isBlur = true;
                            cubit.changeBackground();
                            Navigator.pop(context);
                          },
                          child: ListTile(
                            leading: new Icon(Icons.refresh,
                                size: 26, color: Colors.blue),
                            title: new Text("Change Image",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue)),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            screenshotController
                                .capture(delay: Duration(milliseconds: 100))
                                .then((Uint8List? image) async {
                              // _imageFile = image;
                              if (image != null) {
                                final directory = (await getApplicationDocumentsDirectory()).path;
                                File imgFile =new File('$directory/MyQuoutes.png');
                                imgFile.writeAsBytes(image);
//                                final images = await File('image.png').create();
//                                await images.writeAsBytes(image);
                                // File('share.jpg').writeAsBytes(image);
                                 Share.shareFiles(['$directory/MyQuoutes.png'],
                                     text: 'Hey, Check out my quotes');

//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => Scaffold(
//                                     appBar: AppBar(
//                                       title: Text("CAPURED SCREENSHOT"),
//                                     ),
//                                     body: Center(
//                                         child: Column(
//                                       children: [
//                                         Image.memory(image),
//                                       ],
//                                     )),
//                                   ),
//                                 );
                              }
                            }).catchError((onError) {
                              print(onError);
                            });
                          },
                          child: ListTile(
                            leading: new Icon(Icons.save_alt_outlined,
                                size: 26, color: Colors.blue),
                            title: new Text("Share",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue)),
                          ),
                        ),
                      ),
                    ],
                  );
                });
              });
        },
        child: Screenshot(
          controller: screenshotController,
          child: Stack(
            children: [
              BlocBuilder<QuoteCubit, QuoteState>(
                builder: (context, state) {
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: (state is RefreshQuote)
                        ? Image.network(
                            state.quote.url,
                            fit: BoxFit.cover,
                          )
                        : Center(child: CircularProgressIndicator()),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: size.height,
                width: size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<QuoteCubit, QuoteState>(
                        builder: (context, state) {
                          if (state is RefreshQuote) {
                            return Expanded(
                              child: Center(
                                child: Text(
                                  state.quote.caption,
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      (state.quote.isShadow)
                                          ? Shadow(
                                              offset: Offset(5.0, 2.0),
                                              blurRadius: 7.0,
                                              color:
                                                  Color.fromARGB(150, 0, 0, 0),
                                            )
                                          : Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              color: Color.fromARGB(0, 0, 0, 0),
                                            ),
                                    ],
                                    fontSize: state.quote.textSize.toDouble(),
                                    fontStyle: (state.quote.isItalic)
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                    fontWeight: (state.quote.isBold)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        },
                      ),
                    ]),
              ),
              credits(),
            ],
          ),
        ),
      ),
    );
  }

  Widget credits() {
    return Positioned(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: BlocBuilder<QuoteCubit, QuoteState>(
              builder: (context, state) {
                if (state is RefreshQuote) {
                  if (state.quote.isCredit) {
                    return Text(state.quote.image_author,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: state.quote.footerSize.toDouble(),
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 2.0),
                              blurRadius: 7.0,
                              color: Color.fromARGB(150, 0, 0, 0),
                            ),
                          ],
                          color: Colors.yellow,
                          fontWeight: FontWeight.w700,
                        ));
                  } else {
                    return Text("");
                  }
                } else {
                  return Text("");
                }
              },
            ),
          )),
    );
  }
}
