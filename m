From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:51 -0700
Subject: [PATCH 15/17] doc: ReSTify keys-ecryptfs.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-16-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under keys security devel index.

Cc: David Howells <dhowells@redhat.com>
Cc: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/security/00-INDEX                       |  2 --
 .../security/{keys-ecryptfs.txt => keys/ecryptfs.rst} | 19 ++++++++++++-------
 Documentation/security/keys/index.rst                 |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/security/{keys-ecryptfs.txt => keys/ecryptfs.rst} (91%)

diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index a840095bb11c..08a6e7a195ef 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file.
-keys-ecryptfs.txt
-	- description of the encryption keys for the ecryptfs filesystem.
 keys-request-key.txt
 	- description of the kernel key request service.
 keys-trusted-encrypted.txt
diff --git a/Documentation/security/keys-ecryptfs.txt b/Documentation/security/keys/ecryptfs.rst
similarity index 91%
rename from Documentation/security/keys-ecryptfs.txt
rename to Documentation/security/keys/ecryptfs.rst
index c3bbeba63562..4920f3a8ea75 100644
--- a/Documentation/security/keys-ecryptfs.txt
+++ b/Documentation/security/keys/ecryptfs.rst
@@ -1,4 +1,6 @@
-		Encrypted keys for the eCryptfs filesystem
+==========================================
+Encrypted keys for the eCryptfs filesystem
+==========================================
 
 ECryptfs is a stacked filesystem which transparently encrypts and decrypts each
 file using a randomly generated File Encryption Key (FEK).
@@ -35,20 +37,23 @@ controlled environment.  Another advantage is that the key is not exposed to
 threats of malicious software, because it is available in clear form only at
 kernel level.
 
-Usage:
+Usage::
+
    keyctl add encrypted name "new ecryptfs key-type:master-key-name keylen" ring
    keyctl add encrypted name "load hex_blob" ring
    keyctl update keyid "update key-type:master-key-name"
 
-name:= '<16 hexadecimal characters>'
-key-type:= 'trusted' | 'user'
-keylen:= 64
+Where::
+
+	name:= '<16 hexadecimal characters>'
+	key-type:= 'trusted' | 'user'
+	keylen:= 64
 
 
 Example of encrypted key usage with the eCryptfs filesystem:
 
 Create an encrypted key "1000100010001000" of length 64 bytes with format
-'ecryptfs' and save it using a previously loaded user key "test":
+'ecryptfs' and save it using a previously loaded user key "test"::
 
     $ keyctl add encrypted 1000100010001000 "new ecryptfs user:test 64" @u
     19184530
@@ -62,7 +67,7 @@ Create an encrypted key "1000100010001000" of length 64 bytes with format
     $ keyctl pipe 19184530 > ecryptfs.blob
 
 Mount an eCryptfs filesystem using the created encrypted key "1000100010001000"
-into the '/secret' directory:
+into the '/secret' directory::
 
     $ mount -i -t ecryptfs -oecryptfs_sig=1000100010001000,\
       ecryptfs_cipher=aes,ecryptfs_key_bytes=32 /secret /secret
diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
index ddfe7e4726e6..d34f663354bb 100644
--- a/Documentation/security/keys/index.rst
+++ b/Documentation/security/keys/index.rst
@@ -6,3 +6,4 @@ Kernel Keys
    :maxdepth: 1
 
    core
+   ecryptfs
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
