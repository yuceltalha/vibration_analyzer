import "dart:math";

sMehanic(List<int> liste) {
  if (liste.length > 3) {
    for (var i = 2; i < liste.length; i++) {
      if (liste[i] >= liste[i - 1] && liste[i - 1] >= liste[i - 2]) {
        liste.removeAt(i - 1);
      } else if (liste[i] < liste[i - 1] && liste[i - 1] < liste[i - 2]) {
        liste.removeAt(i - 1);
      }
    }
  }
  print(liste.length.toString());
  return liste;
}

kri(List a) {
  List b = [a.first];
  for(int i = 1; i< a.length-1;i++){
    if(a[i - 1] <= a[i] && a[i] >= a[i + 1]){
      b.add(a[i]);
    }
    else if(a[i - 1] >= a[i] && a[i] <= a[i + 1]){
      b.add(a[i]);
    }
  }
  b.add(a.last);
  return b;
}

vol2(List a){
  List b =[];
  bool inc =true;
  for(int i = 1; i< a.length-1;i++){
    if(a[i-1]<a[i] && a[i]<a[i+1]){
      if(inc){
        b.add(a[i]);
      }
     inc = false; 
    }
    else if(a[i-1]>a[i] && a[i]>a[i+1]){
      if(!inc){
        b.add(a[i]);
      }
      inc = true;
    }
    
  }
  return b;
}

vol3(List a){
  List b =[];
  bool inc =true;
  for(int i = 1; i< a.length-1;i++){
    if(a[i-1]<a[i]){
      if(a[i]<a[i+1]){
        
      }   
    }
  }
}



void main() {
  List<int> empt = [];
  for (var i = 0; i < 40; i++) {
    empt.add(Random().nextInt(10));
  }
  print(empt);
  print(kri(empt));
}
