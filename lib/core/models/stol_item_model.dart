class SlotItem {
  String image;
  bool isWin;

  SlotItem(this.image, this.isWin);

  @override
  bool operator ==(Object other) =>
      other is SlotItem &&
      runtimeType == other.runtimeType &&
      image == other.image &&
      isWin == other.isWin;

  @override
  int get hashCode => image.hashCode ^ isWin.hashCode;
}
