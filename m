From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Tue,  4 Apr 2017 11:30:30 -0700
Subject: [PATCH] KEYS: Fix integrity calls to keyring_alloc
Message-ID: <20170404183030.6054-1-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

keyring_alloc's restrict_link parameter was changed to take a structure
pointer instead of a function pointer, but the calls from the integrity
subsystem did not get updated.

Fixes: c5faca6b4a58 ("KEYS: Use structure to capture key restriction function and data")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Addresses the 2017-04-04 linux-next / keys-next build issue.

This commit is on the keyctl-restrict branch of
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
(commit id 34ef461204d6e6c48848ef60fd3bd3bec176fe20)


 security/integrity/digsig.c      |  9 ++++++++-
 security/integrity/ima/ima_mok.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 106e855e2d9d..06554c448dce 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -81,18 +81,25 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 int __init integrity_init_keyring(const unsigned int id)
 {
 	const struct cred *cred = current_cred();
+	struct key_restriction *restriction;
 	int err = 0;
 
 	if (!init_keyring)
 		return 0;
 
+	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
+	if (!restriction)
+		return -ENOMEM;
+
+	restriction->check = restrict_link_to_ima;
+
 	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
 				    KGIDT_INIT(0), cred,
 				    ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 				     KEY_USR_VIEW | KEY_USR_READ |
 				     KEY_USR_WRITE | KEY_USR_SEARCH),
 				    KEY_ALLOC_NOT_IN_QUOTA,
-				    restrict_link_to_ima, NULL);
+				    restriction, NULL);
 	if (IS_ERR(keyring[id])) {
 		err = PTR_ERR(keyring[id]);
 		pr_info("Can't allocate %s keyring (%d)\n",
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 74a279957464..073ddc9bce5b 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -17,6 +17,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <keys/system_keyring.h>
 
 
@@ -27,15 +28,23 @@ struct key *ima_blacklist_keyring;
  */
 __init int ima_mok_init(void)
 {
+	struct key_restriction *restriction;
+
 	pr_notice("Allocating IMA blacklist keyring.\n");
 
+	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
+	if (!restriction)
+		panic("Can't allocate IMA blacklist restriction.");
+
+	restriction->check = restrict_link_by_builtin_trusted;
+
 	ima_blacklist_keyring = keyring_alloc(".ima_blacklist",
 				KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
 				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
 				KEY_USR_VIEW | KEY_USR_READ |
 				KEY_USR_WRITE | KEY_USR_SEARCH,
 				KEY_ALLOC_NOT_IN_QUOTA,
-				restrict_link_by_builtin_trusted, NULL);
+				restriction, NULL);
 
 	if (IS_ERR(ima_blacklist_keyring))
 		panic("Can't allocate IMA blacklist keyring.");
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
