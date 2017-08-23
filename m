From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 23 Aug 2017 06:12:59 -0400
Subject: [PATCH V3 08/10] capabilities: invert logic for clarity
In-Reply-To: <cover.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
Message-ID: <6c9745800b15f096639297937ea53b0ec60c2183.1503459890.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The way the logic was presented, it was awkward to read and verify.  Invert the
logic using DeMorgan's Law to be more easily able to read and understand.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/commoncap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index ffcaff0..eb2da69 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -552,10 +552,10 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
 	bool ret = false;
 
 	if (cap_grew(effective, ambient, cred) &&
-	    (!cap_full(effective, cred) ||
-	     !is_eff(root, cred) ||
-	     !is_real(root, cred) ||
-	     !root_privileged()))
+	    !(cap_full(effective, cred) &&
+	      is_eff(root, cred) &&
+	      is_real(root, cred) &&
+	      root_privileged()))
 		ret = true;
 	return ret;
 }
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
