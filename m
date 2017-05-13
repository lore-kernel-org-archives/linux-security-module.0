From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:53 -0700
Subject: [PATCH 17/17] doc: ReSTify keys-trusted-encrypted.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-18-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under keys security devel index.

Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/security/00-INDEX                    |  4 ---
 Documentation/security/conf.py                     |  8 ------
 Documentation/security/keys/index.rst              |  1 +
 .../trusted-encrypted.rst}                         | 32 ++++++++++++++--------
 MAINTAINERS                                        |  4 +--
 security/keys/encrypted-keys/encrypted.c           |  2 +-
 security/keys/encrypted-keys/masterkey_trusted.c   |  2 +-
 security/keys/trusted.c                            |  2 +-
 8 files changed, 26 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/security/00-INDEX
 delete mode 100644 Documentation/security/conf.py
 rename Documentation/security/{keys-trusted-encrypted.txt => keys/trusted-encrypted.rst} (93%)

diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
deleted file mode 100644
index c8dbbc227326..000000000000
--- a/Documentation/security/00-INDEX
+++ /dev/null
@@ -1,4 +0,0 @@
-00-INDEX
-	- this file.
-keys-trusted-encrypted.txt
-	- info on the Trusted and Encrypted keys in the kernel key ring service.
diff --git a/Documentation/security/conf.py b/Documentation/security/conf.py
deleted file mode 100644
index 472fc9a8eb67..000000000000
--- a/Documentation/security/conf.py
+++ /dev/null
@@ -1,8 +0,0 @@
-project = "The kernel security subsystem manual"
-
-tags.add("subproject")
-
-latex_documents = [
-    ('index', 'security.tex', project,
-     'The kernel development community', 'manual'),
-]
diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
index d7ddbc1c2502..647d58f2588e 100644
--- a/Documentation/security/keys/index.rst
+++ b/Documentation/security/keys/index.rst
@@ -8,3 +8,4 @@ Kernel Keys
    core
    ecryptfs
    request-key
+   trusted-encrypted
diff --git a/Documentation/security/keys-trusted-encrypted.txt b/Documentation/security/keys/trusted-encrypted.rst
similarity index 93%
rename from Documentation/security/keys-trusted-encrypted.txt
rename to Documentation/security/keys/trusted-encrypted.rst
index b20a993a32af..7b503831bdea 100644
--- a/Documentation/security/keys-trusted-encrypted.txt
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -1,4 +1,6 @@
-			Trusted and Encrypted Keys
+==========================
+Trusted and Encrypted Keys
+==========================
 
 Trusted and Encrypted Keys are two new key types added to the existing kernel
 key ring service.  Both of these new types are variable length symmetric keys,
@@ -20,7 +22,8 @@ By default, trusted keys are sealed under the SRK, which has the default
 authorization value (20 zeros).  This can be set at takeownership time with the
 trouser's utility: "tpm_takeownership -u -z".
 
-Usage:
+Usage::
+
     keyctl add trusted name "new keylen [options]" ring
     keyctl add trusted name "load hex_blob [pcrlock=pcrnum]" ring
     keyctl update key "update [options]"
@@ -64,19 +67,22 @@ The decrypted portion of encrypted keys can contain either a simple symmetric
 key or a more complex structure. The format of the more complex structure is
 application specific, which is identified by 'format'.
 
-Usage:
+Usage::
+
     keyctl add encrypted name "new [format] key-type:master-key-name keylen"
         ring
     keyctl add encrypted name "load hex_blob" ring
     keyctl update keyid "update key-type:master-key-name"
 
-format:= 'default | ecryptfs'
-key-type:= 'trusted' | 'user'
+Where::
+
+	format:= 'default | ecryptfs'
+	key-type:= 'trusted' | 'user'
 
 
 Examples of trusted and encrypted key usage:
 
-Create and save a trusted key named "kmk" of length 32 bytes:
+Create and save a trusted key named "kmk" of length 32 bytes::
 
     $ keyctl add trusted kmk "new 32" @u
     440502848
@@ -99,7 +105,7 @@ Create and save a trusted key named "kmk" of length 32 bytes:
 
     $ keyctl pipe 440502848 > kmk.blob
 
-Load a trusted key from the saved blob:
+Load a trusted key from the saved blob::
 
     $ keyctl add trusted kmk "load `cat kmk.blob`" @u
     268728824
@@ -114,7 +120,7 @@ Load a trusted key from the saved blob:
     f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
     e4a8aea2b607ec96931e6f4d4fe563ba
 
-Reseal a trusted key under new pcr values:
+Reseal a trusted key under new pcr values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
     $ keyctl print 268728824
@@ -135,11 +141,13 @@ compromised by a user level problem, and when sealed to specific boot PCR
 values, protects against boot and offline attacks.  Create and save an
 encrypted key "evm" using the above trusted key "kmk":
 
-option 1: omitting 'format'
+option 1: omitting 'format'::
+
     $ keyctl add encrypted evm "new trusted:kmk 32" @u
     159771175
 
-option 2: explicitly defining 'format' as 'default'
+option 2: explicitly defining 'format' as 'default'::
+
     $ keyctl add encrypted evm "new default trusted:kmk 32" @u
     159771175
 
@@ -150,7 +158,7 @@ option 2: explicitly defining 'format' as 'default'
 
     $ keyctl pipe 159771175 > evm.blob
 
-Load an encrypted key "evm" from saved blob:
+Load an encrypted key "evm" from saved blob::
 
     $ keyctl add encrypted evm "load `cat evm.blob`" @u
     831684262
@@ -164,4 +172,4 @@ Other uses for trusted and encrypted keys, such as for disk and file encryption
 are anticipated.  In particular the new format 'ecryptfs' has been defined in
 in order to use encrypted keys to mount an eCryptfs filesystem.  More details
 about the usage can be found in the file
-'Documentation/security/keys-ecryptfs.txt'.
+``Documentation/security/keys-ecryptfs.txt``.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3973e25e5aca..c7674bda49ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7356,7 +7356,7 @@ M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
 L:	linux-security-module at vger.kernel.org
 L:	keyrings at vger.kernel.org
 S:	Supported
-F:	Documentation/security/keys-trusted-encrypted.txt
+F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	security/keys/trusted.h
@@ -7367,7 +7367,7 @@ M:	David Safford <safford@us.ibm.com>
 L:	linux-security-module at vger.kernel.org
 L:	keyrings at vger.kernel.org
 S:	Supported
-F:	Documentation/security/keys-trusted-encrypted.txt
+F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 0010955d7876..72ecbd0d1e37 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -11,7 +11,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, version 2 of the License.
  *
- * See Documentation/security/keys-trusted-encrypted.txt
+ * See Documentation/security/keys/trusted-encrypted.rst
  */
 
 #include <linux/uaccess.h>
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index b5b4812dbc87..cbf0bc127a73 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -11,7 +11,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, version 2 of the License.
  *
- * See Documentation/security/keys-trusted-encrypted.txt
+ * See Documentation/security/keys/trusted-encrypted.rst
  */
 
 #include <linux/uaccess.h>
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 2ae31c5a87de..3811e75d280f 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, version 2 of the License.
  *
- * See Documentation/security/keys-trusted-encrypted.txt
+ * See Documentation/security/keys/trusted-encrypted.rst
  */
 
 #include <crypto/hash_info.h>
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
