From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 26 Aug 2017 16:18:46 +0530
Subject: [PATCH] smack: constify nf_hook_ops
Message-ID: <34731ab554f22661849c01f4e6a675798e834245.1503744327.git.arvind.yadav.cs@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

nf_hook_ops are not supposed to change at runtime. nf_register_net_hooks
and nf_unregister_net_hooks are working with const nf_hook_ops.
So mark the non-const nf_hook_ops structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 security/smack/smack_netfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index cdeb0f3..e36d178 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -58,7 +58,7 @@ static unsigned int smack_ipv4_output(void *priv,
 	return NF_ACCEPT;
 }
 
-static struct nf_hook_ops smack_nf_ops[] = {
+static const struct nf_hook_ops smack_nf_ops[] = {
 	{
 		.hook =		smack_ipv4_output,
 		.pf =		NFPROTO_IPV4,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
