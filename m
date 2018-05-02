From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Wed,  2 May 2018 19:08:11 -0400
Subject: [PATCH v6 4/4] KEYS: Print insert-sys-cert information to stdout
	instead of stderr
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
Message-ID: <20180502230811.2751-5-mkayaalp@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Detailed INFO output should go to stdout instead of stderr.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index a3bd7ea8a436..caa446fe91b8 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -32,7 +32,7 @@
 #define USED_SYM  "system_extra_cert_used"
 #define LSIZE_SYM "system_certificate_list_size"
 
-#define info(format, args...) fprintf(stderr, "INFO:    " format, ## args)
+#define info(format, args...) fprintf(stdout, "INFO:    " format, ## args)
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
 
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
