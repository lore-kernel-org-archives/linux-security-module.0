From: hernan@vanguardiasur.com.ar (=?UTF-8?q?Hern=C3=A1n=20Gonzalez?=)
Date: Tue, 27 Feb 2018 19:17:00 -0300
Subject: [PATCH 2/2] security: evm: Constify *integrity_status_msg[]
In-Reply-To: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
Message-ID: <1519769820-20365-2-git-send-email-hernan@vanguardiasur.com.ar>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Note: This is compile only tested.
There is no gain from doing this except for some self-documenting.

Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 826926d..7a968fa 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -30,7 +30,7 @@
 
 int evm_initialized;
 
-static char *integrity_status_msg[] = {
+static const char * const integrity_status_msg[] = {
 	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
 int evm_hmac_attrs;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
