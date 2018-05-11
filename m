From: alexey.kodanev@oracle.com (Alexey Kodanev)
Date: Fri, 11 May 2018 20:15:12 +0300
Subject: [PATCH v2 2/3] selinux: fix address family in bind() and connect() to
	match address/port
In-Reply-To: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526058913-14198-2-git-send-email-alexey.kodanev@oracle.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Since sctp_bindx() and sctp_connectx() can have multiple addresses,
sk_family can differ from sa_family. Therefore, selinux_socket_bind()
and selinux_socket_connect_helper(), which process sockaddr structure
(address and port), should use the address family from that structure
too, and not from the socket one.

The initialization of the data for the audit record is moved above,
in selinux_socket_bind(), so that there is no duplicate changes and
code.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: new patch in v2

 security/selinux/hooks.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1ed7004..e7882e5a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4630,6 +4630,11 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			goto err_af;
 		}
 
+		ad.type = LSM_AUDIT_DATA_NET;
+		ad.u.net = &net;
+		ad.u.net->sport = htons(snum);
+		ad.u.net->family = family_sa;
+
 		if (snum) {
 			int low, high;
 
@@ -4641,10 +4646,6 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 						      snum, &sid);
 				if (err)
 					goto out;
-				ad.type = LSM_AUDIT_DATA_NET;
-				ad.u.net = &net;
-				ad.u.net->sport = htons(snum);
-				ad.u.net->family = family;
 				err = avc_has_perm(&selinux_state,
 						   sksec->sid, sid,
 						   sksec->sclass,
@@ -4676,15 +4677,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			break;
 		}
 
-		err = sel_netnode_sid(addrp, family, &sid);
+		err = sel_netnode_sid(addrp, family_sa, &sid);
 		if (err)
 			goto out;
 
-		ad.type = LSM_AUDIT_DATA_NET;
-		ad.u.net = &net;
-		ad.u.net->sport = htons(snum);
-		ad.u.net->family = family;
-
 		if (family_sa == AF_INET)
 			ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
 		else
@@ -4780,7 +4776,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		ad.type = LSM_AUDIT_DATA_NET;
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
-		ad.u.net->family = sk->sk_family;
+		ad.u.net->family = address->sa_family;
 		err = avc_has_perm(&selinux_state,
 				   sksec->sid, sid, sksec->sclass, perm, &ad);
 		if (err)
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
