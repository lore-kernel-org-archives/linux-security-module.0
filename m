From: colin.king@canonical.com (Colin Ian King)
Date: Fri, 4 May 2018 15:36:57 +0100
Subject: [PATCH v2] apparmor: secid: fix error return value in error
	handling path
In-Reply-To: <20180504140914.GA16787@embeddedor.com>
References: <20180504140914.GA16787@embeddedor.com>
Message-ID: <1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Gustavo,

if you are using the coverity scan bug tracking, please can you mark a
bug as being worked on by yourself so I don't work on it at the same
time as we're duplicating work here.

Colin

On 04/05/18 15:09, Gustavo A. R. Silva wrote:
> Currently, function apparmor_secid_to_secctx returns always zero,
> no matter if the value returned by aa_label_asxprint is negative
> (which implies that an error has occurred).
> 
> Notice that *seclen* is of type u32 (32 bits, unsigned), and a
> less-than-zero comparison of an unsigned value is never true.
> 
> Fix this by temporarily storing the value returned by aa_label_asxprint
> into a variable of type int (signed) for its further evaluation.
> 
> Addresses-Coverity-ID: 1468514 ("Unsigned compared against 0")
> Fixes: c092921219d2 ("apparmor: add support for mapping secids and using
> secctxes")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes is v2:
>  - Update changelog.
>  - Fix misaligned lines.
> 
>  security/apparmor/secid.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 5029248..efaa0d9 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -142,6 +142,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
>  	/* TODO: cache secctx and ref count so we don't have to recreate */
>  	struct aa_label *label = aa_secid_to_label(secid);
> +	int seclen_tmp;
>  
>  	AA_BUG(!secdata);
>  	AA_BUG(!seclen);
> @@ -150,17 +151,21 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  		return -EINVAL;
>  
>  	if (secdata)
> -		*seclen = aa_label_asxprint(secdata, root_ns, label,
> -					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -					    FLAG_HIDDEN_UNCONFINED |
> -					    FLAG_ABS_ROOT, GFP_ATOMIC);
> +		seclen_tmp = aa_label_asxprint(secdata, root_ns, label,
> +					       FLAG_SHOW_MODE |
> +					       FLAG_VIEW_SUBNS |
> +					       FLAG_HIDDEN_UNCONFINED |
> +					       FLAG_ABS_ROOT, GFP_ATOMIC);
>  	else
> -		*seclen = aa_label_snxprint(NULL, 0, root_ns, label,
> -					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -					    FLAG_HIDDEN_UNCONFINED |
> -					    FLAG_ABS_ROOT);
> -	if (*seclen < 0)
> +		seclen_tmp = aa_label_snxprint(NULL, 0, root_ns, label,
> +					       FLAG_SHOW_MODE |
> +					       FLAG_VIEW_SUBNS |
> +					       FLAG_HIDDEN_UNCONFINED |
> +					       FLAG_ABS_ROOT);
> +	if (seclen_tmp < 0)
>  		return -ENOMEM;
> +	else
> +		*seclen = seclen_tmp;
>  
>  	return 0;
>  }
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
