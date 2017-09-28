From: ebiggers3@gmail.com (Eric Biggers)
Date: Thu, 28 Sep 2017 14:25:58 -0700
Subject: [PATCH 3/7] lib/digsig: fix dereference of NULL user_key_payload
In-Reply-To: <20170928212602.41744-1-ebiggers3@gmail.com>
References: <20170928212602.41744-1-ebiggers3@gmail.com>
Message-ID: <20170928212602.41744-4-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

digsig_verify() requests a user key, then accesses its payload.
However, a revoked key has a NULL payload, and we failed to check for
this.  request_key() *does* skip revoked keys, but there is still a
window where the key can be revoked before we acquire its semaphore.

Fix it by checking for a NULL payload, treating it like a key which was
already revoked at the time it was requested.

Fixes: 051dbb918c7f ("crypto: digital signature verification support")
Cc: <stable@vger.kernel.org>    [v3.3+]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/digsig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/digsig.c b/lib/digsig.c
index 03d7c63837ae..6ba6fcd92dd1 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -87,6 +87,12 @@ static int digsig_verify_rsa(struct key *key,
 	down_read(&key->sem);
 	ukp = user_key_payload_locked(key);
 
+	if (!ukp) {
+		/* key was revoked before we acquired its semaphore */
+		err = -EKEYREVOKED;
+		goto err1;
+	}
+
 	if (ukp->datalen < sizeof(*pkh))
 		goto err1;
 
-- 
2.14.2.822.g60be5d43e6-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
