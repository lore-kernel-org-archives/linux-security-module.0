From: keescook@chromium.org (Kees Cook)
Date: Mon, 8 May 2017 14:43:24 -0700
Subject: [PATCH] key: Convert big_key payload.data to struct
Message-ID: <20170508214324.GA124468@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There is a lot of needless casting happening in the big_key data payload.
This is harder to trivially verify by static analysis and specifically
the randstruct GCC plugin (which was unhappy about casting a struct
path across two entries of a void * array). This converts the payload to
the actually used structures (one pointer, one embedded struct, and one
size_t).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/key.h     | 11 ++++++++++-
 security/keys/big_key.c | 45 +++++++++++++++++----------------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 78e25aabedaf..2390830e3b1a 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -24,6 +24,7 @@
 #include <linux/atomic.h>
 #include <linux/assoc_array.h>
 #include <linux/refcount.h>
+#include <linux/path.h>
 
 #ifdef __KERNEL__
 #include <linux/uidgid.h>
@@ -92,7 +93,15 @@ struct keyring_index_key {
 
 union key_payload {
 	void __rcu		*rcu_data0;
-	void			*data[4];
+	union {
+		void		*data[4];
+		/* Layout of big_key payload words. */
+		struct {
+			u8		*key_data;
+			struct path	key_path;
+			size_t		key_len;
+		};
+	};
 };
 
 /*****************************************************************************/
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 835c1ab30d01..6a0feb964e4a 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,16 +22,6 @@
 #include <crypto/skcipher.h>
 
 /*
- * Layout of key payload words.
- */
-enum {
-	big_key_data,
-	big_key_path,
-	big_key_path_2nd_part,
-	big_key_len,
-};
-
-/*
  * Crypto operation with big_key data
  */
 enum big_key_op {
@@ -123,7 +113,7 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
  */
 int big_key_preparse(struct key_preparsed_payload *prep)
 {
-	struct path *path = (struct path *)&prep->payload.data[big_key_path];
+	struct path *path = &prep->payload.key_path;
 	struct file *file;
 	u8 *enckey;
 	u8 *data = NULL;
@@ -138,7 +128,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 	/* Set an arbitrary quota */
 	prep->quotalen = 16;
 
-	prep->payload.data[big_key_len] = (void *)(unsigned long)datalen;
+	prep->payload.key_len = datalen;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
 		/* Create a shmem file to store the data in.  This will permit the data
@@ -190,7 +180,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		/* Pin the mount and dentry to the key so that we can open it again
 		 * later
 		 */
-		prep->payload.data[big_key_data] = enckey;
+		prep->payload.key_data = enckey;
 		*path = file->f_path;
 		path_get(path);
 		fput(file);
@@ -202,7 +192,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		if (!data)
 			return -ENOMEM;
 
-		prep->payload.data[big_key_data] = data;
+		prep->payload.key_data = data;
 		memcpy(data, prep->data, prep->datalen);
 	}
 	return 0;
@@ -222,11 +212,11 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 void big_key_free_preparse(struct key_preparsed_payload *prep)
 {
 	if (prep->datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&prep->payload.data[big_key_path];
+		struct path *path = &prep->payload.key_path;
 
 		path_put(path);
 	}
-	kfree(prep->payload.data[big_key_data]);
+	kfree(prep->payload.key_data);
 }
 
 /*
@@ -235,12 +225,12 @@ void big_key_free_preparse(struct key_preparsed_payload *prep)
  */
 void big_key_revoke(struct key *key)
 {
-	struct path *path = (struct path *)&key->payload.data[big_key_path];
+	struct path *path = &key->payload.key_path;
 
 	/* clear the quota */
 	key_payload_reserve(key, 0);
 	if (key_is_instantiated(key) &&
-	    (size_t)key->payload.data[big_key_len] > BIG_KEY_FILE_THRESHOLD)
+	    key->payload.key_len > BIG_KEY_FILE_THRESHOLD)
 		vfs_truncate(path, 0);
 }
 
@@ -249,17 +239,17 @@ void big_key_revoke(struct key *key)
  */
 void big_key_destroy(struct key *key)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	size_t datalen = key->payload.key_len;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&key->payload.data[big_key_path];
+		struct path *path = &key->payload.key_path;
 
 		path_put(path);
 		path->mnt = NULL;
 		path->dentry = NULL;
 	}
-	kfree(key->payload.data[big_key_data]);
-	key->payload.data[big_key_data] = NULL;
+	kfree(key->payload.key_data);
+	key->payload.key_data = NULL;
 }
 
 /*
@@ -267,7 +257,7 @@ void big_key_destroy(struct key *key)
  */
 void big_key_describe(const struct key *key, struct seq_file *m)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	size_t datalen = key->payload.key_len;
 
 	seq_puts(m, key->description);
 
@@ -283,17 +273,17 @@ void big_key_describe(const struct key *key, struct seq_file *m)
  */
 long big_key_read(const struct key *key, char __user *buffer, size_t buflen)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	size_t datalen = key->payload.key_len;
 	long ret;
 
 	if (!buffer || buflen < datalen)
 		return datalen;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&key->payload.data[big_key_path];
+		struct path *path = &key->payload.key_path;
 		struct file *file;
 		u8 *data;
-		u8 *enckey = (u8 *)key->payload.data[big_key_data];
+		u8 *enckey = key->payload.key_data;
 		size_t enclen = ALIGN(datalen, crypto_skcipher_blocksize(big_key_skcipher));
 
 		data = kmalloc(enclen, GFP_KERNEL);
@@ -329,8 +319,7 @@ long big_key_read(const struct key *key, char __user *buffer, size_t buflen)
 		kfree(data);
 	} else {
 		ret = datalen;
-		if (copy_to_user(buffer, key->payload.data[big_key_data],
-				 datalen) != 0)
+		if (copy_to_user(buffer, key->payload.key_data, datalen) != 0)
 			ret = -EFAULT;
 	}
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
