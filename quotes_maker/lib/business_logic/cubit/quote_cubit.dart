import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_maker/model/quote_model.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final _random = new Random();

  late QuoteModel quotes;
  late int image_id;

  QuoteCubit() : super(QuoteInitial());

  String refreshImageUrl() {
    image_id = _random.nextInt(1000);

    if (quotes.isBlur && quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/1080/1920?grayscale&blur=5";
    }

    if (quotes.isBlur) {
      return "https://picsum.photos/id/${image_id}/1080/1920?blur=5";
    }

    if (quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/1080/1920?grayscale";
    }

    return "https://picsum.photos/id/${image_id}/1080/1920";
  }

  String initImageUrl() {
    image_id = _random.nextInt(1000);
    return "https://picsum.photos/id/${image_id}/1080/2000?grayscale&blur=5";
  }

  void init() {
    this.quotes = new QuoteModel(
      url: initImageUrl(),
      caption: "Indahnya dunia ini hanyalah background semata :)",
      textSize: 14,
      isBold: false,
      isItalic: false,
      isGrayscale: true,
      isBlur: true,
    );

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

  void changeItalicProps(bool newValue) {
    this.quotes.isItalic = newValue;

    emit(RefreshQuote(this.quotes));
  }
}
