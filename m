From: dh.herrmann@gmail.com (David Herrmann)
Date: Mon, 23 Apr 2018 15:30:14 +0200
Subject: [PATCH 2/3] net/unix: hook unix_socketpair() into LSM
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Message-ID: <20180423133015.5455-3-dh.herrmann@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Use the newly created LSM-hook for unix_socketpair(). The default hook
return-value is 0, so behavior stays the same unless LSMs start using
this hook.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/unix/af_unix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 68bb70a62afe..bc9705ace9b1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1371,6 +1371,11 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 static int unix_socketpair(struct socket *socka, struct socket *sockb)
 {
 	struct sock *ska = socka->sk, *skb = sockb->sk;
+	int err;
+
+	err = security_unix_stream_socketpair(ska, skb);
+	if (err)
+		return err;
 
 	/* Join our sockets back to back */
 	sock_hold(ska);
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
