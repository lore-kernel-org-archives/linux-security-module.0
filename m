From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 21 Apr 2017 10:57:45 -0700
Subject: [PATCH security-next 1/2] smack: use pernet operations for hook
	registration
In-Reply-To: <20170421094909.28961-2-fw@strlen.de>
References: <20170421094909.28961-1-fw@strlen.de>
	<20170421094909.28961-2-fw@strlen.de>
Message-ID: <b41fc9ae-f099-5ed6-9ece-09994e3a723f@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/21/2017 2:49 AM, Florian Westphal wrote:
> It will allow us to remove the old netfilter hook api in the near future.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

I will take this patch into the Smack tree from 4.13.

Thank you.

> ---
>  security/smack/smack_netfilter.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index 205b785fb400..cdeb0f3243dd 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -18,6 +18,7 @@
>  #include <linux/netfilter_ipv6.h>
>  #include <linux/netdevice.h>
>  #include <net/inet_sock.h>
> +#include <net/net_namespace.h>
>  #include "smack.h"
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -74,20 +75,29 @@ static struct nf_hook_ops smack_nf_ops[] = {
>  #endif	/* IPV6 */
>  };
>  
> -static int __init smack_nf_ip_init(void)
> +static int __net_init smack_nf_register(struct net *net)
> +{
> +	return nf_register_net_hooks(net, smack_nf_ops,
> +				     ARRAY_SIZE(smack_nf_ops));
> +}
> +
> +static void __net_exit smack_nf_unregister(struct net *net)
>  {
> -	int err;
> +	nf_unregister_net_hooks(net, smack_nf_ops, ARRAY_SIZE(smack_nf_ops));
> +}
>  
> +static struct pernet_operations smack_net_ops = {
> +	.init = smack_nf_register,
> +	.exit = smack_nf_unregister,
> +};
> +
> +static int __init smack_nf_ip_init(void)
> +{
>  	if (smack_enabled == 0)
>  		return 0;
>  
>  	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
> -
> -	err = nf_register_hooks(smack_nf_ops, ARRAY_SIZE(smack_nf_ops));
> -	if (err)
> -		pr_info("Smack: nf_register_hooks: error %d\n", err);
> -
> -	return 0;
> +	return register_pernet_subsys(&smack_net_ops);
>  }
>  
>  __initcall(smack_nf_ip_init);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
