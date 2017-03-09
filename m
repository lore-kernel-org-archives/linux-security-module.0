From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu,  9 Mar 2017 12:23:13 -0800
Subject: [PATCH v12 08/10] KEYS: Add a lookup_restriction function for the
	asymmetric key type
In-Reply-To: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170309202315.15361-9-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Look up asymmetric keyring restriction information using the key-type
lookup_restrict hook.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/crypto/asymmetric-keys.txt | 35 +++++++++++++++++++
 crypto/asymmetric_keys/asymmetric_type.c | 59 +++++++++++++++++++++++++++-----
 2 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 2b7816dea370..4373e7d86c6a 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -311,3 +311,38 @@ Functions are provided to register and unregister parsers:
 
 Parsers may not have the same name.  The names are otherwise only used for
 displaying in debugging messages.
+
+
+=========================
+KEYRING LINK RESTRICTIONS
+=========================
+
+Keyrings created from userspace using add_key can be configured to check the
+signature of the key being linked.
+
+Several restriction methods are available:
+
+ (1) Restrict using the kernel builtin trusted keyring
+
+     - Option string used with KEYCTL_RESTRICT_KEYRING:
+       - "builtin_trusted"
+
+     The kernel builtin trusted keyring will be searched for the signing
+     key. The ca_keys kernel parameter also affects which keys are used for
+     signature verification.
+
+ (2) Restrict using the kernel builtin and secondary trusted keyrings
+
+     - Option string used with KEYCTL_RESTRICT_KEYRING:
+       - "builtin_and_secondary_trusted"
+
+     The kernel builtin and secondary trusted keyrings will be searched for the
+     signing key. The ca_keys kernel parameter also affects which keys are used
+     for signature verification.
+
+In all of these cases, if the signing key is found the signature of the key to
+be linked will be verified using the signing key.  The requested key is added
+to the keyring only if the signature is successfully verified.  -ENOKEY is
+returned if the parent certificate could not be found, or -EKEYREJECTED is
+returned if the signature check fails or the key is blacklisted.  Other errors
+may be returned if the signature check could not be performed.
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 6600181d5d01..39708253defc 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <keys/system_keyring.h>
 #include "asymmetric_keys.h"
 
 MODULE_LICENSE("GPL");
@@ -451,15 +452,57 @@ static void asymmetric_key_destroy(struct key *key)
 	asymmetric_key_free_kids(kids);
 }
 
+static struct key_restriction *asymmetric_restriction_alloc(
+	key_restrict_link_func_t check,
+	void (*free_data)(void *),
+	void *data)
+{
+	struct key_restriction *keyres =
+		kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
+
+	if (!keyres) {
+		if (free_data)
+			free_data(data);
+
+		return ERR_PTR(-ENOMEM);
+	}
+
+	keyres->check = check;
+	keyres->free_data = free_data;
+	keyres->data = data;
+	keyres->keytype = &key_type_asymmetric;
+
+	return keyres;
+}
+
+/*
+ * look up keyring restrict functions for asymmetric keys
+ */
+static struct key_restriction *asymmetric_lookup_restriction(
+	const char *restriction)
+{
+	if (strcmp("builtin_trusted", restriction) == 0)
+		return asymmetric_restriction_alloc(
+			restrict_link_by_builtin_trusted, NULL, NULL);
+
+	if (strcmp("builtin_and_secondary_trusted", restriction) == 0)
+		return asymmetric_restriction_alloc(
+			restrict_link_by_builtin_and_secondary_trusted,
+			NULL, NULL);
+
+	return ERR_PTR(-EINVAL);
+}
+
 struct key_type key_type_asymmetric = {
-	.name		= "asymmetric",
-	.preparse	= asymmetric_key_preparse,
-	.free_preparse	= asymmetric_key_free_preparse,
-	.instantiate	= generic_key_instantiate,
-	.match_preparse	= asymmetric_key_match_preparse,
-	.match_free	= asymmetric_key_match_free,
-	.destroy	= asymmetric_key_destroy,
-	.describe	= asymmetric_key_describe,
+	.name			= "asymmetric",
+	.preparse		= asymmetric_key_preparse,
+	.free_preparse		= asymmetric_key_free_preparse,
+	.instantiate		= generic_key_instantiate,
+	.match_preparse		= asymmetric_key_match_preparse,
+	.match_free		= asymmetric_key_match_free,
+	.destroy		= asymmetric_key_destroy,
+	.describe		= asymmetric_key_describe,
+	.lookup_restriction	= asymmetric_lookup_restriction,
 };
 EXPORT_SYMBOL_GPL(key_type_asymmetric);
 
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
