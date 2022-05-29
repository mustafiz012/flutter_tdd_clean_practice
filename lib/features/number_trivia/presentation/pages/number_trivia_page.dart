import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: BlocProvider(
        create: (BuildContext context) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                  return TriviaDisplay(
                      numberTrivia: NumberTrivia(
                          "Start searching Start searching Start searching Start searching Start searching Start searching Start searching Start searching Start searching Start searching ",
                          12));
                  if (state is Empty) {
                    return MessageDisplay(
                      message: "Still searching...",
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return MessageDisplay(message: state.trivia.text);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                }),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    Placeholder(fallbackHeight: 40),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Placeholder(fallbackHeight: 30),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Placeholder(fallbackHeight: 30),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({Key? key, required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Text(
                numberTrivia.text,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
