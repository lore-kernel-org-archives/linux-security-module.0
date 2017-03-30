From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:20 -0700
Subject: [PATCH v13 03/10] KEYS: Add a key restriction struct
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170330235027.6879-4-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Key link restrictions require restriction-specific data as well as a
restriction-specific function pointer. As a first step toward replacing
the restrict_link pointer in struct key, define a more general
key_restriction structure that captures the required function, key, and
key type pointers. Key type modules should not be pinned on account of
this key type pointer because the pointer will be cleared by the garbage
collector if the key type is unregistered.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/linux/key.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 59cad0268fa7..9fd726642846 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -131,6 +131,12 @@ typedef int (*key_restrict_link_func_t)(struct key *dest_keyring,
 					const union key_payload *payload,
 					struct key *restriction_key);
 
+struct key_restriction {
+	key_restrict_link_func_t check;
+	struct key *key;
+	struct key_type *keytype;
+};
+
 /*****************************************************************************/
 /*
  * authentication token / access credential / keyring
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
