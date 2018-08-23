From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 23 Aug 2018 08:42:55 -0500
Subject: [PATCH] apparmor: remove dead code
Message-ID: <20180823134255.GA12128@embeddedor.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Due to commit fb5841091f28 ("apparmor: remove no-op permission check
in policy_unpack"), there is some leftover code.

Coverity reports this issue as Structurally dead code. Fix this by
removing such code.

Addresses-Coverity-ID: 1472998 ("Structurally dead code")
Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/apparmor/policy_unpack.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3647b58..21cb384 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -422,10 +422,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
 	}
 
 	return dfa;
-
-fail:
-	aa_put_dfa(dfa);
-	return ERR_PTR(-EPROTO);
 }
 
 /**
-- 
2.7.4
