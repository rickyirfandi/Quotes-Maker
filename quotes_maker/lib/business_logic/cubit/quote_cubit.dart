import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_maker/model/quote_model.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  late QuoteModel quotes;

  QuoteCubit() : super(QuoteInitial());

  void init() {
    this.quotes = new QuoteModel(
        caption: "Indahnya dunia ini hanyalah background semata :)",
        textSize: 14,
        isBold: false);

    emit(RefreshQuote(this.quotes));
  }

  void changeCaption(String newCaption) {
    this.quotes.caption = newCaption;

    emit(RefreshQuote(this.quotes));
  }

  void changeTextSize(int newSize) {
    this.quotes.textSize = newSize;

    emit(RefreshQuote(this.quotes));
  }

  void changeBoldProps(bool newValue) {
    this.quotes.isBold = newValue;

    emit(RefreshQuote(this.quotes));
  }
}
