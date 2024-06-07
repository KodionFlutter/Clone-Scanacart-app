import 'package:flutter/material.dart';
import 'package:html_editor_enhanced_plus/html_editor.dart';

class HtmlEditorPage extends StatelessWidget {
  final HtmlEditorController htmlEditorController;

  const HtmlEditorPage({super.key, required this.htmlEditorController});

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: htmlEditorController,
      htmlToolbarOptions: HtmlToolbarOptions(
        allowImagePicking: true,
        toolbarItemHeight: 25,
        toolbarType: ToolbarType.nativeExpandable,
        toolbarPosition: ToolbarPosition.aboveEditor,
        //by default
        onButtonPressed:
            (ButtonType type, bool? status, Function? updateStatus) {
          print("button  pressed, the current selected status is $status");
          return true;
        },
        onDropdownChanged: (DropdownType type, dynamic changed,
            Function(dynamic)? updateSelectedItem) {
          print("dropdown  changed to $changed");
          return true;
        },
        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
          print(url);
          return true;
        },
      ),
      htmlEditorOptions: const HtmlEditorOptions(
          autoAdjustHeight: true,
          hint: "Your text here..",
          androidUseHybridComposition: true),
      otherOptions: OtherOptions(height: 370),
      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
        print('html before change is $currentHtml');
      }, onChangeContent: (String? changed) {
        print('content changed to $changed');
      }, onChangeCodeview: (String? changed) {
        print('code changed to $changed');
      }, onChangeSelection: (EditorSettings settings) {
        print('parent element is ${settings.parentElement}');
        print('font name is ${settings.fontName}');
      }, onDialogShown: () {
        print('dialog shown');
      }, onEnter: () {
        print('enter/return pressed');
      }, onFocus: () {
        print('editor focused');
      }, onBlur: () {
        print('editor unfocused');
      }, onBlurCodeview: () {
        print('codeview either focused or unfocused');
      }, onInit: () {
        print('init');
      }, onImageUploadError:
          (FileUpload? file, String? base64Str, UploadError error) {
        print(base64Str ?? '');
        if (file != null) {
          print(file.name);
          print(file.size);
          print(file.type);
        }
      }, onKeyDown: (int? keyCode) {
        print('$keyCode key downed');
        print(
            'current character count: ${htmlEditorController.characterCount}');
      }, onKeyUp: (int? keyCode) {
        print('$keyCode key released');
      }, onMouseDown: () {
        print('mouse downed');
      }, onMouseUp: () {
        print('mouse released');
      }, onNavigationRequestMobile: (String url) {
        print(url);
        return NavigationActionPolicy.ALLOW;
      }, onPaste: () {
        print('pasted into editor');
      }, onScroll: () {
        print('editor scrolled');
      }),
    );
  }
}