From: john.johansen@canonical.com (John Johansen)
Date: Tue, 29 Aug 2017 12:47:32 -0700
Subject: [apparmor] [PATCH] RFC: Add Apparmor policy matching to IMA
In-Reply-To: <20170829190401.18056-1-mjg59@google.com>
References: <20170829190401.18056-1-mjg59@google.com>
Message-ID: <9780464d-80c8-e397-d97b-26451eb502d1@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/29/2017 12:04 PM, Matthew Garrett wrote:
> IMA has support for matching based on security context, but this is
> currently limited to modules that implement the audit_rule_match hook.
> The infrastructure around this seems to depend on having 32 bit security
> IDs to reference the policy associated with tasks or files, which
> doesn't seem to be a concept that Apparmor really has. So, this
> implementation ignores the abstraction and calls through to Apparmor
> directly.
> 
> This seems ugly, so is there a better way to achieve this?

probably via secids :/

secid support in apparmor is a wip, and we are hoping to land full support
in 4.15

I'll see if I can't get a dev branch with them up for you this week.

that said if you wanted to land this sooner I am not opposed to this
going in with a minor change (see below) on the apparmor end

> ---
>  include/linux/apparmor.h            | 16 ++++++++++++++++
>  security/apparmor/lib.c             | 32 ++++++++++++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c | 24 +++++++++++++++++++++---
>  3 files changed, 69 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/apparmor.h
> 
> diff --git a/include/linux/apparmor.h b/include/linux/apparmor.h
> new file mode 100644
> index 000000000000..d8ac3f706437
> --- /dev/null
> +++ b/include/linux/apparmor.h
> @@ -0,0 +1,16 @@
> +#ifndef _APPARMOR_H_
> +
> +struct linux_binprm;
> +
> +#ifdef CONFIG_SECURITY_APPARMOR
> +int aa_task_profile_match(struct linux_binprm *bprm, struct task_struct *tsk,
> +			  const char *profile);
> +#else
> +static int aa_task_profile_match(struct linux_binprm *bprm,
> +				 struct task_struct *tsk, const char *profile)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 08ca26bcca77..04d087e4a1a3 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -17,9 +17,11 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
> +#include <linux/apparmor.h>
>  
>  #include "include/audit.h"
>  #include "include/apparmor.h"
> +#include "include/context.h"
>  #include "include/lib.h"
>  #include "include/perms.h"
>  #include "include/policy.h"
> @@ -385,6 +387,36 @@ void aa_profile_match_label(struct aa_profile *profile, struct aa_label *label,
>  	aa_label_match(profile, label, state, false, request, perms);
>  }
>  
> +/**
> + * aa_task_profile_match - check whether a task is using the specified profile
> + * @bprm - bprm structure to extract creds from.
> + * @tsk - task to verify. Ignored if @bprm is not NULL.
> + * @name - name of the profile to search for.
> + */
> +int aa_task_profile_match(struct linux_binprm *bprm, struct task_struct *tsk,
> +			   const char *name)
> +{
> +	struct aa_label *label;
> +	struct aa_profile *profile;
> +	struct aa_task_ctx *ctx;
> +	struct label_it i;
> +	const struct cred *cred;
> +
> +	if (bprm) {
> +		ctx = cred_ctx(bprm->cred);
> +		label = aa_get_newest_label(ctx->label);
> +	} else {
> +		cred = __task_cred(tsk);
> +		label = aa_get_newest_cred_label(cred);
> +	}
> +
> +	label_for_each(i, label, profile) {
> +		if (strcmp(name, profile->base.name) == 0)
> +			return 1;
> +	}
> +
you should be using
  profile->base.hname

its an stupid artefact of "hat" profile naming, which predates apparmor policy
namespace support

> +	return 0;
> +}
>  
>  /* currently unused */
>  int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 93f6af4e3a20..556a1292734c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -20,6 +20,7 @@
>  #include <linux/rculist.h>
>  #include <linux/genhd.h>
>  #include <linux/seq_file.h>
> +#include <linux/apparmor.h>
>  
>  #include "ima.h"
>  
> @@ -47,9 +48,9 @@
>  int ima_policy_flag;
>  static int temp_ima_appraise;
>  
> -#define MAX_LSM_RULES 6
> +#define MAX_LSM_RULES 7
>  enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
> -	LSM_SUBJ_USER, LSM_SUBJ_ROLE, LSM_SUBJ_TYPE
> +       LSM_SUBJ_USER, LSM_SUBJ_ROLE, LSM_SUBJ_TYPE, LSM_AA_PROFILE
>  };
>  
>  enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
> @@ -313,6 +314,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  							Audit_equal,
>  							rule->lsm[i].rule,
>  							NULL);
> +			break;
> +		case LSM_AA_PROFILE:
> +			rc = aa_task_profile_match(bprm, tsk,
> +						   rule->lsm[i].args_p);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -527,7 +533,7 @@ enum {
>  	Opt_audit,
>  	Opt_obj_user, Opt_obj_role, Opt_obj_type,
>  	Opt_subj_user, Opt_subj_role, Opt_subj_type,
> -	Opt_func, Opt_mask, Opt_fsmagic,
> +	Opt_aa_profile, Opt_func, Opt_mask, Opt_fsmagic,
>  	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
>  	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
> @@ -547,6 +553,7 @@ static match_table_t policy_tokens = {
>  	{Opt_subj_user, "subj_user=%s"},
>  	{Opt_subj_role, "subj_role=%s"},
>  	{Opt_subj_type, "subj_type=%s"},
> +	{Opt_aa_profile, "aa_profile=%s"},
>  	{Opt_func, "func=%s"},
>  	{Opt_mask, "mask=%s"},
>  	{Opt_fsmagic, "fsmagic=%s"},
> @@ -847,6 +854,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  						   LSM_SUBJ_TYPE,
>  						   AUDIT_SUBJ_TYPE);
>  			break;
> +		case Opt_aa_profile:
> +			ima_log_string(ab, "aa_profile", args[0].from);
> +			entry->lsm[LSM_AA_PROFILE].args_p = match_strdup(args);
> +			entry->lsm[LSM_AA_PROFILE].rule = 1;
> +			if (!entry->lsm[LSM_AA_PROFILE].args_p)
> +				result = -ENOMEM;
> +			break;
>  		case Opt_appraise_type:
>  			if (entry->action != APPRAISE) {
>  				result = -EINVAL;
> @@ -1138,6 +1152,10 @@ int ima_policy_show(struct seq_file *m, void *v)
>  				seq_printf(m, pt(Opt_subj_type),
>  					   (char *)entry->lsm[i].args_p);
>  				break;
> +			case LSM_AA_PROFILE:
> +				seq_printf(m, pt(Opt_aa_profile),
> +					   (char *)entry->lsm[i].args_p);
> +				break;
>  			}
>  		}
>  	}
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
