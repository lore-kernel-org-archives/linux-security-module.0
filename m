From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Fri, 2 Jun 2017 10:33:22 +0200
Subject: [PATCH security-next 1/2] smack: use pernet operations for hook
	registration
In-Reply-To: <0868b816-939b-12d2-c8aa-a5c8677e1cce@schaufler-ca.com>
References: <20170421094909.28961-1-fw@strlen.de>
	<20170421094909.28961-2-fw@strlen.de>
	<0868b816-939b-12d2-c8aa-a5c8677e1cce@schaufler-ca.com>
Message-ID: <20170602083322.GA2117@salvia>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 01, 2017 at 09:44:05AM -0700, Casey Schaufler wrote:
> On 4/21/2017 2:49 AM, Florian Westphal wrote:
> > It will allow us to remove the old netfilter hook api in the near future.
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> I have applied this to git://github.com/cschaufler/smack-next#smack-for-4.13

Thanks Casey.

We're very much looking forward to getting rid of all these
nf_register_hooks() calls all over the tree. This patch helps us going
in that direction.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
