#include "socketsignal.h"

SocketSignal::SocketSignal(QObject *parent) : QObject(parent) {
}

QString SocketSignal::getSocketPath()
{
    return m_socketPath;
}

void SocketSignal::setSocketPath(const QString &path)
{
    m_socketPath = path;
    QLocalServer::removeServer(m_socketPath);
    if (server.listen(m_socketPath)) {
        connect(&server, &QLocalServer::newConnection, this, &SocketSignal::handleNewConnection);
    }
    socketPathCanged();
}

void SocketSignal::handleNewConnection() {
    QLocalSocket *client = server.nextPendingConnection();
    connect(client, &QLocalSocket::readyRead, this, &SocketSignal::handleReadyRead);
    connect(client, &QLocalSocket::disconnected, client, &QLocalSocket::deleteLater);
}

void SocketSignal::handleReadyRead() {
    QLocalSocket *client = qobject_cast<QLocalSocket *>(sender());
    if (!client) return;

    QString command = QString::fromUtf8(client->readAll()).trimmed();
    emit signalReceived(command);

    client->disconnectFromServer();
}
