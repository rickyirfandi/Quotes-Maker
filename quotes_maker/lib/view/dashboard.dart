import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<QuoteCubit>();
    bool isBold = true;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: <Widget>[
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {},
                        child: ListTile(
                          leading: new Icon(Icons.calendar_today_rounded,
                              size: 26, color: Colors.blue),
                          title: new Text("Trace Back",
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
                      width: size.width,
                      margin: EdgeInsets.only(bottom: 5),
                      child: TextButton(
                        onPressed: () {},
                        child: ListTile(
                          leading: new Icon(Icons.list_rounded,
                              size: 26, color: Colors.blue),
                          title: new Text("Lain Lain",
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
                          cubit.changeBackground();
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: new Icon(Icons.refresh,
                              size: 26, color: Colors.blue),
                          title: new Text("Ganti Gambar",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          cubit.changeBackground();
                          Navigator.pop(context);
                        },
                        child: ListTileSwitch(
                          value: isBold,
                          leading: Icon(Icons.access_alarms),
                          onChanged: (value) {
                            cubit.changeBoldProps(value);
                          },
                          visualDensity: VisualDensity.comfortable,
                          switchType: SwitchType.cupertino,
                          switchActiveColor: Colors.indigo,
                          title: Text('Default Custom Switch'),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
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
                          return Text(
                            state.quote.caption,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5.0, 2.0),
                                  blurRadius: 7.0,
                                  color: Color.fromARGB(150, 0, 0, 0),
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
                          );
                        } else {
                          return Text("");
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          cubit.changeCaption(
                              "Aku sayang kamu tapi kamu sayang sama yang lain");

                          cubit.changeTextSize(24);

                          cubit.changeBoldProps(true);

                          cubit.changeItalicProps(true);
                        },
                        child: Text("Update")),
                  ]),
            ),
            credits(),
          ],
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
                  return Text("Photo: ${state.quote.image_author}",
                      style: TextStyle(
                        color: Colors.yellow,
                      ));
                } else {
                  return Text("");
                }
              },
            ),
          )),
    );
  }
}
