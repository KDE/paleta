#pragma once
#include <QObject>
#include <QColor>

class ColorUtils : public QObject
{
    Q_OBJECT
public:
    explicit ColorUtils(QObject *parent = nullptr);

public Q_SLOTS:
    qreal contrastRatio(const QColor &c1, const QColor &c2);

};

