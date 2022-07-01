class AppPathModel {
  final bool? isUnknown;
  final bool? isRoot;

  String? path;

  AppPathModel remove() {
    path = path!.substring(0, path!.lastIndexOf('/'));
    return AppPathModel(path: path, isRoot: isRoot, isUnknown: isUnknown);
  }

  AppPathModel({
    this.path,
    this.isUnknown = false,
    this.isRoot = false,
  });
}
