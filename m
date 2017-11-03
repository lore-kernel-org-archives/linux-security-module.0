From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 03 Nov 2017 11:08:36 -0400
Subject: [PATCH] MAINTAINERS: update the IMA, EVM, trusted-keys,
	encrypted-keys entries
Message-ID: <1509721716.3416.51.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

With all the changes to MAINTAINERS there's a conflict with the patch
in my next branch. ?Could you carry this patch?

thanks,

Mimi
---

Update the mailing list information.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 MAINTAINERS | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c43cfabd438..1b41b99be98e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,8 +5213,7 @@ F:	fs/ext4/
 
 Extended Verification Module (EVM)
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-ima-devel at lists.sourceforge.net
-L:	linux-security-module at vger.kernel.org
+L:	linux-integrity at vger.kernel.org
 S:	Supported
 F:	security/integrity/evm/
 
@@ -6840,9 +6839,7 @@ L:	linux-crypto at vger.kernel.org
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
-L:	linux-ima-devel at lists.sourceforge.net
-L:	linux-ima-user at lists.sourceforge.net
-L:	linux-security-module at vger.kernel.org
+L:	linux-integrity at vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 S:	Supported
 F:	security/integrity/ima/
@@ -7625,7 +7622,7 @@ F:	kernel/kexec*
 
 KEYS-ENCRYPTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-security-module at vger.kernel.org
+L:	linux-integrity at vger.kernel.org
 L:	keyrings at vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
@@ -7634,7 +7631,7 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
-L:	linux-security-module at vger.kernel.org
+L:	linux-integrity at vger.kernel.org
 L:	keyrings at vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
