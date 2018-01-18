From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 18 Jan 2018 16:11:00 -0500
Subject: [PATCH] ima/policy: fix parsing of fsuuid
In-Reply-To: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <1516309860.3772.0.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-01-17 at 20:27 +0200, Mike Rapoport wrote:
> The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
> is zero during parsing of "fsuuid=" rule. Instead of making sure the
> &entry->fsuuid field is not attempted to be overwriten, we bail out for
> perfectly correct rule.
> 
> Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Thanks, Mike.

> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ee4613fa5840..f19f4841a97a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -743,7 +743,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		case Opt_fsuuid:
>  			ima_log_string(ab, "fsuuid", args[0].from);
> 
> -			if (uuid_is_null(&entry->fsuuid)) {
> +			if (!uuid_is_null(&entry->fsuuid)) {
>  				result = -EINVAL;
>  				break;
>  			}

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
