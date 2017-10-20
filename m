From: wangboshi@huawei.com (Boshi Wang)
Date: Fri, 20 Oct 2017 16:01:03 +0800
Subject: [PATCH] ima: fix hash algorithm initialization
In-Reply-To: <3aaaf65f-d3b0-f770-f074-11e8f9796685@huawei.com>
References: <3aaaf65f-d3b0-f770-f074-11e8f9796685@huawei.com>
Message-ID: <20171020080105.178467-1-wangboshi@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The hash_setup function always sets the hash_setup_done flag, even
when the hash algorithm is invalid.  This prevents the default hash
algorithm defined as CONFIG_IMA_DEFAULT_HASH from being used.

This patch sets hash_setup_done flag only for valid hash algorithms.

Signed-off-by: Boshi Wang <wangboshi@huawei.com>
---
 security/integrity/ima/ima_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb79..ab70a39 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -51,6 +51,8 @@ static int __init hash_setup(char *str)
 			ima_hash_algo = HASH_ALGO_SHA1;
 		else if (strncmp(str, "md5", 3) == 0)
 			ima_hash_algo = HASH_ALGO_MD5;
+		else
+			return 1;
 		goto out;
 	}
 
@@ -60,6 +62,8 @@ static int __init hash_setup(char *str)
 			break;
 		}
 	}
+	if (i == HASH_ALGO__LAST)
+		return 1;
 out:
 	hash_setup_done = 1;
 	return 1;
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
