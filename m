From: dhowells@redhat.com (David Howells)
Date: Thu, 12 Oct 2017 21:17:10 +0100
Subject: [PATCH 10/15] KEYS: checking the input id parameters before finding
	asymmetric key
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
Message-ID: <150783943076.10956.7407914508155575420.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Lee, Chun-Yi <joeyli.kernel@gmail.com>

For finding asymmetric key, the input id_0 and id_1 parameters can
not be NULL at the same time. This patch adds the BUG_ON checking
for id_0 and id_1.

Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/asymmetric_type.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a597f5c5a222..39aecad286fe 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -57,6 +57,8 @@ struct key *find_asymmetric_key(struct key *keyring,
 	char *req, *p;
 	int len;
 
+	BUG_ON(!id_0 && !id_1);
+
 	if (id_0) {
 		lookup = id_0->data;
 		len = id_0->len;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
