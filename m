From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 18 Sep 2017 11:36:31 -0700
Subject: [PATCH] KEYS: fix key refcount leak in keyctl_read_key()
Message-ID: <20170918183631.113991-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In keyctl_read_key(), if key_permission() were to return an error code
other than EACCES, we would leak a the reference to the key.  This can't
actually happen currently because key_permission() can only return an
error code other than EACCES if security_key_permission() does, only
SELinux and Smack implement that hook, and neither can return an error
code other than EACCES.  But it should still be fixed, as it is a bug
waiting to happen.

Fixes: 29db91906340 ("[PATCH] Keys: Add LSM hooks for key management [try #3]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 552e4460683b..365ff85d7e27 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -776,7 +776,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	if (ret == 0)
 		goto can_read_key;
 	if (ret != -EACCES)
-		goto error;
+		goto error2;
 
 	/* we can't; see if it's searchable from this process's keyrings
 	 * - we automatically take account of the fact that it may be
-- 
2.14.1.690.gbb1197296e-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
