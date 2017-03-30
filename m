From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:18 -0700
Subject: [PATCH v13 01/10] KEYS: Use a typedef for restrict_link function
	pointers
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170330235027.6879-2-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This pointer type needs to be returned from a lookup function, and
without a typedef the syntax gets cumbersome.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/security/keys.txt |  5 +----
 include/linux/key.h             | 16 +++++++---------
 security/keys/key.c             |  8 ++------
 security/keys/keyring.c         |  4 +---
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index 3849814bfe6d..df695bddc140 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -1032,10 +1032,7 @@ payload contents" for more information.
 	struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
 				  const struct cred *cred,
 				  key_perm_t perm,
-				  int (*restrict_link)(struct key *,
-						       const struct key_type *,
-						       unsigned long,
-						       const union key_payload *),
+				  key_restrict_link_func_t restrict_link,
 				  unsigned long flags,
 				  struct key *dest);
 
diff --git a/include/linux/key.h b/include/linux/key.h
index 722914798f37..455171320ffc 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -126,6 +126,10 @@ static inline bool is_key_possessed(const key_ref_t key_ref)
 	return (unsigned long) key_ref & 1UL;
 }
 
+typedef int (*key_restrict_link_func_t)(struct key *keyring,
+					const struct key_type *type,
+					const union key_payload *payload);
+
 /*****************************************************************************/
 /*
  * authentication token / access credential / keyring
@@ -214,9 +218,7 @@ struct key {
 	 * overrides this, allowing the kernel to add extra keys without
 	 * restriction.
 	 */
-	int (*restrict_link)(struct key *keyring,
-			     const struct key_type *type,
-			     const union key_payload *payload);
+	key_restrict_link_func_t restrict_link;
 };
 
 extern struct key *key_alloc(struct key_type *type,
@@ -225,9 +227,7 @@ extern struct key *key_alloc(struct key_type *type,
 			     const struct cred *cred,
 			     key_perm_t perm,
 			     unsigned long flags,
-			     int (*restrict_link)(struct key *,
-						  const struct key_type *,
-						  const union key_payload *));
+			     key_restrict_link_func_t restrict_link);
 
 
 #define KEY_ALLOC_IN_QUOTA		0x0000	/* add to quota, reject if would overrun */
@@ -303,9 +303,7 @@ extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid
 				 const struct cred *cred,
 				 key_perm_t perm,
 				 unsigned long flags,
-				 int (*restrict_link)(struct key *,
-						      const struct key_type *,
-						      const union key_payload *),
+				 key_restrict_link_func_t restrict_link,
 				 struct key *dest);
 
 extern int restrict_link_reject(struct key *keyring,
diff --git a/security/keys/key.c b/security/keys/key.c
index 346fbf201c22..4e9138cc89e0 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -225,9 +225,7 @@ static inline void key_alloc_serial(struct key *key)
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      kuid_t uid, kgid_t gid, const struct cred *cred,
 		      key_perm_t perm, unsigned long flags,
-		      int (*restrict_link)(struct key *,
-					   const struct key_type *,
-					   const union key_payload *))
+		      key_restrict_link_func_t restrict_link)
 {
 	struct key_user *user = NULL;
 	struct key *key;
@@ -806,9 +804,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
 	int ret;
-	int (*restrict_link)(struct key *,
-			     const struct key_type *,
-			     const union key_payload *) = NULL;
+	key_restrict_link_func_t restrict_link = NULL;
 
 	/* look up the key type to see if it's one of the registered kernel
 	 * types */
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index c91e4e0cea08..a7f26fd08f6c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -492,9 +492,7 @@ static long keyring_read(const struct key *keyring,
 struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 			  const struct cred *cred, key_perm_t perm,
 			  unsigned long flags,
-			  int (*restrict_link)(struct key *,
-					       const struct key_type *,
-					       const union key_payload *),
+			  key_restrict_link_func_t restrict_link,
 			  struct key *dest)
 {
 	struct key *keyring;
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
