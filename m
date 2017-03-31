From: elena.reshetova@intel.com (Elena Reshetova)
Date: Fri, 31 Mar 2017 15:20:49 +0300
Subject: [PATCH 2/2] security,
	keys: convert key_user.usage from atomic_t to refcount_t
In-Reply-To: <1490962849-3634-1-git-send-email-elena.reshetova@intel.com>
References: <1490962849-3634-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <1490962849-3634-3-git-send-email-elena.reshetova@intel.com>
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
 security/keys/internal.h     | 3 ++-
 security/keys/key.c          | 6 +++---
 security/keys/proc.c         | 2 +-
 security/keys/process_keys.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 74c1411..298439b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -17,6 +17,7 @@
 #include <linux/key-type.h>
 #include <linux/task_work.h>
 #include <linux/keyctl.h>
+#include <linux/refcount.h>
 
 struct iovec;
 
@@ -53,7 +54,7 @@ struct key_user {
 	struct rb_node		node;
 	struct mutex		cons_lock;	/* construction initiation lock */
 	spinlock_t		lock;
-	atomic_t		usage;		/* for accessing qnkeys & qnbytes */
+	refcount_t		usage;		/* for accessing qnkeys & qnbytes */
 	atomic_t		nkeys;		/* number of keys */
 	atomic_t		nikeys;		/* number of instantiated keys */
 	kuid_t			uid;
diff --git a/security/keys/key.c b/security/keys/key.c
index ff92443..b4958b3 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -93,7 +93,7 @@ struct key_user *key_user_lookup(kuid_t uid)
 
 	/* if we get here, then the user record still hadn't appeared on the
 	 * second pass - so we use the candidate record */
-	atomic_set(&candidate->usage, 1);
+	refcount_set(&candidate->usage, 1);
 	atomic_set(&candidate->nkeys, 0);
 	atomic_set(&candidate->nikeys, 0);
 	candidate->uid = uid;
@@ -110,7 +110,7 @@ struct key_user *key_user_lookup(kuid_t uid)
 
 	/* okay - we found a user record for this UID */
 found:
-	atomic_inc(&user->usage);
+	refcount_inc(&user->usage);
 	spin_unlock(&key_user_lock);
 	kfree(candidate);
 out:
@@ -122,7 +122,7 @@ struct key_user *key_user_lookup(kuid_t uid)
  */
 void key_user_put(struct key_user *user)
 {
-	if (atomic_dec_and_lock(&user->usage, &key_user_lock)) {
+	if (refcount_dec_and_lock(&user->usage, &key_user_lock)) {
 		rb_erase(&user->node, &key_user_tree);
 		spin_unlock(&key_user_lock);
 
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 69199f1..bf08d02 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -340,7 +340,7 @@ static int proc_key_users_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "%5u: %5d %d/%d %d/%d %d/%d\n",
 		   from_kuid_munged(seq_user_ns(m), user->uid),
-		   atomic_read(&user->usage),
+		   refcount_read(&user->usage),
 		   atomic_read(&user->nkeys),
 		   atomic_read(&user->nikeys),
 		   user->qnkeys,
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b6fdd22..44451af 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -30,7 +30,7 @@ static DEFINE_MUTEX(key_user_keyring_mutex);
 
 /* The root user's tracking struct */
 struct key_user root_key_user = {
-	.usage		= ATOMIC_INIT(3),
+	.usage		= REFCOUNT_INIT(3),
 	.cons_lock	= __MUTEX_INITIALIZER(root_key_user.cons_lock),
 	.lock		= __SPIN_LOCK_UNLOCKED(root_key_user.lock),
 	.nkeys		= ATOMIC_INIT(2),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
