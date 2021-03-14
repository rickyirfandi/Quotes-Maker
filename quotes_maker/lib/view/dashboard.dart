import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                      width: MediaQuery.of(context).size.width,
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
                        onPressed: () {},
                        child: ListTile(
                          leading: new Icon(Icons.account_balance_wallet,
                              size: 26, color: Colors.blue),
                          title: new Text("Bank Opname",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue)),
                          trailing: new Icon(Icons.arrow_right_outlined,
                              size: 28, color: Colors.blue),
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
                          context
                              .read<QuoteCubit>()
                              .changeCaption("Kapan kita jalan");

                          context.read<QuoteCubit>().changeTextSize(40);

                          context.read<QuoteCubit>().changeBoldProps(true);

                          context.read<QuoteCubit>().changeItalicProps(true);
                        },
                        child: Text("Update")),
                  ]),
            ),
            Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
