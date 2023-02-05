import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_practice/features/number_trivia/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Loaded || state is Error || state is Empty) {
                    return Container();
                  }
                  /*else if (state is CacheLoaded) {
                    return const LinearProgressIndicator();
                  } */
                  else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: "Still searching...",
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    print("Loaded ${state.trivia.number}");
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is CacheLoaded) {
                    print("CacheLoaded ${state.trivia.number}");
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  } else {
                    return MessageDisplay(
                      message: "Still searching...",
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
