From: elena.reshetova@intel.com (Elena Reshetova)
Date: Fri, 31 Mar 2017 15:20:48 +0300
Subject: [PATCH 1/2] security,
	keys: convert key.usage from atomic_t to refcount_t
In-Reply-To: <1490962849-3634-1-git-send-email-elena.reshetova@intel.com>
References: <1490962849-3634-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <1490962849-3634-2-git-send-email-elena.reshetova@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 include/linux/key.h              | 5 +++--
 security/keys/gc.c               | 2 +-
 security/keys/key.c              | 6 +++---
 security/keys/keyring.c          | 8 ++++----
 security/keys/proc.c             | 2 +-
 security/keys/request_key_auth.c | 2 +-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e45212f..9d9fac5 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -23,6 +23,7 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 #include <linux/assoc_array.h>
+#include <linux/refcount.h>
 
 #ifdef __KERNEL__
 #include <linux/uidgid.h>
@@ -135,7 +136,7 @@ static inline bool is_key_possessed(const key_ref_t key_ref)
  *   - Kerberos TGTs and tickets
  */
 struct key {
-	atomic_t		usage;		/* number of references */
+	refcount_t		usage;		/* number of references */
 	key_serial_t		serial;		/* key serial number */
 	union {
 		struct list_head graveyard_link;
@@ -242,7 +243,7 @@ extern void key_put(struct key *key);
 
 static inline struct key *__key_get(struct key *key)
 {
-	atomic_inc(&key->usage);
+	refcount_inc(&key->usage);
 	return key;
 }
 
diff --git a/security/keys/gc.c b/security/keys/gc.c
index addf060..4478925 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -220,7 +220,7 @@ static void key_garbage_collector(struct work_struct *work)
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
 
-		if (atomic_read(&key->usage) == 0)
+		if (refcount_read(&key->usage) == 0)
 			goto found_unreferenced_key;
 
 		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
diff --git a/security/keys/key.c b/security/keys/key.c
index 346fbf2..ff92443 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -285,7 +285,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	if (!key->index_key.description)
 		goto no_memory_3;
 
-	atomic_set(&key->usage, 1);
+	refcount_set(&key->usage, 1);
 	init_rwsem(&key->sem);
 	lockdep_set_class(&key->sem, &type->lock_class);
 	key->index_key.type = type;
@@ -621,7 +621,7 @@ void key_put(struct key *key)
 	if (key) {
 		key_check(key);
 
-		if (atomic_dec_and_test(&key->usage))
+		if (refcount_dec_and_test(&key->usage))
 			schedule_work(&key_gc_work);
 	}
 }
@@ -656,7 +656,7 @@ struct key *key_lookup(key_serial_t id)
 
 found:
 	/* pretend it doesn't exist if it is awaiting deletion */
-	if (atomic_read(&key->usage) == 0)
+	if (refcount_read(&key->usage) == 0)
 		goto not_found;
 
 	/* this races with key_put(), but that doesn't matter since key_put()
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index c91e4e0..3d95f7d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1033,7 +1033,7 @@ struct key *find_keyring_by_name(const char *name, bool skip_perm_check)
 			/* we've got a match but we might end up racing with
 			 * key_cleanup() if the keyring is currently 'dead'
 			 * (ie. it has a zero usage count) */
-			if (!atomic_inc_not_zero(&keyring->usage))
+			if (!refcount_inc_not_zero(&keyring->usage))
 				continue;
 			keyring->last_used_at = current_kernel_time().tv_sec;
 			goto out;
@@ -1250,14 +1250,14 @@ int key_link(struct key *keyring, struct key *key)
 	struct assoc_array_edit *edit;
 	int ret;
 
-	kenter("{%d,%d}", keyring->serial, atomic_read(&keyring->usage));
+	kenter("{%d,%d}", keyring->serial, refcount_read(&keyring->usage));
 
 	key_check(keyring);
 	key_check(key);
 
 	ret = __key_link_begin(keyring, &key->index_key, &edit);
 	if (ret == 0) {
-		kdebug("begun {%d,%d}", keyring->serial, atomic_read(&keyring->usage));
+		kdebug("begun {%d,%d}", keyring->serial, refcount_read(&keyring->usage));
 		ret = __key_link_check_restriction(keyring, key);
 		if (ret == 0)
 			ret = __key_link_check_live_key(keyring, key);
@@ -1266,7 +1266,7 @@ int key_link(struct key *keyring, struct key *key)
 		__key_link_end(keyring, &key->index_key, edit);
 	}
 
-	kleave(" = %d {%d,%d}", ret, keyring->serial, atomic_read(&keyring->usage));
+	kleave(" = %d {%d,%d}", ret, keyring->serial, refcount_read(&keyring->usage));
 	return ret;
 }
 EXPORT_SYMBOL(key_link);
diff --git a/security/keys/proc.c b/security/keys/proc.c
index b9f531c..69199f1 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -252,7 +252,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
 		   showflag(key, 'N', KEY_FLAG_NEGATIVE),
 		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
-		   atomic_read(&key->usage),
+		   refcount_read(&key->usage),
 		   xbuf,
 		   key->perm,
 		   from_kuid_munged(seq_user_ns(m), key->uid),
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 6bbe2f5..0f06215 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -213,7 +213,7 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	if (ret < 0)
 		goto error_inst;
 
-	kleave(" = {%d,%d}", authkey->serial, atomic_read(&authkey->usage));
+	kleave(" = {%d,%d}", authkey->serial, refcount_read(&authkey->usage));
 	return authkey;
 
 auth_key_revoked:
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
