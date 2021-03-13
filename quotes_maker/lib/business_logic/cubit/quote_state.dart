part of 'quote_cubit.dart';

@immutable
abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class RefreshQuote extends QuoteState {
  final QuoteModel quote;

  RefreshQuote(this.quote);
}
