import QtQuick 2.0
import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FM

import org.kde.paleta 1.0 as Paleta

Maui.Page
{
    id: control
    showCSDControls: true
    headBar.background: null
    autoHideHeader: true
    property real contrastRatio : Maui.ColorUtils.contrastRatio(_imgColors.foreground, _imgColors.background)

    background: Rectangle
    {
        readonly property bool isDark : Maui.ColorUtils.brightnessForColor(_imgColors.dominant) === Maui.ColorUtils.Dark
        color: Maui.ColorUtils.tintWithAlpha(Maui.Theme.backgroundColor, _imgColors.dominant, isDark ? 0.2 : 0.4)
    }

    Component
    {
        id:  _fileDialogComponent
        FM.FileDialog
        {

        }
    }

    headBar.leftContent: Maui.ToolButtonMenu
    {
        icon.name: "application-menu"
        MenuItem
        {
            text: i18n("Settings")
            icon.name: "settings-configure"
        }

        MenuItem
        {
            text: i18n("About")
            icon.name: "documentinfo"
            onTriggered: root.about()
        }

    }

    headBar.rightContent: Switch
    {
        //            text: i18n("Dark")
        icon.name: "contrast"
        checked: Maui.Style.styleType === Maui.Style.Dark

        onToggled: Maui.Style.styleType = Maui.Style.styleType === Maui.Style.Dark ? Maui.Style.Light : Maui.Style.Dark
    }

    Maui.ImageColors
    {
        id: _imgColors
        source: _img.imageSource.replace("file://", "")
    }

    ScrollView
    {
        width: Math.min(parent.width, 800)
        anchors.centerIn: parent
        height: Math.min(contentHeight+ topPadding +bottomPadding, parent.height)
        padding: Maui.Style.space.medium

        Flickable
        {
            id: _flickable

            //            contentWidth: availableWidth
            contentHeight: _grid.implicitHeight

            GridLayout
            {
                id: _grid
                readonly property bool isWide : width > Maui.Style.units.gridUnit * 30
                width: parent.width

                //rows: 2
                columns: isWide? 2 : 1
                rowSpacing: Maui.Style.space.huge
                columnSpacing: rowSpacing

                ColumnLayout
                {
                    spacing: Maui.Style.space.medium
                    Layout.preferredWidth: 200
                    Layout.fillWidth: !_grid.isWide

                    Item
                    {

                        implicitHeight: 200
                        Layout.fillWidth: true
                        Maui.IconItem
                        {
                            id: _img
                            anchors.fill:parent
                            imageSource: "file:///home/camilo/Downloads/Elizabeth Pryton/EP 1335_e.jpg"
                            maskRadius: Maui.Style.radiusV
                        }

                        DropArea
                        {
                            id: _dropArea
                            anchors.fill: parent
                            onDropped: _img.imageSource = drop.urls[0]

                            Rectangle
                            {
                                anchors.fill: parent
                                radius: Maui.Style.radiusV
                                visible: _dropArea.containsDrag
                                color: Maui.Theme.backgroundColor
                            }
                        }
                    }

                    Button
                    {
                        Layout.alignment: Qt.AlignCenter
                        //                        Layout.fillWidth: true
                        text: i18n("Select")
                        onClicked: openImage()
                    }
                }


                Maui.SectionGroup
                {
                    Layout.fillWidth: true
                    //                Layout.minimumWidth: 300
                    title: "Colors"

                    Maui.SectionItem
                    {
                        label1.text: i18n("Palette")
                        columns: 1

                        Flow
                        {
                            spacing: Maui.Style.space.medium
                            Layout.fillWidth: true

                            Repeater
                            {
                                model:_imgColors.palette

                                delegate: ColorButton
                                {

                                    color: modelData.color
                                    text: modelData.color

                                    onClicked:
                                    {
                                        Maui.Handy.copyTextToClipboard(modelData.color)
                                        root.notify("color", "Color copied1","color copied", () => {console.log(index)}, 2000, i18n("Copy"))

                                    }
                                }
                            }
                        }
                    }

                    Maui.SectionItem
                    {
                        label1.text: i18n("Colors")
                        columns: 1

                        Flow
                        {
                            Layout.fillWidth: true
                            spacing: Maui.Style.space.medium

                            ColorButton
                            {
                                color: _imgColors.background
                                text: i18n("Background")
                            }

                            ColorButton
                            {
                                color: _imgColors.foreground
                                text: i18n("Foreground")

                            }

                            ColorButton
                            {
                                color: _imgColors.dominant
                                text: i18n("Dominant")

                            }

                            ColorButton
                            {
                                color: _imgColors.highlight
                                text: i18n("Highlight")

                            }

                            ColorButton
                            {
                                color: _imgColors.average
                                text: i18n("Average")

                            }
                        }
                    }


                    Maui.SectionItem
                    {
                        label1.text: i18n("Others")
                        columns: 1
                        Flow
                        {
                            Layout.fillWidth: true
                            spacing: Maui.Style.space.medium

                            ColorButton
                            {
                                color: _imgColors.closestToWhite
                                text: i18n("Light")

                            }
                            ColorButton
                            {
                                color: _imgColors.closestToBlack
                                text: i18n("Dark")

                            }
                        }
                    }
                }

                Maui.SectionGroup
                {
                    Layout.fillWidth: true
                    Layout.columnSpan: _grid.columns
                    title: i18n("Contrast Ratio")


                    Pane
                    {
                        Layout.fillWidth: true
                        implicitWidth: _layout.implicitWidth + leftPadding + rightPadding
                        implicitHeight: _layout.implicitHeight + topPadding + bottomPadding

                        background: Rectangle
                        {
                            radius: Maui.Style.radiusV
                            color: _imgColors.background
                        }

                        contentItem: ColumnLayout
                        {
                            id: _layout
                            spacing: Maui.Style.space.medium

                            Label
                            {
                                Layout.fillWidth: true
                                text: i18n("Hello World! This is an example text.")
                                font: Maui.Style.h1Font
                                color: _imgColors.foreground
                                wrapMode: Text.Wrap
                                elide: Text.ElideRight
                                verticalAlignment: Qt.AlignVCenter
                            }

                            Label
                            {
                                Layout.fillWidth: true

                                text: i18n("WCAG 2.0 level AA requires a contrast ratio of at least 4.5:1 for normal text and 3:1 for large text. .")
                                color: _imgColors.foreground
                                wrapMode: Text.Wrap
                                elide: Text.ElideRight
                                verticalAlignment: Qt.AlignVCenter
                            }
                        }
                    }

                    Maui.SectionItem
                    {
                        label1.text: i18n("Contrast Ratio")
                        label2.text: contrastRatio
                    }

                    Maui.SectionItem
                    {
                        label1.text: "Checks"

                        columns: 1

                        Flow
                        {
                            Layout.fillWidth: true
                            spacing: Maui.Style.space.medium

                            Maui.Chip
                            {
                                text: i18n("AA Small Text")
                                icon.name: passes ? "checkbox" : "error"
                                property bool passes : contrastRatio > 4.5
                                color: passes ? Maui.Theme.positiveBackgroundColor : Maui.Theme.negativeBackgroundColor
                            }

                            Maui.Chip
                            {
                                text: i18n("AAA Small Text")
                                icon.name: passes ? "checkbox" : "error"

                                property bool passes : contrastRatio > 7.0
                                color: passes ? Maui.Theme.positiveBackgroundColor : Maui.Theme.negativeBackgroundColor
                            }

                            Maui.Chip
                            {
                                text: i18n("AA Large Text")
                                icon.name: passes ? "checkbox" : "error"

                                property bool passes : contrastRatio > 3
                                color: passes ? Maui.Theme.positiveBackgroundColor : Maui.Theme.negativeBackgroundColor
                            }

                            Maui.Chip
                            {
                                text: i18n("AAA Large Text")
                                icon.name: passes ? "checkbox" : "error"

                                property bool passes : contrastRatio > 4.5
                                color: passes ? Maui.Theme.positiveBackgroundColor : Maui.Theme.negativeBackgroundColor
                            }
                        }
                    }
                }
            }
        }
    }

    Maui.Holder
    {
        anchors.fill: parent
        visible: _img.imageSource.length === 0

        emoji: Maui.App.iconName
        title: Maui.App.about.displayName
        body: Maui.App.about.shortDescription

        actions: Action
        {
            text: i18n("Open...")
            onTriggered: openImage()
        }
    }

    function openImage()
    {
        _dialogLoader.sourceComponent = _fileDialogComponent
        dialog.mode = dialog.modes.OPEN
        dialog.singleSelection = true
        dialog.callback = (urls) => { console.log("files selected:", urls); _img.imageSource = urls[0]}

        dialog.settings.filterType = FM.FMList.IMAGE
        dialog.open()
    }
}
