#include "colorutils.h"
#include <KColorUtils>

ColorUtils::ColorUtils(QObject *parent) : QObject(parent)
{

}

qreal ColorUtils::contrastRatio(const QColor &c1, const QColor &c2)
{
   return KColorUtils::contrastRatio(c1, c2);
}
