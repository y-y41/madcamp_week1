class Imagedata{
  int? imagenum;
  String? imagename;
  String? imagedate;
  String? imageurl;
  String? imageloc;

  Imagedata({
    this.imagenum,
    this.imagename,
    this.imagedate,
    this.imageurl,
    this.imageloc,
});
  Imagedata.fromJson(Map<String,dynamic> json){
    imagenum=int.parse(json['imagenum']);
    imagename=json['imagename'];
    imagedate=json['imagedate'];
    imageurl=json['imageurl'];
    imageloc=json['imageloc'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data={};
    data['imagenum']=imagenum;
    data['imagename']=imagename;
    data['imagedate']=imagedate;
    data['imageurl']=imageurl;
    data['imageloc']=imageloc;
    return data;
  }
}