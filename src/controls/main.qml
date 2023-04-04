import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FM

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
