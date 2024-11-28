part of 'system_manager.dart';

class _SystemMethod {
  static void directoryList(String dir, SendPort sendPort) async {
    Stream<FileSystemEntity> stream = Directory(dir).list();
    List<SystemFileEntity> files = [];
    var ext = p.extension(dir).split('.').last;
    SystemFileEntity fileEntity = SystemFileEntity(
      name: p.basename(dir),
      path: dir,
      type: SystemFileEntityType.folder,
      ext: ext,
      fileType: SystemFileType.fromExtension(ext),
      children: files,
    );

    await for (FileSystemEntity entity in stream) {
      if (entity is File) {
        var ext = p.extension(entity.path).split('.').last;
        files.add(
          SystemFileEntity(
            name: p.basename(entity.path),
            path: entity.path,
            type: SystemFileEntityType.file,
            ext: ext,
            fileType: SystemFileType.fromExtension(ext),
            children: [],
          ),
        );
      } else if (entity is Directory) {
        List<FileSystemEntity> list = Directory(entity.path).listSync();
        List<SystemFileEntity> children = [];
        List<SystemFileEntity> preview = [];

        for (var item in list) {
          var ext = p.extension(item.path).split('.').last;
          if (item is File) {
            var entity = SystemFileEntity(
              name: p.basename(item.path),
              path: item.path,
              type: SystemFileEntityType.file,
              ext: ext,
              fileType: SystemFileType.fromExtension(ext),
              children: [],
            );
            children.add(entity);
            if (preview.length < 5 && ['jpeg', 'jpg', 'png', 'gif'].contains(entity.ext)) {
              preview.add(entity);
            }
          } else if (item is Directory) {
            children.add(
              SystemFileEntity(
                name: p.basename(item.path),
                path: item.path,
                type: SystemFileEntityType.folder,
                ext: ext,
                fileType: SystemFileType.fromExtension(ext),
                children: [],
              ),
            );
          }
        }
        var ext = p.extension(entity.path).split('.').last;
        files.add(
          SystemFileEntity(
            name: p.basename(entity.path),
            path: entity.path,
            type: SystemFileEntityType.folder,
            ext: ext,
            fileType: SystemFileType.fromExtension(ext),
            children: children,
            preview: preview,
          ),
        );
      }
      fileEntity.children = files;
      sendPort.send(_SystemMethodModel(_SystemAction.readerDirectory, fileEntity));
    }
  }
}
