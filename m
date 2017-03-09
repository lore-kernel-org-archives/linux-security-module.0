From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu,  9 Mar 2017 12:23:09 -0800
Subject: [PATCH v12 04/10] KEYS: Use structure to capture key restriction
	function and data
In-Reply-To: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170309202315.15361-5-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace struct key's restrict_link function pointer with a pointer to
the new struct key_restriction. The structure contains pointers to the
restriction function as well as relevant data for evaluating the
restriction. The optional key_restriction free_data function is called
at keyring destruction time.

The garbage collector checks restrict_link->keytype when key types are
unregistered. Restrictions involving a removed key type are converted
to use restrict_link_reject so that restrictions cannot be removed by
unregistering key types.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/security/keys.txt | 14 +++++---
 certs/system_keyring.c          | 21 +++++++++++-
 include/linux/key.h             |  8 ++---
 security/keys/gc.c              | 11 +++++++
 security/keys/internal.h        |  2 ++
 security/keys/key.c             | 23 ++++++++-----
 security/keys/keyring.c         | 73 ++++++++++++++++++++++++++++++++++++++---
 7 files changed, 128 insertions(+), 24 deletions(-)

diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index 5e7f63bade96..a31b7af8f5cf 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -1032,7 +1032,7 @@ payload contents" for more information.
 	struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
 				  const struct cred *cred,
 				  key_perm_t perm,
-				  key_restrict_link_func_t restrict_link,
+				  struct key_restriction *restrict_link,
 				  unsigned long flags,
 				  struct key *dest);
 
@@ -1044,10 +1044,14 @@ payload contents" for more information.
     KEY_ALLOC_NOT_IN_QUOTA in flags if the keyring shouldn't be accounted
     towards the user's quota).  Error ENOMEM can also be returned.
 
-    If restrict_link not NULL, it should point to a function that will be
-    called each time an attempt is made to link a key into the new keyring.
-    This function is called to check whether a key may be added into the keying
-    or not.  Callers of key_create_or_update() within the kernel can pass
+    If restrict_link is not NULL, it should point to a structure that contains
+    the function that will be called each time an attempt is made to link a key
+    into the new keyring.  The structure may also contain pertinent data, a
+    function to free that data, and an associated key type.  The function is
+    called to check whether a key may be added into the keyring or not.  The
+    key type is used by the garbage collector to clean up function or data
+    pointers in this structure if the given key type is unregistered.  Callers
+    of key_create_or_update() within the kernel can pass
     KEY_ALLOC_BYPASS_RESTRICTION to suppress the check.  An example of using
     this is to manage rings of cryptographic keys that are set up when the
     kernel boots where userspace is also permitted to add keys - provided they
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index e904653b7cff..a64419bdf91e 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
@@ -68,6 +69,24 @@ int restrict_link_by_builtin_and_secondary_trusted(
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  secondary_trusted_keys);
 }
+
+/**
+ * Allocate a struct key_restriction for the "builtin and secondary trust"
+ * keyring. Only for use in system_trusted_keyring_init().
+ */
+static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
+{
+	struct key_restriction *restriction;
+
+	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
+
+	if (!restriction)
+		panic("Can't allocate secondary trusted keyring restriction\n");
+
+	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+
+	return restriction;
+}
 #endif
 
 /*
@@ -95,7 +114,7 @@ static __init int system_trusted_keyring_init(void)
 			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
 			       KEY_USR_WRITE),
 			      KEY_ALLOC_NOT_IN_QUOTA,
-			      restrict_link_by_builtin_and_secondary_trusted,
+			      get_builtin_and_secondary_restriction(),
 			      NULL);
 	if (IS_ERR(secondary_trusted_keys))
 		panic("Can't allocate secondary trusted keyring\n");
diff --git a/include/linux/key.h b/include/linux/key.h
index 771eda3385e0..36725f728145 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -217,7 +217,7 @@ struct key {
 	};
 
 	/* This is set on a keyring to restrict the addition of a link to a key
-	 * to it.  If this method isn't provided then it is assumed that the
+	 * to it.  If this structure isn't provided then it is assumed that the
 	 * keyring is open to any addition.  It is ignored for non-keyring
 	 * keys.
 	 *
@@ -226,7 +226,7 @@ struct key {
 	 * overrides this, allowing the kernel to add extra keys without
 	 * restriction.
 	 */
-	key_restrict_link_func_t restrict_link;
+	struct key_restriction *restrict_link;
 };
 
 extern struct key *key_alloc(struct key_type *type,
@@ -235,7 +235,7 @@ extern struct key *key_alloc(struct key_type *type,
 			     const struct cred *cred,
 			     key_perm_t perm,
 			     unsigned long flags,
-			     key_restrict_link_func_t restrict_link);
+			     struct key_restriction *restrict_link);
 
 
 #define KEY_ALLOC_IN_QUOTA		0x0000	/* add to quota, reject if would overrun */
@@ -311,7 +311,7 @@ extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid
 				 const struct cred *cred,
 				 key_perm_t perm,
 				 unsigned long flags,
-				 key_restrict_link_func_t restrict_link,
+				 struct key_restriction *restrict_link,
 				 struct key *dest);
 
 extern int restrict_link_reject(struct key *keyring,
diff --git a/security/keys/gc.c b/security/keys/gc.c
index addf060399e0..d107a49a99d3 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -229,6 +229,9 @@ static void key_garbage_collector(struct work_struct *work)
 				set_bit(KEY_FLAG_DEAD, &key->flags);
 				key->perm = 0;
 				goto skip_dead_key;
+			} else if (key->type == &key_type_keyring &&
+				   key->restrict_link) {
+				goto found_restricted_keyring;
 			}
 		}
 
@@ -334,6 +337,14 @@ static void key_garbage_collector(struct work_struct *work)
 	gc_state |= KEY_GC_REAP_AGAIN;
 	goto maybe_resched;
 
+	/* We found a restricted keyring and need to update the restriction if
+	 * it is associated with the dead key type.
+	 */
+found_restricted_keyring:
+	spin_unlock(&key_serial_lock);
+	keyring_restriction_gc(key, key_gc_dead_keytype);
+	goto maybe_resched;
+
 	/* We found a keyring and we need to check the payload for links to
 	 * dead or expired keys.  We don't flag another reap immediately as we
 	 * have to wait for the old payload to be destroyed by RCU before we
diff --git a/security/keys/internal.h b/security/keys/internal.h
index a705a7d92ad7..3caeeee10a3e 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -166,6 +166,8 @@ extern void key_change_session_keyring(struct callback_head *twork);
 extern struct work_struct key_gc_work;
 extern unsigned key_gc_delay;
 extern void keyring_gc(struct key *keyring, time_t limit);
+extern void keyring_restriction_gc(struct key *keyring,
+				   struct key_type *dead_type);
 extern void key_schedule_gc(time_t gc_at);
 extern void key_schedule_gc_links(void);
 extern void key_gc_keytype(struct key_type *ktype);
diff --git a/security/keys/key.c b/security/keys/key.c
index 128ea40b01bd..488adf2b6ad4 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -201,12 +201,15 @@ static inline void key_alloc_serial(struct key *key)
  * @cred: The credentials specifying UID namespace.
  * @perm: The permissions mask of the new key.
  * @flags: Flags specifying quota properties.
- * @restrict_link: Optional link restriction method for new keyrings.
+ * @restrict_link: Optional link restriction for new keyrings.
  *
  * Allocate a key of the specified type with the attributes given.  The key is
  * returned in an uninstantiated state and the caller needs to instantiate the
  * key before returning.
  *
+ * The restrict_link structure (if not NULL) will be freed when the
+ * keyring is destroyed, so it must be dynamically allocated.
+ *
  * The user's key count quota is updated to reflect the creation of the key and
  * the user's key data quota has the default for the key type reserved.  The
  * instantiation function should amend this as necessary.  If insufficient
@@ -225,7 +228,7 @@ static inline void key_alloc_serial(struct key *key)
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      kuid_t uid, kgid_t gid, const struct cred *cred,
 		      key_perm_t perm, unsigned long flags,
-		      key_restrict_link_func_t restrict_link)
+		      struct key_restriction *restrict_link)
 {
 	struct key_user *user = NULL;
 	struct key *key;
@@ -497,9 +500,11 @@ int key_instantiate_and_link(struct key *key,
 	}
 
 	if (keyring) {
-		if (keyring->restrict_link) {
-			ret = keyring->restrict_link(keyring, key->type,
-						     &prep.payload, NULL);
+		if (keyring->restrict_link && keyring->restrict_link->check) {
+			struct key_restriction *keyres = keyring->restrict_link;
+
+			ret = keyres->check(keyring, key->type, &prep.payload,
+					    keyres->data);
 			if (ret < 0)
 				goto error;
 		}
@@ -804,7 +809,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
 	int ret;
-	key_restrict_link_func_t restrict_link = NULL;
+	struct key_restriction *restrict_link = NULL;
 
 	/* look up the key type to see if it's one of the registered kernel
 	 * types */
@@ -850,9 +855,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 	index_key.desc_len = strlen(index_key.description);
 
-	if (restrict_link) {
-		ret = restrict_link(keyring, index_key.type, &prep.payload,
-				    NULL);
+	if (restrict_link && restrict_link->check) {
+		ret = restrict_link->check(keyring, index_key.type,
+					   &prep.payload, restrict_link->data);
 		if (ret < 0) {
 			key_ref = ERR_PTR(ret);
 			goto error_free_prep;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index ccffb536d17e..9b1195bb841c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -394,6 +394,15 @@ static void keyring_destroy(struct key *keyring)
 		write_unlock(&keyring_name_lock);
 	}
 
+	if (keyring->restrict_link) {
+		struct key_restriction *keyres = keyring->restrict_link;
+
+		if (keyres->free_data)
+			keyres->free_data(keyres->data);
+
+		kfree(keyres);
+	}
+
 	assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
 }
 
@@ -492,7 +501,7 @@ static long keyring_read(const struct key *keyring,
 struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 			  const struct cred *cred, key_perm_t perm,
 			  unsigned long flags,
-			  key_restrict_link_func_t restrict_link,
+			  struct key_restriction *restrict_link,
 			  struct key *dest)
 {
 	struct key *keyring;
@@ -523,8 +532,8 @@ EXPORT_SYMBOL(keyring_alloc);
  * passing KEY_ALLOC_BYPASS_RESTRICTION to key_instantiate_and_link() when
  * adding a key to a keyring.
  *
- * This is meant to be passed as the restrict_link parameter to
- * keyring_alloc().
+ * This is meant to be stored in a key_restriction structure which is passed
+ * in the restrict_link parameter to keyring_alloc().
  */
 int restrict_link_reject(struct key *keyring,
 			 const struct key_type *type,
@@ -1220,9 +1229,10 @@ void __key_link_end(struct key *keyring,
  */
 static int __key_link_check_restriction(struct key *keyring, struct key *key)
 {
-	if (!keyring->restrict_link)
+	if (!keyring->restrict_link || !keyring->restrict_link->check)
 		return 0;
-	return keyring->restrict_link(keyring, key->type, &key->payload, NULL);
+	return keyring->restrict_link->check(keyring, key->type, &key->payload,
+					     keyring->restrict_link->data);
 }
 
 /**
@@ -1426,3 +1436,56 @@ void keyring_gc(struct key *keyring, time_t limit)
 	up_write(&keyring->sem);
 	kleave(" [gc]");
 }
+
+/*
+ * Garbage collect restriction pointers from a keyring.
+ *
+ * Keyring restrictions are associated with a key type, and must be cleaned
+ * up if the key type is unregistered. The restriction is altered to always
+ * reject additional keys so a keyring cannot be opened up by unregistering
+ * a key type.
+ *
+ * Not called with any keyring locks held. The keyring's key struct will not
+ * be deallocated under us as only our caller may deallocate it.
+ *
+ * The caller is required to hold key_types_sem and dead_type->sem. This is
+ * fulfilled by key_gc_keytype() holding the locks on behalf of
+ * key_garbage_collector(), which it invokes on a workqueue.
+ */
+void keyring_restriction_gc(struct key *keyring, struct key_type *dead_type)
+{
+	struct key_restriction *keyres;
+
+	kenter("%x{%s}", keyring->serial, keyring->description ?: "");
+
+	/*
+	 * keyring->restrict_link is only assigned at key allocation time
+	 * or with the key type locked, so the only values that could be
+	 * concurrently assigned to keyring->restrict_link are for key
+	 * types other than dead_type. Given this, it's ok to check
+	 * the key type before acquiring keyring->sem.
+	 */
+	if (!dead_type || !keyring->restrict_link ||
+	    keyring->restrict_link->keytype != dead_type) {
+		kleave(" [no restriction gc]");
+		return;
+	}
+
+	/* Lock the keyring to ensure that a link is not in progress */
+	down_write(&keyring->sem);
+
+	keyres = keyring->restrict_link;
+
+	keyres->check = restrict_link_reject;
+
+	if (keyres->free_data)
+		keyres->free_data(keyres->data);
+
+	keyres->data = NULL;
+	keyres->free_data = NULL;
+	keyres->keytype = NULL;
+
+	up_write(&keyring->sem);
+
+	kleave(" [restriction gc]");
+}
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
