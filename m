From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Fri, 30 Jun 2017 08:48:14 -0400
Subject: [PATCH] selinux: return -ENOMEM if kzalloc() fails
In-Reply-To: <20170630075614.ywv3y3tptor5ox7g@mwanda>
References: <20170630075614.ywv3y3tptor5ox7g@mwanda>
Message-ID: <1498826894.16913.1.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-06-30 at 10:56 +0300, Dan Carpenter wrote:
> We accidentally return success instead of -ENOMEM on this failure
> path.
> 
> Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of
> PKey SIDs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

NAK, that's intentional.  See the comment just above the code in
question.

> 
> diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
> index e3614ee5f1c0..36e61f622b5a 100644
> --- a/security/selinux/ibpkey.c
> +++ b/security/selinux/ibpkey.c
> @@ -160,8 +160,10 @@ static int sel_ib_pkey_sid_slow(u64
> subnet_prefix, u16 pkey_num, u32 *sid)
> ?	?* is valid, it just won't be added to the cache.
> ?	?*/
> ?	new = kzalloc(sizeof(*new), GFP_ATOMIC);
> -	if (!new)
> +	if (!new) {
> +		ret = -ENOMEM;
> ?		goto out;
> +	}
> ?
> ?	new->psec.subnet_prefix = subnet_prefix;
> ?	new->psec.pkey = pkey_num;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
