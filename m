From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 2 Aug 2018 11:38:23 +0300
Subject: [PATCH] apparmor: fix an error code in __aa_create_ns()
Message-ID: <20180802083823.qrx5ieekfvtz2w4d@kili.mountain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We should return error pointers in this function.  Returning NULL
results in a NULL dereference in the caller.

Fixes: 73688d1ed0b8 ("apparmor: refactor prepare_ns() and make usable from different views")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index b0f9dc3f765a..1a7cec5d9cac 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -255,7 +255,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	ns->level = parent->level + 1;
 	mutex_lock_nested(&ns->lock, ns->level);
 	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
