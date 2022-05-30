import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/style.dart';
import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key? key}) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputString = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
            controller: controller,
            onChanged: (value) {
              inputString = value;
            },
            onSubmitted: (_) {
              dispatchConcrete();
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Input a number")),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text("Search"),
                onPressed: () {
                  dispatchConcrete();
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: raisedRegularButtonStyle,
                child: Text("Get random trivia"),
                onPressed: () {
                  dispatchRandom();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(numberString: inputString));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
