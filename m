From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Apr 2017 14:54:24 -0700
Subject: [PATCH RFC 10/11] Smack: sendmsg compile error fix
In-Reply-To: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
Message-ID: <b85e60ae-f3f5-6431-202e-99fdc3868ad5@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH RFC 10/11] Smack: sendmsg compile error fix

Move the declaration of ssp out of ifdefs as it's now
always required.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e1264b9..2ac6d33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3637,11 +3637,11 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 				int size, struct netlbl_lsm_secattr **attrs)
 {
 	struct sockaddr_in *sip = (struct sockaddr_in *) msg->msg_name;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
