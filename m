From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 13 Sep 2018 21:18:11 +0800
Subject: [PATCH -next] Smack: remove set but not used variable 'root_inode'
Message-ID: <20180913131811.25432-1-yuehaibing@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

security/smack/smackfs.c: In function 'smk_fill_super':
security/smack/smackfs.c:2856:16: warning:
 variable 'root_inode' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/smack/smackfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f4e91c5..8972da4 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2855,7 +2855,6 @@ static int smk_fill_super(struct super_block *sb, void *data, size_t data_size,
 			  int silent)
 {
 	int rc;
-	struct inode *root_inode;
 
 	static const struct tree_descr smack_files[] = {
 		[SMK_LOAD] = {
@@ -2919,8 +2918,6 @@ static int smk_fill_super(struct super_block *sb, void *data, size_t data_size,
 		return rc;
 	}
 
-	root_inode = d_inode(sb->s_root);
-
 	return 0;
 }
 
-- 
2.7.0
