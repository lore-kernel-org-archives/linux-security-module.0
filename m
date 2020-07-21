Return-Path: <SRS0=/BYZ=BA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84DC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 02:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D188206E9
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 02:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGUCmI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:42:08 -0400
Received: from mail.hallyn.com ([178.63.66.53]:59360 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGUCmI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 22:42:08 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DC963A10; Mon, 20 Jul 2020 21:42:02 -0500 (CDT)
Date:   Mon, 20 Jul 2020 21:42:02 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org, keescook@chromium.org,
        casey@schaufler-ca.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, serge@hallyn.com,
        jmorris@namei.org, Thomas Cedeno <thomascedeno@google.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add GID security policy handling
Message-ID: <20200721024202.GB28125@mail.hallyn.com>
References: <20200720181203.1461548-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720181203.1461548-1-mortonm@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 20, 2020 at 11:12:03AM -0700, Micah Morton wrote:
> From: Thomas Cedeno <thomascedeno@google.com>
> 
> The SafeSetID LSM has functionality for restricting setuid() calls based
> on its configured security policies. This patch adds the analogous
> functionality for setgid() calls. This is mostly a copy-and-paste change
> with some code deduplication, plus slight modifications/name changes to
> the policy-rule-related structs (now contain GID rules in addition to
> the UID ones) and some type generalization since SafeSetID now needs to
> deal with kgid_t and kuid_t types.
> 
> Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Just one question and two little comments below.

> ---
> NOTE: Looks like some userns-related lines in the selftest for SafeSetID
> recently had some kind of regression. We won't be sending a patch to
> update the selftest until we can get to the bottom of that. However, we
> have a WIP (due to the userns regression) update to the selftest which
> tests the GID stuff and we have used it to ensure this patch is correct.
> 
>  security/safesetid/lsm.c        | 178 +++++++++++++++++++++-------
>  security/safesetid/lsm.h        |  38 ++++--
>  security/safesetid/securityfs.c | 198 +++++++++++++++++++++++---------
>  3 files changed, 309 insertions(+), 105 deletions(-)
> 
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 7760019ad35d..787a98e82f1e 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -24,20 +24,36 @@
>  /* Flag indicating whether initialization completed */
>  int safesetid_initialized;
>  
> -struct setuid_ruleset __rcu *safesetid_setuid_rules;
> +struct setid_ruleset __rcu *safesetid_setuid_rules;
> +struct setid_ruleset __rcu *safesetid_setgid_rules;
> +
>  
>  /* Compute a decision for a transition from @src to @dst under @policy. */
> -enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
> -		kuid_t src, kuid_t dst)
> +enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
> +		kid_t src, kid_t dst)
>  {
> -	struct setuid_rule *rule;
> +	struct setid_rule *rule;
>  	enum sid_policy_type result = SIDPOL_DEFAULT;
>  
> -	hash_for_each_possible(policy->rules, rule, next, __kuid_val(src)) {
> -		if (!uid_eq(rule->src_uid, src))
> -			continue;
> -		if (uid_eq(rule->dst_uid, dst))
> -			return SIDPOL_ALLOWED;
> +	if (policy->type == UID) {
> +		hash_for_each_possible(policy->rules, rule, next, __kuid_val(src.uid)) {
> +			if (!uid_eq(rule->src_id.uid, src.uid))
> +				continue;
> +			if (uid_eq(rule->dst_id.uid, dst.uid))
> +				return SIDPOL_ALLOWED;
> +			result = SIDPOL_CONSTRAINED;

Can you describe precisely under which conditions SIDPOL_CONSTRAINED should
be returned vs. SIDPOL_DEFAULT?

> +		}
> +	} else if (policy->type == GID) {
> +		hash_for_each_possible(policy->rules, rule, next, __kgid_val(src.gid)) {
> +			if (!gid_eq(rule->src_id.gid, src.gid))
> +				continue;
> +			if (gid_eq(rule->dst_id.gid, dst.gid)){
> +				return SIDPOL_ALLOWED;
> +			}
> +			result = SIDPOL_CONSTRAINED;
> +		}
> +	} else {
> +		/* Should not reach here, report the ID as contrainsted */
>  		result = SIDPOL_CONSTRAINED;
>  	}
>  	return result;
> @@ -47,15 +63,26 @@ enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
>   * Compute a decision for a transition from @src to @dst under the active
>   * policy.
>   */
> -static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
> +static enum sid_policy_type setid_policy_lookup(kid_t src, kid_t dst, enum setid_type new_type)
>  {
>  	enum sid_policy_type result = SIDPOL_DEFAULT;
> -	struct setuid_ruleset *pol;
> +	struct setid_ruleset *pol;
>  
>  	rcu_read_lock();
> -	pol = rcu_dereference(safesetid_setuid_rules);
> -	if (pol)
> -		result = _setuid_policy_lookup(pol, src, dst);
> +	if (new_type == UID)
> +		pol = rcu_dereference(safesetid_setuid_rules);
> +	else if (new_type == GID)
> +		pol = rcu_dereference(safesetid_setgid_rules);
> +	else { /* Should not reach here */
> +		result = SIDPOL_CONSTRAINED;
> +		rcu_read_unlock();
> +		return result;
> +	}
> +
> +	if (pol) {
> +		pol->type = new_type;
> +		result = _setid_policy_lookup(pol, src, dst);
> +	}
>  	rcu_read_unlock();
>  	return result;
>  }
> @@ -65,8 +92,8 @@ static int safesetid_security_capable(const struct cred *cred,
>  				      int cap,
>  				      unsigned int opts)
>  {
> -	/* We're only interested in CAP_SETUID. */
> -	if (cap != CAP_SETUID)
> +	/* We're only interested in CAP_SETUID and CAP_SETGID. */
> +	if (cap != CAP_SETUID && cap != CAP_SETGID)
>  		return 0;
>  
>  	/*
> @@ -77,45 +104,83 @@ static int safesetid_security_capable(const struct cred *cred,
>  	if ((opts & CAP_OPT_INSETID) != 0)
>  		return 0;
>  
> -	/*
> -	 * If no policy applies to this task, allow the use of CAP_SETUID for
> -	 * other purposes.
> -	 */
> -	if (setuid_policy_lookup(cred->uid, INVALID_UID) == SIDPOL_DEFAULT)
> +	switch (cap) {
> +	case CAP_SETUID:
> +		/*
> +		* If no policy applies to this task, allow the use of CAP_SETUID for
> +		* other purposes.
> +		*/
> +		if (setid_policy_lookup((kid_t)cred->uid, INVALID_ID, UID) == SIDPOL_DEFAULT)
> +			return 0;
> +		/*
> +		 * Reject use of CAP_SETUID for functionality other than calling
> +		 * set*uid() (e.g. setting up userns uid mappings).
> +		 */
> +		pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> +			__kuid_val(cred->uid));
> +		return -EPERM;
> +		break;
> +	case CAP_SETGID:
> +		/*
> +		* If no policy applies to this task, allow the use of CAP_SETGID for
> +		* other purposes.
> +		*/
> +		if (setid_policy_lookup((kid_t)cred->gid, INVALID_ID, GID) == SIDPOL_DEFAULT)
> +			return 0;
> +		/*
> +		 * Reject use of CAP_SETUID for functionality other than calling
> +		 * set*gid() (e.g. setting up userns gid mappings).
> +		 */
> +		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
> +			__kuid_val(cred->uid));
> +		return -EPERM;
> +		break;
> +	default:
> +		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
>  		return 0;
> -
> -	/*
> -	 * Reject use of CAP_SETUID for functionality other than calling
> -	 * set*uid() (e.g. setting up userns uid mappings).
> -	 */
> -	pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> -		__kuid_val(cred->uid));
> -	return -EPERM;
> +		break;
> +	}
> +	return 0;
>  }
>  
>  /*
>   * Check whether a caller with old credentials @old is allowed to switch to
> - * credentials that contain @new_uid.
> + * credentials that contain @new_id.
>   */
> -static bool uid_permitted_for_cred(const struct cred *old, kuid_t new_uid)
> +static bool id_permitted_for_cred(const struct cred *old, kid_t new_id, enum setid_type new_type)
>  {
>  	bool permitted;
>  
> -	/* If our old creds already had this UID in it, it's fine. */
> -	if (uid_eq(new_uid, old->uid) || uid_eq(new_uid, old->euid) ||
> -	    uid_eq(new_uid, old->suid))
> -		return true;
> +	/* If our old creds already had this ID in it, it's fine. */
> +	if (new_type == UID) {
> +		if (uid_eq(new_id.uid, old->uid) || uid_eq(new_id.uid, old->euid) ||
> +			uid_eq(new_id.uid, old->suid))
> +			return true;
> +	} else if (new_type == GID){
> +		if (gid_eq(new_id.gid, old->gid) || gid_eq(new_id.gid, old->egid) ||
> +			gid_eq(new_id.gid, old->sgid))
> +			return true;
> +	} else /* Error, new_type is an invalid type */
> +		return false;
>  
>  	/*
>  	 * Transitions to new UIDs require a check against the policy of the old
>  	 * RUID.
>  	 */
>  	permitted =
> -	    setuid_policy_lookup(old->uid, new_uid) != SIDPOL_CONSTRAINED;
> +	    setid_policy_lookup((kid_t)old->uid, new_id, new_type) != SIDPOL_CONSTRAINED;
> +
>  	if (!permitted) {
> -		pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
> -			__kuid_val(old->uid), __kuid_val(old->euid),
> -			__kuid_val(old->suid), __kuid_val(new_uid));
> +		if (new_type == UID) {
> +			pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
> +				__kuid_val(old->uid), __kuid_val(old->euid),
> +				__kuid_val(old->suid), __kuid_val(new_id.uid));
> +		} else if (new_type == GID) {
> +			pr_warn("GID transition ((%d,%d,%d) -> %d) blocked\n",
> +				__kgid_val(old->gid), __kgid_val(old->egid),
> +				__kgid_val(old->sgid), __kgid_val(new_id.gid));
> +		} else /* Error, new_type is an invalid type */
> +			return false;
>  	}
>  	return permitted;
>  }
> @@ -131,13 +196,37 @@ static int safesetid_task_fix_setuid(struct cred *new,
>  {
>  
>  	/* Do nothing if there are no setuid restrictions for our old RUID. */
> -	if (setuid_policy_lookup(old->uid, INVALID_UID) == SIDPOL_DEFAULT)
> +	if (setid_policy_lookup((kid_t)old->uid, INVALID_ID, UID) == SIDPOL_DEFAULT)
> +		return 0;
> +
> +	if (id_permitted_for_cred(old, (kid_t)new->uid, UID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->euid, UID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->suid, UID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->fsuid, UID))
> +		return 0;
> +
> +	/*
> +	 * Kill this process to avoid potential security vulnerabilities
> +	 * that could arise from a missing whitelist entry preventing a
> +	 * privileged process from dropping to a lesser-privileged one.
> +	 */
> +	force_sig(SIGKILL);
> +	return -EACCES;
> +}
> +
> +static int safesetid_task_fix_setgid(struct cred *new,
> +				     const struct cred *old,
> +				     int flags)
> +{
> +
> +	/* Do nothing if there are no setgid restrictions for our old RGID. */
> +	if (setid_policy_lookup((kid_t)old->gid, INVALID_ID, GID) == SIDPOL_DEFAULT)
>  		return 0;
>  
> -	if (uid_permitted_for_cred(old, new->uid) &&
> -	    uid_permitted_for_cred(old, new->euid) &&
> -	    uid_permitted_for_cred(old, new->suid) &&
> -	    uid_permitted_for_cred(old, new->fsuid))
> +	if (id_permitted_for_cred(old, (kid_t)new->gid, GID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->egid, GID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->sgid, GID) &&
> +	    id_permitted_for_cred(old, (kid_t)new->fsgid, GID))
>  		return 0;
>  
>  	/*
> @@ -151,6 +240,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>  
>  static struct security_hook_list safesetid_security_hooks[] = {
>  	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> +	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
>  	LSM_HOOK_INIT(capable, safesetid_security_capable)
>  };
>  
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index db6d16e6bbc3..bde8c43a3767 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -27,27 +27,47 @@ enum sid_policy_type {
>  	SIDPOL_ALLOWED /* target ID explicitly allowed */
>  };
>  
> +typedef union {
> +	kuid_t uid;
> +	kgid_t gid;
> +} kid_t;
> +
> +enum setid_type {
> +	UID,
> +	GID
> +};
> +
>  /*
> - * Hash table entry to store safesetid policy signifying that 'src_uid'
> - * can setuid to 'dst_uid'.
> + * Hash table entry to store safesetid policy signifying that 'src_id'
> + * can set*id to 'dst_id'.
>   */
> -struct setuid_rule {
> +struct setid_rule {
>  	struct hlist_node next;
> -	kuid_t src_uid;
> -	kuid_t dst_uid;
> +	kid_t src_id;
> +	kid_t dst_id;
> +
> +	/* Flag to signal if rule is for UID's or GID's */
> +	enum setid_type type;
>  };
>  
>  #define SETID_HASH_BITS 8 /* 256 buckets in hash table */
>  
> -struct setuid_ruleset {
> +/* Extension of INVALID_UID/INVALID_GID for kid_t type */
> +#define INVALID_ID (kid_t){.uid = INVALID_UID}
> +
> +struct setid_ruleset {
>  	DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
>  	char *policy_str;
>  	struct rcu_head rcu;
> +
> +	//Flag to signal if ruleset is for UID's or GID's
> +	enum setid_type type;
>  };
>  
> -enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
> -		kuid_t src, kuid_t dst);
> +enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
> +		kid_t src, kid_t dst);
>  
> -extern struct setuid_ruleset __rcu *safesetid_setuid_rules;
> +extern struct setid_ruleset __rcu *safesetid_setuid_rules;
> +extern struct setid_ruleset __rcu *safesetid_setgid_rules;
>  
>  #endif /* _SAFESETID_H */
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index f8bc574cea9c..211050d0a922 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -19,22 +19,23 @@
>  
>  #include "lsm.h"
>  
> -static DEFINE_MUTEX(policy_update_lock);
> +static DEFINE_MUTEX(uid_policy_update_lock);
> +static DEFINE_MUTEX(gid_policy_update_lock);
>  
>  /*
> - * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> + * In the case the input buffer contains one or more invalid IDs, the kid_t
>   * variables pointed to by @parent and @child will get updated but this
>   * function will return an error.
>   * Contents of @buf may be modified.
>   */
>  static int parse_policy_line(struct file *file, char *buf,
> -	struct setuid_rule *rule)
> +	struct setid_rule *rule)
>  {
>  	char *child_str;
>  	int ret;
>  	u32 parsed_parent, parsed_child;
>  
> -	/* Format of |buf| string should be <UID>:<UID>. */
> +	/* Format of |buf| string should be <UID>:<UID> or <GID>:<GID> */
>  	child_str = strchr(buf, ':');
>  	if (child_str == NULL)
>  		return -EINVAL;
> @@ -49,20 +50,36 @@ static int parse_policy_line(struct file *file, char *buf,
>  	if (ret)
>  		return ret;
>  
> -	rule->src_uid = make_kuid(file->f_cred->user_ns, parsed_parent);
> -	rule->dst_uid = make_kuid(file->f_cred->user_ns, parsed_child);
> -	if (!uid_valid(rule->src_uid) || !uid_valid(rule->dst_uid))
> +	if (rule->type == UID){
> +		rule->src_id.uid = make_kuid(file->f_cred->user_ns, parsed_parent);
> +		rule->dst_id.uid = make_kuid(file->f_cred->user_ns, parsed_child);
> +	} else if (rule->type == GID){
> +		rule->src_id.gid = make_kgid(file->f_cred->user_ns, parsed_parent);
> +		rule->dst_id.gid = make_kgid(file->f_cred->user_ns, parsed_child);
> +	} else {
> +		/* Error, rule->type is an invalid type */
>  		return -EINVAL;
> +	}

Is there any reason to have these the below if/else actions go into the above
if/else block?

> +	if (rule->type == UID) {
> +		if (!uid_valid(rule->src_id.uid) || !uid_valid(rule->dst_id.uid))
> +			return -EINVAL;
> +	} else if (rule->type == GID) {
> +		if (!gid_valid(rule->src_id.gid) || !gid_valid(rule->dst_id.gid))
> +			return -EINVAL;
> +	} else {
> +		/* Error, rule->type is an invalid type */
> +		return -EINVAL;
> +	}
>  	return 0;
>  }
>  
>  static void __release_ruleset(struct rcu_head *rcu)
>  {
> -	struct setuid_ruleset *pol =
> -		container_of(rcu, struct setuid_ruleset, rcu);
> +	struct setid_ruleset *pol =
> +		container_of(rcu, struct setid_ruleset, rcu);
>  	int bucket;
> -	struct setuid_rule *rule;
> +	struct setid_rule *rule;
>  	struct hlist_node *tmp;
>  
>  	hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
> @@ -71,36 +88,58 @@ static void __release_ruleset(struct rcu_head *rcu)
>  	kfree(pol);
>  }
>  
> -static void release_ruleset(struct setuid_ruleset *pol)
> -{
> +static void release_ruleset(struct setid_ruleset *pol){
>  	call_rcu(&pol->rcu, __release_ruleset);
>  }
>  
> -static void insert_rule(struct setuid_ruleset *pol, struct setuid_rule *rule)
> +static void insert_rule(struct setid_ruleset *pol, struct setid_rule *rule)
>  {
> -	hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> +	if (pol->type == UID)
> +		hash_add(pol->rules, &rule->next, __kuid_val(rule->src_id.uid));
> +	else if (pol->type == GID)
> +		hash_add(pol->rules, &rule->next, __kgid_val(rule->src_id.gid));
> +	else /* Error, pol->type is neither UID or GID */
> +		return;
>  }
>  
> -static int verify_ruleset(struct setuid_ruleset *pol)
> +static int verify_ruleset(struct setid_ruleset *pol)
>  {
>  	int bucket;
> -	struct setuid_rule *rule, *nrule;
> +	struct setid_rule *rule, *nrule;
>  	int res = 0;
>  
>  	hash_for_each(pol->rules, bucket, rule, next) {
> -		if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> -		    SIDPOL_DEFAULT) {
> -			pr_warn("insecure policy detected: uid %d is constrained but transitively unconstrained through uid %d\n",
> -				__kuid_val(rule->src_uid),
> -				__kuid_val(rule->dst_uid));
> +		if (_setid_policy_lookup(pol, rule->dst_id, INVALID_ID) == SIDPOL_DEFAULT) {
> +			if (pol->type == UID) {
> +				pr_warn("insecure policy detected: uid %d is constrained but transitively unconstrained through uid %d\n",
> +					__kuid_val(rule->src_id.uid),
> +					__kuid_val(rule->dst_id.uid));
> +			} else if (pol->type == GID) {
> +				pr_warn("insecure policy detected: gid %d is constrained but transitively unconstrained through gid %d\n",
> +					__kgid_val(rule->src_id.gid),
> +					__kgid_val(rule->dst_id.gid));
> +			} else { /* pol->type is an invalid type */
> +				res = -EINVAL;
> +				return res;
> +			}
>  			res = -EINVAL;
>  
>  			/* fix it up */
> -			nrule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
> +			nrule = kmalloc(sizeof(struct setid_rule), GFP_KERNEL);
>  			if (!nrule)
>  				return -ENOMEM;
> -			nrule->src_uid = rule->dst_uid;
> -			nrule->dst_uid = rule->dst_uid;
> +			if (pol->type == UID){
> +				nrule->src_id.uid = rule->dst_id.uid;
> +				nrule->dst_id.uid = rule->dst_id.uid;
> +				nrule->type = UID;
> +			} else if (pol->type == GID){
> +				nrule->src_id.gid = rule->dst_id.gid;
> +				nrule->dst_id.gid = rule->dst_id.gid;
> +				nrule->type = GID;
> +			} else { /* Error, pol->type is neither UID or GID */
> +				kfree(nrule);

Why not check this before the kmalloc?

> +				return res;
> +			}
>  			insert_rule(pol, nrule);
>  		}
>  	}
> @@ -108,16 +147,17 @@ static int verify_ruleset(struct setuid_ruleset *pol)
>  }
>  
>  static ssize_t handle_policy_update(struct file *file,
> -				    const char __user *ubuf, size_t len)
> +				    const char __user *ubuf, size_t len, enum setid_type policy_type)
>  {
> -	struct setuid_ruleset *pol;
> +	struct setid_ruleset *pol;
>  	char *buf, *p, *end;
>  	int err;
>  
> -	pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
> +	pol = kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
>  	if (!pol)
>  		return -ENOMEM;
>  	pol->policy_str = NULL;
> +	pol->type = policy_type;
>  	hash_init(pol->rules);
>  
>  	p = buf = memdup_user_nul(ubuf, len);
> @@ -133,7 +173,7 @@ static ssize_t handle_policy_update(struct file *file,
>  
>  	/* policy lines, including the last one, end with \n */
>  	while (*p != '\0') {
> -		struct setuid_rule *rule;
> +		struct setid_rule *rule;
>  
>  		end = strchr(p, '\n');
>  		if (end == NULL) {
> @@ -142,18 +182,18 @@ static ssize_t handle_policy_update(struct file *file,
>  		}
>  		*end = '\0';
>  
> -		rule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
> +		rule = kmalloc(sizeof(struct setid_rule), GFP_KERNEL);
>  		if (!rule) {
>  			err = -ENOMEM;
>  			goto out_free_buf;
>  		}
>  
> +		rule->type = policy_type;
>  		err = parse_policy_line(file, p, rule);
>  		if (err)
>  			goto out_free_rule;
>  
> -		if (_setuid_policy_lookup(pol, rule->src_uid, rule->dst_uid) ==
> -		    SIDPOL_ALLOWED) {
> +		if (_setid_policy_lookup(pol, rule->src_id, rule->dst_id) == SIDPOL_ALLOWED) {
>  			pr_warn("bad policy: duplicate entry\n");
>  			err = -EEXIST;
>  			goto out_free_rule;
> @@ -178,21 +218,45 @@ static ssize_t handle_policy_update(struct file *file,
>  	 * What we really want here is an xchg() wrapper for RCU, but since that
>  	 * doesn't currently exist, just use a spinlock for now.
>  	 */
> -	mutex_lock(&policy_update_lock);
> -	pol = rcu_replace_pointer(safesetid_setuid_rules, pol,
> -				  lockdep_is_held(&policy_update_lock));
> -	mutex_unlock(&policy_update_lock);
> +	if (policy_type == UID) {
> +		mutex_lock(&uid_policy_update_lock);
> +		pol = rcu_replace_pointer(safesetid_setuid_rules, pol,
> +					  lockdep_is_held(&uid_policy_update_lock));
> +		mutex_unlock(&uid_policy_update_lock);
> +	} else if (policy_type == GID) {
> +		mutex_lock(&gid_policy_update_lock);
> +		pol = rcu_replace_pointer(safesetid_setgid_rules, pol,
> +					  lockdep_is_held(&gid_policy_update_lock));
> +		mutex_unlock(&gid_policy_update_lock);
> +	} else {
> +		/* Error, policy type is neither UID or GID */
> +		pr_warn("error: bad policy type");
> +	}
>  	err = len;
>  
>  out_free_buf:
>  	kfree(buf);
>  out_free_pol:
>  	if (pol)
> -                release_ruleset(pol);
> +		release_ruleset(pol);
>  	return err;
>  }
>  
> -static ssize_t safesetid_file_write(struct file *file,
> +static ssize_t safesetid_uid_file_write(struct file *file,
> +				    const char __user *buf,
> +				    size_t len,
> +				    loff_t *ppos)
> +{
> +	if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
> +		return -EPERM;
> +
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
> +	return handle_policy_update(file, buf, len, UID);
> +}
> +
> +static ssize_t safesetid_gid_file_write(struct file *file,
>  				    const char __user *buf,
>  				    size_t len,
>  				    loff_t *ppos)
> @@ -203,38 +267,60 @@ static ssize_t safesetid_file_write(struct file *file,
>  	if (*ppos != 0)
>  		return -EINVAL;
>  
> -	return handle_policy_update(file, buf, len);
> +	return handle_policy_update(file, buf, len, GID);
>  }
>  
>  static ssize_t safesetid_file_read(struct file *file, char __user *buf,
> -				   size_t len, loff_t *ppos)
> +				   size_t len, loff_t *ppos, struct mutex *policy_update_lock, struct setid_ruleset* ruleset)
>  {
>  	ssize_t res = 0;
> -	struct setuid_ruleset *pol;
> +	struct setid_ruleset *pol;
>  	const char *kbuf;
>  
> -	mutex_lock(&policy_update_lock);
> -	pol = rcu_dereference_protected(safesetid_setuid_rules,
> -					lockdep_is_held(&policy_update_lock));
> +	mutex_lock(policy_update_lock);
> +	pol = rcu_dereference_protected(ruleset, lockdep_is_held(&policy_update_lock));
>  	if (pol) {
>  		kbuf = pol->policy_str;
>  		res = simple_read_from_buffer(buf, len, ppos,
>  					      kbuf, strlen(kbuf));
>  	}
> -	mutex_unlock(&policy_update_lock);
> +	mutex_unlock(policy_update_lock);
> +
>  	return res;
>  }
>  
> -static const struct file_operations safesetid_file_fops = {
> -	.read = safesetid_file_read,
> -	.write = safesetid_file_write,
> +static ssize_t safesetid_uid_file_read(struct file *file, char __user *buf,
> +				   size_t len, loff_t *ppos)
> +{
> +	return safesetid_file_read(file, buf, len, ppos,
> +				   &uid_policy_update_lock, safesetid_setuid_rules);
> +}
> +
> +static ssize_t safesetid_gid_file_read(struct file *file, char __user *buf,
> +				   size_t len, loff_t *ppos)
> +{
> +	return safesetid_file_read(file, buf, len, ppos,
> +				   &gid_policy_update_lock, safesetid_setgid_rules);
> +}
> +
> +
> +
> +static const struct file_operations safesetid_uid_file_fops = {
> +	.read = safesetid_uid_file_read,
> +	.write = safesetid_uid_file_write,
> +};
> +
> +static const struct file_operations safesetid_gid_file_fops = {
> +	.read = safesetid_gid_file_read,
> +	.write = safesetid_gid_file_write,
>  };
>  
>  static int __init safesetid_init_securityfs(void)
>  {
>  	int ret;
>  	struct dentry *policy_dir;
> -	struct dentry *policy_file;
> +	struct dentry *uid_policy_file;
> +	struct dentry *gid_policy_file;
>  
>  	if (!safesetid_initialized)
>  		return 0;
> @@ -245,13 +331,21 @@ static int __init safesetid_init_securityfs(void)
>  		goto error;
>  	}
>  
> -	policy_file = securityfs_create_file("whitelist_policy", 0600,
> -			policy_dir, NULL, &safesetid_file_fops);
> -	if (IS_ERR(policy_file)) {
> -		ret = PTR_ERR(policy_file);
> +	uid_policy_file = securityfs_create_file("uid_whitelist_policy", 0600,
> +			policy_dir, NULL, &safesetid_uid_file_fops);
> +	if (IS_ERR(uid_policy_file)) {
> +		ret = PTR_ERR(uid_policy_file);
>  		goto error;
>  	}
>  
> +	gid_policy_file = securityfs_create_file("gid_whitelist_policy", 0600,
> +			policy_dir, NULL, &safesetid_gid_file_fops);
> +	if (IS_ERR(gid_policy_file)) {
> +		ret = PTR_ERR(gid_policy_file);
> +		goto error;
> +	}
> +
> +
>  	return 0;
>  
>  error:
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
