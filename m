From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu,  9 Mar 2017 12:23:10 -0800
Subject: [PATCH v12 05/10] KEYS: Add an optional lookup_restriction hook to
	key_type
In-Reply-To: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170309202315.15361-6-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The restrict_link functions used to validate keys as they are linked
to a keyring can be associated with specific key types.  Each key type
may be loaded (or not) at runtime, so lookup of restrict_link
functions needs to be part of the key type implementation to ensure
that the requested keys can be examined.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/security/keys.txt | 9 +++++++++
 include/linux/key-type.h        | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index a31b7af8f5cf..18d54fbc9129 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -1433,6 +1433,15 @@ The structure has a number of fields, some of which are mandatory:
      	 The authorisation key.
 
 
+ (*) struct key_restriction *(*lookup_restriction)(const char *params);
+
+     This optional method is used to enable userspace configuration of keyring
+     restrictions. The restriction parameter string (not including the key type
+     name) is passed in, and this method returns a pointer to a key_restriction
+     structure containing the relevant functions and data to evaluate each
+     attempted key link operation. If there is no match, -EINVAL is returned.
+
+
 ============================
 REQUEST-KEY CALLBACK SERVICE
 ============================
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index eaee981c5558..0a0b4c61e829 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -147,6 +147,15 @@ struct key_type {
 	 */
 	request_key_actor_t request_key;
 
+	/* Look up a keyring access restriction (optional)
+	 *
+	 * - The caller must hold a read lock on the key type's semaphore
+	 * - NULL is a valid return value (meaning the requested restriction
+	 *   is known but will never block addition of a key)
+	 * - should return -EINVAL if the restriction is unknown
+	 */
+	struct key_restriction *(*lookup_restriction)(const char *params);
+
 	/* internal fields */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
