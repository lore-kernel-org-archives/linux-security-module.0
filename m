From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 08:32:24 -0700
Subject: [PATCH 7/8] apparmor: allow specifying an already created dir to
	create ns entries in
In-Reply-To: <20170525153225.19070-1-john.johansen@canonical.com>
References: <20170525153225.19070-1-john.johansen@canonical.com>
Message-ID: <20170525153225.19070-8-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Signed-off-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/apparmorfs.c         | 9 +++++----
 security/apparmor/include/apparmorfs.h | 4 ++--
 security/apparmor/policy_ns.c          | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 74c3bfd1af8d..f45aeb77e1f0 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1338,11 +1338,12 @@ static int __aafs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
 /*
  * Requires: @ns->lock held
  */
-int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
+int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
+		    struct dentry *dent)
 {
 	struct aa_ns *sub;
 	struct aa_profile *child;
-	struct dentry *dent, *dir;
+	struct dentry *dir;
 	int error;
 
 	AA_BUG(!ns);
@@ -1372,7 +1373,7 @@ int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
 	/* subnamespaces */
 	list_for_each_entry(sub, &ns->sub_ns, base.list) {
 		mutex_lock(&sub->lock);
-		error = __aafs_ns_mkdir(sub, ns_subns_dir(ns), NULL);
+		error = __aafs_ns_mkdir(sub, ns_subns_dir(ns), NULL, NULL);
 		mutex_unlock(&sub->lock);
 		if (error)
 			goto fail2;
@@ -1928,7 +1929,7 @@ static int __init aa_create_aafs(void)
 	ns_subremove(root_ns) = dent;
 
 	mutex_lock(&root_ns->lock);
-	error = __aafs_ns_mkdir(root_ns, aa_sfs_entry.dentry, "policy");
+	error = __aafs_ns_mkdir(root_ns, aa_sfs_entry.dentry, "policy", NULL);
 	mutex_unlock(&root_ns->lock);
 
 	if (error)
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index bcad87740cb6..071a59a1f056 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -112,8 +112,8 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
 				   struct aa_profile *new);
 int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent);
 void __aafs_ns_rmdir(struct aa_ns *ns);
-int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent,
-		     const char *name);
+int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
+		     struct dentry *dent);
 
 struct aa_loaddata;
 void __aa_fs_remove_rawdata(struct aa_loaddata *rawdata);
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 0a8bc4e887ef..7d7c23705be2 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -196,7 +196,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 	if (!ns)
 		return NULL;
 	mutex_lock(&ns->lock);
-	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name);
+	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);
 	if (error) {
 		AA_ERROR("Failed to create interface for ns %s\n",
 			 ns->base.name);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
