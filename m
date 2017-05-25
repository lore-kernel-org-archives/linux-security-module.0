From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 08:32:25 -0700
Subject: [PATCH 8/8] apparmor: convert from securityfs to apparmorfs for
	policy ns files
In-Reply-To: <20170525153225.19070-1-john.johansen@canonical.com>
References: <20170525153225.19070-1-john.johansen@canonical.com>
Message-ID: <20170525153225.19070-9-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Virtualize the apparmor policy/ directory so that the current
namespace affects what part of policy is seen. To do this convert to
using apparmorfs for policy namespace files and setup a magic symlink
in the securityfs apparmor dir to access those files.

Signed-off-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/apparmorfs.c | 63 +++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index f45aeb77e1f0..70ade4c07e64 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -944,7 +944,7 @@ static void remove_rawdata_dents(struct aa_loaddata *rawdata)
 	for (i = 0; i < AAFS_LOADDATA_NDENTS; i++) {
 		if (!IS_ERR_OR_NULL(rawdata->dents[i])) {
 			/* no refcounts on i_private */
-			securityfs_remove(rawdata->dents[i]);
+			aafs_remove(rawdata->dents[i]);
 			rawdata->dents[i] = NULL;
 		}
 	}
@@ -981,32 +981,32 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 		/* ->name freed when rawdata freed */
 		return -ENOMEM;
 
-	dir = securityfs_create_dir(rawdata->name, ns_subdata_dir(ns));
+	dir = aafs_create_dir(rawdata->name, ns_subdata_dir(ns));
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 	rawdata->dents[AAFS_LOADDATA_DIR] = dir;
 
-	dent = securityfs_create_file("abi", S_IFREG | 0444, dir, rawdata,
+	dent = aafs_create_file("abi", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_abi_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	rawdata->dents[AAFS_LOADDATA_ABI] = dent;
 
-	dent = securityfs_create_file("revision", S_IFREG | 0444, dir, rawdata,
+	dent = aafs_create_file("revision", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_revision_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
 
 	if (aa_g_hash_policy) {
-		dent = securityfs_create_file("sha1", S_IFREG | 0444, dir,
+		dent = aafs_create_file("sha1", S_IFREG | 0444, dir,
 					      rawdata, &seq_rawdata_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
 		rawdata->dents[AAFS_LOADDATA_HASH] = dent;
 	}
 
-	dent = securityfs_create_file("raw_data", S_IFREG | 0444,
+	dent = aafs_create_file("raw_data", S_IFREG | 0444,
 				      dir, rawdata, &rawdata_fops);
 	if (IS_ERR(dent))
 		goto fail;
@@ -1048,7 +1048,7 @@ void __aafs_profile_rmdir(struct aa_profile *profile)
 			continue;
 
 		proxy = d_inode(profile->dents[i])->i_private;
-		securityfs_remove(profile->dents[i]);
+		aafs_remove(profile->dents[i]);
 		aa_put_proxy(proxy);
 		profile->dents[i] = NULL;
 	}
@@ -1078,7 +1078,7 @@ static struct dentry *create_profile_file(struct dentry *dir, const char *name,
 	struct aa_proxy *proxy = aa_get_proxy(profile->proxy);
 	struct dentry *dent;
 
-	dent = securityfs_create_file(name, S_IFREG | 0444, dir, proxy, fops);
+	dent = aafs_create_file(name, S_IFREG | 0444, dir, proxy, fops);
 	if (IS_ERR(dent))
 		aa_put_proxy(proxy);
 
@@ -1131,7 +1131,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		p = aa_deref_parent(profile);
 		dent = prof_dir(p);
 		/* adding to parent that previously didn't have children */
-		dent = securityfs_create_dir("profiles", dent);
+		dent = aafs_create_dir("profiles", dent);
 		if (IS_ERR(dent))
 			goto fail;
 		prof_child_dir(p) = parent = dent;
@@ -1150,7 +1150,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		sprintf(profile->dirname + len, ".%ld", profile->ns->uniq_id++);
 	}
 
-	dent = securityfs_create_dir(profile->dirname, parent);
+	dent = aafs_create_dir(profile->dirname, parent);
 	if (IS_ERR(dent))
 		goto fail;
 	prof_dir(profile) = dir = dent;
@@ -1189,7 +1189,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 					 profile->rawdata->name, "sha1");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_sha1", dir, target, NULL);
+		dent = aafs_create_symlink("raw_sha1", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_HASH] = dent;
@@ -1198,7 +1198,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 					 profile->rawdata->name, "abi");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_abi", dir, target, NULL);
+		dent = aafs_create_symlink("raw_abi", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_ABI] = dent;
@@ -1207,7 +1207,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 					 profile->rawdata->name, "raw_data");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_data", dir, target, NULL);
+		dent = aafs_create_symlink("raw_data", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_DATA] = dent;
@@ -1282,7 +1282,7 @@ void __aafs_ns_rmdir(struct aa_ns *ns)
 	}
 
 	for (i = AAFS_NS_SIZEOF - 1; i >= 0; --i) {
-		securityfs_remove(ns->dents[i]);
+		aafs_remove(ns->dents[i]);
 		ns->dents[i] = NULL;
 	}
 }
@@ -1295,38 +1295,38 @@ static int __aafs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
 	AA_BUG(!ns);
 	AA_BUG(!dir);
 
-	dent = securityfs_create_dir("profiles", dir);
+	dent = aafs_create_dir("profiles", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	ns_subprofs_dir(ns) = dent;
 
-	dent = securityfs_create_dir("raw_data", dir);
+	dent = aafs_create_dir("raw_data", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	ns_subdata_dir(ns) = dent;
 
-	dent = securityfs_create_file(".load", 0640, dir, ns,
+	dent = aafs_create_file(".load", 0640, dir, ns,
 				      &aa_fs_profile_load);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subload(ns) = dent;
 
-	dent = securityfs_create_file(".replace", 0640, dir, ns,
+	dent = aafs_create_file(".replace", 0640, dir, ns,
 				      &aa_fs_profile_replace);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subreplace(ns) = dent;
 
-	dent = securityfs_create_file(".remove", 0640, dir, ns,
+	dent = aafs_create_file(".remove", 0640, dir, ns,
 				      &aa_fs_profile_remove);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subremove(ns) = dent;
 
-	dent = securityfs_create_dir("namespaces", dir);
+	dent = aafs_create_dir("namespaces", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
@@ -1353,11 +1353,13 @@ int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
 	if (!name)
 		name = ns->base.name;
 
-	/* create ns dir if it doesn't already exist */
-	dent = securityfs_create_dir(name, parent);
-	if (IS_ERR(dent))
-		goto fail;
-
+	if (!dent) {
+		/* create ns dir if it doesn't already exist */
+		dent = aafs_create_dir(name, parent);
+		if (IS_ERR(dent))
+			goto fail;
+	} else
+		dget(dent);
 	ns_dir(ns) = dir = dent;
 	error = __aafs_ns_mkdir_entries(ns, dir);
 	if (error)
@@ -1929,12 +1931,21 @@ static int __init aa_create_aafs(void)
 	ns_subremove(root_ns) = dent;
 
 	mutex_lock(&root_ns->lock);
-	error = __aafs_ns_mkdir(root_ns, aa_sfs_entry.dentry, "policy", NULL);
+	error = __aafs_ns_mkdir(root_ns, aafs_mnt->mnt_root, ".policy",
+				aafs_mnt->mnt_root);
 	mutex_unlock(&root_ns->lock);
 
 	if (error)
 		goto error;
 
+	/* magic symlink similar to nsfs redirects based on task policy */
+	dent = securityfs_create_symlink("policy", aa_sfs_entry.dentry,
+					 NULL, &policy_link_iops);
+	if (IS_ERR(dent)) {
+		error = PTR_ERR(dent);
+		goto error;
+	}
+
 	error = aa_mk_null_file(aa_sfs_entry.dentry);
 	if (error)
 		goto error;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
