import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellitalk/src/screen_record/controller/screen_record_controller.dart';

class ScreenRecordPage extends StatelessWidget {
  ScreenRecordPage({super.key});

  final _sCRecordC = Get.put(ScreenRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Recording'),
      ),
      body: Obx(
        () => _sCRecordC.isLoading.isTrue
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Expanded(child: Center(child: Text('Loading...')))
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Recording Preview',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 300,
                      height: 200,
                      color: Colors.blue,
                      child: HtmlElementView(
                        key: UniqueKey(),
                        viewType: 'preview',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final html.MediaStream? stream =
                          //         await _sCRecordC.openCamera();
                          //     _sCRecordC.startRecording(stream!);
                          //   },
                          //   child: const Text('Start Recording'),
                          // ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: _sCRecordC.isRecord.isTrue
                                ? () => _sCRecordC.stopRecording()
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _sCRecordC.isRecord.isTrue
                                  ? Colors.blue
                                  : Colors.grey.shade700,
                            ),
                            child: Text(
                              'Stop Recording',
                              style: TextStyle(
                                color: _sCRecordC.isRecord.isTrue
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Recording Result',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 300,
                      height: 200,
                      color: Colors.blue,
                      child: HtmlElementView(
                        key: UniqueKey(),
                        viewType: 'result',
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
