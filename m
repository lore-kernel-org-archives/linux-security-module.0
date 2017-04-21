From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 01:30:33 -0700
Subject: [PATCH 1/5] KEYS: sanitize add_key() and keyctl() key payloads
In-Reply-To: <20170421083037.12746-1-ebiggers3@gmail.com>
References: <20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <20170421083037.12746-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Before returning from add_key() or one of the keyctl() commands that
takes in a key payload, zero the temporary buffer that was allocated to
hold the key payload copied from userspace.  This may contain sensitive
key material that should not be kept around in the slab caches.

This must not be applied before the patch "KEYS: fix dereferencing NULL
payload with nonzero length".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10fcea154c0f..d2852621e358 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -137,6 +137,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 
 	key_ref_put(keyring_ref);
  error3:
+	memzero_explicit(payload, plen);
 	kvfree(payload);
  error2:
 	kfree(description);
@@ -347,7 +348,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	kfree(payload);
+	kzfree(payload);
 error:
 	return ret;
 }
@@ -1098,6 +1099,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		keyctl_change_reqkey_auth(NULL);
 
 error2:
+	memzero_explicit(payload, plen);
 	kvfree(payload);
 error:
 	return ret;
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
