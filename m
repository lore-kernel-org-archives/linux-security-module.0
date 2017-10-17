From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 17 Oct 2017 15:07:03 -0400
Subject: [PATCH 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <20171016203709.11199-2-mjg59@google.com>
References: <20171016203709.11199-1-mjg59@google.com>
	<20171016203709.11199-2-mjg59@google.com>
Message-ID: <1508267223.4513.23.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-10-16 at 13:37 -0700, Matthew Garrett wrote:

>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 95209a5f8595..c9d5735711eb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -247,10 +247,9 @@ static void ima_lsm_update_rules(void)
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> -			    enum ima_hooks func, int mask)
> +			    const struct cred *cred, enum ima_hooks func,
> +			    int mask)
>  {
> -	struct task_struct *tsk = current;
> -	const struct cred *cred = current_cred();
>  	int i;
> 
>  	if ((rule->flags & IMA_FUNC) &&
> @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			security_task_getsecid(tsk, &sid);
> +			security_cred_getsecid(cred, &sid);
>  			rc = security_filter_rule_match(sid,
>  							rule->lsm[i].type,
>  							Audit_equal,

By replacing the call from security_task_getsec() to
security_cred_getsecid(), I assume you're expecting different results.
?Will this change break existing IMA policies?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
