From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 31 May 2017 08:53:42 -0700
Subject: [PATCH] Smack: Safer check for a socket in file_receive
Message-ID: <36cefa8b-3441-91b4-1f8c-51c4d7004141@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH] Smack: Safer check for a socket in file_receive

The check of S_ISSOCK() in smack_file_receive() is not
appropriate if the passed descriptor is a socket.

Reported-by: Stephen Smalley <sds@tyco.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 658f5d8..463af86 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1915,7 +1915,7 @@ static int smack_file_receive(struct file *file)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 
-	if (S_ISSOCK(inode->i_mode)) {
+	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
 		tsp = current_security();

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
