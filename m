From: aranea@aixah.de (Luis Ressel)
Date: Mon, 19 Jun 2017 23:33:48 +0200
Subject: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
Message-ID: <20170619213348.2970-1-aranea@aixah.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.

Signed-off-by: Luis Ressel <aranea@aixah.de>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 819fd6858b49..1a331fba4a3c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1275,6 +1275,7 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 		case SOCK_SEQPACKET:
 			return SECCLASS_UNIX_STREAM_SOCKET;
 		case SOCK_DGRAM:
+		case SOCK_RAW:
 			return SECCLASS_UNIX_DGRAM_SOCKET;
 		}
 		break;
-- 
2.13.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
