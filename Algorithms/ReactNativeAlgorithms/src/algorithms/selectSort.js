export default function selectSort(list) {
  for(var i = 0; i < list.length - 1; i++) {
    var min_el_pos = i;
    for(var j = min_el_pos + 1; j < list.length; j++) {
      if(list[j] < list[min_el_pos]) {
        min_el_pos = j;
      }
    }
    // swap
    var temp = list[i];
    list[i] = list[min_el_pos];
    list[min_el_pos] = temp;
  }
  return list;
}