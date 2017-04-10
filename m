From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Tue, 11 Apr 2017 07:07:22 +0900
Subject: [PATCH RFC 04/11] LSM: general but not extreme module stacking
In-Reply-To: <05b1edee-9850-5d68-35be-cdd595e47f5c@schaufler-ca.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
	<05b1edee-9850-5d68-35be-cdd595e47f5c@schaufler-ca.com>
Message-ID: <201704110707.HCD34852.MQOSLFHtFFOVOJ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> @@ -1365,6 +1432,77 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  {
>  	struct security_hook_list *hp;
>  	int rc;
> +	char *local;
> +	char *cp;
> +	int slen;
> +	int failed = 0;
> +
> +	/*
> +	 * If lsm is NULL look at all the modules to find one
> +	 * that processes name. If lsm is not NULL only look at
> +	 * that module.
> +	 *
> +	 * "context" is handled directly here.
> +	 */
> +	if (strcmp(name, "context") == 0) {
> +		/*
> +		 * First verify that the input is acceptable.
> +		 * lsm1='v1'lsm2='v2'lsm3='v3'
> +		 *
> +		 * A note on the use of strncmp() below.
> +		 * The check is for the substring at the beginning of cp.
> +		 * The kzalloc of size + 1 ensures a terminated string.
> +		 */
> +		rc = -EINVAL;
> +		local = kzalloc(size + 1, GFP_KERNEL);
> +		memcpy(local, value, size);
> +		cp = local;
> +		list_for_each_entry(hp, &security_hook_heads.setprocattr,
> +					list) {
> +			if (lsm != NULL && strcmp(lsm, hp->lsm))
> +				continue;
> +			if (cp[0] == ',') {
> +				if (cp == local)
> +					goto free_out;
> +				cp++;
> +			}
> +			slen = strlen(hp->lsm);
> +			if (strncmp(cp, hp->lsm, slen))
> +				goto free_out;
> +			cp += slen;
> +			if (cp[0] != '=' || cp[1] != '\'' || cp[2] == '\'')
> +				goto free_out;
> +			for (cp += 2; cp[0] != '\''; cp++)
> +				if (cp[0] == '\0')
> +					goto free_out;
> +			cp++;
> +		}
> +
> +		cp = local;
> +		list_for_each_entry(hp, &security_hook_heads.setprocattr,
> +					list) {
> +			if (lsm != NULL && strcmp(lsm, hp->lsm))
> +				continue;
> +			if (cp[0] == ',')
> +				cp++;
> +			cp += strlen(hp->lsm) + 2;
> +			for (slen = 0; cp[slen] != '\''; slen++)
> +				;
> +			cp[slen] = '\0';
> +
> +			rc = hp->hook.setprocattr("context", cp, slen);
> +			if (rc < 0)
> +				failed = rc;

I did not find your answer to my question.
When

  valid_lsmname1='valid_value_for_lsmname1'valid_lsmname2='valid_value_for_lsmname2'valid_lsmname3='invalid_value_for_lsmname3'

is given, there is no way to undo already committed

  valid_lsmname1='valid_value_for_lsmname1'valid_lsmname2='valid_value_for_lsmname2'

changes while return value tells failure at

  valid_lsmname3='invalid_value_for_lsmname3'

. If you want to allow updating multiple values, you need to make them a transaction.

> +			cp += slen + 1;
> +		}
> +		if (failed != 0)
> +			rc = failed;
> +		else
> +			rc = size;
> +free_out:
> +		kfree(local);
> +		return rc;
> +	}
>  
>  	list_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsm))
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
