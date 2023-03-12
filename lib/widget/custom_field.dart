import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:MyMovie/color.dart';
import 'package:MyMovie/widget/shake_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:MyMovie/styles.dart' as style;

class TextFieldWidget extends StatefulWidget {
  final String title; //Label Field
  final String hintText; //Hint Text in Field
  final List<TextInputFormatter>? formatField; //Format Field
  final bool noticeField; //Logic for set Notice Field
  final String noticeText; //String for Notice Field
  final TextEditingController? cont; //Controller for Field
  final void Function(String?)? onSaved; //Func onSave in Field
  final String? Function(String?)? validator; //Validator for Field
  final TextInputType? keyboardType; //Format For Field
  final double? heightSpaceLabelAndField; //height for space Label to field
  final Function(String?)? onChanged; // set logic when onchange
  final bool obscureText; //Logic for set masking in Field
  final VoidCallback? logicIcon; //for Logic Icon
  final bool dropdownlist;
  final String image;
  final bool readonly;
  final double titleSize;
  final bool enable;
  const TextFieldWidget(
      {Key? key,
      required this.title,
      required this.hintText,
      this.obscureText = false,
      this.formatField,
      this.noticeField = false,
      this.noticeText = "",
      this.cont,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.heightSpaceLabelAndField = 5.0,
      this.onChanged,
      this.dropdownlist = false,
      this.image = "",
      this.logicIcon,
      this.readonly = false,
      this.enable = true,
      this.titleSize = 9})
      : super(key: key);
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    if (widget.logicIcon != null) {
      if (widget.dropdownlist == true) {
        if (widget.image == "") {
          return dropdownWithNoticeAndIcon(context);
        } else {
          return dropdownWithNoticeAndIconAndImage(context);
        }
      } else {
        return fieldWithNoticeAndIcon(context);
      }
    } else {
      if (widget.dropdownlist == true) {
        return dropdownWithNoticeAndIcon(context);
      } else {
        return fieldWithNotice(context);
      }
    }
  }

  void onfocus() {
    setState(() {
      _focus = !_focus;
    });
  }

  Widget fieldWithNotice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != "")
          Text(
            widget.title,
            style: style.fontMon.copyWith(
              fontSize: widget.titleSize.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (widget.title != "")
          SizedBox(
            height: widget.heightSpaceLabelAndField,
          ),
        Focus(
          onFocusChange: (focus) => onfocus(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.noticeField == true
                    ? Colors.red
                    : _focus == true
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    readOnly: widget.readonly,
                    onChanged: widget.onChanged,
                    style: style.fieldText.copyWith(
                      fontSize: 12.sp,
                    ),
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.formatField,
                    controller: widget.cont,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: style.hintText.copyWith(
                        fontSize: 12.sp,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      isDense: true,
                      errorBorder: InputBorder.none,
                      errorStyle: const TextStyle(fontSize: 0, height: 0),
                    ),
                    validator: widget.validator,
                    onSaved: widget.onSaved,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.noticeField)
          const SizedBox(
            height: 1.5,
          ),
        if (widget.noticeField)
          SizedBox(
            child: Align(
                alignment: Alignment.centerLeft,
                child: ShakeWidget(
                    child: Text(
                  widget.noticeText,
                  textAlign: TextAlign.left,
                  style: style.validasiText.copyWith(
                    fontSize: 10.sp,
                  ),
                ))),
          ),
      ],
    );
  }

  Widget fieldWithNoticeAndIcon(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: style.fontMon.copyWith(
              fontSize: widget.titleSize.sp,
              fontWeight: FontWeight.w500,
            ),
        ),
        SizedBox(
          height: widget.heightSpaceLabelAndField,
        ),
        Focus(
          onFocusChange: (focus) => onfocus(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.noticeField == true
                    ? Colors.red
                    : _focus == true
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    readOnly: widget.readonly,
                    style: style.fieldText.copyWith(
                      fontSize: 12.sp,
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: widget.obscureText,
                    controller: widget.cont,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: style.hintText.copyWith(
                        fontSize: 12.sp,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      isDense: true,
                      errorBorder: InputBorder.none,
                      errorStyle: const TextStyle(fontSize: 0, height: 0),
                    ),
                    validator: widget.validator,
                    onSaved: widget.onSaved,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: widget.logicIcon,
                    child: Icon(
                      widget.obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.noticeField)
          const SizedBox(
            height: 1.5,
          ),
        if (widget.noticeField)
          Align(
              alignment: Alignment.centerLeft,
              child: ShakeWidget(
                child: Text(
                  widget.noticeText,
                  textAlign: TextAlign.left,
                  style: style.validasiText.copyWith(
                    fontSize: 10.sp,
                  ),
                ),
              )),
      ],
    );
  }

  Widget dropdownWithNoticeAndIcon(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: style.fontMon.copyWith(
              fontSize: widget.titleSize.sp,
              fontWeight: FontWeight.w500,
            ),
        ),
        SizedBox(
          height: widget.heightSpaceLabelAndField,
        ),
        Focus(
          onFocusChange: (focus) => onfocus(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.noticeField == true
                    ? Colors.red
                    : _focus == true
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    style: style.fieldText.copyWith(
                      fontSize: 12.sp,
                    ),
                    onTap: widget.logicIcon,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    enabled: widget.enable,
                    obscureText: widget.obscureText,
                    controller: widget.cont,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: style.hintText.copyWith(
                        fontSize: 12.sp,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      isDense: true,
                      errorBorder: InputBorder.none,
                      errorStyle: const TextStyle(fontSize: 0, height: 0),
                    ),
                    validator: widget.validator,
                    onSaved: widget.onSaved,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: widget.logicIcon,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.noticeField)
          const SizedBox(
            height: 1.5,
          ),
        if (widget.noticeField)
          Align(
              alignment: Alignment.centerLeft,
              child: ShakeWidget(
                child: Text(
                  widget.noticeText,
                  textAlign: TextAlign.left,
                  style: style.validasiText.copyWith(
                    fontSize: 10.sp,
                  ),
                ),
              )),
      ],
    );
  }

  Widget dropdownWithNoticeAndIconAndImage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: style.fontMon.copyWith(
              fontSize: widget.titleSize.sp,
              fontWeight: FontWeight.w500,
            ),
        ),
        SizedBox(
          height: widget.heightSpaceLabelAndField,
        ),
        Focus(
          onFocusChange: (focus) => onfocus(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.noticeField == true
                    ? Colors.red
                    : _focus == true
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    height: 3.h,
                    width: 9.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2), //or 15.0
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: style.fieldText.copyWith(
                      fontSize: 12.sp,
                    ),
                    onTap: widget.logicIcon,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    enabled: widget.enable,
                    obscureText: widget.obscureText,
                    controller: widget.cont,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: style.hintText.copyWith(
                        fontSize: 12.sp,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      isDense: true,
                      errorBorder: InputBorder.none,
                      errorStyle: const TextStyle(fontSize: 0, height: 0),
                    ),
                    validator: widget.validator,
                    onSaved: widget.onSaved,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: widget.logicIcon,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.noticeField)
          const SizedBox(
            height: 1.5,
          ),
        if (widget.noticeField)
          Align(
              alignment: Alignment.centerLeft,
              child: ShakeWidget(
                child: Text(
                  widget.noticeText,
                  textAlign: TextAlign.left,
                  style: style.validasiText.copyWith(
                    fontSize: 10.sp,
                  ),
                ),
              )),
      ],
    );
  }
}
