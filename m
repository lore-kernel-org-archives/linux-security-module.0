From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 17 Oct 2017 22:53:21 -0200
Subject: [PATCH v5 08/18] integrity: Select CONFIG_KEYS instead of depending
	on it
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20171018005331.2688-9-bauerman@linux.vnet.ibm.com>
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
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
