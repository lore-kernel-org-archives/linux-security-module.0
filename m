From: paul@paul-moore.com (Paul Moore)
Date: Mon, 28 Aug 2017 17:34:31 -0400
Subject: [PATCH] selinux: constify nf_hook_ops
In-Reply-To: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
References: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAHC9VhQzXMzOv0JsLWHd0sfB2S0T_U2Ax-dGwiedOHV4vKu-AA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 26, 2017 at 6:47 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> nf_hook_ops are not supposed to change at runtime. nf_register_net_hooks
> and nf_unregister_net_hooks are working with const nf_hook_ops.
> So mark the non-const nf_hook_ops structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 33fd061..2f2e133 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6530,7 +6530,7 @@ security_initcall(selinux_init);
>
>  #if defined(CONFIG_NETFILTER)
>
> -static struct nf_hook_ops selinux_nf_ops[] = {
> +static const struct nf_hook_ops selinux_nf_ops[] = {
>         {
>                 .hook =         selinux_ipv4_postroute,
>                 .pf =           NFPROTO_IPV4,
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
