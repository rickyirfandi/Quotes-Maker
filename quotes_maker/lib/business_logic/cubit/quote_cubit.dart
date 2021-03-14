import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_maker/model/quote_model.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final _random = new Random();

  late QuoteModel quotes;
  late int image_id;
  late String image_author;

  QuoteCubit() : super(QuoteInitial());

  String refreshImageUrl() {
    image_id = _random.nextInt(1000);

    if (quotes.isBlur && quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/1080/1920?grayscale&blur=7";
    }

    if (quotes.isBlur) {
      return "https://picsum.photos/id/${image_id}/1080/1920?blur=7";
    }

    if (quotes.isGrayscale) {
      return "https://picsum.photos/id/${image_id}/1080/1920?grayscale";
    }

    return "https://picsum.photos/id/${image_id}/1080/1920";
  }

  Future<String> initImageUrl() async {
    bool isValid = false;

    while (!isValid) {
      image_id = _random.nextInt(1000);
      isValid = await verifyImage(image_id);
    }
    return "https://picsum.photos/id/${image_id}/1080/2000?grayscale&blur=5";
  }

  Future<bool> verifyImage(int id) async {
    var response = await http.get(Uri.https('picsum.photos', '/id/$id/info'));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var author = jsonResponse['author'];
      print('Author : $author.');
      this.image_author = author;
      return true;
    } else {
      return false;
    }
  }

  void init() async {
    this.quotes = new QuoteModel(
      url: await initImageUrl(),
      caption: "Indahnya dunia ini hanyalah background semata :)",
      textSize: 14,
      isBold: false,
      isItalic: false,
      isGrayscale: true,
      isBlur: true,
      image_author: image_author,
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

  void changeBackground() async {
    emit(QuoteInitial());
    this.quotes.url = await initImageUrl();
    this.quotes.image_author = this.image_author;
    emit(RefreshQuote(this.quotes));
  }
}
