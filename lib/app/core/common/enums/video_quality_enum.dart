enum VideoQualityEnum {
  sd,
  hd,
  fullhd;

  String get name {
    switch (this) {
      case VideoQualityEnum.sd:
        return 'SD';
      case VideoQualityEnum.hd:
        return 'HD';
      case VideoQualityEnum.fullhd:
        return 'Full HD';
      default:
        return '';
    }
  }

  String get resolution {
    switch (this) {
      case VideoQualityEnum.sd:
        return '360';
      case VideoQualityEnum.hd:
        return '720';
      case VideoQualityEnum.fullhd:
        return '1080';
      default:
        return '';
    }
  }
}
