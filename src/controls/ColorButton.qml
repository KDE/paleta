import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import org.mauikit.controls 1.3 as Maui

AbstractButton
{
    id: control
    Maui.Theme.colorSet: Maui.Theme.Button
    Maui.Theme.inherit: false

    property color color : Maui.Theme.backgroundColor
spacing: Maui.Style.space.medium
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    implicitWidth: 100 + leftPadding + rightPadding

    font.pointSize: Maui.Style.fontSizes.small
padding: Maui.Style.space.medium
hoverEnabled: true

    background: Rectangle
    {
        radius: Maui.Style.radiusV
        color: control.down || control.pressed ? Maui.Theme.focusColor : control.hovered ? Maui.Theme.hoverColor : Maui.Theme.alternateBackgroundColor
    }

    contentItem: Column
    {
        spacing: control.spacing
        Rectangle
        {
            height: 32
            width: height
            radius: height/2
            color: control.color
            border.width: 3
            border.color: Maui.ColorUtils.brightnessForColor(control.color) === Maui.ColorUtils.Dark ? Qt.lighter(control.color) : Qt.darker(control.color)

        }

        Label
        {
            width: parent.width
            text: control.text
            font: control.font
            wrapMode: Text.Wrap
        }
    }

}
