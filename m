From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 26 Sep 2018 14:57:03 -0700
Subject: [PATCH v4 20/19] LSM: Correct file blob free empty blob check
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Message-ID: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Instead of checking if the kmem_cache for file blobs
has been initialized check if the blob is NULL. This
allows non-blob using modules to do other kinds of
clean up in the security_file_free hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index e7c8506041f1..76f7dc49b63c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
 {
 	void *blob;
 
-	if (!lsm_file_cache)
-		return;
-
 	call_void_hook(file_free_security, file);
 
 	blob = file->f_security;
-	file->f_security = NULL;
-	kmem_cache_free(lsm_file_cache, blob);
+	if (blob) {
+		file->f_security = NULL;
+		kmem_cache_free(lsm_file_cache, blob);
+	}
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-- 
2.17.1
