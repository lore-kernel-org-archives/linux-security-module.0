From: ebiggers3@gmail.com (Eric Biggers)
Date: Sat,  1 Apr 2017 14:34:28 -0700
Subject: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
Message-ID: <20170401213428.17097-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sys_add_key() and the KEYCTL_UPDATE operation of sys_keyctl() allowed a
NULL payload with nonzero length to be passed to the key type's
->preparse(), ->instantiate(), and/or ->update() methods.  Various key
types including asymmetric, cifs.idmap, cifs.spnego, and pkcs7_test did
not handle this case, allowing an unprivileged user to trivially cause a
NULL pointer dereference (kernel oops) if one of these key types was
present.  Fix it by doing the copy_from_user() when 'plen' is nonzero
rather than when '_payload' is non-NULL, causing the syscall to fail
with EFAULT as expected when an invalid buffer is specified.

Cc: stable at vger.kernel.org # 2.6.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 52c34532c785..57447cd29154 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -99,7 +99,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	/* pull the payload in if one was supplied */
 	payload = NULL;
 
-	if (_payload) {
+	if (plen) {
 		ret = -ENOMEM;
 		payload = kmalloc(plen, GFP_KERNEL | __GFP_NOWARN);
 		if (!payload) {
@@ -324,7 +324,7 @@ long keyctl_update_key(key_serial_t id,
 
 	/* pull the payload in if one was supplied */
 	payload = NULL;
-	if (_payload) {
+	if (plen) {
 		ret = -ENOMEM;
 		payload = kmalloc(plen, GFP_KERNEL);
 		if (!payload)
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
