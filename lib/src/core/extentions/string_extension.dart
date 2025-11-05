extension StringExtension on String {

  String? canBeIntText({
    bool allowNegative = true,
    int? maxLength,
    String invalidNegativeMessage = "Invalid negative number",
    String containsNonIntegerMessage = "Must be an integer",
    String exceedMaxLengthMessage = "Exceed max length",
  }) {

    int? effectiveMaxLength(String value) {
      if (maxLength==null) {
        return null;
      }

      if (! allowNegative) {
        return maxLength;
      }

      if (value.isNotEmpty && value[0]=='-') {
        return maxLength+1;
      }

      return maxLength;
    }

    if (trim().length != length) {
      return containsNonIntegerMessage;
    }

    if(effectiveMaxLength(this)!=null && length > effectiveMaxLength(this)!){
      return exceedMaxLengthMessage;
    }

    for (var i = 0; i < length; i++) {
      if (i==0 && this[i]=='-') {
        if(!allowNegative) {
          return invalidNegativeMessage;
        }
        
        continue ;
      }

      if (int.tryParse(this[i])==null) {
        return containsNonIntegerMessage;
      }
    }
    return null;
  }

  String formatAsIntValue({
    bool allowNegative = true,
  }){
    String toReturn = this;
    
    if (! allowNegative) {
      toReturn = toReturn.replaceAll('-', '');
    }

    if(toReturn.isEmpty) {
      return toReturn;
    }
    
    for (var i = toReturn[0]=='-'? 1: 0; i < toReturn.length; i++) {
      if (int.tryParse(toReturn[i])==null) {
        toReturn = toReturn.replaceRange(i, i+1, '');
        i--;
      }
    }
    return toReturn;
  }

}