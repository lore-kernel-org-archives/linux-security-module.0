From: dhowells@redhat.com (David Howells)
Date: Thu, 08 Jun 2017 14:50:04 +0100
Subject: [PATCH 22/23] crypto : asymmetric_keys : verify_pefile:zero memory
	content before freeing
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
Message-ID: <149692980440.11452.10627624845628502682.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Loganaden Velvindron <logan@hackers.mu>

Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
Signed-off-by: Yasir Auleear <yasirmx@hackers.mu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/verify_pefile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 672a94c2c3ff..d178650fd524 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -381,7 +381,7 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
 	}
 
 error:
-	kfree(desc);
+	kzfree(desc);
 error_no_desc:
 	crypto_free_shash(tfm);
 	kleave(" = %d", ret);
@@ -450,6 +450,6 @@ int verify_pefile_signature(const void *pebuf, unsigned pelen,
 	ret = pefile_digest_pe(pebuf, pelen, &ctx);
 
 error:
-	kfree(ctx.digest);
+	kzfree(ctx.digest);
 	return ret;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
