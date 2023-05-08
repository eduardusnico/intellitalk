import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:js' as js;

class ScreenRecordController extends GetxController {
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxBool _isRecord = false.obs;
  RxBool get isRecord => _isRecord;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _isLoading.value = true;

    _preview = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..width = html.window.innerWidth!
      ..height = html.window.innerHeight!;

    _result = html.VideoElement()
      ..autoplay = false
      ..muted = false
      ..width = html.window.innerWidth!
      ..height = html.window.innerHeight!
      ..controls = true;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('preview', (int _) => _preview);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('result', (int _) => _result);
    await openCameraAndStartRecord();
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () => _isLoading.value = false,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  late html.VideoElement _preview;
  late html.MediaRecorder _recorder;
  late html.VideoElement _result;

  // THIS FUNCTION TO START RECORD AUTOMATICALLY WHEN USER TURN ON THEIR CAMERA
  Future<void> openCameraAndStartRecord() async {
    final streamCamera = await openCamera();
    if (streamCamera != null) {
      startRecording(streamCamera);
      _isRecord.value = true;
    }
  }

  // THIS FUNCTION FOR OPEN CAMERA USER
  Future<html.MediaStream?> openCamera() async {
    final html.MediaStream? stream = await html.window.navigator.mediaDevices
        ?.getUserMedia({'video': true, 'audio': true});
    _preview.srcObject = stream;
    return stream;
  }

  // THIS FUNCTION FOR STOP RECORDING
  void startRecording(html.MediaStream stream) {
    _recorder = html.MediaRecorder(stream);
    _recorder.start();

    html.Blob blob = html.Blob([]);

    _recorder.addEventListener('dataavailable', (event) {
      blob = js.JsObject.fromBrowserObject(event)['data'];
    }, true);

    _recorder.addEventListener('stop', (event) {
      final url = html.Url.createObjectUrl(blob);
      _result.src = url;

      stream.getTracks().forEach((track) {
        if (track.readyState == 'live') {
          track.stop();
        }
      });
    });
  }

  void stopRecording() {
    _recorder.stop();
    _isRecord.value = false;
  }
}
