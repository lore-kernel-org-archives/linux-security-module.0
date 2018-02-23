From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Feb 2018 22:12:09 +0100
Subject: [PATCH] selinux: fix typo in selinux_netlbl_sctp_sk_clone declaration
Message-ID: <20180223211235.2402024-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A missing 'struct' keyword caused a build error when CONFIG_NETLABEL
is disabled:

In file included from security/selinux/hooks.c:99:
security/selinux/include/netlabel.h:135:66: error: unknown type name 'sock'
 static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
                                                                  ^~~~
security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
security/selinux/hooks.c:5188:2: error: implicit declaration of function 'selinux_netlbl_sctp_sk_clone'; did you mean 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-declaration]

Fixes: db97c9f9d312 ("selinux: Add SCTP support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/selinux/include/netlabel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 6ef4953431dc..8671de09c363 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -132,7 +132,8 @@ static inline void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
 	return;
 }
-static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk, sock *newsk)
+static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
+						struct sock *newsk)
 {
 	return;
 }
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
