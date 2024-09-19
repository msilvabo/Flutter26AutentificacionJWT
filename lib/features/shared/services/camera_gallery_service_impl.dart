import 'camera_gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = new ImagePicker();

  @override
  Future<List<String>>? selectMultiplePhoto() {
    throw UnimplementedError();
  }

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80);

    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear);
        
    if (photo == null) return null;
    return photo.path;
  }
}
