From: ebiggers3@gmail.com (Eric Biggers)
Date: Sat,  1 Apr 2017 16:39:08 -0700
Subject: [PATCH] KEYS: fix keyctl_set_reqkey_keyring() to not leak thread
	keyrings
Message-ID: <20170401233908.20786-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Running the following program as an unprivileged user exhausts kernel
memory by leaking thread keyrings:

	#include <keyutils.h>

	int main()
	{
		for (;;)
			keyctl_set_reqkey_keyring(KEY_REQKEY_DEFL_THREAD_KEYRING);
	}

Fix it by only creating a new thread keyring if there wasn't one before,
just as we do for process keyrings.

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Cc: stable at vger.kernel.org # 2.6.29+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c       | 13 +++++--------
 security/keys/process_keys.c |  3 +++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 52c34532c785..6f3440530835 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1253,8 +1253,8 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
  * Read or set the default keyring in which request_key() will cache keys and
  * return the old setting.
  *
- * If a process keyring is specified then this will be created if it doesn't
- * yet exist.  The old setting will be returned if successful.
+ * If a thread or process keyring is specified then it will be created if it
+ * doesn't yet exist.  The old setting will be returned if successful.
  */
 long keyctl_set_reqkey_keyring(int reqkey_defl)
 {
@@ -1273,17 +1273,14 @@ long keyctl_set_reqkey_keyring(int reqkey_defl)
 	switch (reqkey_defl) {
 	case KEY_REQKEY_DEFL_THREAD_KEYRING:
 		ret = install_thread_keyring_to_cred(new);
-		if (ret < 0)
+		if (ret < 0 && ret != -EEXIST)
 			goto error;
 		goto set;
 
 	case KEY_REQKEY_DEFL_PROCESS_KEYRING:
 		ret = install_process_keyring_to_cred(new);
-		if (ret < 0) {
-			if (ret != -EEXIST)
-				goto error;
-			ret = 0;
-		}
+		if (ret < 0 && ret != -EEXIST)
+			goto error;
 		goto set;
 
 	case KEY_REQKEY_DEFL_DEFAULT:
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b6fdd22205b1..9e5337876e52 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -135,6 +135,9 @@ int install_thread_keyring_to_cred(struct cred *new)
 {
 	struct key *keyring;
 
+	if (new->thread_keyring)
+		return -EEXIST;
+
 	keyring = keyring_alloc("_tid", new->uid, new->gid, new,
 				KEY_POS_ALL | KEY_USR_VIEW,
 				KEY_ALLOC_QUOTA_OVERRUN,
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
