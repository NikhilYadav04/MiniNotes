import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes/model/product_model.dart';

class API{

  static const baseurl1 = "http://192.168.0.106/api/add";
  static const baseurl2 = "http://192.168.0.106/api/get";

  static add_product(Map data) async{

    var url1 = Uri.parse(baseurl1);
   

  try{
   final res = await http.post(url1,body: data);

   if(res.statusCode == 200)
   {
     var response = jsonDecode(res.body.toString());
     print(response);
   }
   else
   {
     print("Failed to receive data");
   }
  }catch(e)
  {
    print("Error is :${e}");
  }

    
  }

  static get_product() async{

    List<Note> note = [];
     var url2 = Uri.parse(baseurl2);

  try{

     final res = await http.get(url2);

     if(res.statusCode == 200)
     {
          var pdata= jsonDecode(res.body);
          //print(pdata);
          
          //  print(pdata['ndata']);
         pdata['ndata'].forEach(
           (value)=>{
            note.add(
              Note(data: value['data'], date: value['date'],
              
               id: (value['_id']))
            )
           }
         );
        // print(note);
         return note;
     }
     else
     {
       return [];
     }

  }catch(e)
  {
        print("error giving data $e");
  }

  }

  static update_product(id,Map data) async{

  var baseurl3 = "http://192.168.0.106/api/update/$id";
  var url3 = Uri.parse(baseurl3);
  

  try{
    final res = await http.put(url3,body: data);
    

    if(res.statusCode == 200)
    {
           var response = jsonDecode(res.body);
           print(response);
    }
    else
    {
       
            print("failed to update data");
    }
  }catch(e){
      print(" $e is Error");
  }



  }

  static delete(id) async{

    var baseurl4 = "http://192.168.0.106/api/delete/$id";
  var url4 = Uri.parse(baseurl4);

  final res = await http.delete(url4);

  if(res.statusCode == 200)
  {
    print("deleted sucess");
  }
  else
  {
    print("Failed to delete data");
  }

  }
}
