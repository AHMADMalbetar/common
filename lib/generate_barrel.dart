import 'dart:io';

void main() {
  final directory = Directory('lib/common'); // Directory to scan for Dart files
  final barrelFile = File('lib/common.dart'); // Generate barrel file in lib/

  // Check if the directory exists
  if (!directory.existsSync()) {
    print('❌ Error: Directory ${directory.path} does not exist.');
    exit(1); // Exit with error
  }

  final buffer = StringBuffer();

  for (var file in directory.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      var relativePath = file.path.replaceFirst('lib/', '');
      if (relativePath != 'common.dart') { // Prevent self-export
        // Normalize path separators to forward slashes
        relativePath = relativePath.replaceAll('\\', '/');
        buffer.writeln("export '$relativePath';");
      }
    }
  }

  barrelFile.writeAsStringSync(buffer.toString());
  print('✅ Barrel file generated at lib/common.dart');
}
