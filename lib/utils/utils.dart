class Utils{
  static String FormateType(int typeId) {
    if(typeId<10)
      return '0'+typeId.toString();
    else 
      return typeId.toString();     
  }
}