import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/searchbox.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/search_bloc/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceSearchPage extends StatefulWidget {
  const VoiceSearchPage({super.key});

  @override
  State<VoiceSearchPage> createState() => _VoiceSearchPageState();
}

class _VoiceSearchPageState extends State<VoiceSearchPage> {
  TextEditingController searchController = TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool textEnabled = false;
  String _initialMsg = "Click to Speak";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          // listening finished and nothing spoken
          if (status == "done" && _lastWords.isEmpty) {
            setState(() {
              _lastWords = "";
              _initialMsg = "No Speech Detected";
            });
          }
        },
      );

      setState(() {});
    } else {
      print("permission not granted");
    }
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    // setState(() {
    //   _lastWords = "";
    // });
    _lastWords = "";
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 5),
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    print("here");
    print(result);
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchStateSuccess) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: state.products);
        } else if (state is SearchSuccessEmptyData) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: []);
        } else if (state is SearchProductsFetchErrorState) {
          navigatorKey.currentState
              ?.pushNamed(RouteNames.searchResults, arguments: state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height(100),
                  ),
                  // MyText(
                  //     title: _lastWords.isNotEmpty
                  //         ? _lastWords
                  //         : _speechToText.isListening
                  //             ? "Listening....."
                  //             : "Click to Speak",
                  //     fontSize: 25,

                  //     ),
                  Expanded(
                    child: Text(
                      _lastWords.isNotEmpty
                          ? _lastWords
                          : _speechToText.isListening
                              ? "Listening....."
                              : _initialMsg,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height(10),
              ),
              _speechToText.isListening
                  ? InkWell(
                      onTap:
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? _startListening
                              : _stopListening,
                      child: Lottie.asset(
                        'assets/animations/voiceSearch.json',
                        width: 200,
                        repeat: false,
                      ),
                    )
                  : GestureDetector(
                      onTap:
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? _startListening
                              : _stopListening,
                      child: Image.asset(
                        "assets/images/voiceSearch.png",
                        width: 180,
                        height: 200,
                      )),
              _lastWords.isNotEmpty && _lastWords != "No speech detected"
                  ? ElevatedButton(
                      onPressed: () {
                        print(
                            "______________________________________________________");
                        print(_lastWords);
                        context
                            .read<SearchBloc>()
                            .add(SearchProduct(productName: _lastWords));
                      },
                      child: MyText(
                        title: "Go",
                        fontSize: 14,
                        color: CustomStyles.textWhite,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomStyles.submit),
                    )
                  : SizedBox(),
              SizedBox(
                height: height(300),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateLoading) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
