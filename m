From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 10 Jul 2018 10:00:12 -0500
Subject: [PATCH 1/2] apparmor: Check buffer bounds when mapping
	permissions mask
In-Reply-To: <1530854701-7348-2-git-send-email-tyhicks@canonical.com>
References: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
	<1530854701-7348-2-git-send-email-tyhicks@canonical.com>
Message-ID: <20180710150012.GC1661@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Tyler Hicks (tyhicks at canonical.com):
> Don't read past the end of the buffer containing permissions
> characters or write past the end of the destination string.
> 
> Detected by CoverityScan CID#1415361, 1415376 ("Out-of-bounds access")
> 
> Fixes: e53cfe6c7caa ("apparmor: rework perm mapping to a slightly broader set")
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/file.c          |  3 ++-
>  security/apparmor/include/perms.h |  3 ++-
>  security/apparmor/lib.c           | 17 +++++++++++++----
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index 224b2fef93ca..4285943f7260 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -47,7 +47,8 @@ static void audit_file_mask(struct audit_buffer *ab, u32 mask)
>  {
>  	char str[10];
>  
> -	aa_perm_mask_to_str(str, aa_file_perm_chrs, map_mask_to_chr_mask(mask));
> +	aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> +			    map_mask_to_chr_mask(mask));
>  	audit_log_string(ab, str);
>  }
>  
> diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
> index 38aa6247d00f..b94ec114d1a4 100644
> --- a/security/apparmor/include/perms.h
> +++ b/security/apparmor/include/perms.h
> @@ -137,7 +137,8 @@ extern struct aa_perms allperms;
>  	xcheck(fn_for_each((L1), (P), (FN1)), fn_for_each((L2), (P), (FN2)))
>  
>  
> -void aa_perm_mask_to_str(char *str, const char *chrs, u32 mask);
> +void aa_perm_mask_to_str(char *str, size_t str_size, const char *chrs,
> +			 u32 mask);
>  void aa_audit_perm_names(struct audit_buffer *ab, const char * const *names,
>  			 u32 mask);
>  void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index a7b3f681b80e..7ab368c3789b 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -198,15 +198,24 @@ const char *aa_file_perm_names[] = {
>  /**
>   * aa_perm_mask_to_str - convert a perm mask to its short string
>   * @str: character buffer to store string in (at least 10 characters)
> + * @str_size: size of the @str buffer
> + * @chrs: NUL-terminated character buffer of permission characters
>   * @mask: permission mask to convert
>   */
> -void aa_perm_mask_to_str(char *str, const char *chrs, u32 mask)
> +void aa_perm_mask_to_str(char *str, size_t str_size, const char *chrs, u32 mask)
>  {
>  	unsigned int i, perm = 1;
> +	size_t num_chrs = strlen(chrs);
> +
> +	for (i = 0; i < num_chrs; perm <<= 1, i++) {
> +		if (mask & perm) {
> +			/* Ensure that one byte is left for NUL-termination */
> +			if (WARN_ON_ONCE(str_size <= 1))
> +				continue;
>  
> -	for (i = 0; i < 32; perm <<= 1, i++) {
> -		if (mask & perm)
>  			*str++ = chrs[i];
> +			str_size--;
> +		}
>  	}
>  	*str = '\0';
>  }
> @@ -236,7 +245,7 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
>  
>  	audit_log_format(ab, "\"");
>  	if ((mask & chrsmask) && chrs) {
> -		aa_perm_mask_to_str(str, chrs, mask & chrsmask);
> +		aa_perm_mask_to_str(str, sizeof(str), chrs, mask & chrsmask);
>  		mask &= ~chrsmask;
>  		audit_log_format(ab, "%s", str);
>  		if (mask & namesmask)
> -- 
> 2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
