// ignore_for_file: prefer_const_constructors

import 'package:destini/story_brain.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Destini());
StoryBrain storyBrain = StoryBrain();

class Destini extends StatelessWidget {
  const Destini({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  choiceOneFunction(choiceOne) {
    setState(() {
      storyBrain.nextStory(choiceOne);
    });
  }

  choiceTwoFunction(choiceTwo) {
    setState(() {
      storyBrain.nextStory(choiceTwo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () {
                    //Choice 1 made by user
                    choiceOneFunction(1);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  child: Text(
                    storyBrain.getChoice1(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                  flex: 2,
                  child: Visibility(
                    visible: storyBrain.buttonShouldBeVisible(),
                    child: TextButton(
                      onPressed: () {
                        //Choice 2 made by user.
                        choiceTwoFunction(2);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      child: Text(storyBrain.getChoice2(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



//TODO: Step 29 - Run the app and test it against the Story Outline to make sure you've completed all the steps. The code for the completed app can be found here: https://github.com/londonappbrewery/destini-challenge-completed/
