import 'package:seller_finalproject/const/const.dart';
import 'package:seller_finalproject/views/widgets/text_style.dart';

Widget ourButton({title, color = primaryApp, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          // ignore: deprecated_member_use
          padding: const EdgeInsets.all(12.0)),
      onPressed: onPress,
      child: normalText(text: title, size: 16.0));
}
