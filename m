From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:24 -0700
Subject: [PATCH v13 07/10] KEYS: Add KEYCTL_RESTRICT_KEYRING
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170330235027.6879-8-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Keyrings recently gained restrict_link capabilities that allow
individual keys to be validated prior to linking.  This functionality
was only available using internal kernel APIs.

With the KEYCTL_RESTRICT_KEYRING command existing keyrings can be
configured to check the content of keys before they are linked, and
then allow or disallow linkage of that key to the keyring.

To restrict a keyring, call:

  keyctl(KEYCTL_RESTRICT_KEYRING, key_serial_t keyring, const char *type,
         const char *restriction)

where 'type' is the name of a registered key type and 'restriction' is a
string describing how key linkage is to be restricted. The restriction
option syntax is specific to each key type.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/security/keys.txt |  25 ++++++++++
 include/linux/key.h             |   6 ++-
 include/uapi/linux/keyctl.h     |   1 +
 security/keys/compat.c          |   4 ++
 security/keys/internal.h        |   3 ++
 security/keys/keyctl.c          |  58 ++++++++++++++++++++++
 security/keys/keyring.c         | 105 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index e007825d79b9..b9c86c2550b3 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -857,6 +857,31 @@ The keyctl syscall functions are:
      supported, error ENOKEY if the key could not be found, or error
      EACCES if the key is not readable by the caller.
 
+ (*) Restrict keyring linkage
+
+       long keyctl(KEYCTL_RESTRICT_KEYRING, key_serial_t keyring,
+		   const char *type, const char *restriction);
+
+     An existing keyring can restrict linkage of additional keys by evaluating
+     the contents of the key according to a restriction scheme.
+
+     "keyring" is the key ID for an existing keyring to apply a restriction
+     to. It may be empty or may already have keys linked. Existing linked keys
+     will remain in the keyring even if the new restriction would reject them.
+
+     "type" is a registered key type.
+
+     "restriction" is a string describing how key linkage is to be restricted.
+     The format varies depending on the key type, and the string is passed to
+     the lookup_restriction() function for the requested type.  It may specify
+     a method and relevant data for the restriction such as signature
+     verification or constraints on key payload. If the requested key type is
+     later unregistered, no keys may be added to the keyring after the key type
+     is removed.
+
+     To apply a keyring restriction the process must have Set Attribute
+     permission and the keyring must not be previously restricted.
+
 ===============
 KERNEL SERVICES
 ===============
diff --git a/include/linux/key.h b/include/linux/key.h
index 3f910d624c1f..4fdb63205fa4 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -218,7 +218,8 @@ struct key {
 	/* This is set on a keyring to restrict the addition of a link to a key
 	 * to it.  If this structure isn't provided then it is assumed that the
 	 * keyring is open to any addition.  It is ignored for non-keyring
-	 * keys.
+	 * keys. Only set this value using keyring_restrict(), keyring_alloc(),
+	 * or key_alloc().
 	 *
 	 * This is intended for use with rings of trusted keys whereby addition
 	 * to the keyring needs to be controlled.  KEY_ALLOC_BYPASS_RESTRICTION
@@ -327,6 +328,9 @@ extern key_ref_t keyring_search(key_ref_t keyring,
 extern int keyring_add_key(struct key *keyring,
 			   struct key *key);
 
+extern int keyring_restrict(key_ref_t keyring, const char *type,
+			    const char *restriction);
+
 extern struct key *key_lookup(key_serial_t id);
 
 static inline key_serial_t key_serial(const struct key *key)
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 86eddd6241f3..ff79c44e49a3 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -60,6 +60,7 @@
 #define KEYCTL_INVALIDATE		21	/* invalidate a key */
 #define KEYCTL_GET_PERSISTENT		22	/* get a user's persistent keyring */
 #define KEYCTL_DH_COMPUTE		23	/* Compute Diffie-Hellman values */
+#define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
 
 /* keyctl structures */
 struct keyctl_dh_params {
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 36c80bf5b89c..bb98f2b8dd7d 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -136,6 +136,10 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 		return keyctl_dh_compute(compat_ptr(arg2), compat_ptr(arg3),
 					 arg4, compat_ptr(arg5));
 
+	case KEYCTL_RESTRICT_KEYRING:
+		return keyctl_restrict_keyring(arg2, compat_ptr(arg3),
+					       compat_ptr(arg4));
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3caeeee10a3e..3da71856633e 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -250,6 +250,9 @@ struct iov_iter;
 extern long keyctl_instantiate_key_common(key_serial_t,
 					  struct iov_iter *,
 					  key_serial_t);
+extern long keyctl_restrict_keyring(key_serial_t id,
+				    const char __user *_type,
+				    const char __user *_restriction);
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 extern long keyctl_get_persistent(uid_t, key_serial_t);
 extern unsigned persistent_keyring_expiry;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d580ad06b792..a07944223c9d 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1581,6 +1581,59 @@ long keyctl_session_to_parent(void)
 }
 
 /*
+ * Apply a restriction to a given keyring.
+ *
+ * The caller must have Setattr permission to change keyring restrictions.
+ *
+ * The requested type name may be a NULL pointer to reject all attempts
+ * to link to the keyring. If _type is non-NULL, _restriction can be
+ * NULL or a pointer to a string describing the restriction. If _type is
+ * NULL, _restriction must also be NULL.
+ *
+ * Returns 0 if successful.
+ */
+long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
+			     const char __user *_restriction)
+{
+	key_ref_t key_ref;
+	bool link_reject = !_type;
+	char type[32];
+	char *restriction = NULL;
+	long ret;
+
+	key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
+	if (IS_ERR(key_ref))
+		return PTR_ERR(key_ref);
+
+	if (_type) {
+		ret = key_get_type_from_user(type, _type, sizeof(type));
+		if (ret < 0)
+			goto error;
+	}
+
+	if (_restriction) {
+		if (!_type) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		restriction = strndup_user(_restriction, PAGE_SIZE);
+		if (IS_ERR(restriction)) {
+			ret = PTR_ERR(restriction);
+			goto error;
+		}
+	}
+
+	ret = keyring_restrict(key_ref, link_reject ? NULL : type, restriction);
+	kfree(restriction);
+
+error:
+	key_ref_put(key_ref);
+
+	return ret;
+}
+
+/*
  * The key control system call
  */
 SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
@@ -1691,6 +1744,11 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					 (char __user *) arg3, (size_t) arg4,
 					 (void __user *) arg5);
 
+	case KEYCTL_RESTRICT_KEYRING:
+		return keyctl_restrict_keyring((key_serial_t) arg2,
+					       (const char __user *) arg3,
+					       (const char __user *) arg4);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e46542c87017..b5b967c4a3fc 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -947,6 +947,111 @@ key_ref_t keyring_search(key_ref_t keyring,
 }
 EXPORT_SYMBOL(keyring_search);
 
+static struct key_restriction *keyring_restriction_alloc(
+	key_restrict_link_func_t check)
+{
+	struct key_restriction *keyres =
+		kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
+
+	if (!keyres)
+		return ERR_PTR(-ENOMEM);
+
+	keyres->check = check;
+
+	return keyres;
+}
+
+/*
+ * Semaphore to serialise restriction setup to prevent reference count
+ * cycles through restriction key pointers.
+ */
+static DECLARE_RWSEM(keyring_serialise_restrict_sem);
+
+/*
+ * Check for restriction cycles that would prevent keyring garbage collection.
+ * keyring_serialise_restrict_sem must be held.
+ */
+static bool keyring_detect_restriction_cycle(const struct key *dest_keyring,
+					     struct key_restriction *keyres)
+{
+	while (keyres && keyres->key &&
+	       keyres->key->type == &key_type_keyring) {
+		if (keyres->key == dest_keyring)
+			return true;
+
+		keyres = keyres->key->restrict_link;
+	}
+
+	return false;
+}
+
+/**
+ * keyring_restrict - Look up and apply a restriction to a keyring
+ *
+ * @keyring: The keyring to be restricted
+ * @restriction: The restriction options to apply to the keyring
+ */
+int keyring_restrict(key_ref_t keyring_ref, const char *type,
+		     const char *restriction)
+{
+	struct key *keyring;
+	struct key_type *restrict_type = NULL;
+	struct key_restriction *restrict_link;
+	int ret = 0;
+
+	keyring = key_ref_to_ptr(keyring_ref);
+	key_check(keyring);
+
+	if (keyring->type != &key_type_keyring)
+		return -ENOTDIR;
+
+	if (!type) {
+		restrict_link = keyring_restriction_alloc(restrict_link_reject);
+	} else {
+		restrict_type = key_type_lookup(type);
+
+		if (IS_ERR(restrict_type))
+			return PTR_ERR(restrict_type);
+
+		if (!restrict_type->lookup_restriction) {
+			ret = -ENOENT;
+			goto error;
+		}
+
+		restrict_link = restrict_type->lookup_restriction(restriction);
+	}
+
+	if (IS_ERR(restrict_link)) {
+		ret = PTR_ERR(restrict_link);
+		goto error;
+	}
+
+	down_write(&keyring->sem);
+	down_write(&keyring_serialise_restrict_sem);
+
+	if (keyring->restrict_link)
+		ret = -EEXIST;
+	else if (keyring_detect_restriction_cycle(keyring, restrict_link))
+		ret = -EDEADLK;
+	else
+		keyring->restrict_link = restrict_link;
+
+	up_write(&keyring_serialise_restrict_sem);
+	up_write(&keyring->sem);
+
+	if (ret < 0) {
+		key_put(restrict_link->key);
+		kfree(restrict_link);
+	}
+
+error:
+	if (restrict_type)
+		key_type_put(restrict_type);
+
+	return ret;
+}
+EXPORT_SYMBOL(keyring_restrict);
+
 /*
  * Search the given keyring for a key that might be updated.
  *
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
