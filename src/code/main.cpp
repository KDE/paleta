#include <QApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>
#include <QQmlContext>

#include <QDate>
#include <QIcon>

#include <MauiKit4/Core/mauiapp.h>

#include <KAboutData>
#include <KLocalizedString>

#include "../project_version.h"

#include "colorutils.h"

//Useful for setting quickly an app template
#define ORG_NAME "Maui"
#define PROJECT_NAME "Paleta"
#define COMPONENT_NAME "paleta"
#define PROJECT_DESCRIPTION "Color utilities."
#define PROJECT_YEAR "2022"
#define PRODUCT_NAME "maui/paleta"
#define PROJECT_PAGE "https://mauikit.org"
#define REPORT_PAGE "https://github.com/Nitrux/maui-colors/issues/new"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setOrganizationName(QStringLiteral(ORG_NAME));
    app.setWindowIcon(QIcon(QStringLiteral(":/paleta.png")));

    MauiApp::instance()->setIconName(QStringLiteral("qrc:/paleta.svg"));

    KLocalizedString::setApplicationDomain(COMPONENT_NAME);

    KAboutData about(QStringLiteral(COMPONENT_NAME),
                     QStringLiteral(PROJECT_NAME),
                     QStringLiteral(PROJECT_VERSION_STRING),
                     i18n(PROJECT_DESCRIPTION),
                     KAboutLicense::LGPL_V3,
                     QStringLiteral(APP_COPYRIGHT_NOTICE),
                     QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(i18n("Camilo Higuita"), i18n("Developer"), QStringLiteral("milo.h@aol.com"));

    about.setHomepage(QStringLiteral(PROJECT_PAGE));
    about.setProductName(PRODUCT_NAME);
    about.setBugAddress(REPORT_PAGE);
    about.setOrganizationDomain(PROJECT_URI);
    about.setProgramLogo(app.windowIcon());

    KAboutData::setApplicationData(about);

    QCommandLineParser parser;
    parser.setApplicationDescription(about.shortDescription());
    parser.process(app);
    about.processCommandLine(&parser);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/app/maui/paleta/controls/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    qmlRegisterSingletonType<ColorUtils>(PROJECT_URI, 1, 0, "ColorUtils", [](QQmlEngine *, QJSEngine *) -> QObject*
      {
          return new ColorUtils;
      });

    engine.load(url);

    return app.exec();
}
