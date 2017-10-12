From: dhowells@redhat.com (David Howells)
Date: Thu, 12 Oct 2017 21:16:18 +0100
Subject: [PATCH 03/15] lib/digsig: fix dereference of NULL user_key_payload
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
Message-ID: <150783937851.10956.16601369966019710171.stgit@warthog.procyon.org.uk>
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
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v3.3+]
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/digsig.c |    6 ++++++
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
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
