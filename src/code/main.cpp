#include <QApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>
#include <QDate>
#include <QIcon>

#include <MauiKit/Core/mauiapp.h>

#include <KAboutData>
#include <KI18n/KLocalizedString>

#include "../project_version.h"

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
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName(QStringLiteral(ORG_NAME));
    app.setWindowIcon(QIcon(":/logo.png"));

    MauiApp::instance()->setIconName("qrc:/logo.svg");

    KLocalizedString::setApplicationDomain(COMPONENT_NAME);

    KAboutData about(QStringLiteral(COMPONENT_NAME), i18n(PROJECT_NAME), PROJECT_VERSION_STRING, i18n(PROJECT_DESCRIPTION),
                     KAboutLicense::LGPL_V3, QString("© %1-%2 %3 Development Team").arg(PROJECT_YEAR, QString::number(QDate::currentDate().year()), ORG_NAME), QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(i18n("Camilo Higuita"), i18n("Developer"), QStringLiteral("milo.h@aol.com"));

    about.setHomepage(PROJECT_PAGE);
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
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
