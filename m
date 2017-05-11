From: guilherme.magalhaes@hpe.com (Guilherme Magalhaes)
Date: Thu, 11 May 2017 11:00:00 -0300
Subject: [RFC 08/11] ima: block initial namespace id on the namespace policy
	interface
In-Reply-To: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
Message-ID: <1494511203-8397-9-git-send-email-guilherme.magalhaes@hpe.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The initial namespace policy is set through the existent interface
in the ima/policy securityfs file. Block the initial namespace
id when it is written to the ima/namespace securityfs file.

Signed-off-by: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
---
 security/integrity/ima/ima_fs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 61f8da1..65c43e7 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -365,6 +365,16 @@ static int check_mntns(unsigned int ns_id)
 	return result;
 }
 
+static unsigned int initial_mntns_id;
+static void get_initial_mntns_id(void)
+{
+	struct ns_common *ns;
+
+	ns = mntns_operations.get(&init_task);
+	initial_mntns_id = ns->inum;
+	mntns_operations.put(ns);
+}
+
 /*
  * ima_find_namespace_id_from_inode
  * @policy_inode: the inode of the securityfs policy file for a given
@@ -699,6 +709,12 @@ static ssize_t handle_new_namespace_policy(const char *data, size_t datalen)
 		goto out;
 	}
 
+	if (ns_id == initial_mntns_id) {
+		pr_err("IMA: invalid use of the initial mount namespace\n");
+		result = -EINVAL;
+		goto out;
+	}
+
 	ima_namespace_lock();
 	if (check_mntns(ns_id)) {
 		result = -ENOENT;
@@ -835,6 +851,8 @@ int __init ima_fs_init(void)
 						&ima_namespaces_ops);
 	if (IS_ERR(ima_namespaces))
 		goto out;
+
+	get_initial_mntns_id();
 #endif
 
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
