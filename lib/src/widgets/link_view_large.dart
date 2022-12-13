import 'package:flutter/material.dart';

/// Large type LinkPreviewGenerator widget
class LinkViewLarge extends StatelessWidget {
  final Color? bgColor;
  final int? descriptionMaxLines;
  final TextOverflow? descriptionTextOverflow;
  final TextStyle? descriptionTextStyle;
  final String description;
  final String domain;
  final TextStyle? domainTextStyle;
  final String imageUri;
  final bool isIcon;
  final double? radius;
  final bool showDescription;
  final bool showDomain;
  final bool showGraphic;
  final bool showTitle;
  final BoxFit graphicFit;
  final String title;
  final TextStyle? titleTextStyle;
  final String url;

  const LinkViewLarge({
    Key? key,
    required this.url,
    required this.domain,
    required this.title,
    required this.description,
    required this.imageUri,
    required this.graphicFit,
    required this.showDescription,
    required this.showDomain,
    required this.showGraphic,
    required this.showTitle,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.domainTextStyle,
    this.descriptionTextOverflow,
    this.descriptionMaxLines,
    this.isIcon = false,
    this.bgColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var layoutWidth = constraints.biggest.width;
        var layoutHeight = constraints.biggest.height;

        var _titleTS = titleTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutHeight),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
        var _descriptionTS = descriptionTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutHeight) - 1,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            );
        var _domainTS = domainTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutHeight) - 1,
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            );

        return Column(
          children: <Widget>[
            showGraphic
                ? Expanded(
                    flex: 3,
                    child: imageUri == ''
                        ? Container(color: bgColor ?? Colors.grey)
                        : Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: radius == 0
                                  ? BorderRadius.zero
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                              image: DecorationImage(
                                image: NetworkImage(imageUri),
                                fit: isIcon ? BoxFit.contain : graphicFit,
                              ),
                            ),
                          ),
                  )
                : const SizedBox(height: 5),
            showTitle
                ? _buildTitleContainer(
                    _titleTS, computeTitleLines(layoutHeight, layoutWidth))
                : const SizedBox(),
            showDomain
                ? _buildDomainContainer(
                    _domainTS, computeTitleLines(layoutHeight, layoutWidth))
                : const SizedBox(),
            showDescription
                ? _buildDescriptionContainer(_descriptionTS, _domainTS,
                    computeDescriptionLines(layoutHeight))
                : const SizedBox(),
          ],
        );
      },
    );
  }

  int? computeDescriptionLines(layoutHeight) {
    var lines = layoutHeight ~/ 90 == 0 ? 1 : layoutHeight ~/ 90;
    lines += showDomain ? 0 : 1;
    return lines;
  }

  double computeTitleFontSize(double height) {
    var size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight, layoutWidth) {
    return layoutHeight - layoutWidth < 50 ? 1 : 2;
  }

  Widget _buildDescriptionContainer(
      TextStyle _descriptionTS, TextStyle _domainTS, _maxLines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              description,
              style: _descriptionTS,
              overflow: descriptionTextOverflow ?? TextOverflow.ellipsis,
              maxLines: descriptionMaxLines ?? _maxLines,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContainer(TextStyle _titleTS, _maxLines) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(10, 5, 5, showDomain || showDescription ? 0 : 5),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: _titleTS,
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainContainer(TextStyle _domainTS, _maxLines) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 5, showDescription ? 0 : 5),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              domain,
              style: _domainTS,
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines,
            ),
          ],
        ),
      ),
    );
  }
}
