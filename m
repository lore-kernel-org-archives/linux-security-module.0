From: ebiggers3@gmail.com (Eric Biggers)
Date: Thu, 26 Oct 2017 20:12:07 -0700
Subject: [PATCH] MAINTAINERS: remove David Safford as maintainer for
	encrypted+trusted keys
Message-ID: <20171027031207.6193-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Emails to David's listed email address bounce, and in the commit log
there's no activity from him within the last 5 years.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d85c08956875..f0b69d1c2041 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7626,7 +7626,6 @@ F:	kernel/kexec*
 
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-M:	David Safford <safford@us.ibm.com>
 L:	linux-security-module at vger.kernel.org
 L:	keyrings at vger.kernel.org
 S:	Supported
@@ -7635,7 +7634,6 @@ F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
-M:	David Safford <safford@us.ibm.com>
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 L:	linux-security-module at vger.kernel.org
 L:	keyrings at vger.kernel.org
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
