class FileFunctionsHelper{
  static String getMimeType(String filePath) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'png';
      case 'jpg':
      case 'jpeg':
        return 'jpeg';
      case 'pdf':
        return 'pdf';
      default:
        throw Exception('Unsupported file type');
    }
  }
}