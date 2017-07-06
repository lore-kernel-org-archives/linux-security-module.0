From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu,  6 Jul 2017 19:17:51 -0300
Subject: [PATCH v3 5/7] integrity: Select CONFIG_KEYS instead of depending on
	it
In-Reply-To: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
References: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20170706221753.17380-6-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This avoids a dependency cycle in CONFIG_IMA_APPRAISE_MODSIG (introduced by
a later patch in this series): it will select CONFIG_MODULE_SIG_FORMAT
which in turn selects CONFIG_KEYS. Kconfig then complains that
CONFIG_INTEGRITY_SIGNATURE depends on CONFIG_KEYS.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index da9565891738..0d642e0317c7 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -17,8 +17,8 @@ if INTEGRITY
 
 config INTEGRITY_SIGNATURE
 	bool "Digital signature verification using multiple keyrings"
-	depends on KEYS
 	default n
+	select KEYS
 	select SIGNATURE
 	help
 	  This option enables digital signature verification support
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
