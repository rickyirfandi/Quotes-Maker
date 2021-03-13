import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          color: Colors.white38,
          child: Stack(
            children: [
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
                              style: TextStyle(
                                fontSize: state.quote.textSize.toDouble(),
                                fontWeight: (state.quote.isBold)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
                          },
                          child: Text("Update")),
                    ]),
              )
            ],
          )),
    );
  }
}
