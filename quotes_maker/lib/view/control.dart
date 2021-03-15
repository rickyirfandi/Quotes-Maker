import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_maker/business_logic/cubit/quote_cubit.dart';

class Control extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<QuoteCubit>();

    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            child: Center(child: BlocBuilder<QuoteCubit, QuoteState>(
              builder: (context, state) {
                if (state is RefreshQuote) {
                  return Text(state.quote.caption);
                } else {
                  return Text("");
                }
              },
            ))));
  }
}
