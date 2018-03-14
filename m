From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 14 Mar 2018 17:20:17 -0300
Subject: [PATCH 1/4] integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20180314202020.3794-2-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This macro isn't used anymore since commit 0d73a55208e9 ("ima: re-introduce
own integrity cache lock"), so remove it.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/integrity.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 8224880935e0..5e58e02ba8dc 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -30,7 +30,6 @@
 
 /* iint cache flags */
 #define IMA_ACTION_FLAGS	0xff000000
-#define IMA_ACTION_RULE_FLAGS	0x06000000
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
