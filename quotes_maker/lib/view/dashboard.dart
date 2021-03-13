import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<QuoteCubit, QuoteState>(
            builder: (context, state) {
              return Container(
                height: size.height,
                width: size.width,
                child: Image.network(
                  (state is RefreshQuote) ? state.quote.url : "",
                  fit: BoxFit.cover,
                ),
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
          )
        ],
      ),
    );
  }
}
