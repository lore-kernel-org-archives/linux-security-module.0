From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 13 Aug 2017 10:41:33 -0500
Subject: [PATCH 4/4] selinux: Adjust five checks for null pointers
In-Reply-To: <b74d176c-b028-7e82-80c6-a3014d57d648@users.sourceforge.net>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
	<b74d176c-b028-7e82-80c6-a3014d57d648@users.sourceforge.net>
Message-ID: <20170813154133.GA4515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting SF Markus Elfring (elfring at users.sourceforge.net):
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 16:16:05 +0200
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The script ?checkpatch.pl? pointed information out like the following.
> 
> Comparison to NULL could be written ?

...  could be written all sorts of ways.  But what's the advantage of this?
Personally I find "x == NULL" easier to read, and AFAIK psychology backs me
up on the idea that negation is harder on the brain and worth avoiding when
possible.

> Thus fix affected source code places.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/ebitmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 697bd748760a..c778135989f5 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -96,12 +96,12 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
>  	unsigned int iter;
>  	int rc;
>  
> -	if (e_iter == NULL) {
> +	if (!e_iter) {
>  		*catmap = NULL;
>  		return 0;
>  	}
>  
> -	if (*catmap != NULL)
> +	if (*catmap)
>  		netlbl_catmap_free(*catmap);
>  	*catmap = NULL;
>  
> @@ -161,14 +161,14 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>  			continue;
>  		}
>  
> -		if (e_iter == NULL ||
> +		if (!e_iter ||
>  		    offset >= e_iter->startbit + EBITMAP_SIZE) {
>  			e_prev = e_iter;
>  			e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
> -			if (e_iter == NULL)
> +			if (!e_iter)
>  				goto netlbl_import_failure;
>  			e_iter->startbit = offset - (offset % EBITMAP_SIZE);
> -			if (e_prev == NULL)
> +			if (!e_prev)
>  				ebmap->node = e_iter;
>  			else
>  				e_prev->next = e_iter;
> -- 
> 2.14.0
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
