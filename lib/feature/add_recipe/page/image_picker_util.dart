
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagePickerUtil {
  static const defaultImageUrl = "images/boy.jpg";

  final ImagePicker _picker = ImagePicker();
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String bucketName = 'Images';

  Future<String?> pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && (Platform.isAndroid || Platform.isIOS || kIsWeb)) {
        return await uploadImageToSupabase(File(image.path));
      } else {
        Fluttertoast.showToast(
          msg: "Выбор изображения поддерживается только на мобильных устройствах и Web",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error selecting image: $e');
      Fluttertoast.showToast(
        msg: "Ошибка при выборе изображения",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    return defaultImageUrl; // Возвращаем дефолтное изображение, если выбор не удался или ошибка
  }

  Future<String> uploadImageToSupabase(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";

      // Загружаем файл в Supabase Storage
      final response = await _supabaseClient.storage.from(bucketName).upload(
        fileName,
        imageFile,
        fileOptions: const FileOptions(upsert: true),
      );

      // Проверяем, что загрузка прошла успешно
      if (response.isNotEmpty) {
        // Получаем публичный URL загруженного файла
        final publicUrl = _supabaseClient.storage.from(bucketName).getPublicUrl(fileName);
        print('Image uploaded successfully: $publicUrl');
        return publicUrl;
      } else {
        print('Upload error: Response is empty');
      }
    } catch (e) {
      print('Upload error: $e');
    }

    // Возвращаем URL дефолтного изображения, если загрузка не удалась
    print('Returning default image URL due to an error.');
    return defaultImageUrl;
  }
}