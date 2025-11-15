import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageCompressorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class ImageCompressorApp extends StatefulWidget {
  

  ImageCompressorApp({super.key});

  @override
  State<ImageCompressorApp> createState() => _ImageCompressorAppState();
}

class _ImageCompressorAppState extends State<ImageCompressorApp> {
  // stores the original image
  File? _selectedImage;
  // stores the compressed image 
  File? _compressedImage;
  // checks if compression is ongoing
  bool _isCompressing = false;
  // stores error messages
  String? _error;


  // function to pick image from the gallery
  Future<void> _pickImage() async {
    try{
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null){
        setState((){
          {
          // store selected image 
          _selectedImage =  File(pickedFile.path);
          // reset previous compressed image
          _compressedImage = null;
          // clear any previoud errors
          _error = null;
          // show that compression is starting
          _isCompressing = true;

        }
        });
        // compress the selected image
        await compressImage(_selectedImage!);
      }
    } catch (e){
      setState(() {
        // store error
        _error = 'Error picking image $e';
        // stop compression state
        _isCompressing =  false;
      });
    }
  }

  // function to compress the selected image
  Future<void> compressImage(File image) async {
    try{
      // get a temporary directory to store the compressed image
      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/ compressed_image.jpg';

      // compress the image and store it in the new location
      var result = await FlutterImageCompress.compressAndGetFile(image.absolute.path, targetPath, quality: 85);
      if (result != null ){
        final compressedFile = File(result.path);
        if(await compressedFile.exists()){
          final orginalSize = await image.length;
          final compressedSize = await compressedFile.length();
          setState(() {
            
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Compressor'),

        backgroundColor: Colors.indigo[300],
        foregroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(

      ),
    );
  }
}