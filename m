From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 1 Aug 2018 15:55:53 -0700
Subject: [PATCH] Smack: Mark expected switch fall-through
In-Reply-To: <20180801223854.GA14499@embeddedor.com>
References: <20180801223854.GA14499@embeddedor.com>
Message-ID: <da15be5c-6c5f-3002-6562-50c60cd44263@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/1/2018 3:38 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced "No break" with a
> proper "Fall through" annotation, which is what GCC is expecting
> to find.

Holy bikeshedding, Batman! For decades I've seen "no break" as
the proper way to warn that the lack of a "break;" is intentional.
I suppose that "Fall through" makes just as much sense. Grumble.

> Warning level 2 was used: -Wimplicit-fallthrough=2
>
> Addresses-Coverity-ID: 115051 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Sure, I'll take this for 4.20 as my 4.19 changes are complete
and there doesn't seem to be special urgency.

> ---
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ad45761..a307b00 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3739,7 +3739,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		 */
>  		final = &smack_known_star;
>  		/*
> -		 * No break.
> +		 * Fall through.
>  		 *
>  		 * If a smack value has been set we want to use it,
>  		 * but since tmpfs isn't giving us the opportunity

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
