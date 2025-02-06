import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts

import org.mauikit.controls as Maui
import org.mauikit.filebrowsing as FM

Maui.ApplicationWindow
{
    id: root
    title: qsTr("Astro")

    property alias dialog : _dialogLoader.item

    Loader
    {
        id: _dialogLoader
    }


    StackView
    {
        id: _stackView
        anchors.fill: parent
        padding: 0

        initialItem:  ImagePage
        {
            id: _imagePage
        }
    }
}
