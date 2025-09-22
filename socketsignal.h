#pragma once

#include <QObject>
#include <QLocalServer>
#include <QLocalSocket>

class SocketSignal : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString socketPath READ getSocketPath WRITE setSocketPath NOTIFY socketPathCanged)

public:
    explicit SocketSignal(QObject *parent = nullptr);

    QString getSocketPath();
    void setSocketPath(const QString &path);

signals:
    void signalReceived(const QString &data);
    void socketPathCanged();

private slots:
    void handleNewConnection();
    void handleReadyRead();

private:
    QLocalServer server;
    QString m_socketPath;
};
