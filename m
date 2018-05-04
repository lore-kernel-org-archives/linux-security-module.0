From: dh.herrmann@gmail.com (David Herrmann)
Date: Fri,  4 May 2018 16:28:20 +0200
Subject: [PATCH v2 2/4] net: hook socketpair() into LSM
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Message-ID: <20180504142822.15233-3-dh.herrmann@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Use the newly created LSM-hook for socketpair(). The default hook
return-value is 0, so behavior stays the same unless LSMs start using
this hook.

Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/socket.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..667a7b397134 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1420,6 +1420,13 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 		goto out;
 	}
 
+	err = security_socket_socketpair(sock1, sock2);
+	if (unlikely(err)) {
+		sock_release(sock2);
+		sock_release(sock1);
+		goto out;
+	}
+
 	err = sock1->ops->socketpair(sock1, sock2);
 	if (unlikely(err < 0)) {
 		sock_release(sock2);
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
