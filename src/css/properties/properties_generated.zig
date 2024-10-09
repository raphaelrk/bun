const std = @import("std");
const bun = @import("root").bun;
const Allocator = std.mem.Allocator;

pub const css = @import("../css_parser.zig");

const Printer = css.Printer;
const PrintErr = css.PrintErr;
const VendorPrefix = css.VendorPrefix;

const PropertyImpl = @import("./properties_impl.zig").PropertyImpl;
const PropertyIdImpl = @import("./properties_impl.zig").PropertyIdImpl;

const CSSWideKeyword = css.css_properties.CSSWideKeyword;
const UnparsedProperty = css.css_properties.custom.UnparsedProperty;
const CustomProperty = css.css_properties.custom.CustomProperty;

const css_values = css.css_values;
const CssColor = css.css_values.color.CssColor;
const Image = css.css_values.image.Image;
const Length = css.css_values.length.Length;
const LengthValue = css.css_values.length.LengthValue;
const LengthPercentage = css_values.length.LengthPercentage;
const LengthPercentageOrAuto = css_values.length.LengthPercentageOrAuto;
const PropertyCategory = css.PropertyCategory;
const LogicalGroup = css.LogicalGroup;
const CSSNumber = css.css_values.number.CSSNumber;
const CSSInteger = css.css_values.number.CSSInteger;
const NumberOrPercentage = css.css_values.percentage.NumberOrPercentage;
const Percentage = css.css_values.percentage.Percentage;
const Angle = css.css_values.angle.Angle;
const DashedIdentReference = css.css_values.ident.DashedIdentReference;
const Time = css.css_values.time.Time;
const EasingFunction = css.css_values.easing.EasingFunction;
const CustomIdent = css.css_values.ident.CustomIdent;
const CSSString = css.css_values.string.CSSString;
const DashedIdent = css.css_values.ident.DashedIdent;
const Url = css.css_values.url.Url;
const CustomIdentList = css.css_values.ident.CustomIdentList;
const Location = css.Location;
const HorizontalPosition = css.css_values.position.HorizontalPosition;
const VerticalPosition = css.css_values.position.VerticalPosition;
const ContainerName = css.css_rules.container.ContainerName;

pub const font = css.css_properties.font;
const border = css.css_properties.border;
const border_radius = css.css_properties.border_radius;
const border_image = css.css_properties.border_image;
const outline = css.css_properties.outline;
const flex = css.css_properties.flex;
const @"align" = css.css_properties.@"align";
const margin_padding = css.css_properties.margin_padding;
const transition = css.css_properties.transition;
const animation = css.css_properties.animation;
const transform = css.css_properties.transform;
const text = css.css_properties.text;
const ui = css.css_properties.ui;
const list = css.css_properties.list;
const css_modules = css.css_properties.css_modules;
const svg = css.css_properties.svg;
const shape = css.css_properties.shape;
const masking = css.css_properties.masking;
const background = css.css_properties.background;
const effects = css.css_properties.effects;
const contain = css.css_properties.contain;
const custom = css.css_properties.custom;
const position = css.css_properties.position;
const box_shadow = css.css_properties.box_shadow;
const size = css.css_properties.size;
const overflow = css.css_properties.overflow;

const BorderSideWidth = border.BorderSideWidth;
const Size2D = css_values.size.Size2D;
const BorderRadius = border_radius.BorderRadius;
const Rect = css_values.rect.Rect;
const LengthOrNumber = css_values.length.LengthOrNumber;
const BorderImageRepeat = border_image.BorderImageRepeat;
const BorderImageSideWidth = border_image.BorderImageSideWidth;
const BorderImageSlice = border_image.BorderImageSlice;
const BorderImage = border_image.BorderImage;
const BorderColor = border.BorderColor;
const BorderStyle = border.BorderStyle;
const BorderWidth = border.BorderWidth;
const BorderBlockColor = border.BorderBlockColor;
const BorderBlockStyle = border.BorderBlockStyle;
const BorderBlockWidth = border.BorderBlockWidth;
const BorderInlineColor = border.BorderInlineColor;
const BorderInlineStyle = border.BorderInlineStyle;
const BorderInlineWidth = border.BorderInlineWidth;
const Border = border.Border;
const BorderTop = border.BorderTop;
const BorderRight = border.BorderRight;
const BorderLeft = border.BorderLeft;
const BorderBottom = border.BorderBottom;
const BorderBlockStart = border.BorderBlockStart;
const BorderBlockEnd = border.BorderBlockEnd;
const BorderInlineStart = border.BorderInlineStart;
const BorderInlineEnd = border.BorderInlineEnd;
const BorderBlock = border.BorderBlock;
const BorderInline = border.BorderInline;
const Outline = outline.Outline;
// const OutlineStyle = outline.OutlineStyle;
// const FlexDirection = flex.FlexDirection;
// const FlexWrap = flex.FlexWrap;
// const FlexFlow = flex.FlexFlow;
// const Flex = flex.Flex;
// const BoxOrient = flex.BoxOrient;
// const BoxDirection = flex.BoxDirection;
// const BoxAlign = flex.BoxAlign;
// const BoxPack = flex.BoxPack;
// const BoxLines = flex.BoxLines;
// const FlexPack = flex.FlexPack;
// const FlexItemAlign = flex.FlexItemAlign;
// const FlexLinePack = flex.FlexLinePack;
// const AlignContent = @"align".AlignContent;
// const JustifyContent = @"align".JustifyContent;
// const PlaceContent = @"align".PlaceContent;
// const AlignSelf = @"align".AlignSelf;
// const JustifySelf = @"align".JustifySelf;
// const PlaceSelf = @"align".PlaceSelf;
// const AlignItems = @"align".AlignItems;
// const JustifyItems = @"align".JustifyItems;
// const PlaceItems = @"align".PlaceItems;
// const GapValue = @"align".GapValue;
// const Gap = @"align".Gap;
// const MarginBlock = margin_padding.MarginBlock;
// const Margin = margin_padding.Margin;
// const MarginInline = margin_padding.MarginInline;
// const PaddingBlock = margin_padding.PaddingBlock;
// const PaddingInline = margin_padding.PaddingInline;
// const Padding = margin_padding.Padding;
// const ScrollMarginBlock = margin_padding.ScrollMarginBlock;
// const ScrollMarginInline = margin_padding.ScrollMarginInline;
// const ScrollMargin = margin_padding.ScrollMargin;
// const ScrollPaddingBlock = margin_padding.ScrollPaddingBlock;
// const ScrollPaddingInline = margin_padding.ScrollPaddingInline;
// const ScrollPadding = margin_padding.ScrollPadding;
// const FontWeight = font.FontWeight;
// const FontSize = font.FontSize;
// const FontStretch = font.FontStretch;
// const FontFamily = font.FontFamily;
// const FontStyle = font.FontStyle;
// const FontVariantCaps = font.FontVariantCaps;
// const LineHeight = font.LineHeight;
// const Font = font.Font;
// const VerticalAlign = font.VerticalAlign;
// const Transition = transition.Transition;
// const AnimationNameList = animation.AnimationNameList;
// const AnimationList = animation.AnimationList;
// const AnimationIterationCount = animation.AnimationIterationCount;
// const AnimationDirection = animation.AnimationDirection;
// const AnimationPlayState = animation.AnimationPlayState;
// const AnimationFillMode = animation.AnimationFillMode;
// const AnimationComposition = animation.AnimationComposition;
// const AnimationTimeline = animation.AnimationTimeline;
// const AnimationRangeStart = animation.AnimationRangeStart;
// const AnimationRangeEnd = animation.AnimationRangeEnd;
// const AnimationRange = animation.AnimationRange;
// const TransformList = transform.TransformList;
// const TransformStyle = transform.TransformStyle;
// const TransformBox = transform.TransformBox;
// const BackfaceVisibility = transform.BackfaceVisibility;
// const Perspective = transform.Perspective;
// const Translate = transform.Translate;
// const Rotate = transform.Rotate;
// const Scale = transform.Scale;
// const TextTransform = text.TextTransform;
// const WhiteSpace = text.WhiteSpace;
// const WordBreak = text.WordBreak;
// const LineBreak = text.LineBreak;
// const Hyphens = text.Hyphens;
// const OverflowWrap = text.OverflowWrap;
// const TextAlign = text.TextAlign;
// const TextIndent = text.TextIndent;
// const Spacing = text.Spacing;
// const TextJustify = text.TextJustify;
// const TextAlignLast = text.TextAlignLast;
// const TextDecorationLine = text.TextDecorationLine;
// const TextDecorationStyle = text.TextDecorationStyle;
// const TextDecorationThickness = text.TextDecorationThickness;
// const TextDecoration = text.TextDecoration;
// const TextDecorationSkipInk = text.TextDecorationSkipInk;
// const TextEmphasisStyle = text.TextEmphasisStyle;
// const TextEmphasis = text.TextEmphasis;
// const TextEmphasisPositionVertical = text.TextEmphasisPositionVertical;
// const TextEmphasisPositionHorizontal = text.TextEmphasisPositionHorizontal;
// const TextEmphasisPosition = text.TextEmphasisPosition;
// const TextShadow = text.TextShadow;
// const TextSizeAdjust = text.TextSizeAdjust;
const Direction = text.Direction;
// const UnicodeBidi = text.UnicodeBidi;
// const BoxDecorationBreak = text.BoxDecorationBreak;
// const Resize = ui.Resize;
// const Cursor = ui.Cursor;
// const ColorOrAuto = ui.ColorOrAuto;
// const CaretShape = ui.CaretShape;
// const Caret = ui.Caret;
// const UserSelect = ui.UserSelect;
// const Appearance = ui.Appearance;
// const ColorScheme = ui.ColorScheme;
// const ListStyleType = list.ListStyleType;
// const ListStylePosition = list.ListStylePosition;
// const ListStyle = list.ListStyle;
// const MarkerSide = list.MarkerSide;
const Composes = css_modules.Composes;
// const SVGPaint = svg.SVGPaint;
// const FillRule = shape.FillRule;
// const AlphaValue = shape.AlphaValue;
// const StrokeLinecap = svg.StrokeLinecap;
// const StrokeLinejoin = svg.StrokeLinejoin;
// const StrokeDasharray = svg.StrokeDasharray;
// const Marker = svg.Marker;
// const ColorInterpolation = svg.ColorInterpolation;
// const ColorRendering = svg.ColorRendering;
// const ShapeRendering = svg.ShapeRendering;
// const TextRendering = svg.TextRendering;
// const ImageRendering = svg.ImageRendering;
// const ClipPath = masking.ClipPath;
// const MaskMode = masking.MaskMode;
// const MaskClip = masking.MaskClip;
// const GeometryBox = masking.GeometryBox;
// const MaskComposite = masking.MaskComposite;
// const MaskType = masking.MaskType;
// const Mask = masking.Mask;
// const MaskBorderMode = masking.MaskBorderMode;
// const MaskBorder = masking.MaskBorder;
// const WebKitMaskComposite = masking.WebKitMaskComposite;
// const WebKitMaskSourceType = masking.WebKitMaskSourceType;
// const BackgroundRepeat = background.BackgroundRepeat;
// const BackgroundSize = background.BackgroundSize;
// const FilterList = effects.FilterList;
// const ContainerType = contain.ContainerType;
// const Container = contain.Container;
// const ContainerNameList = contain.ContainerNameList;
const CustomPropertyName = custom.CustomPropertyName;
const display = css.css_properties.display;

const Position = position.Position;

const Result = css.Result;

const ArrayList = std.ArrayListUnmanaged;
const SmallList = css.SmallList;
pub const Property = union(PropertyIdTag) {
    @"background-color": CssColor,
    @"background-image": SmallList(Image, 1),
    @"background-position-x": SmallList(css_values.position.HorizontalPosition, 1),
    @"background-position-y": SmallList(css_values.position.HorizontalPosition, 1),
    @"background-position": SmallList(background.BackgroundPosition, 1),
    @"background-size": SmallList(background.BackgroundSize, 1),
    @"background-repeat": SmallList(background.BackgroundSize, 1),
    @"background-attachment": SmallList(background.BackgroundAttachment, 1),
    @"background-clip": struct { SmallList(background.BackgroundAttachment, 1), VendorPrefix },
    @"background-origin": SmallList(background.BackgroundOrigin, 1),
    background: SmallList(background.Background, 1),
    @"box-shadow": struct { SmallList(box_shadow.BoxShadow, 1), VendorPrefix },
    opacity: css.css_values.alpha.AlphaValue,
    color: CssColor,
    display: display.Display,
    visibility: display.Visibility,
    width: size.Size,
    height: size.Size,
    @"min-width": size.Size,
    @"min-height": size.Size,
    @"max-width": size.MaxSize,
    @"max-height": size.MaxSize,
    @"block-size": size.Size,
    @"inline-size": size.Size,
    @"min-block-size": size.Size,
    @"min-inline-size": size.Size,
    @"max-block-size": size.MaxSize,
    @"max-inline-size": size.MaxSize,
    @"box-sizing": struct { size.BoxSizing, VendorPrefix },
    @"aspect-ratio": size.AspectRatio,
    overflow: overflow.Overflow,
    @"overflow-x": overflow.OverflowKeyword,
    @"overflow-y": overflow.OverflowKeyword,
    @"text-overflow": struct { overflow.TextOverflow, VendorPrefix },
    position: position.Position,
    top: LengthPercentageOrAuto,
    bottom: LengthPercentageOrAuto,
    left: LengthPercentageOrAuto,
    right: LengthPercentageOrAuto,
    @"inset-block-start": LengthPercentageOrAuto,
    @"inset-block-end": LengthPercentageOrAuto,
    @"inset-inline-start": LengthPercentageOrAuto,
    @"inset-inline-end": LengthPercentageOrAuto,
    @"inset-block": margin_padding.InsetBlock,
    @"inset-inline": margin_padding.InsetInline,
    inset: margin_padding.Inset,
    @"border-spacing": css.css_values.size.Size2D(Length),
    @"border-top-color": CssColor,
    @"border-bottom-color": CssColor,
    @"border-left-color": CssColor,
    @"border-right-color": CssColor,
    @"border-block-start-color": CssColor,
    @"border-block-end-color": CssColor,
    @"border-inline-start-color": CssColor,
    @"border-inline-end-color": CssColor,
    @"border-top-style": border.LineStyle,
    @"border-bottom-style": border.LineStyle,
    @"border-left-style": border.LineStyle,
    @"border-right-style": border.LineStyle,
    @"border-block-start-style": border.LineStyle,
    @"border-block-end-style": border.LineStyle,
    @"border-inline-start-style": border.LineStyle,
    @"border-inline-end-style": border.LineStyle,
    @"border-top-width": BorderSideWidth,
    @"border-bottom-width": BorderSideWidth,
    @"border-left-width": BorderSideWidth,
    @"border-right-width": BorderSideWidth,
    @"border-block-start-width": BorderSideWidth,
    @"border-block-end-width": BorderSideWidth,
    @"border-inline-start-width": BorderSideWidth,
    @"border-inline-end-width": BorderSideWidth,
    @"border-top-left-radius": struct { Size2D(LengthPercentage), VendorPrefix },
    @"border-top-right-radius": struct { Size2D(LengthPercentage), VendorPrefix },
    @"border-bottom-left-radius": struct { Size2D(LengthPercentage), VendorPrefix },
    @"border-bottom-right-radius": struct { Size2D(LengthPercentage), VendorPrefix },
    @"border-start-start-radius": Size2D(LengthPercentage),
    @"border-start-end-radius": Size2D(LengthPercentage),
    @"border-end-start-radius": Size2D(LengthPercentage),
    @"border-end-end-radius": Size2D(LengthPercentage),
    @"border-radius": struct { BorderRadius, VendorPrefix },
    @"border-image-source": Image,
    @"border-image-outset": Rect(LengthOrNumber),
    @"border-image-repeat": BorderImageRepeat,
    @"border-image-width": Rect(BorderImageSideWidth),
    @"border-image-slice": BorderImageSlice,
    @"border-image": struct { BorderImage, VendorPrefix },
    @"border-color": BorderColor,
    @"border-style": BorderStyle,
    @"border-width": BorderWidth,
    @"border-block-color": BorderBlockColor,
    @"border-block-style": BorderBlockStyle,
    @"border-block-width": BorderBlockWidth,
    @"border-inline-color": BorderInlineColor,
    @"border-inline-style": BorderInlineStyle,
    @"border-inline-width": BorderInlineWidth,
    border: Border,
    @"border-top": BorderTop,
    @"border-bottom": BorderBottom,
    @"border-left": BorderLeft,
    @"border-right": BorderRight,
    @"border-block": BorderBlock,
    @"border-block-start": BorderBlockStart,
    @"border-block-end": BorderBlockEnd,
    @"border-inline": BorderInline,
    @"border-inline-start": BorderInlineStart,
    @"border-inline-end": BorderInlineEnd,
    outline: Outline,
    @"outline-color": CssColor,
    @"text-decoration-color": struct { CssColor, VendorPrefix },
    @"text-emphasis-color": struct { CssColor, VendorPrefix },
    direction: Direction,
    composes: Composes,
    all: CSSWideKeyword,
    unparsed: UnparsedProperty,
    custom: CustomProperty,

    pub usingnamespace PropertyImpl();

    // SANITY CHECK!
    comptime {
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(Image, 1), "deepClone")) {
            @compileError("SmallList(Image, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(css_values.position.HorizontalPosition, 1), "deepClone")) {
            @compileError("SmallList(css_values.position.HorizontalPosition, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(css_values.position.HorizontalPosition, 1), "deepClone")) {
            @compileError("SmallList(css_values.position.HorizontalPosition, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundPosition, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundPosition, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundSize, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundSize, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundSize, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundSize, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundAttachment, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundAttachment, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundAttachment, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundAttachment, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.BackgroundOrigin, 1), "deepClone")) {
            @compileError("SmallList(background.BackgroundOrigin, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(background.Background, 1), "deepClone")) {
            @compileError("SmallList(background.Background, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(SmallList(box_shadow.BoxShadow, 1), "deepClone")) {
            @compileError("SmallList(box_shadow.BoxShadow, 1): does not have a deepClone() function.");
        }
        if (!@hasDecl(css.css_values.alpha.AlphaValue, "deepClone")) {
            @compileError("css.css_values.alpha.AlphaValue: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(display.Display, "deepClone")) {
            @compileError("display.Display: does not have a deepClone() function.");
        }
        if (!@hasDecl(display.Visibility, "deepClone")) {
            @compileError("display.Visibility: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.MaxSize, "deepClone")) {
            @compileError("size.MaxSize: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.MaxSize, "deepClone")) {
            @compileError("size.MaxSize: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.Size, "deepClone")) {
            @compileError("size.Size: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.MaxSize, "deepClone")) {
            @compileError("size.MaxSize: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.MaxSize, "deepClone")) {
            @compileError("size.MaxSize: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.BoxSizing, "deepClone")) {
            @compileError("size.BoxSizing: does not have a deepClone() function.");
        }
        if (!@hasDecl(size.AspectRatio, "deepClone")) {
            @compileError("size.AspectRatio: does not have a deepClone() function.");
        }
        if (!@hasDecl(overflow.Overflow, "deepClone")) {
            @compileError("overflow.Overflow: does not have a deepClone() function.");
        }
        if (!@hasDecl(overflow.OverflowKeyword, "deepClone")) {
            @compileError("overflow.OverflowKeyword: does not have a deepClone() function.");
        }
        if (!@hasDecl(overflow.OverflowKeyword, "deepClone")) {
            @compileError("overflow.OverflowKeyword: does not have a deepClone() function.");
        }
        if (!@hasDecl(overflow.TextOverflow, "deepClone")) {
            @compileError("overflow.TextOverflow: does not have a deepClone() function.");
        }
        if (!@hasDecl(position.Position, "deepClone")) {
            @compileError("position.Position: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(LengthPercentageOrAuto, "deepClone")) {
            @compileError("LengthPercentageOrAuto: does not have a deepClone() function.");
        }
        if (!@hasDecl(margin_padding.InsetBlock, "deepClone")) {
            @compileError("margin_padding.InsetBlock: does not have a deepClone() function.");
        }
        if (!@hasDecl(margin_padding.InsetInline, "deepClone")) {
            @compileError("margin_padding.InsetInline: does not have a deepClone() function.");
        }
        if (!@hasDecl(margin_padding.Inset, "deepClone")) {
            @compileError("margin_padding.Inset: does not have a deepClone() function.");
        }
        if (!@hasDecl(css.css_values.size.Size2D(Length), "deepClone")) {
            @compileError("css.css_values.size.Size2D(Length): does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(border.LineStyle, "deepClone")) {
            @compileError("border.LineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderSideWidth, "deepClone")) {
            @compileError("BorderSideWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(Size2D(LengthPercentage), "deepClone")) {
            @compileError("Size2D(LengthPercentage): does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderRadius, "deepClone")) {
            @compileError("BorderRadius: does not have a deepClone() function.");
        }
        if (!@hasDecl(Image, "deepClone")) {
            @compileError("Image: does not have a deepClone() function.");
        }
        if (!@hasDecl(Rect(LengthOrNumber), "deepClone")) {
            @compileError("Rect(LengthOrNumber): does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderImageRepeat, "deepClone")) {
            @compileError("BorderImageRepeat: does not have a deepClone() function.");
        }
        if (!@hasDecl(Rect(BorderImageSideWidth), "deepClone")) {
            @compileError("Rect(BorderImageSideWidth): does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderImageSlice, "deepClone")) {
            @compileError("BorderImageSlice: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderImage, "deepClone")) {
            @compileError("BorderImage: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderColor, "deepClone")) {
            @compileError("BorderColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderStyle, "deepClone")) {
            @compileError("BorderStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderWidth, "deepClone")) {
            @compileError("BorderWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlockColor, "deepClone")) {
            @compileError("BorderBlockColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlockStyle, "deepClone")) {
            @compileError("BorderBlockStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlockWidth, "deepClone")) {
            @compileError("BorderBlockWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInlineColor, "deepClone")) {
            @compileError("BorderInlineColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInlineStyle, "deepClone")) {
            @compileError("BorderInlineStyle: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInlineWidth, "deepClone")) {
            @compileError("BorderInlineWidth: does not have a deepClone() function.");
        }
        if (!@hasDecl(Border, "deepClone")) {
            @compileError("Border: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderTop, "deepClone")) {
            @compileError("BorderTop: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBottom, "deepClone")) {
            @compileError("BorderBottom: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderLeft, "deepClone")) {
            @compileError("BorderLeft: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderRight, "deepClone")) {
            @compileError("BorderRight: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlock, "deepClone")) {
            @compileError("BorderBlock: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlockStart, "deepClone")) {
            @compileError("BorderBlockStart: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderBlockEnd, "deepClone")) {
            @compileError("BorderBlockEnd: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInline, "deepClone")) {
            @compileError("BorderInline: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInlineStart, "deepClone")) {
            @compileError("BorderInlineStart: does not have a deepClone() function.");
        }
        if (!@hasDecl(BorderInlineEnd, "deepClone")) {
            @compileError("BorderInlineEnd: does not have a deepClone() function.");
        }
        if (!@hasDecl(Outline, "deepClone")) {
            @compileError("Outline: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(CssColor, "deepClone")) {
            @compileError("CssColor: does not have a deepClone() function.");
        }
        if (!@hasDecl(Direction, "deepClone")) {
            @compileError("Direction: does not have a deepClone() function.");
        }
        if (!@hasDecl(Composes, "deepClone")) {
            @compileError("Composes: does not have a deepClone() function.");
        }
    }

    /// Parses a CSS property by name.
    pub fn parse(property_id: PropertyId, input: *css.Parser, options: *const css.ParserOptions) Result(Property) {
        const state = input.state();

        switch (property_id) {
            .@"background-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-color" = c } };
                    }
                }
            },
            .@"background-image" => {
                if (css.generic.parseWithOptions(SmallList(Image, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-image" = c } };
                    }
                }
            },
            .@"background-position-x" => {
                if (css.generic.parseWithOptions(SmallList(css_values.position.HorizontalPosition, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-position-x" = c } };
                    }
                }
            },
            .@"background-position-y" => {
                if (css.generic.parseWithOptions(SmallList(css_values.position.HorizontalPosition, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-position-y" = c } };
                    }
                }
            },
            .@"background-position" => {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundPosition, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-position" = c } };
                    }
                }
            },
            .@"background-size" => {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundSize, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-size" = c } };
                    }
                }
            },
            .@"background-repeat" => {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundSize, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-repeat" = c } };
                    }
                }
            },
            .@"background-attachment" => {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundAttachment, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-attachment" = c } };
                    }
                }
            },
            .@"background-clip" => |pre| {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundAttachment, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-clip" = .{ c, pre } } };
                    }
                }
            },
            .@"background-origin" => {
                if (css.generic.parseWithOptions(SmallList(background.BackgroundOrigin, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"background-origin" = c } };
                    }
                }
            },
            .background => {
                if (css.generic.parseWithOptions(SmallList(background.Background, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .background = c } };
                    }
                }
            },
            .@"box-shadow" => |pre| {
                if (css.generic.parseWithOptions(SmallList(box_shadow.BoxShadow, 1), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"box-shadow" = .{ c, pre } } };
                    }
                }
            },
            .opacity => {
                if (css.generic.parseWithOptions(css.css_values.alpha.AlphaValue, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .opacity = c } };
                    }
                }
            },
            .color => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .color = c } };
                    }
                }
            },
            .display => {
                if (css.generic.parseWithOptions(display.Display, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .display = c } };
                    }
                }
            },
            .visibility => {
                if (css.generic.parseWithOptions(display.Visibility, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .visibility = c } };
                    }
                }
            },
            .width => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .width = c } };
                    }
                }
            },
            .height => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .height = c } };
                    }
                }
            },
            .@"min-width" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"min-width" = c } };
                    }
                }
            },
            .@"min-height" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"min-height" = c } };
                    }
                }
            },
            .@"max-width" => {
                if (css.generic.parseWithOptions(size.MaxSize, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"max-width" = c } };
                    }
                }
            },
            .@"max-height" => {
                if (css.generic.parseWithOptions(size.MaxSize, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"max-height" = c } };
                    }
                }
            },
            .@"block-size" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"block-size" = c } };
                    }
                }
            },
            .@"inline-size" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inline-size" = c } };
                    }
                }
            },
            .@"min-block-size" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"min-block-size" = c } };
                    }
                }
            },
            .@"min-inline-size" => {
                if (css.generic.parseWithOptions(size.Size, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"min-inline-size" = c } };
                    }
                }
            },
            .@"max-block-size" => {
                if (css.generic.parseWithOptions(size.MaxSize, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"max-block-size" = c } };
                    }
                }
            },
            .@"max-inline-size" => {
                if (css.generic.parseWithOptions(size.MaxSize, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"max-inline-size" = c } };
                    }
                }
            },
            .@"box-sizing" => |pre| {
                if (css.generic.parseWithOptions(size.BoxSizing, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"box-sizing" = .{ c, pre } } };
                    }
                }
            },
            .@"aspect-ratio" => {
                if (css.generic.parseWithOptions(size.AspectRatio, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"aspect-ratio" = c } };
                    }
                }
            },
            .overflow => {
                if (css.generic.parseWithOptions(overflow.Overflow, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .overflow = c } };
                    }
                }
            },
            .@"overflow-x" => {
                if (css.generic.parseWithOptions(overflow.OverflowKeyword, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"overflow-x" = c } };
                    }
                }
            },
            .@"overflow-y" => {
                if (css.generic.parseWithOptions(overflow.OverflowKeyword, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"overflow-y" = c } };
                    }
                }
            },
            .@"text-overflow" => |pre| {
                if (css.generic.parseWithOptions(overflow.TextOverflow, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"text-overflow" = .{ c, pre } } };
                    }
                }
            },
            .position => {
                if (css.generic.parseWithOptions(position.Position, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .position = c } };
                    }
                }
            },
            .top => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .top = c } };
                    }
                }
            },
            .bottom => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .bottom = c } };
                    }
                }
            },
            .left => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .left = c } };
                    }
                }
            },
            .right => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .right = c } };
                    }
                }
            },
            .@"inset-block-start" => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-block-start" = c } };
                    }
                }
            },
            .@"inset-block-end" => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-block-end" = c } };
                    }
                }
            },
            .@"inset-inline-start" => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-inline-start" = c } };
                    }
                }
            },
            .@"inset-inline-end" => {
                if (css.generic.parseWithOptions(LengthPercentageOrAuto, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-inline-end" = c } };
                    }
                }
            },
            .@"inset-block" => {
                if (css.generic.parseWithOptions(margin_padding.InsetBlock, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-block" = c } };
                    }
                }
            },
            .@"inset-inline" => {
                if (css.generic.parseWithOptions(margin_padding.InsetInline, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"inset-inline" = c } };
                    }
                }
            },
            .inset => {
                if (css.generic.parseWithOptions(margin_padding.Inset, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .inset = c } };
                    }
                }
            },
            .@"border-spacing" => {
                if (css.generic.parseWithOptions(css.css_values.size.Size2D(Length), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-spacing" = c } };
                    }
                }
            },
            .@"border-top-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top-color" = c } };
                    }
                }
            },
            .@"border-bottom-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom-color" = c } };
                    }
                }
            },
            .@"border-left-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-left-color" = c } };
                    }
                }
            },
            .@"border-right-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-right-color" = c } };
                    }
                }
            },
            .@"border-block-start-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-start-color" = c } };
                    }
                }
            },
            .@"border-block-end-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-end-color" = c } };
                    }
                }
            },
            .@"border-inline-start-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-start-color" = c } };
                    }
                }
            },
            .@"border-inline-end-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-end-color" = c } };
                    }
                }
            },
            .@"border-top-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top-style" = c } };
                    }
                }
            },
            .@"border-bottom-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom-style" = c } };
                    }
                }
            },
            .@"border-left-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-left-style" = c } };
                    }
                }
            },
            .@"border-right-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-right-style" = c } };
                    }
                }
            },
            .@"border-block-start-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-start-style" = c } };
                    }
                }
            },
            .@"border-block-end-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-end-style" = c } };
                    }
                }
            },
            .@"border-inline-start-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-start-style" = c } };
                    }
                }
            },
            .@"border-inline-end-style" => {
                if (css.generic.parseWithOptions(border.LineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-end-style" = c } };
                    }
                }
            },
            .@"border-top-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top-width" = c } };
                    }
                }
            },
            .@"border-bottom-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom-width" = c } };
                    }
                }
            },
            .@"border-left-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-left-width" = c } };
                    }
                }
            },
            .@"border-right-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-right-width" = c } };
                    }
                }
            },
            .@"border-block-start-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-start-width" = c } };
                    }
                }
            },
            .@"border-block-end-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-end-width" = c } };
                    }
                }
            },
            .@"border-inline-start-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-start-width" = c } };
                    }
                }
            },
            .@"border-inline-end-width" => {
                if (css.generic.parseWithOptions(BorderSideWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-end-width" = c } };
                    }
                }
            },
            .@"border-top-left-radius" => |pre| {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top-left-radius" = .{ c, pre } } };
                    }
                }
            },
            .@"border-top-right-radius" => |pre| {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top-right-radius" = .{ c, pre } } };
                    }
                }
            },
            .@"border-bottom-left-radius" => |pre| {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom-left-radius" = .{ c, pre } } };
                    }
                }
            },
            .@"border-bottom-right-radius" => |pre| {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom-right-radius" = .{ c, pre } } };
                    }
                }
            },
            .@"border-start-start-radius" => {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-start-start-radius" = c } };
                    }
                }
            },
            .@"border-start-end-radius" => {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-start-end-radius" = c } };
                    }
                }
            },
            .@"border-end-start-radius" => {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-end-start-radius" = c } };
                    }
                }
            },
            .@"border-end-end-radius" => {
                if (css.generic.parseWithOptions(Size2D(LengthPercentage), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-end-end-radius" = c } };
                    }
                }
            },
            .@"border-radius" => |pre| {
                if (css.generic.parseWithOptions(BorderRadius, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-radius" = .{ c, pre } } };
                    }
                }
            },
            .@"border-image-source" => {
                if (css.generic.parseWithOptions(Image, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image-source" = c } };
                    }
                }
            },
            .@"border-image-outset" => {
                if (css.generic.parseWithOptions(Rect(LengthOrNumber), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image-outset" = c } };
                    }
                }
            },
            .@"border-image-repeat" => {
                if (css.generic.parseWithOptions(BorderImageRepeat, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image-repeat" = c } };
                    }
                }
            },
            .@"border-image-width" => {
                if (css.generic.parseWithOptions(Rect(BorderImageSideWidth), input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image-width" = c } };
                    }
                }
            },
            .@"border-image-slice" => {
                if (css.generic.parseWithOptions(BorderImageSlice, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image-slice" = c } };
                    }
                }
            },
            .@"border-image" => |pre| {
                if (css.generic.parseWithOptions(BorderImage, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-image" = .{ c, pre } } };
                    }
                }
            },
            .@"border-color" => {
                if (css.generic.parseWithOptions(BorderColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-color" = c } };
                    }
                }
            },
            .@"border-style" => {
                if (css.generic.parseWithOptions(BorderStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-style" = c } };
                    }
                }
            },
            .@"border-width" => {
                if (css.generic.parseWithOptions(BorderWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-width" = c } };
                    }
                }
            },
            .@"border-block-color" => {
                if (css.generic.parseWithOptions(BorderBlockColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-color" = c } };
                    }
                }
            },
            .@"border-block-style" => {
                if (css.generic.parseWithOptions(BorderBlockStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-style" = c } };
                    }
                }
            },
            .@"border-block-width" => {
                if (css.generic.parseWithOptions(BorderBlockWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-width" = c } };
                    }
                }
            },
            .@"border-inline-color" => {
                if (css.generic.parseWithOptions(BorderInlineColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-color" = c } };
                    }
                }
            },
            .@"border-inline-style" => {
                if (css.generic.parseWithOptions(BorderInlineStyle, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-style" = c } };
                    }
                }
            },
            .@"border-inline-width" => {
                if (css.generic.parseWithOptions(BorderInlineWidth, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-width" = c } };
                    }
                }
            },
            .border => {
                if (css.generic.parseWithOptions(Border, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .border = c } };
                    }
                }
            },
            .@"border-top" => {
                if (css.generic.parseWithOptions(BorderTop, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-top" = c } };
                    }
                }
            },
            .@"border-bottom" => {
                if (css.generic.parseWithOptions(BorderBottom, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-bottom" = c } };
                    }
                }
            },
            .@"border-left" => {
                if (css.generic.parseWithOptions(BorderLeft, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-left" = c } };
                    }
                }
            },
            .@"border-right" => {
                if (css.generic.parseWithOptions(BorderRight, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-right" = c } };
                    }
                }
            },
            .@"border-block" => {
                if (css.generic.parseWithOptions(BorderBlock, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block" = c } };
                    }
                }
            },
            .@"border-block-start" => {
                if (css.generic.parseWithOptions(BorderBlockStart, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-start" = c } };
                    }
                }
            },
            .@"border-block-end" => {
                if (css.generic.parseWithOptions(BorderBlockEnd, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-block-end" = c } };
                    }
                }
            },
            .@"border-inline" => {
                if (css.generic.parseWithOptions(BorderInline, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline" = c } };
                    }
                }
            },
            .@"border-inline-start" => {
                if (css.generic.parseWithOptions(BorderInlineStart, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-start" = c } };
                    }
                }
            },
            .@"border-inline-end" => {
                if (css.generic.parseWithOptions(BorderInlineEnd, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"border-inline-end" = c } };
                    }
                }
            },
            .outline => {
                if (css.generic.parseWithOptions(Outline, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .outline = c } };
                    }
                }
            },
            .@"outline-color" => {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"outline-color" = c } };
                    }
                }
            },
            .@"text-decoration-color" => |pre| {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"text-decoration-color" = .{ c, pre } } };
                    }
                }
            },
            .@"text-emphasis-color" => |pre| {
                if (css.generic.parseWithOptions(CssColor, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .@"text-emphasis-color" = .{ c, pre } } };
                    }
                }
            },
            .direction => {
                if (css.generic.parseWithOptions(Direction, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .direction = c } };
                    }
                }
            },
            .composes => {
                if (css.generic.parseWithOptions(Composes, input, options).asValue()) |c| {
                    if (input.expectExhausted().isOk()) {
                        return .{ .result = .{ .composes = c } };
                    }
                }
            },
            .all => return .{ .result = .{ .all = switch (CSSWideKeyword.parse(input)) {
                .result => |v| v,
                .err => |e| return .{ .err = e },
            } } },
            .custom => |name| return .{ .result = .{ .custom = switch (CustomProperty.parse(name, input, options)) {
                .result => |v| v,
                .err => |e| return .{ .err = e },
            } } },
            else => {},
        }

        // If a value was unable to be parsed, treat as an unparsed property.
        // This is different from a custom property, handled below, in that the property name is known
        // and stored as an enum rather than a string. This lets property handlers more easily deal with it.
        // Ideally we'd only do this if var() or env() references were seen, but err on the safe side for now.
        input.reset(&state);
        return .{ .result = .{ .unparsed = switch (UnparsedProperty.parse(property_id, input, options)) {
            .result => |v| v,
            .err => |e| return .{ .err = e },
        } } };
    }

    pub fn propertyId(this: *const Property) PropertyId {
        return switch (this.*) {
            .@"background-color" => .@"background-color",
            .@"background-image" => .@"background-image",
            .@"background-position-x" => .@"background-position-x",
            .@"background-position-y" => .@"background-position-y",
            .@"background-position" => .@"background-position",
            .@"background-size" => .@"background-size",
            .@"background-repeat" => .@"background-repeat",
            .@"background-attachment" => .@"background-attachment",
            .@"background-clip" => |*v| PropertyId{ .@"background-clip" = v[1] },
            .@"background-origin" => .@"background-origin",
            .background => .background,
            .@"box-shadow" => |*v| PropertyId{ .@"box-shadow" = v[1] },
            .opacity => .opacity,
            .color => .color,
            .display => .display,
            .visibility => .visibility,
            .width => .width,
            .height => .height,
            .@"min-width" => .@"min-width",
            .@"min-height" => .@"min-height",
            .@"max-width" => .@"max-width",
            .@"max-height" => .@"max-height",
            .@"block-size" => .@"block-size",
            .@"inline-size" => .@"inline-size",
            .@"min-block-size" => .@"min-block-size",
            .@"min-inline-size" => .@"min-inline-size",
            .@"max-block-size" => .@"max-block-size",
            .@"max-inline-size" => .@"max-inline-size",
            .@"box-sizing" => |*v| PropertyId{ .@"box-sizing" = v[1] },
            .@"aspect-ratio" => .@"aspect-ratio",
            .overflow => .overflow,
            .@"overflow-x" => .@"overflow-x",
            .@"overflow-y" => .@"overflow-y",
            .@"text-overflow" => |*v| PropertyId{ .@"text-overflow" = v[1] },
            .position => .position,
            .top => .top,
            .bottom => .bottom,
            .left => .left,
            .right => .right,
            .@"inset-block-start" => .@"inset-block-start",
            .@"inset-block-end" => .@"inset-block-end",
            .@"inset-inline-start" => .@"inset-inline-start",
            .@"inset-inline-end" => .@"inset-inline-end",
            .@"inset-block" => .@"inset-block",
            .@"inset-inline" => .@"inset-inline",
            .inset => .inset,
            .@"border-spacing" => .@"border-spacing",
            .@"border-top-color" => .@"border-top-color",
            .@"border-bottom-color" => .@"border-bottom-color",
            .@"border-left-color" => .@"border-left-color",
            .@"border-right-color" => .@"border-right-color",
            .@"border-block-start-color" => .@"border-block-start-color",
            .@"border-block-end-color" => .@"border-block-end-color",
            .@"border-inline-start-color" => .@"border-inline-start-color",
            .@"border-inline-end-color" => .@"border-inline-end-color",
            .@"border-top-style" => .@"border-top-style",
            .@"border-bottom-style" => .@"border-bottom-style",
            .@"border-left-style" => .@"border-left-style",
            .@"border-right-style" => .@"border-right-style",
            .@"border-block-start-style" => .@"border-block-start-style",
            .@"border-block-end-style" => .@"border-block-end-style",
            .@"border-inline-start-style" => .@"border-inline-start-style",
            .@"border-inline-end-style" => .@"border-inline-end-style",
            .@"border-top-width" => .@"border-top-width",
            .@"border-bottom-width" => .@"border-bottom-width",
            .@"border-left-width" => .@"border-left-width",
            .@"border-right-width" => .@"border-right-width",
            .@"border-block-start-width" => .@"border-block-start-width",
            .@"border-block-end-width" => .@"border-block-end-width",
            .@"border-inline-start-width" => .@"border-inline-start-width",
            .@"border-inline-end-width" => .@"border-inline-end-width",
            .@"border-top-left-radius" => |*v| PropertyId{ .@"border-top-left-radius" = v[1] },
            .@"border-top-right-radius" => |*v| PropertyId{ .@"border-top-right-radius" = v[1] },
            .@"border-bottom-left-radius" => |*v| PropertyId{ .@"border-bottom-left-radius" = v[1] },
            .@"border-bottom-right-radius" => |*v| PropertyId{ .@"border-bottom-right-radius" = v[1] },
            .@"border-start-start-radius" => .@"border-start-start-radius",
            .@"border-start-end-radius" => .@"border-start-end-radius",
            .@"border-end-start-radius" => .@"border-end-start-radius",
            .@"border-end-end-radius" => .@"border-end-end-radius",
            .@"border-radius" => |*v| PropertyId{ .@"border-radius" = v[1] },
            .@"border-image-source" => .@"border-image-source",
            .@"border-image-outset" => .@"border-image-outset",
            .@"border-image-repeat" => .@"border-image-repeat",
            .@"border-image-width" => .@"border-image-width",
            .@"border-image-slice" => .@"border-image-slice",
            .@"border-image" => |*v| PropertyId{ .@"border-image" = v[1] },
            .@"border-color" => .@"border-color",
            .@"border-style" => .@"border-style",
            .@"border-width" => .@"border-width",
            .@"border-block-color" => .@"border-block-color",
            .@"border-block-style" => .@"border-block-style",
            .@"border-block-width" => .@"border-block-width",
            .@"border-inline-color" => .@"border-inline-color",
            .@"border-inline-style" => .@"border-inline-style",
            .@"border-inline-width" => .@"border-inline-width",
            .border => .border,
            .@"border-top" => .@"border-top",
            .@"border-bottom" => .@"border-bottom",
            .@"border-left" => .@"border-left",
            .@"border-right" => .@"border-right",
            .@"border-block" => .@"border-block",
            .@"border-block-start" => .@"border-block-start",
            .@"border-block-end" => .@"border-block-end",
            .@"border-inline" => .@"border-inline",
            .@"border-inline-start" => .@"border-inline-start",
            .@"border-inline-end" => .@"border-inline-end",
            .outline => .outline,
            .@"outline-color" => .@"outline-color",
            .@"text-decoration-color" => |*v| PropertyId{ .@"text-decoration-color" = v[1] },
            .@"text-emphasis-color" => |*v| PropertyId{ .@"text-emphasis-color" = v[1] },
            .direction => .direction,
            .composes => .composes,
            .all => PropertyId.all,
            .unparsed => |unparsed| unparsed.property_id,
            .custom => |c| .{ .custom = c.name },
        };
    }

    pub fn deepClone(this: *const Property, allocator: std.mem.Allocator) Property {
        return switch (this.*) {
            .@"background-color" => |*v| .{ .@"background-color" = v.deepClone(allocator) },
            .@"background-image" => |*v| .{ .@"background-image" = v.deepClone(allocator) },
            .@"background-position-x" => |*v| .{ .@"background-position-x" = v.deepClone(allocator) },
            .@"background-position-y" => |*v| .{ .@"background-position-y" = v.deepClone(allocator) },
            .@"background-position" => |*v| .{ .@"background-position" = v.deepClone(allocator) },
            .@"background-size" => |*v| .{ .@"background-size" = v.deepClone(allocator) },
            .@"background-repeat" => |*v| .{ .@"background-repeat" = v.deepClone(allocator) },
            .@"background-attachment" => |*v| .{ .@"background-attachment" = v.deepClone(allocator) },
            .@"background-clip" => |*v| .{ .@"background-clip" = .{ v[0].deepClone(allocator), v[1] } },
            .@"background-origin" => |*v| .{ .@"background-origin" = v.deepClone(allocator) },
            .background => |*v| .{ .background = v.deepClone(allocator) },
            .@"box-shadow" => |*v| .{ .@"box-shadow" = .{ v[0].deepClone(allocator), v[1] } },
            .opacity => |*v| .{ .opacity = v.deepClone(allocator) },
            .color => |*v| .{ .color = v.deepClone(allocator) },
            .display => |*v| .{ .display = v.deepClone(allocator) },
            .visibility => |*v| .{ .visibility = v.deepClone(allocator) },
            .width => |*v| .{ .width = v.deepClone(allocator) },
            .height => |*v| .{ .height = v.deepClone(allocator) },
            .@"min-width" => |*v| .{ .@"min-width" = v.deepClone(allocator) },
            .@"min-height" => |*v| .{ .@"min-height" = v.deepClone(allocator) },
            .@"max-width" => |*v| .{ .@"max-width" = v.deepClone(allocator) },
            .@"max-height" => |*v| .{ .@"max-height" = v.deepClone(allocator) },
            .@"block-size" => |*v| .{ .@"block-size" = v.deepClone(allocator) },
            .@"inline-size" => |*v| .{ .@"inline-size" = v.deepClone(allocator) },
            .@"min-block-size" => |*v| .{ .@"min-block-size" = v.deepClone(allocator) },
            .@"min-inline-size" => |*v| .{ .@"min-inline-size" = v.deepClone(allocator) },
            .@"max-block-size" => |*v| .{ .@"max-block-size" = v.deepClone(allocator) },
            .@"max-inline-size" => |*v| .{ .@"max-inline-size" = v.deepClone(allocator) },
            .@"box-sizing" => |*v| .{ .@"box-sizing" = .{ v[0].deepClone(allocator), v[1] } },
            .@"aspect-ratio" => |*v| .{ .@"aspect-ratio" = v.deepClone(allocator) },
            .overflow => |*v| .{ .overflow = v.deepClone(allocator) },
            .@"overflow-x" => |*v| .{ .@"overflow-x" = v.deepClone(allocator) },
            .@"overflow-y" => |*v| .{ .@"overflow-y" = v.deepClone(allocator) },
            .@"text-overflow" => |*v| .{ .@"text-overflow" = .{ v[0].deepClone(allocator), v[1] } },
            .position => |*v| .{ .position = v.deepClone(allocator) },
            .top => |*v| .{ .top = v.deepClone(allocator) },
            .bottom => |*v| .{ .bottom = v.deepClone(allocator) },
            .left => |*v| .{ .left = v.deepClone(allocator) },
            .right => |*v| .{ .right = v.deepClone(allocator) },
            .@"inset-block-start" => |*v| .{ .@"inset-block-start" = v.deepClone(allocator) },
            .@"inset-block-end" => |*v| .{ .@"inset-block-end" = v.deepClone(allocator) },
            .@"inset-inline-start" => |*v| .{ .@"inset-inline-start" = v.deepClone(allocator) },
            .@"inset-inline-end" => |*v| .{ .@"inset-inline-end" = v.deepClone(allocator) },
            .@"inset-block" => |*v| .{ .@"inset-block" = v.deepClone(allocator) },
            .@"inset-inline" => |*v| .{ .@"inset-inline" = v.deepClone(allocator) },
            .inset => |*v| .{ .inset = v.deepClone(allocator) },
            .@"border-spacing" => |*v| .{ .@"border-spacing" = v.deepClone(allocator) },
            .@"border-top-color" => |*v| .{ .@"border-top-color" = v.deepClone(allocator) },
            .@"border-bottom-color" => |*v| .{ .@"border-bottom-color" = v.deepClone(allocator) },
            .@"border-left-color" => |*v| .{ .@"border-left-color" = v.deepClone(allocator) },
            .@"border-right-color" => |*v| .{ .@"border-right-color" = v.deepClone(allocator) },
            .@"border-block-start-color" => |*v| .{ .@"border-block-start-color" = v.deepClone(allocator) },
            .@"border-block-end-color" => |*v| .{ .@"border-block-end-color" = v.deepClone(allocator) },
            .@"border-inline-start-color" => |*v| .{ .@"border-inline-start-color" = v.deepClone(allocator) },
            .@"border-inline-end-color" => |*v| .{ .@"border-inline-end-color" = v.deepClone(allocator) },
            .@"border-top-style" => |*v| .{ .@"border-top-style" = v.deepClone(allocator) },
            .@"border-bottom-style" => |*v| .{ .@"border-bottom-style" = v.deepClone(allocator) },
            .@"border-left-style" => |*v| .{ .@"border-left-style" = v.deepClone(allocator) },
            .@"border-right-style" => |*v| .{ .@"border-right-style" = v.deepClone(allocator) },
            .@"border-block-start-style" => |*v| .{ .@"border-block-start-style" = v.deepClone(allocator) },
            .@"border-block-end-style" => |*v| .{ .@"border-block-end-style" = v.deepClone(allocator) },
            .@"border-inline-start-style" => |*v| .{ .@"border-inline-start-style" = v.deepClone(allocator) },
            .@"border-inline-end-style" => |*v| .{ .@"border-inline-end-style" = v.deepClone(allocator) },
            .@"border-top-width" => |*v| .{ .@"border-top-width" = v.deepClone(allocator) },
            .@"border-bottom-width" => |*v| .{ .@"border-bottom-width" = v.deepClone(allocator) },
            .@"border-left-width" => |*v| .{ .@"border-left-width" = v.deepClone(allocator) },
            .@"border-right-width" => |*v| .{ .@"border-right-width" = v.deepClone(allocator) },
            .@"border-block-start-width" => |*v| .{ .@"border-block-start-width" = v.deepClone(allocator) },
            .@"border-block-end-width" => |*v| .{ .@"border-block-end-width" = v.deepClone(allocator) },
            .@"border-inline-start-width" => |*v| .{ .@"border-inline-start-width" = v.deepClone(allocator) },
            .@"border-inline-end-width" => |*v| .{ .@"border-inline-end-width" = v.deepClone(allocator) },
            .@"border-top-left-radius" => |*v| .{ .@"border-top-left-radius" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-top-right-radius" => |*v| .{ .@"border-top-right-radius" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-bottom-left-radius" => |*v| .{ .@"border-bottom-left-radius" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-bottom-right-radius" => |*v| .{ .@"border-bottom-right-radius" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-start-start-radius" => |*v| .{ .@"border-start-start-radius" = v.deepClone(allocator) },
            .@"border-start-end-radius" => |*v| .{ .@"border-start-end-radius" = v.deepClone(allocator) },
            .@"border-end-start-radius" => |*v| .{ .@"border-end-start-radius" = v.deepClone(allocator) },
            .@"border-end-end-radius" => |*v| .{ .@"border-end-end-radius" = v.deepClone(allocator) },
            .@"border-radius" => |*v| .{ .@"border-radius" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-image-source" => |*v| .{ .@"border-image-source" = v.deepClone(allocator) },
            .@"border-image-outset" => |*v| .{ .@"border-image-outset" = v.deepClone(allocator) },
            .@"border-image-repeat" => |*v| .{ .@"border-image-repeat" = v.deepClone(allocator) },
            .@"border-image-width" => |*v| .{ .@"border-image-width" = v.deepClone(allocator) },
            .@"border-image-slice" => |*v| .{ .@"border-image-slice" = v.deepClone(allocator) },
            .@"border-image" => |*v| .{ .@"border-image" = .{ v[0].deepClone(allocator), v[1] } },
            .@"border-color" => |*v| .{ .@"border-color" = v.deepClone(allocator) },
            .@"border-style" => |*v| .{ .@"border-style" = v.deepClone(allocator) },
            .@"border-width" => |*v| .{ .@"border-width" = v.deepClone(allocator) },
            .@"border-block-color" => |*v| .{ .@"border-block-color" = v.deepClone(allocator) },
            .@"border-block-style" => |*v| .{ .@"border-block-style" = v.deepClone(allocator) },
            .@"border-block-width" => |*v| .{ .@"border-block-width" = v.deepClone(allocator) },
            .@"border-inline-color" => |*v| .{ .@"border-inline-color" = v.deepClone(allocator) },
            .@"border-inline-style" => |*v| .{ .@"border-inline-style" = v.deepClone(allocator) },
            .@"border-inline-width" => |*v| .{ .@"border-inline-width" = v.deepClone(allocator) },
            .border => |*v| .{ .border = v.deepClone(allocator) },
            .@"border-top" => |*v| .{ .@"border-top" = v.deepClone(allocator) },
            .@"border-bottom" => |*v| .{ .@"border-bottom" = v.deepClone(allocator) },
            .@"border-left" => |*v| .{ .@"border-left" = v.deepClone(allocator) },
            .@"border-right" => |*v| .{ .@"border-right" = v.deepClone(allocator) },
            .@"border-block" => |*v| .{ .@"border-block" = v.deepClone(allocator) },
            .@"border-block-start" => |*v| .{ .@"border-block-start" = v.deepClone(allocator) },
            .@"border-block-end" => |*v| .{ .@"border-block-end" = v.deepClone(allocator) },
            .@"border-inline" => |*v| .{ .@"border-inline" = v.deepClone(allocator) },
            .@"border-inline-start" => |*v| .{ .@"border-inline-start" = v.deepClone(allocator) },
            .@"border-inline-end" => |*v| .{ .@"border-inline-end" = v.deepClone(allocator) },
            .outline => |*v| .{ .outline = v.deepClone(allocator) },
            .@"outline-color" => |*v| .{ .@"outline-color" = v.deepClone(allocator) },
            .@"text-decoration-color" => |*v| .{ .@"text-decoration-color" = .{ v[0].deepClone(allocator), v[1] } },
            .@"text-emphasis-color" => |*v| .{ .@"text-emphasis-color" = .{ v[0].deepClone(allocator), v[1] } },
            .direction => |*v| .{ .direction = v.deepClone(allocator) },
            .composes => |*v| .{ .composes = v.deepClone(allocator) },
            .all => |*a| return .{ .all = a.deepClone(allocator) },
            .unparsed => |*u| return .{ .unparsed = u.deepClone(allocator) },
            .custom => |*c| return .{ .custom = c.deepClone(allocator) },
        };
    }

    pub fn deinit(this: *@This(), allocator: std.mem.Allocator) void {
        _ = this; // autofix
        _ = allocator; // autofix
        @panic(css.todo_stuff.depth);
    }

    pub inline fn __toCssHelper(this: *const Property) struct { []const u8, VendorPrefix } {
        return switch (this.*) {
            .@"background-color" => .{ "background-color", VendorPrefix{ .none = true } },
            .@"background-image" => .{ "background-image", VendorPrefix{ .none = true } },
            .@"background-position-x" => .{ "background-position-x", VendorPrefix{ .none = true } },
            .@"background-position-y" => .{ "background-position-y", VendorPrefix{ .none = true } },
            .@"background-position" => .{ "background-position", VendorPrefix{ .none = true } },
            .@"background-size" => .{ "background-size", VendorPrefix{ .none = true } },
            .@"background-repeat" => .{ "background-repeat", VendorPrefix{ .none = true } },
            .@"background-attachment" => .{ "background-attachment", VendorPrefix{ .none = true } },
            .@"background-clip" => |*x| .{ "background-clip", x.@"1" },
            .@"background-origin" => .{ "background-origin", VendorPrefix{ .none = true } },
            .background => .{ "background", VendorPrefix{ .none = true } },
            .@"box-shadow" => |*x| .{ "box-shadow", x.@"1" },
            .opacity => .{ "opacity", VendorPrefix{ .none = true } },
            .color => .{ "color", VendorPrefix{ .none = true } },
            .display => .{ "display", VendorPrefix{ .none = true } },
            .visibility => .{ "visibility", VendorPrefix{ .none = true } },
            .width => .{ "width", VendorPrefix{ .none = true } },
            .height => .{ "height", VendorPrefix{ .none = true } },
            .@"min-width" => .{ "min-width", VendorPrefix{ .none = true } },
            .@"min-height" => .{ "min-height", VendorPrefix{ .none = true } },
            .@"max-width" => .{ "max-width", VendorPrefix{ .none = true } },
            .@"max-height" => .{ "max-height", VendorPrefix{ .none = true } },
            .@"block-size" => .{ "block-size", VendorPrefix{ .none = true } },
            .@"inline-size" => .{ "inline-size", VendorPrefix{ .none = true } },
            .@"min-block-size" => .{ "min-block-size", VendorPrefix{ .none = true } },
            .@"min-inline-size" => .{ "min-inline-size", VendorPrefix{ .none = true } },
            .@"max-block-size" => .{ "max-block-size", VendorPrefix{ .none = true } },
            .@"max-inline-size" => .{ "max-inline-size", VendorPrefix{ .none = true } },
            .@"box-sizing" => |*x| .{ "box-sizing", x.@"1" },
            .@"aspect-ratio" => .{ "aspect-ratio", VendorPrefix{ .none = true } },
            .overflow => .{ "overflow", VendorPrefix{ .none = true } },
            .@"overflow-x" => .{ "overflow-x", VendorPrefix{ .none = true } },
            .@"overflow-y" => .{ "overflow-y", VendorPrefix{ .none = true } },
            .@"text-overflow" => |*x| .{ "text-overflow", x.@"1" },
            .position => .{ "position", VendorPrefix{ .none = true } },
            .top => .{ "top", VendorPrefix{ .none = true } },
            .bottom => .{ "bottom", VendorPrefix{ .none = true } },
            .left => .{ "left", VendorPrefix{ .none = true } },
            .right => .{ "right", VendorPrefix{ .none = true } },
            .@"inset-block-start" => .{ "inset-block-start", VendorPrefix{ .none = true } },
            .@"inset-block-end" => .{ "inset-block-end", VendorPrefix{ .none = true } },
            .@"inset-inline-start" => .{ "inset-inline-start", VendorPrefix{ .none = true } },
            .@"inset-inline-end" => .{ "inset-inline-end", VendorPrefix{ .none = true } },
            .@"inset-block" => .{ "inset-block", VendorPrefix{ .none = true } },
            .@"inset-inline" => .{ "inset-inline", VendorPrefix{ .none = true } },
            .inset => .{ "inset", VendorPrefix{ .none = true } },
            .@"border-spacing" => .{ "border-spacing", VendorPrefix{ .none = true } },
            .@"border-top-color" => .{ "border-top-color", VendorPrefix{ .none = true } },
            .@"border-bottom-color" => .{ "border-bottom-color", VendorPrefix{ .none = true } },
            .@"border-left-color" => .{ "border-left-color", VendorPrefix{ .none = true } },
            .@"border-right-color" => .{ "border-right-color", VendorPrefix{ .none = true } },
            .@"border-block-start-color" => .{ "border-block-start-color", VendorPrefix{ .none = true } },
            .@"border-block-end-color" => .{ "border-block-end-color", VendorPrefix{ .none = true } },
            .@"border-inline-start-color" => .{ "border-inline-start-color", VendorPrefix{ .none = true } },
            .@"border-inline-end-color" => .{ "border-inline-end-color", VendorPrefix{ .none = true } },
            .@"border-top-style" => .{ "border-top-style", VendorPrefix{ .none = true } },
            .@"border-bottom-style" => .{ "border-bottom-style", VendorPrefix{ .none = true } },
            .@"border-left-style" => .{ "border-left-style", VendorPrefix{ .none = true } },
            .@"border-right-style" => .{ "border-right-style", VendorPrefix{ .none = true } },
            .@"border-block-start-style" => .{ "border-block-start-style", VendorPrefix{ .none = true } },
            .@"border-block-end-style" => .{ "border-block-end-style", VendorPrefix{ .none = true } },
            .@"border-inline-start-style" => .{ "border-inline-start-style", VendorPrefix{ .none = true } },
            .@"border-inline-end-style" => .{ "border-inline-end-style", VendorPrefix{ .none = true } },
            .@"border-top-width" => .{ "border-top-width", VendorPrefix{ .none = true } },
            .@"border-bottom-width" => .{ "border-bottom-width", VendorPrefix{ .none = true } },
            .@"border-left-width" => .{ "border-left-width", VendorPrefix{ .none = true } },
            .@"border-right-width" => .{ "border-right-width", VendorPrefix{ .none = true } },
            .@"border-block-start-width" => .{ "border-block-start-width", VendorPrefix{ .none = true } },
            .@"border-block-end-width" => .{ "border-block-end-width", VendorPrefix{ .none = true } },
            .@"border-inline-start-width" => .{ "border-inline-start-width", VendorPrefix{ .none = true } },
            .@"border-inline-end-width" => .{ "border-inline-end-width", VendorPrefix{ .none = true } },
            .@"border-top-left-radius" => |*x| .{ "border-top-left-radius", x.@"1" },
            .@"border-top-right-radius" => |*x| .{ "border-top-right-radius", x.@"1" },
            .@"border-bottom-left-radius" => |*x| .{ "border-bottom-left-radius", x.@"1" },
            .@"border-bottom-right-radius" => |*x| .{ "border-bottom-right-radius", x.@"1" },
            .@"border-start-start-radius" => .{ "border-start-start-radius", VendorPrefix{ .none = true } },
            .@"border-start-end-radius" => .{ "border-start-end-radius", VendorPrefix{ .none = true } },
            .@"border-end-start-radius" => .{ "border-end-start-radius", VendorPrefix{ .none = true } },
            .@"border-end-end-radius" => .{ "border-end-end-radius", VendorPrefix{ .none = true } },
            .@"border-radius" => |*x| .{ "border-radius", x.@"1" },
            .@"border-image-source" => .{ "border-image-source", VendorPrefix{ .none = true } },
            .@"border-image-outset" => .{ "border-image-outset", VendorPrefix{ .none = true } },
            .@"border-image-repeat" => .{ "border-image-repeat", VendorPrefix{ .none = true } },
            .@"border-image-width" => .{ "border-image-width", VendorPrefix{ .none = true } },
            .@"border-image-slice" => .{ "border-image-slice", VendorPrefix{ .none = true } },
            .@"border-image" => |*x| .{ "border-image", x.@"1" },
            .@"border-color" => .{ "border-color", VendorPrefix{ .none = true } },
            .@"border-style" => .{ "border-style", VendorPrefix{ .none = true } },
            .@"border-width" => .{ "border-width", VendorPrefix{ .none = true } },
            .@"border-block-color" => .{ "border-block-color", VendorPrefix{ .none = true } },
            .@"border-block-style" => .{ "border-block-style", VendorPrefix{ .none = true } },
            .@"border-block-width" => .{ "border-block-width", VendorPrefix{ .none = true } },
            .@"border-inline-color" => .{ "border-inline-color", VendorPrefix{ .none = true } },
            .@"border-inline-style" => .{ "border-inline-style", VendorPrefix{ .none = true } },
            .@"border-inline-width" => .{ "border-inline-width", VendorPrefix{ .none = true } },
            .border => .{ "border", VendorPrefix{ .none = true } },
            .@"border-top" => .{ "border-top", VendorPrefix{ .none = true } },
            .@"border-bottom" => .{ "border-bottom", VendorPrefix{ .none = true } },
            .@"border-left" => .{ "border-left", VendorPrefix{ .none = true } },
            .@"border-right" => .{ "border-right", VendorPrefix{ .none = true } },
            .@"border-block" => .{ "border-block", VendorPrefix{ .none = true } },
            .@"border-block-start" => .{ "border-block-start", VendorPrefix{ .none = true } },
            .@"border-block-end" => .{ "border-block-end", VendorPrefix{ .none = true } },
            .@"border-inline" => .{ "border-inline", VendorPrefix{ .none = true } },
            .@"border-inline-start" => .{ "border-inline-start", VendorPrefix{ .none = true } },
            .@"border-inline-end" => .{ "border-inline-end", VendorPrefix{ .none = true } },
            .outline => .{ "outline", VendorPrefix{ .none = true } },
            .@"outline-color" => .{ "outline-color", VendorPrefix{ .none = true } },
            .@"text-decoration-color" => |*x| .{ "text-decoration-color", x.@"1" },
            .@"text-emphasis-color" => |*x| .{ "text-emphasis-color", x.@"1" },
            .direction => .{ "direction", VendorPrefix{ .none = true } },
            .composes => .{ "composes", VendorPrefix{ .none = true } },
            .all => .{ "all", VendorPrefix{ .none = true } },
            .unparsed => |*unparsed| brk: {
                var prefix = unparsed.property_id.prefix();
                if (prefix.isEmpty()) {
                    prefix = VendorPrefix{ .none = true };
                }
                break :brk .{ unparsed.property_id.name(), prefix };
            },
            .custom => unreachable,
        };
    }

    /// Serializes the value of a CSS property without its name or `!important` flag.
    pub fn valueToCss(this: *const Property, comptime W: type, dest: *css.Printer(W)) PrintErr!void {
        return switch (this.*) {
            .@"background-color" => |*value| value.toCss(W, dest),
            .@"background-image" => |*value| value.toCss(W, dest),
            .@"background-position-x" => |*value| value.toCss(W, dest),
            .@"background-position-y" => |*value| value.toCss(W, dest),
            .@"background-position" => |*value| value.toCss(W, dest),
            .@"background-size" => |*value| value.toCss(W, dest),
            .@"background-repeat" => |*value| value.toCss(W, dest),
            .@"background-attachment" => |*value| value.toCss(W, dest),
            .@"background-clip" => |*value| value[0].toCss(W, dest),
            .@"background-origin" => |*value| value.toCss(W, dest),
            .background => |*value| value.toCss(W, dest),
            .@"box-shadow" => |*value| value[0].toCss(W, dest),
            .opacity => |*value| value.toCss(W, dest),
            .color => |*value| value.toCss(W, dest),
            .display => |*value| value.toCss(W, dest),
            .visibility => |*value| value.toCss(W, dest),
            .width => |*value| value.toCss(W, dest),
            .height => |*value| value.toCss(W, dest),
            .@"min-width" => |*value| value.toCss(W, dest),
            .@"min-height" => |*value| value.toCss(W, dest),
            .@"max-width" => |*value| value.toCss(W, dest),
            .@"max-height" => |*value| value.toCss(W, dest),
            .@"block-size" => |*value| value.toCss(W, dest),
            .@"inline-size" => |*value| value.toCss(W, dest),
            .@"min-block-size" => |*value| value.toCss(W, dest),
            .@"min-inline-size" => |*value| value.toCss(W, dest),
            .@"max-block-size" => |*value| value.toCss(W, dest),
            .@"max-inline-size" => |*value| value.toCss(W, dest),
            .@"box-sizing" => |*value| value[0].toCss(W, dest),
            .@"aspect-ratio" => |*value| value.toCss(W, dest),
            .overflow => |*value| value.toCss(W, dest),
            .@"overflow-x" => |*value| value.toCss(W, dest),
            .@"overflow-y" => |*value| value.toCss(W, dest),
            .@"text-overflow" => |*value| value[0].toCss(W, dest),
            .position => |*value| value.toCss(W, dest),
            .top => |*value| value.toCss(W, dest),
            .bottom => |*value| value.toCss(W, dest),
            .left => |*value| value.toCss(W, dest),
            .right => |*value| value.toCss(W, dest),
            .@"inset-block-start" => |*value| value.toCss(W, dest),
            .@"inset-block-end" => |*value| value.toCss(W, dest),
            .@"inset-inline-start" => |*value| value.toCss(W, dest),
            .@"inset-inline-end" => |*value| value.toCss(W, dest),
            .@"inset-block" => |*value| value.toCss(W, dest),
            .@"inset-inline" => |*value| value.toCss(W, dest),
            .inset => |*value| value.toCss(W, dest),
            .@"border-spacing" => |*value| value.toCss(W, dest),
            .@"border-top-color" => |*value| value.toCss(W, dest),
            .@"border-bottom-color" => |*value| value.toCss(W, dest),
            .@"border-left-color" => |*value| value.toCss(W, dest),
            .@"border-right-color" => |*value| value.toCss(W, dest),
            .@"border-block-start-color" => |*value| value.toCss(W, dest),
            .@"border-block-end-color" => |*value| value.toCss(W, dest),
            .@"border-inline-start-color" => |*value| value.toCss(W, dest),
            .@"border-inline-end-color" => |*value| value.toCss(W, dest),
            .@"border-top-style" => |*value| value.toCss(W, dest),
            .@"border-bottom-style" => |*value| value.toCss(W, dest),
            .@"border-left-style" => |*value| value.toCss(W, dest),
            .@"border-right-style" => |*value| value.toCss(W, dest),
            .@"border-block-start-style" => |*value| value.toCss(W, dest),
            .@"border-block-end-style" => |*value| value.toCss(W, dest),
            .@"border-inline-start-style" => |*value| value.toCss(W, dest),
            .@"border-inline-end-style" => |*value| value.toCss(W, dest),
            .@"border-top-width" => |*value| value.toCss(W, dest),
            .@"border-bottom-width" => |*value| value.toCss(W, dest),
            .@"border-left-width" => |*value| value.toCss(W, dest),
            .@"border-right-width" => |*value| value.toCss(W, dest),
            .@"border-block-start-width" => |*value| value.toCss(W, dest),
            .@"border-block-end-width" => |*value| value.toCss(W, dest),
            .@"border-inline-start-width" => |*value| value.toCss(W, dest),
            .@"border-inline-end-width" => |*value| value.toCss(W, dest),
            .@"border-top-left-radius" => |*value| value[0].toCss(W, dest),
            .@"border-top-right-radius" => |*value| value[0].toCss(W, dest),
            .@"border-bottom-left-radius" => |*value| value[0].toCss(W, dest),
            .@"border-bottom-right-radius" => |*value| value[0].toCss(W, dest),
            .@"border-start-start-radius" => |*value| value.toCss(W, dest),
            .@"border-start-end-radius" => |*value| value.toCss(W, dest),
            .@"border-end-start-radius" => |*value| value.toCss(W, dest),
            .@"border-end-end-radius" => |*value| value.toCss(W, dest),
            .@"border-radius" => |*value| value[0].toCss(W, dest),
            .@"border-image-source" => |*value| value.toCss(W, dest),
            .@"border-image-outset" => |*value| value.toCss(W, dest),
            .@"border-image-repeat" => |*value| value.toCss(W, dest),
            .@"border-image-width" => |*value| value.toCss(W, dest),
            .@"border-image-slice" => |*value| value.toCss(W, dest),
            .@"border-image" => |*value| value[0].toCss(W, dest),
            .@"border-color" => |*value| value.toCss(W, dest),
            .@"border-style" => |*value| value.toCss(W, dest),
            .@"border-width" => |*value| value.toCss(W, dest),
            .@"border-block-color" => |*value| value.toCss(W, dest),
            .@"border-block-style" => |*value| value.toCss(W, dest),
            .@"border-block-width" => |*value| value.toCss(W, dest),
            .@"border-inline-color" => |*value| value.toCss(W, dest),
            .@"border-inline-style" => |*value| value.toCss(W, dest),
            .@"border-inline-width" => |*value| value.toCss(W, dest),
            .border => |*value| value.toCss(W, dest),
            .@"border-top" => |*value| value.toCss(W, dest),
            .@"border-bottom" => |*value| value.toCss(W, dest),
            .@"border-left" => |*value| value.toCss(W, dest),
            .@"border-right" => |*value| value.toCss(W, dest),
            .@"border-block" => |*value| value.toCss(W, dest),
            .@"border-block-start" => |*value| value.toCss(W, dest),
            .@"border-block-end" => |*value| value.toCss(W, dest),
            .@"border-inline" => |*value| value.toCss(W, dest),
            .@"border-inline-start" => |*value| value.toCss(W, dest),
            .@"border-inline-end" => |*value| value.toCss(W, dest),
            .outline => |*value| value.toCss(W, dest),
            .@"outline-color" => |*value| value.toCss(W, dest),
            .@"text-decoration-color" => |*value| value[0].toCss(W, dest),
            .@"text-emphasis-color" => |*value| value[0].toCss(W, dest),
            .direction => |*value| value.toCss(W, dest),
            .composes => |*value| value.toCss(W, dest),
            .all => |*keyword| keyword.toCss(W, dest),
            .unparsed => |*unparsed| unparsed.value.toCss(W, dest, false),
            .custom => |*c| c.value.toCss(W, dest, c.name == .custom),
        };
    }

    /// Returns the given longhand property for a shorthand.
    pub fn longhand(this: *const Property, property_id: *const PropertyId) ?Property {
        switch (this.*) {
            .@"background-position" => |*v| return v.longhand(property_id),
            .overflow => |*v| return v.longhand(property_id),
            .@"inset-block" => |*v| return v.longhand(property_id),
            .@"inset-inline" => |*v| return v.longhand(property_id),
            .inset => |*v| return v.longhand(property_id),
            .@"border-radius" => |*v| {
                if (!v[1].eq(property_id.prefix())) return null;
                return v[0].longhand(property_id);
            },
            .@"border-image" => |*v| {
                if (!v[1].eq(property_id.prefix())) return null;
                return v[0].longhand(property_id);
            },
            .@"border-color" => |*v| return v.longhand(property_id),
            .@"border-style" => |*v| return v.longhand(property_id),
            .@"border-width" => |*v| return v.longhand(property_id),
            .@"border-block-color" => |*v| return v.longhand(property_id),
            .@"border-block-style" => |*v| return v.longhand(property_id),
            .@"border-block-width" => |*v| return v.longhand(property_id),
            .@"border-inline-color" => |*v| return v.longhand(property_id),
            .@"border-inline-style" => |*v| return v.longhand(property_id),
            .@"border-inline-width" => |*v| return v.longhand(property_id),
            .border => |*v| return v.longhand(property_id),
            .@"border-top" => |*v| return v.longhand(property_id),
            .@"border-bottom" => |*v| return v.longhand(property_id),
            .@"border-left" => |*v| return v.longhand(property_id),
            .@"border-right" => |*v| return v.longhand(property_id),
            .@"border-block" => |*v| return v.longhand(property_id),
            .@"border-block-start" => |*v| return v.longhand(property_id),
            .@"border-block-end" => |*v| return v.longhand(property_id),
            .@"border-inline" => |*v| return v.longhand(property_id),
            .@"border-inline-start" => |*v| return v.longhand(property_id),
            .@"border-inline-end" => |*v| return v.longhand(property_id),
            .outline => |*v| return v.longhand(property_id),
            else => {},
        }
        return null;
    }
};
pub const PropertyId = union(PropertyIdTag) {
    @"background-color",
    @"background-image",
    @"background-position-x",
    @"background-position-y",
    @"background-position",
    @"background-size",
    @"background-repeat",
    @"background-attachment",
    @"background-clip": VendorPrefix,
    @"background-origin",
    background,
    @"box-shadow": VendorPrefix,
    opacity,
    color,
    display,
    visibility,
    width,
    height,
    @"min-width",
    @"min-height",
    @"max-width",
    @"max-height",
    @"block-size",
    @"inline-size",
    @"min-block-size",
    @"min-inline-size",
    @"max-block-size",
    @"max-inline-size",
    @"box-sizing": VendorPrefix,
    @"aspect-ratio",
    overflow,
    @"overflow-x",
    @"overflow-y",
    @"text-overflow": VendorPrefix,
    position,
    top,
    bottom,
    left,
    right,
    @"inset-block-start",
    @"inset-block-end",
    @"inset-inline-start",
    @"inset-inline-end",
    @"inset-block",
    @"inset-inline",
    inset,
    @"border-spacing",
    @"border-top-color",
    @"border-bottom-color",
    @"border-left-color",
    @"border-right-color",
    @"border-block-start-color",
    @"border-block-end-color",
    @"border-inline-start-color",
    @"border-inline-end-color",
    @"border-top-style",
    @"border-bottom-style",
    @"border-left-style",
    @"border-right-style",
    @"border-block-start-style",
    @"border-block-end-style",
    @"border-inline-start-style",
    @"border-inline-end-style",
    @"border-top-width",
    @"border-bottom-width",
    @"border-left-width",
    @"border-right-width",
    @"border-block-start-width",
    @"border-block-end-width",
    @"border-inline-start-width",
    @"border-inline-end-width",
    @"border-top-left-radius": VendorPrefix,
    @"border-top-right-radius": VendorPrefix,
    @"border-bottom-left-radius": VendorPrefix,
    @"border-bottom-right-radius": VendorPrefix,
    @"border-start-start-radius",
    @"border-start-end-radius",
    @"border-end-start-radius",
    @"border-end-end-radius",
    @"border-radius": VendorPrefix,
    @"border-image-source",
    @"border-image-outset",
    @"border-image-repeat",
    @"border-image-width",
    @"border-image-slice",
    @"border-image": VendorPrefix,
    @"border-color",
    @"border-style",
    @"border-width",
    @"border-block-color",
    @"border-block-style",
    @"border-block-width",
    @"border-inline-color",
    @"border-inline-style",
    @"border-inline-width",
    border,
    @"border-top",
    @"border-bottom",
    @"border-left",
    @"border-right",
    @"border-block",
    @"border-block-start",
    @"border-block-end",
    @"border-inline",
    @"border-inline-start",
    @"border-inline-end",
    outline,
    @"outline-color",
    @"text-decoration-color": VendorPrefix,
    @"text-emphasis-color": VendorPrefix,
    direction,
    composes,
    all,
    unparsed,
    custom: CustomPropertyName,

    pub usingnamespace PropertyIdImpl();

    /// Returns the property name, without any vendor prefixes.
    pub inline fn name(this: *const PropertyId) []const u8 {
        return @tagName(this.*);
    }

    /// Returns the vendor prefix for this property id.
    pub fn prefix(this: *const PropertyId) VendorPrefix {
        return switch (this.*) {
            .@"background-color" => VendorPrefix.empty(),
            .@"background-image" => VendorPrefix.empty(),
            .@"background-position-x" => VendorPrefix.empty(),
            .@"background-position-y" => VendorPrefix.empty(),
            .@"background-position" => VendorPrefix.empty(),
            .@"background-size" => VendorPrefix.empty(),
            .@"background-repeat" => VendorPrefix.empty(),
            .@"background-attachment" => VendorPrefix.empty(),
            .@"background-clip" => |p| p,
            .@"background-origin" => VendorPrefix.empty(),
            .background => VendorPrefix.empty(),
            .@"box-shadow" => |p| p,
            .opacity => VendorPrefix.empty(),
            .color => VendorPrefix.empty(),
            .display => VendorPrefix.empty(),
            .visibility => VendorPrefix.empty(),
            .width => VendorPrefix.empty(),
            .height => VendorPrefix.empty(),
            .@"min-width" => VendorPrefix.empty(),
            .@"min-height" => VendorPrefix.empty(),
            .@"max-width" => VendorPrefix.empty(),
            .@"max-height" => VendorPrefix.empty(),
            .@"block-size" => VendorPrefix.empty(),
            .@"inline-size" => VendorPrefix.empty(),
            .@"min-block-size" => VendorPrefix.empty(),
            .@"min-inline-size" => VendorPrefix.empty(),
            .@"max-block-size" => VendorPrefix.empty(),
            .@"max-inline-size" => VendorPrefix.empty(),
            .@"box-sizing" => |p| p,
            .@"aspect-ratio" => VendorPrefix.empty(),
            .overflow => VendorPrefix.empty(),
            .@"overflow-x" => VendorPrefix.empty(),
            .@"overflow-y" => VendorPrefix.empty(),
            .@"text-overflow" => |p| p,
            .position => VendorPrefix.empty(),
            .top => VendorPrefix.empty(),
            .bottom => VendorPrefix.empty(),
            .left => VendorPrefix.empty(),
            .right => VendorPrefix.empty(),
            .@"inset-block-start" => VendorPrefix.empty(),
            .@"inset-block-end" => VendorPrefix.empty(),
            .@"inset-inline-start" => VendorPrefix.empty(),
            .@"inset-inline-end" => VendorPrefix.empty(),
            .@"inset-block" => VendorPrefix.empty(),
            .@"inset-inline" => VendorPrefix.empty(),
            .inset => VendorPrefix.empty(),
            .@"border-spacing" => VendorPrefix.empty(),
            .@"border-top-color" => VendorPrefix.empty(),
            .@"border-bottom-color" => VendorPrefix.empty(),
            .@"border-left-color" => VendorPrefix.empty(),
            .@"border-right-color" => VendorPrefix.empty(),
            .@"border-block-start-color" => VendorPrefix.empty(),
            .@"border-block-end-color" => VendorPrefix.empty(),
            .@"border-inline-start-color" => VendorPrefix.empty(),
            .@"border-inline-end-color" => VendorPrefix.empty(),
            .@"border-top-style" => VendorPrefix.empty(),
            .@"border-bottom-style" => VendorPrefix.empty(),
            .@"border-left-style" => VendorPrefix.empty(),
            .@"border-right-style" => VendorPrefix.empty(),
            .@"border-block-start-style" => VendorPrefix.empty(),
            .@"border-block-end-style" => VendorPrefix.empty(),
            .@"border-inline-start-style" => VendorPrefix.empty(),
            .@"border-inline-end-style" => VendorPrefix.empty(),
            .@"border-top-width" => VendorPrefix.empty(),
            .@"border-bottom-width" => VendorPrefix.empty(),
            .@"border-left-width" => VendorPrefix.empty(),
            .@"border-right-width" => VendorPrefix.empty(),
            .@"border-block-start-width" => VendorPrefix.empty(),
            .@"border-block-end-width" => VendorPrefix.empty(),
            .@"border-inline-start-width" => VendorPrefix.empty(),
            .@"border-inline-end-width" => VendorPrefix.empty(),
            .@"border-top-left-radius" => |p| p,
            .@"border-top-right-radius" => |p| p,
            .@"border-bottom-left-radius" => |p| p,
            .@"border-bottom-right-radius" => |p| p,
            .@"border-start-start-radius" => VendorPrefix.empty(),
            .@"border-start-end-radius" => VendorPrefix.empty(),
            .@"border-end-start-radius" => VendorPrefix.empty(),
            .@"border-end-end-radius" => VendorPrefix.empty(),
            .@"border-radius" => |p| p,
            .@"border-image-source" => VendorPrefix.empty(),
            .@"border-image-outset" => VendorPrefix.empty(),
            .@"border-image-repeat" => VendorPrefix.empty(),
            .@"border-image-width" => VendorPrefix.empty(),
            .@"border-image-slice" => VendorPrefix.empty(),
            .@"border-image" => |p| p,
            .@"border-color" => VendorPrefix.empty(),
            .@"border-style" => VendorPrefix.empty(),
            .@"border-width" => VendorPrefix.empty(),
            .@"border-block-color" => VendorPrefix.empty(),
            .@"border-block-style" => VendorPrefix.empty(),
            .@"border-block-width" => VendorPrefix.empty(),
            .@"border-inline-color" => VendorPrefix.empty(),
            .@"border-inline-style" => VendorPrefix.empty(),
            .@"border-inline-width" => VendorPrefix.empty(),
            .border => VendorPrefix.empty(),
            .@"border-top" => VendorPrefix.empty(),
            .@"border-bottom" => VendorPrefix.empty(),
            .@"border-left" => VendorPrefix.empty(),
            .@"border-right" => VendorPrefix.empty(),
            .@"border-block" => VendorPrefix.empty(),
            .@"border-block-start" => VendorPrefix.empty(),
            .@"border-block-end" => VendorPrefix.empty(),
            .@"border-inline" => VendorPrefix.empty(),
            .@"border-inline-start" => VendorPrefix.empty(),
            .@"border-inline-end" => VendorPrefix.empty(),
            .outline => VendorPrefix.empty(),
            .@"outline-color" => VendorPrefix.empty(),
            .@"text-decoration-color" => |p| p,
            .@"text-emphasis-color" => |p| p,
            .direction => VendorPrefix.empty(),
            .composes => VendorPrefix.empty(),
            .all, .custom, .unparsed => VendorPrefix.empty(),
        };
    }

    pub fn fromNameAndPrefix(name1: []const u8, pre: VendorPrefix) ?PropertyId {
        // TODO: todo_stuff.match_ignore_ascii_case
        if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-image")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-image";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-position-x")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-position-x";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-position-y")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-position-y";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-position")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-position";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-repeat")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-repeat";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-attachment")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-attachment";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-clip")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"background-clip" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background-origin")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"background-origin";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "background")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .background;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "box-shadow")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"box-shadow" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "opacity")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .opacity;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .color;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "display")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .display;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "visibility")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .visibility;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .width;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "height")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .height;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "min-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"min-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "min-height")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"min-height";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "max-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"max-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "max-height")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"max-height";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "block-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"block-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inline-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inline-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "min-block-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"min-block-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "min-inline-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"min-inline-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "max-block-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"max-block-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "max-inline-size")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"max-inline-size";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "box-sizing")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"box-sizing" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "aspect-ratio")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"aspect-ratio";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "overflow")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .overflow;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "overflow-x")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"overflow-x";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "overflow-y")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"overflow-y";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "text-overflow")) {
            const allowed_prefixes = VendorPrefix{ .o = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"text-overflow" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "position")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .position;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "top")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .top;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "bottom")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .bottom;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "left")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .left;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "right")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .right;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-block-start")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-block-start";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-block-end")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-block-end";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-inline-start")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-inline-start";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-inline-end")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-inline-end";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-block")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-block";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset-inline")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"inset-inline";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "inset")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .inset;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-spacing")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-spacing";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-top-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-bottom-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-left-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-left-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-right-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-right-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-start-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-start-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-end-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-end-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-start-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-start-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-end-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-end-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-top-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-bottom-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-left-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-left-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-right-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-right-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-start-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-start-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-end-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-end-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-start-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-start-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-end-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-end-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-top-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-bottom-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-left-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-left-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-right-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-right-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-start-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-start-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-end-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-end-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-start-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-start-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-end-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-end-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top-left-radius")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-top-left-radius" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top-right-radius")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-top-right-radius" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom-left-radius")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-bottom-left-radius" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom-right-radius")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-bottom-right-radius" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-start-start-radius")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-start-start-radius";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-start-end-radius")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-start-end-radius";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-end-start-radius")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-end-start-radius";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-end-end-radius")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-end-end-radius";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-radius")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-radius" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image-source")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-image-source";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image-outset")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-image-outset";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image-repeat")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-image-repeat";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-image-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image-slice")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-image-slice";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-image")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true, .o = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"border-image" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-style")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-style";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-width")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-width";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .border;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-top")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-top";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-bottom")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-bottom";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-left")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-left";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-right")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-right";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-start")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-start";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-block-end")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-block-end";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-start")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-start";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "border-inline-end")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"border-inline-end";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "outline")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .outline;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "outline-color")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .@"outline-color";
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "text-decoration-color")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true, .moz = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"text-decoration-color" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "text-emphasis-color")) {
            const allowed_prefixes = VendorPrefix{ .webkit = true };
            if (allowed_prefixes.contains(pre)) return .{ .@"text-emphasis-color" = pre };
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "direction")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .direction;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "composes")) {
            const allowed_prefixes = VendorPrefix{ .none = true };
            if (allowed_prefixes.contains(pre)) return .composes;
        } else if (bun.strings.eqlCaseInsensitiveASCIIICheckLength(name1, "all")) {} else {
            return null;
        }

        return null;
    }

    pub fn withPrefix(this: *const PropertyId, pre: VendorPrefix) PropertyId {
        return switch (this.*) {
            .@"background-color" => .@"background-color",
            .@"background-image" => .@"background-image",
            .@"background-position-x" => .@"background-position-x",
            .@"background-position-y" => .@"background-position-y",
            .@"background-position" => .@"background-position",
            .@"background-size" => .@"background-size",
            .@"background-repeat" => .@"background-repeat",
            .@"background-attachment" => .@"background-attachment",
            .@"background-clip" => .{ .@"background-clip" = pre },
            .@"background-origin" => .@"background-origin",
            .background => .background,
            .@"box-shadow" => .{ .@"box-shadow" = pre },
            .opacity => .opacity,
            .color => .color,
            .display => .display,
            .visibility => .visibility,
            .width => .width,
            .height => .height,
            .@"min-width" => .@"min-width",
            .@"min-height" => .@"min-height",
            .@"max-width" => .@"max-width",
            .@"max-height" => .@"max-height",
            .@"block-size" => .@"block-size",
            .@"inline-size" => .@"inline-size",
            .@"min-block-size" => .@"min-block-size",
            .@"min-inline-size" => .@"min-inline-size",
            .@"max-block-size" => .@"max-block-size",
            .@"max-inline-size" => .@"max-inline-size",
            .@"box-sizing" => .{ .@"box-sizing" = pre },
            .@"aspect-ratio" => .@"aspect-ratio",
            .overflow => .overflow,
            .@"overflow-x" => .@"overflow-x",
            .@"overflow-y" => .@"overflow-y",
            .@"text-overflow" => .{ .@"text-overflow" = pre },
            .position => .position,
            .top => .top,
            .bottom => .bottom,
            .left => .left,
            .right => .right,
            .@"inset-block-start" => .@"inset-block-start",
            .@"inset-block-end" => .@"inset-block-end",
            .@"inset-inline-start" => .@"inset-inline-start",
            .@"inset-inline-end" => .@"inset-inline-end",
            .@"inset-block" => .@"inset-block",
            .@"inset-inline" => .@"inset-inline",
            .inset => .inset,
            .@"border-spacing" => .@"border-spacing",
            .@"border-top-color" => .@"border-top-color",
            .@"border-bottom-color" => .@"border-bottom-color",
            .@"border-left-color" => .@"border-left-color",
            .@"border-right-color" => .@"border-right-color",
            .@"border-block-start-color" => .@"border-block-start-color",
            .@"border-block-end-color" => .@"border-block-end-color",
            .@"border-inline-start-color" => .@"border-inline-start-color",
            .@"border-inline-end-color" => .@"border-inline-end-color",
            .@"border-top-style" => .@"border-top-style",
            .@"border-bottom-style" => .@"border-bottom-style",
            .@"border-left-style" => .@"border-left-style",
            .@"border-right-style" => .@"border-right-style",
            .@"border-block-start-style" => .@"border-block-start-style",
            .@"border-block-end-style" => .@"border-block-end-style",
            .@"border-inline-start-style" => .@"border-inline-start-style",
            .@"border-inline-end-style" => .@"border-inline-end-style",
            .@"border-top-width" => .@"border-top-width",
            .@"border-bottom-width" => .@"border-bottom-width",
            .@"border-left-width" => .@"border-left-width",
            .@"border-right-width" => .@"border-right-width",
            .@"border-block-start-width" => .@"border-block-start-width",
            .@"border-block-end-width" => .@"border-block-end-width",
            .@"border-inline-start-width" => .@"border-inline-start-width",
            .@"border-inline-end-width" => .@"border-inline-end-width",
            .@"border-top-left-radius" => .{ .@"border-top-left-radius" = pre },
            .@"border-top-right-radius" => .{ .@"border-top-right-radius" = pre },
            .@"border-bottom-left-radius" => .{ .@"border-bottom-left-radius" = pre },
            .@"border-bottom-right-radius" => .{ .@"border-bottom-right-radius" = pre },
            .@"border-start-start-radius" => .@"border-start-start-radius",
            .@"border-start-end-radius" => .@"border-start-end-radius",
            .@"border-end-start-radius" => .@"border-end-start-radius",
            .@"border-end-end-radius" => .@"border-end-end-radius",
            .@"border-radius" => .{ .@"border-radius" = pre },
            .@"border-image-source" => .@"border-image-source",
            .@"border-image-outset" => .@"border-image-outset",
            .@"border-image-repeat" => .@"border-image-repeat",
            .@"border-image-width" => .@"border-image-width",
            .@"border-image-slice" => .@"border-image-slice",
            .@"border-image" => .{ .@"border-image" = pre },
            .@"border-color" => .@"border-color",
            .@"border-style" => .@"border-style",
            .@"border-width" => .@"border-width",
            .@"border-block-color" => .@"border-block-color",
            .@"border-block-style" => .@"border-block-style",
            .@"border-block-width" => .@"border-block-width",
            .@"border-inline-color" => .@"border-inline-color",
            .@"border-inline-style" => .@"border-inline-style",
            .@"border-inline-width" => .@"border-inline-width",
            .border => .border,
            .@"border-top" => .@"border-top",
            .@"border-bottom" => .@"border-bottom",
            .@"border-left" => .@"border-left",
            .@"border-right" => .@"border-right",
            .@"border-block" => .@"border-block",
            .@"border-block-start" => .@"border-block-start",
            .@"border-block-end" => .@"border-block-end",
            .@"border-inline" => .@"border-inline",
            .@"border-inline-start" => .@"border-inline-start",
            .@"border-inline-end" => .@"border-inline-end",
            .outline => .outline,
            .@"outline-color" => .@"outline-color",
            .@"text-decoration-color" => .{ .@"text-decoration-color" = pre },
            .@"text-emphasis-color" => .{ .@"text-emphasis-color" = pre },
            .direction => .direction,
            .composes => .composes,
            else => this.*,
        };
    }

    pub fn addPrefix(this: *PropertyId, pre: VendorPrefix) void {
        return switch (this.*) {
            .@"background-color" => {},
            .@"background-image" => {},
            .@"background-position-x" => {},
            .@"background-position-y" => {},
            .@"background-position" => {},
            .@"background-size" => {},
            .@"background-repeat" => {},
            .@"background-attachment" => {},
            .@"background-clip" => |*p| {
                p.insert(pre);
            },
            .@"background-origin" => {},
            .background => {},
            .@"box-shadow" => |*p| {
                p.insert(pre);
            },
            .opacity => {},
            .color => {},
            .display => {},
            .visibility => {},
            .width => {},
            .height => {},
            .@"min-width" => {},
            .@"min-height" => {},
            .@"max-width" => {},
            .@"max-height" => {},
            .@"block-size" => {},
            .@"inline-size" => {},
            .@"min-block-size" => {},
            .@"min-inline-size" => {},
            .@"max-block-size" => {},
            .@"max-inline-size" => {},
            .@"box-sizing" => |*p| {
                p.insert(pre);
            },
            .@"aspect-ratio" => {},
            .overflow => {},
            .@"overflow-x" => {},
            .@"overflow-y" => {},
            .@"text-overflow" => |*p| {
                p.insert(pre);
            },
            .position => {},
            .top => {},
            .bottom => {},
            .left => {},
            .right => {},
            .@"inset-block-start" => {},
            .@"inset-block-end" => {},
            .@"inset-inline-start" => {},
            .@"inset-inline-end" => {},
            .@"inset-block" => {},
            .@"inset-inline" => {},
            .inset => {},
            .@"border-spacing" => {},
            .@"border-top-color" => {},
            .@"border-bottom-color" => {},
            .@"border-left-color" => {},
            .@"border-right-color" => {},
            .@"border-block-start-color" => {},
            .@"border-block-end-color" => {},
            .@"border-inline-start-color" => {},
            .@"border-inline-end-color" => {},
            .@"border-top-style" => {},
            .@"border-bottom-style" => {},
            .@"border-left-style" => {},
            .@"border-right-style" => {},
            .@"border-block-start-style" => {},
            .@"border-block-end-style" => {},
            .@"border-inline-start-style" => {},
            .@"border-inline-end-style" => {},
            .@"border-top-width" => {},
            .@"border-bottom-width" => {},
            .@"border-left-width" => {},
            .@"border-right-width" => {},
            .@"border-block-start-width" => {},
            .@"border-block-end-width" => {},
            .@"border-inline-start-width" => {},
            .@"border-inline-end-width" => {},
            .@"border-top-left-radius" => |*p| {
                p.insert(pre);
            },
            .@"border-top-right-radius" => |*p| {
                p.insert(pre);
            },
            .@"border-bottom-left-radius" => |*p| {
                p.insert(pre);
            },
            .@"border-bottom-right-radius" => |*p| {
                p.insert(pre);
            },
            .@"border-start-start-radius" => {},
            .@"border-start-end-radius" => {},
            .@"border-end-start-radius" => {},
            .@"border-end-end-radius" => {},
            .@"border-radius" => |*p| {
                p.insert(pre);
            },
            .@"border-image-source" => {},
            .@"border-image-outset" => {},
            .@"border-image-repeat" => {},
            .@"border-image-width" => {},
            .@"border-image-slice" => {},
            .@"border-image" => |*p| {
                p.insert(pre);
            },
            .@"border-color" => {},
            .@"border-style" => {},
            .@"border-width" => {},
            .@"border-block-color" => {},
            .@"border-block-style" => {},
            .@"border-block-width" => {},
            .@"border-inline-color" => {},
            .@"border-inline-style" => {},
            .@"border-inline-width" => {},
            .border => {},
            .@"border-top" => {},
            .@"border-bottom" => {},
            .@"border-left" => {},
            .@"border-right" => {},
            .@"border-block" => {},
            .@"border-block-start" => {},
            .@"border-block-end" => {},
            .@"border-inline" => {},
            .@"border-inline-start" => {},
            .@"border-inline-end" => {},
            .outline => {},
            .@"outline-color" => {},
            .@"text-decoration-color" => |*p| {
                p.insert(pre);
            },
            .@"text-emphasis-color" => |*p| {
                p.insert(pre);
            },
            .direction => {},
            .composes => {},
            else => {},
        };
    }

    pub inline fn deepClone(this: *const PropertyId, _: std.mem.Allocator) PropertyId {
        return this.*;
    }

    pub fn eql(lhs: *const PropertyId, rhs: *const PropertyId) bool {
        if (@intFromEnum(lhs.*) != @intFromEnum(rhs.*)) return false;
        inline for (bun.meta.EnumFields(PropertyId), std.meta.fields(PropertyId)) |enum_field, union_field| {
            if (enum_field.value == @intFromEnum(lhs.*)) {
                if (comptime union_field.type == css.VendorPrefix) {
                    return @field(lhs, union_field.name).eql(@field(rhs, union_field.name));
                } else {
                    return true;
                }
            }
        }
        unreachable;
    }
};
pub const PropertyIdTag = enum(u16) {
    @"background-color",
    @"background-image",
    @"background-position-x",
    @"background-position-y",
    @"background-position",
    @"background-size",
    @"background-repeat",
    @"background-attachment",
    @"background-clip",
    @"background-origin",
    background,
    @"box-shadow",
    opacity,
    color,
    display,
    visibility,
    width,
    height,
    @"min-width",
    @"min-height",
    @"max-width",
    @"max-height",
    @"block-size",
    @"inline-size",
    @"min-block-size",
    @"min-inline-size",
    @"max-block-size",
    @"max-inline-size",
    @"box-sizing",
    @"aspect-ratio",
    overflow,
    @"overflow-x",
    @"overflow-y",
    @"text-overflow",
    position,
    top,
    bottom,
    left,
    right,
    @"inset-block-start",
    @"inset-block-end",
    @"inset-inline-start",
    @"inset-inline-end",
    @"inset-block",
    @"inset-inline",
    inset,
    @"border-spacing",
    @"border-top-color",
    @"border-bottom-color",
    @"border-left-color",
    @"border-right-color",
    @"border-block-start-color",
    @"border-block-end-color",
    @"border-inline-start-color",
    @"border-inline-end-color",
    @"border-top-style",
    @"border-bottom-style",
    @"border-left-style",
    @"border-right-style",
    @"border-block-start-style",
    @"border-block-end-style",
    @"border-inline-start-style",
    @"border-inline-end-style",
    @"border-top-width",
    @"border-bottom-width",
    @"border-left-width",
    @"border-right-width",
    @"border-block-start-width",
    @"border-block-end-width",
    @"border-inline-start-width",
    @"border-inline-end-width",
    @"border-top-left-radius",
    @"border-top-right-radius",
    @"border-bottom-left-radius",
    @"border-bottom-right-radius",
    @"border-start-start-radius",
    @"border-start-end-radius",
    @"border-end-start-radius",
    @"border-end-end-radius",
    @"border-radius",
    @"border-image-source",
    @"border-image-outset",
    @"border-image-repeat",
    @"border-image-width",
    @"border-image-slice",
    @"border-image",
    @"border-color",
    @"border-style",
    @"border-width",
    @"border-block-color",
    @"border-block-style",
    @"border-block-width",
    @"border-inline-color",
    @"border-inline-style",
    @"border-inline-width",
    border,
    @"border-top",
    @"border-bottom",
    @"border-left",
    @"border-right",
    @"border-block",
    @"border-block-start",
    @"border-block-end",
    @"border-inline",
    @"border-inline-start",
    @"border-inline-end",
    outline,
    @"outline-color",
    @"text-decoration-color",
    @"text-emphasis-color",
    direction,
    composes,
    all,
    unparsed,
    custom,
};
