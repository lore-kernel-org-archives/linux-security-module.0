From: alexey.kodanev@oracle.com (Alexey Kodanev)
Date: Fri, 11 May 2018 20:15:13 +0300
Subject: [PATCH v2 3/3] selinux: correctly handle sa_family cases in
	selinux_sctp_bind_connect()
In-Reply-To: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526058913-14198-3-git-send-email-alexey.kodanev@oracle.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Allow to pass the socket address structure with AF_UNSPEC family for
compatibility purposes. selinux_socket_bind() will further check it
for INADDR_ANY and selinux_socket_connect_helper() should return
EINVAL.

For a bad address family return EINVAL instead of AFNOSUPPORT error,
i.e. what is expected from SCTP protocol in such case.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: new patch in v2

 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7882e5a..be5817d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5277,6 +5277,7 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	while (walk_size < addrlen) {
 		addr = addr_buf;
 		switch (addr->sa_family) {
+		case AF_UNSPEC:
 		case AF_INET:
 			len = sizeof(struct sockaddr_in);
 			break;
@@ -5284,7 +5285,7 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 			len = sizeof(struct sockaddr_in6);
 			break;
 		default:
-			return -EAFNOSUPPORT;
+			return -EINVAL;
 		}
 
 		err = -EINVAL;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
