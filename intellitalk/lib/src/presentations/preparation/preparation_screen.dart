// // import 'dart:html' as html;
// // import 'dart:js' as js;
// // import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intellitalk/constants.dart';
// import 'package:intellitalk/src/data/dataproviders/backend.dart';
// import 'package:intellitalk/src/data/models/user_m.dart';

// class PreparationScreen extends StatefulWidget {
//   final String convoId;
//   const PreparationScreen({super.key, required this.convoId});

//   @override
//   State<PreparationScreen> createState() => _PreparationScreenState();
// }

// class _PreparationScreenState extends State<PreparationScreen> {
//   final be = Backend();
//   User? user;
//   bool isLoadingPage = true;

//   static const List<String> instruction = [
//     'This is timed interview. Please make sure you are not interrupted during the test, as the timer cannot be paused once started.',
//     'Please ensure you have a stable internet connection',
//     'To start interview, click start interview button'
//   ];

//   // final bool _isStartedRecord = false;

//   // late html.VideoElement _preview;
//   // late html.MediaRecorder _recorder;
//   // late html.VideoElement _result;

//   // final bool _isPermission = false;

//   void asynFuct() async {
//     user = await be.fetchDataUser(widget.convoId);
//     if (user != null) {
//       setState(() {
//         isLoadingPage = false;
//       });
//       // checkIsFinish();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     asynFuct();
//     // _preview = html.VideoElement()
//     //   ..autoplay = true
//     //   ..muted = true
//     //   ..width = html.window.innerWidth!
//     //   ..height = html.window.innerHeight!;

//     // _result = html.VideoElement()
//     //   ..autoplay = false
//     //   ..muted = false
//     //   ..width = html.window.innerWidth!
//     //   ..height = html.window.innerHeight!
//     //   ..controls = true;

//     // ignore: undefined_prefixed_name
//     // ui.platformViewRegistry.registerViewFactory('preview', (int _) => _preview);

//     // ignore: undefined_prefixed_name
//     // ui.platformViewRegistry.registerViewFactory('result', (int _) => _result);
//   }

//   // Future<html.MediaStream?> _openCamera() async {
//   //   final html.MediaStream? stream = await html.window.navigator.mediaDevices
//   //       ?.getUserMedia({'video': true, 'audio': true});
//   //   _preview.srcObject = stream;
//   //   return stream;
//   // }

//   // void handlePermission() async {
//   //   try {
//   //     if (!_isPermission) {
//   //       final html.MediaStream? stream = await _openCamera();
//   //       startRecording(stream!);
//   //       _isPermission = true;
//   //       setState(() {});
//   //       Future.delayed(
//   //           Duration.zero,
//   //           () => context.goNamed('conversation', extra: {
//   //                 'recorder': _recorder,
//   //               }, pathParameters: {
//   //                 'convoId': widget.convoId
//   //               }));
//   //     }
//   //   } catch (e) {
//   //     log('ERROR HANDLE PERMISSION $e');
//   //   }
//   // }

//   // void startRecording(html.MediaStream stream) {
//   //   _recorder = html.MediaRecorder(stream);
//   //   _recorder.start();
//   //   html.Blob blob = html.Blob([]);

//   //   _recorder.addEventListener('dataavailable', (event) {
//   //     blob = js.JsObject.fromBrowserObject(event)['data'];
//   //     print('blob $blob');
//   //   }, true);

//   //   _recorder.addEventListener('stop', (event) {
//   //     final url = html.Url.createObjectUrl(blob);
//   //     _result.src = url;
//   //     print('url ${_result.src}');

//   //     stream.getTracks().forEach((track) {
//   //       if (track.readyState == 'live') {
//   //         track.stop();
//   //         print('track stop');
//   //       }
//   //     });
//   //   });
//   // }

//   // void stopRecording() => _recorder.stop();

//   // void testRecord() async {
//   //   MediaDevices({
//   //     video: true,
//   //   }).getUserMedia();
//   //   FlutterScreenRecording.globalForegroundService();
//   //   _isStartedRecord = await FlutterScreenRecording.startRecordScreen(
//   //       'test_record',
//   //       titleNotification: 'Recorded!');
//   //   log('CALLED RECORD $_isStartedRecord');
//   //   setState(() {});
//   //   Future.delayed(const Duration(seconds: 15), () => stopRecord());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoadingPage == true
//           ? SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : Row(children: [
//               Container(
//                 color: kWhite,
//                 padding: EdgeInsets.only(
//                     right: MediaQuery.of(context).size.width * 0.03,
//                     top: MediaQuery.of(context).size.width * 0.03,
//                     left: MediaQuery.of(context).size.width * 0.07),
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       '/images/logo_arkademi_blue.png',
//                       height: 40,
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.2),
//                     Text('Hello, ${user!.name}'),
//                     const SizedBox(height: 28),
//                     const Text(
//                       'Welcome to\nArkademi Intellitalk',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//                     const Text('Estimated Interview Duration'),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${user!.quantity * 3} mins',
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: kPrimaryBlue,
//                 alignment: Alignment.center,
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.04),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Instructions',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: kWhite,
//                           fontSize: 26),
//                     ),
//                     const SizedBox(height: 24),
//                     for (int i = 0; i < instruction.length; i++)
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 3),
//                               child: Text(
//                                 '${i + 1}.',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: kWhite,
//                                     fontSize: 15),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 instruction[i],
//                                 maxLines: 5,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     height: 1.5,
//                                     color: kWhite,
//                                     fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     const SizedBox(height: 50),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: kSecondaryBlue,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 24, horizontal: 34)),
//                       onPressed: () => context.pushNamed('conversation',
//                           // extra: {
//                           // 'recorder': _recorder,
//                           // },
//                           pathParameters: {'convoId': widget.convoId}),
//                       child: const Text(
//                         'Start Interview',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     const Text(
//                       '*Please remember, you can only access this interview once,\ndo your best!',
//                       maxLines: 5,
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           height: 1.5,
//                           color: kWhite,
//                           fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//     );
//   }
// }
