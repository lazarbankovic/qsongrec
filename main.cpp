#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "socketsignal.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QSettings>
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qDebug() << "SSL Support:" << QSslSocket::supportsSsl();
    qDebug() << "SSL Library:" << QSslSocket::sslLibraryBuildVersionString();

    qmlRegisterType<SocketSignal>("CustomControls", 1, 0, "SocketSignal");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
