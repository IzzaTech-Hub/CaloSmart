// import 'package:calories_detector/app/modules/aichat/controllers/aichat_controller.dart';
// import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
// import 'package:calories_detector/app/modules/utills/app_images.dart';
// import 'package:calories_detector/sizeConfig.dart';
// import 'package:flutter/material.dart';
// // import 'package:launch_review/launch_review.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// // import 'package:flutter_web_browser/flutter_web_browser.dart';

// class AichatView extends GetView<AichatController> {
//   const AichatView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Lottie.asset(
//         LottieAnimations.comingsoon,
//         width: SizeConfig.screenWidth * 0.6,
//         height: SizeConfig.screenWidth * 0.6,
//         // height: 200,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }

// class AichatViewAppBar extends GetView<AichatController> {
//   const AichatViewAppBar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return appThemeAppBar(context, 'Ai Chat');
//   }
// }

import 'dart:convert';
import 'dart:developer' as dp;
import 'dart:io';

// import 'package:api_key_pool/api_key_pool.dart';
import 'package:calories_detector/app/modules/aichat/controllers/aichat_controller.dart';
import 'package:calories_detector/app/modules/home/views/home_view.dart';
import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
import 'package:calories_detector/app/modules/utills/remoteConfigVariables.dart';
import 'package:calories_detector/app/premium/premium.dart';
import 'package:calories_detector/app/routes/app_pages.dart';
import 'package:calories_detector/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

final String _apiKey = ApiKeyPool.getKey();
// final String _apiKey ='';
// final String _apiKey = RCVariables.GemeniAPIKey.value;
// const String _apiKey = 'AIzaSyBfsg3ZEwnl0CRPYGBh1r_XhFu9tChvL5o';

// void main() {
//   runApp(const GenerativeAISample());
// }

class AichatView extends StatelessWidget {
  const AichatView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     brightness: Brightness.dark,
      //     seedColor: const Color.fromARGB(255, 171, 222, 244),
      //   ),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: appThemeAppBarforaichat(context, 'Ai Chat'),
        ),
        // body: ChatWidget(apiKey: ''),
        body: ChatWidget(apiKey: ApiKeyPool.getKey()),
        // body: ChatWidget(apiKey: RCVariables.GemeniAPIKey.value),
      ),
    );
  }
}

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key, required this.title});

//   final String title;

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: const ChatWidget(apiKey: _apiKey),
//     );
//   }
// }

// class ChatWidget extends GetView<AichatController> {
class ChatWidget extends StatefulWidget {
  const ChatWidget({
    required this.apiKey,
    super.key,
  });

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  AichatController aichatcontroller = Get.find();

  bool _loading = false;
  bool isImageSelected = false;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: RCVariables.GemeniAiModel.value,
      // model: 'gemini-1.5-flash-latest',
      apiKey: widget.apiKey,
      generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          // maxOutputTokens: 1000,
          // responseMimeType: 'text/plain',
          responseMimeType: 'application/json',
          responseSchema: Schema.object(properties: {
            'massage': Schema.string(),
            'function': Schema.object(properties: {
              'functionType': Schema.enumString(enumValues: [
                'foodData',
                'exerciseData',
                'waterData',
                'none'
              ]),
              'foodData': Schema.object(properties: {
                'foodname': Schema.string(description: 'Food name.'),
                'calories': Schema.number(
                    description:
                        'calculate an estimate of how much calories this food could have.'),
              }, requiredProperties: [
                'foodname',
                'calories'
              ]),
              'waterData': Schema.object(properties: {
                'waterquantity': Schema.number(
                    description:
                        'Water quantity in no of glasses if they are not in glass than calculate to avgestimate glasses.'),
              }, requiredProperties: [
                'waterquantity'
              ]),
              'exerciseData': Schema.object(properties: {
                'exercise':
                    Schema.number(description: 'Exercise quantity in minutes.'),
              }, requiredProperties: [
                'exercise'
              ]),
            }, requiredProperties: [
              'functionType'
            ]),
          }, requiredProperties: [
            'massage',
            'function'
          ])),
      systemInstruction: Content.system(
          'You are an expert dietician. Generate your response as short as posible and to the point. no need to explain every thing only the necessary elements that are being asked. if there is something user is asking to do or he is telling that he have eaten something or drank something or having exercise and you are clear about unit than run function as well. if he is chating reply normally and when ever you are certain about details run function to save that data.'),
    );
    _chat = _model.startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  final textFieldDecoration = InputDecoration(
    hintText: 'Type your message...',
    hintStyle: TextStyle(
      color: Colors.grey.shade500,
      fontSize: 15,
    ),
    filled: true,
    fillColor: Colors.grey.shade100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.primary,
        width: 1.5,
      ),
    ),
  );

  return Container(
    color: Colors.grey.shade50,
    child: Column(
      children: [
        Expanded(
          child: _apiKey.isNotEmpty
              ? (aichatcontroller.generatedContent.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      itemCount: aichatcontroller.generatedContent.length,
                      itemBuilder: (context, idx) {
                        final content = aichatcontroller.generatedContent[idx];
                        return MessageWidget(
                          text: content.text,
                          image: content.image,
                          isFromUser: content.fromUser,
                          isFeedBack: content.isFeedBack,
                          isGood: content.isGood,
                          index: idx,
                        );
                      },
                    )
                  : _buildDefaultPrompts())
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No API key found.\nPlease provide one using "--dart-define=API_KEY=<your_key>".',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, -0.5),
                blurRadius: 6,
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  focusNode: _textFieldFocus,
                  controller: _textController,
                  onSubmitted: _sendChatMessage,
                  decoration: textFieldDecoration,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: !_loading
                    ? () async {
                        if (!isImageSelected) {
                          pickImageFromGallery();
                        } else {
                          setState(() => isImageSelected = false);
                        }
                      }
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isImageSelected
                        ? colorScheme.primary.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isImageSelected
                      ? Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: colorScheme.primary),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(imageFile!, fit: BoxFit.cover),
                          ),
                        )
                      : Icon(Icons.image_rounded,
                          size: 30, color: colorScheme.primary),
                ),
              ),
              const SizedBox(width: 10),
              _loading
                  ? const SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _sendChatMessage(_textController.text),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(Icons.send_rounded,
                              size: 30, color: colorScheme.primary),
                          Positioned(
                            right: -3,
                            bottom: -3,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  isImageSelected ? '5' : '1',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 9),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildDefaultPrompts() {
    List<String> randomPrompts = aichatcontroller.randomPrompts;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(48, 12, 48, 24),
          child: Container(
            height: 42,
            decoration: BoxDecoration(
                color: Colors.amber[100],
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Icon(
                  Icons.info_outline,
                  color: Colors.black.withOpacity(0.3),
                ),
                Text(
                  'This is a temporary chat',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  aichatcontroller.newDefaultPrompts();

                  setState(() {});
                },
                child: Row(
                  children: [
                    Text('Refresh'),
                    Icon(Icons.refresh),
                  ],
                ))
            // GestureDetector(onTap: () {}, child: Icon(Icons.refresh)),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: randomPrompts.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  // padding: EdgeInsets.all(0),
                  child: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.amber[100],
                        // border: Border.all(color: Colors.amber),
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                      child: Text(
                        randomPrompts[idx],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _textController.text = randomPrompts[idx];
                    _textFieldFocus.requestFocus();
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageFile = File(image.path);
          isImageSelected = true;
        });

        print('Image Path: ${image.path}');
        print('Image seted');
        // sendImageToGoogleAI(imageFile);
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _sendImagePrompt(String message) async {
    setState(() {
      _loading = true;
    });
    try {
      Uint8List imgBytes = await imageFile!.readAsBytes();
      // ByteData catBytes = await imageFile!.readAsBytes();
      // ByteData catBytes = await imageFile.readAsBytes();
      // ByteData catBytes = await rootBundle.load('assets/images/cat.jpg');
      // ByteData sconeBytes = await rootBundle.load('assets/images/scones.jpg');
      // ByteData catBytes = await rootBundle.load('assets/images/cat.jpg');
      final content = [
        Content.multi([
          TextPart(message),
          // The only accepted mime types are image/*.
          DataPart('image/jpeg', imgBytes.buffer.asUint8List()),
        ])
      ];
      aichatcontroller.generatedContent.add((
        // image: Image.asset("assets/cat.jpg"),
        image: Image.file(imageFile!),
        text: message,
        fromUser: true,
        isFeedBack: false.obs,
        isGood: false.obs
      ));
      // _generatedContent.add((
      //   image: Image.asset("assets/scones.jpg"),
      //   text: null,
      //   fromUser: true
      // ));

      var response = await _model.generateContent(content);
      var text = response.text;
      dp.log(text.toString());
      aichatcontroller.generatedContent.add((
        image: null,
        text: text,
        fromUser: false,
        isFeedBack: false.obs,
        isGood: false.obs
      ));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          isImageSelected = false;
          _scrollDown();
        });
      }
      Premium.instance.reduce1(5);
      print('reduced by 5');
    } catch (e) {
      // if (e.toString().contains('You exceeded your current quota')) {
      //   dp.log('You exceeded your current quota');
      //   _model.;
      // }
      _showError('Something went wrong, Please try again later');

      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });
    if (isImageSelected) {
      if (Premium.instance.apple!.value >= 5) {
        _sendImagePrompt(message);
      } else {
        setState(() {
          _loading = false;
          isImageSelected = false;
        });
        Get.toNamed(Routes.PAYWALL);
      }
    } else if (Premium.instance.apple!.value >= 1) {
      try {
        aichatcontroller.generatedContent.add((
          image: null,
          text: message,
          fromUser: true,
          isFeedBack: false.obs,
          isGood: false.obs
        ));
        final rawresponse = await _chat.sendMessage(
          Content.text(message),
        );
        dp.log(rawresponse.text.toString());
        final response = jsonDecode(rawresponse.text ?? '');
        dp.log(response.toString());
        final text = response['massage'];
        dp.log(text.toString());
        aichatcontroller.generatedContent.add((
          image: null,
          text: text,
          fromUser: false,
          isFeedBack: false.obs,
          isGood: false.obs
        ));

        if (response['function']['functionType'] != 'none') {
          if (response['function']['functionType'] == 'foodData') {
            dp.log('saving food data');
            dialogueformanualdata(context,
                fn: response['function']['foodData']['foodname'],
                cal: (response['function']['foodData']['calories']).toInt());
          } else if (response['function']['functionType'] == 'waterData') {
            dp.log('saving water data');
            dialogueforwater(context,
                sg: (response['function']['waterData']['waterquantity'])
                    .toInt());
          } else if (response['function']['functionType'] == 'exerciseData') {
            dp.log('saving exercise data');
            dialogueforexercise(context,
                    mins: (response['function']['exerciseData']['exercise'])
                        .toInt()) 
                ;
          }
        }

        if (text == null) {
          _showError('No response from AI.');
          return;
        } else {
          setState(() {
            _loading = false;
            _scrollDown();
          });
        }
        Premium.instance.reduce1(1);
        print('reduced by 1');
      } catch (e) {
        dp.log(e.toString());
        _showError('No Response found, Please try again later');
        setState(() {
          _loading = false;
        });
      } finally {
        _textController.clear();
        setState(() {
          _loading = false;
        });
        _textFieldFocus.requestFocus();
      }
    } else {
      setState(() {
        _loading = false;
      });
      Get.toNamed(Routes.PAYWALL);
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends GetView<AichatController> {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
    required this.isFeedBack,
    required this.isGood,
    required this.index,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;
  final RxBool isFeedBack;
  final RxBool isGood;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
                child: Container(
                    constraints:
                        BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.75),
                    decoration: BoxDecoration(
                      color: isFromUser
                          // ? AppThemeColors.onPrimary2
                          // : AppThemeColors.onPrimary1,
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (image case final image?)
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: image),
                          if (text case final text?)
                            MarkdownBody(
                              data: text,
                              //   styleSheet: isFromUser
                              //       ? MarkdownStyleSheet()
                              //       : MarkdownStyleSheet(
                              //           p: const TextStyle(
                              //               color: Colors.white), // Paragraph text color
                              //           h1: const TextStyle(
                              //               color: Colors.white), // Header 1 color
                              //           h2: const TextStyle(
                              //               color: Colors.white), // Header 2 color
                              //           strong: const TextStyle(
                              //               color: Colors.white), // Bold text color
                              //           em: const TextStyle(color: Colors.white),
                              //         ),
                            ),
                        ]))),
          ],
        ),
        Container(
          // width: SizeConfig.screenWidth,
          // color: Colors.red,
          margin: EdgeInsets.symmetric(
              // vertical: SizeConfig.blockSizeVertical * 1,
              horizontal: SizeConfig.blockSizeHorizontal * 5),
          child: Row(
            mainAxisAlignment:
                isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // IconButton(
              //     padding: EdgeInsets.zero,
              //     color: Colors.white,
              //     tooltip: "Share",
              //     onPressed: () {
              //       controller.ShareMessage(
              //           controller.chatList[index].message);
              //     },
              //     icon: Icon(Icons.share)),

              // horizontalSpace(SizeConfig.blockSizeHorizontal*2),

              // IconButton(
              //     padding: EdgeInsets.zero,
              //     color: Colors.white,
              //     tooltip: "Copy",
              //     onPressed: () {
              //       controller.CopyMessage(
              //           controller.chatList[index].message);
              //     },
              //     icon: Icon(
              //       Icons.copy_rounded,
              //       size: iconSize,
              //     )),

              // !isSender && !(isFeedback && !isGood)
              Obx(
                () => !(isFeedBack.value && !isGood.value) && !isFromUser
                    // 0 == 0
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.black45,
                        tooltip: "Good",
                        onPressed: () {
                          if (0 == 0)
                          //  (!isFeedback)
                          {
                            controller.GoodResponse(
                                // controller.chatList[index].message,
                                // index
                                text!,
                                index);
                          }
                        },
                        icon: Icon(
                          isFeedBack.value && isGood.value
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          size: 30,
                          // size: iconSize,
                        ))
                    : Container(),
              ),
//
//-----------------------------------------------------------------------------------------------------------------------------------------
//

              // !isSender && !(isFeedback && isGood)
              // 0 == 0
              Obx(
                () => !(isFeedBack.value && isGood.value) && !isFromUser
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.black45,
                        tooltip: "Bad Response",
                        onPressed: () {
                          if
                              // (0 == 0)
                              (!isFeedBack.value) {
                            controller.reportMessage(
                                Get.context!,
                                text!
                                // controller.chatList[index].message,
                                ,
                                index);
                          }
                        },
                        icon: Icon(
                          isFeedBack.value && !isGood.value
                              ? Icons.thumb_down
                              : Icons.thumb_down_alt_outlined,
                          size: 30,
                          // size: iconSize,
                        ))
                    : Container(),
              )
              // horizontalSpace(SizeConfig.blockSizeHorizontal*2),
              //   IconButton(
              //     padding: EdgeInsets.zero,

              //     onPressed: (){}, icon:Icon(Icons.share))
              // ,
              // horizontalSpace(SizeConfig.blockSizeHorizontal*2),
            ],
          ),
        ),
      ],
    );
  }
}
