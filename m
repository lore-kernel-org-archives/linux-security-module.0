From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 26 Aug 2017 16:17:35 +0530
Subject: [PATCH] selinux: constify nf_hook_ops
Message-ID: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

nf_hook_ops are not supposed to change at runtime. nf_register_net_hooks
and nf_unregister_net_hooks are working with const nf_hook_ops.
So mark the non-const nf_hook_ops structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33fd061..2f2e133 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6530,7 +6530,7 @@ security_initcall(selinux_init);
 
 #if defined(CONFIG_NETFILTER)
 
-static struct nf_hook_ops selinux_nf_ops[] = {
+static const struct nf_hook_ops selinux_nf_ops[] = {
 	{
 		.hook =		selinux_ipv4_postroute,
 		.pf =		NFPROTO_IPV4,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
