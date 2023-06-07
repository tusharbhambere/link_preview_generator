import 'package:flutter/material.dart';

/// Small type LinkPreviewGenerator widget
class LinkViewSmall extends StatelessWidget {
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

  const LinkViewSmall({
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

        var titleFontSize = titleTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
        var descriptionTS = descriptionTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth) - 1,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            );
        var domainTS = domainTextStyle ??
            TextStyle(
              fontSize: computeTitleFontSize(layoutHeight) - 1,
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            );

        return Row(
          children: <Widget>[
            showGraphic
                ? Expanded(
                    flex: 2,
                    child: imageUri == ''
                        ? Container(color: bgColor ?? Colors.grey)
                        : Container(
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUri),
                                fit: isIcon ? BoxFit.contain : graphicFit,
                              ),
                              borderRadius: radius == 0
                                  ? BorderRadius.zero
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(radius!),
                                      bottomLeft: Radius.circular(radius!),
                                    ),
                            ),
                          ),
                  )
                : const SizedBox(width: 5),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    showTitle
                        ? _buildTitleContainer(
                            titleFontSize, computeTitleLines(layoutHeight))
                        : const SizedBox(),
                    showDomain
                        ? _buildDomainContainer(domainTS, 1)
                        : const SizedBox(),
                    showDescription
                        ? _buildDescriptionContainer(
                            descriptionTS,
                            descriptionTS,
                            computedescriptionLines(layoutHeight))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int computedescriptionLines(layoutHeight) {
    var lines = 1;
    if (layoutHeight > 60) {
      lines += (layoutHeight - 60.0) ~/ 30.0 as int;
    }
    lines += (showDomain ? 0 : 1) + (showTitle ? 0 : 1);
    return lines;
  }

  double computeTitleFontSize(double width) {
    var size = width * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight) {
    return layoutHeight >= 100 ? 2 : 1;
  }

  Widget _buildDescriptionContainer(
      TextStyle descriptionTS, TextStyle domainTS, maxLines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 3, 1),
      child: Column(
        children: <Widget>[
          Container(
            alignment: const Alignment(-1.0, -1.0),
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: descriptionTS,
              overflow: descriptionTextOverflow ?? TextOverflow.ellipsis,
              maxLines: descriptionMaxLines ?? maxLines,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleContainer(TextStyle titleTS, maxLines) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(4, 2, 3, showDomain || showDescription ? 0 : 2),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: titleTS,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainContainer(TextStyle domainTS, maxLines) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 2, 3, showDescription ? 0 : 2),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              domain,
              style: domainTS,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
            ),
          ],
        ),
      ),
    );
  }
}
