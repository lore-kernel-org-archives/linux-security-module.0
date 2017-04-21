From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 01:30:37 -0700
Subject: [PATCH 5/5] KEYS: sanitize key structs before freeing
In-Reply-To: <20170421083037.12746-1-ebiggers3@gmail.com>
References: <20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <20170421083037.12746-6-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

While a 'struct key' itself normally does not contain sensitive
information, Documentation/security/keys.txt actually encourages this:

     "Having a payload is not required; and the payload can, in fact,
     just be a value stored in the struct key itself."

In case someone has taken this advice, or will take this advice in the
future, zero the key structure before freeing it.  We might as well, and
as a bonus this could make it a bit more difficult for an adversary to
determine which keys have recently been in use.

This is safe because the key_jar cache does not use a constructor.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/key.h | 1 -
 security/keys/gc.c  | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 0c9b93b0d1f7..78e25aabedaf 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -173,7 +173,6 @@ struct key {
 #ifdef KEY_DEBUGGING
 	unsigned		magic;
 #define KEY_DEBUG_MAGIC		0x18273645u
-#define KEY_DEBUG_MAGIC_X	0xf8e9dacbu
 #endif
 
 	unsigned long		flags;		/* status flags (change with bitops) */
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 15b9ddf510e4..5233c073d982 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -158,9 +158,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 
 		kfree(key->description);
 
-#ifdef KEY_DEBUGGING
-		key->magic = KEY_DEBUG_MAGIC_X;
-#endif
+		memzero_explicit(key, sizeof(*key));
 		kmem_cache_free(key_jar, key);
 	}
 }
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
