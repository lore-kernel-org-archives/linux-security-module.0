Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937587;
	b=cD3anRx9RaPe8fhB5qf1B5uRZLXPiTNb4xkgWdyAVmgUDFuAwHxaEjdNj3Aceed05Z5p
	 IKLpZhQZCzhEj8MPHwsXXKXs6jp0ecYLfvS2Gz8/ehqNG+ISdBtmuD9gvBrjNPzzbQYsg
	 imzf2S29HlgBNvq8ZFbB4ifQps6Nt6tzU9ZCc+waKAWEMshgiHykCp4uWEHJDQ1chNn7L
	 O2S/OQM3xYVhzU0ffBtD8yUe0a9pL5uQyG3bXRCJlyJA/gE7HchLPIk/jRkvjiAYte+aF
	 D+h6HB7FoMFwdIGEWm3jekMrCbXTG9bTmopQ0HIr8WD08RHgY/I8XTV+amdqmJgc8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937587;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UmfgK7umUHFAox0OKPAdFKkV7oHGXgup5gXN3nip+og=;
	b=AZgxazlRMC2Le6f2bz4GluP2vvm2OHrRxXPUP1PLpm+1McxTfkJKkjWpD8geLmCj33jf
	 l39mN1hokehwNQd27jFFMfqP6xY9iUfXeSYO6a4ZhmkYdD0TBT8tQoeQl3jhTJrZElZH2
	 m0n4YuMJ0kj/4i6qHAWVCo8EiSsSPwZdD5DYWxi/Z6lsOA3dAlYTLEcS2kpe31Ql+hJy+
	 U2Jid/Z30gId4ZHCiEuyQ0xDeM17TEzTgrS+zjzQLKF4tfqQZsM3i7Dpvr2HNmBAKplmP
	 6pGv50r+0MTw0ccvKRsHsCfD/hGRDBo1HRUJ9TA87IKfWr1hcvMpJvcqRL8luVH8+kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=UrpOtO0t;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EC606A31B;
	Fri,  6 Nov 2026 03:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=UrpOtO0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793937582; bh=zQ6fFDAh5KTs4S3euVeNHK208onNk6W8aITDCHvbEgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrpOtO0tfVJr0UsK1NT1E//zrc6mrA8wdl+7qa8IUDO1EmyL2/z9Hn1yNcslGeImf
	 9ru1Jky5eIzFvbNE61UkwB2qjzjO9TFnhngHfqOFy76qkaoxFeOqOXOm8QZUiWXlLe
	 hX0H+TO3KYSJwGryZddArZXBcd0rwxbn8m8CvcAVFTf0msK/EvSb+Fb0+zyRAl50jC
	 uCYRJMzkJO+UcWwE5rtvGxdyBHjHpRqrKqnmYBAGUNbgl1u701D9/pFYSGSaopVgCs
	 DXrJSgFE+mFxhSmYvGFJxdXhCMwRJsIlD+/gGECBCZcHySdV9n9IiiEdw8RuklL1E1
	 1PJHBY6cPeNvg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B5FB3229E; Thu,  5 Nov 2026 21:59:42 -0600 (CST)
Date: Thu, 5 Nov 2026 21:59:42 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 01/13] cred: gather the rules for acting on a task by
 uid
Message-ID: <au1Qro24KQs5CkQ5@hallyn.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-1-956213608f16@toxicpanda.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-b4-cred-ids-v2-1-956213608f16@toxicpanda.com>

On Wed, Nov 04, 2026 at 02:24:28PM +0000, Josef Bacik wrote:
> A number of operations let one task act on another without any capability,
> because the two belong to the same user: signals, scheduling attributes,
> priorities, resource limits, ptrace and more. Each of them compares the
> ids of the two credentials by hand. There are twelve such places, in six
> flavours that differ in which ids they look at, and nothing says that they
> belong together.
> 
> That makes them hard to review and hard to change. Nobody can tell from
> one of them whether it differs from its neighbour on purpose. Whoever
> wants to know what an equal uid is good for has to find all twelve, and so
> does whoever has to change it. A place that is overlooked is a hole.
> 
> Gather the rules in kernel/cred.c, side by side:
> 
>  rule     of the subject    of the object      euid 0 used for
>  signal   euid or uid       suid or uid        no     kill()
>  sigio    euid or uid       suid or uid        yes    SIGIO, SIGURG
>  sched    euid              euid or uid        no     scheduler, nice
>  ioprio   euid or uid       uid                no     ioprio_set()
>  move     euid              uid or suid        yes    cgroup v1, resctrl
>  control  one uid, one gid  all three of each  no     ptrace, prlimit, keys
> 
> Where it says so, a subject with euid 0 may act on anybody. That is a
> capability by another name, from before there were any, and it belongs
> with the rest: it is a uid that decides whether one task may act on
> another.
> 
> What each operation means by "the same user" has grown separately and
> cannot be changed now, so every rule is kept as it is. The functions only
> speak for the ids. A capability that does as well, and the LSM hook that
> goes with the operation, remain with the caller.
> 
> The callers are converted one by one in the patches that follow.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Hi Josef,

this all looks good and correct to me.  I'll reply to the cover letter with

Reviewed-by: Serge Hallyn <serge@hallyn.com>

so hopefully b4 shazam will pick it up for all the patches.

Just one question below:

> ---
>  Documentation/security/credentials.rst |  19 ++++
>  include/linux/cred.h                   |  20 ++++
>  kernel/cred.c                          | 162 +++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index a39a2a2f67aa..b095c03b4531 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -422,6 +422,25 @@ magic.  This may not be used for pointer members as what they point to may
>  disappear the moment the RCU read lock is dropped.
>  
>  
> +Comparing the Ids of Two Tasks
> +------------------------------
> +
> +Whether one task may act on another because both belong to the same user must not
> +be decided by comparing the ids of their credentials by hand.  The rules for that
> +are kept in one place:
> +
> +.. kernel-doc:: kernel/cred.c
> +   :doc: One task acting on another on the strength of its ids
> +
> +.. kernel-doc:: kernel/cred.c
> +   :identifiers: cred_ids_allow_signal cred_ids_allow_sigio
> +                 cred_ids_allow_sched cred_ids_allow_ioprio
> +                 cred_ids_allow_move cred_ids_allow_control
> +
> +.. kernel-doc:: include/linux/cred.h
> +   :identifiers: cred_ids
> +
> +
>  Altering Credentials
>  --------------------
>  
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 49c26af37349..7fb1663a5fc6 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -171,6 +171,26 @@ extern int cred_fscmp(const struct cred *, const struct cred *);
>  extern void __init cred_init(void);
>  extern int set_cred_ucounts(struct cred *);
>  
> +/**
> + * enum cred_ids - which of its ids a subject acts with
> + * @CRED_IDS_REAL:      uid and gid
> + * @CRED_IDS_EFFECTIVE: euid and egid
> + * @CRED_IDS_FS:        fsuid and fsgid
> + */
> +enum cred_ids {
> +	CRED_IDS_REAL,
> +	CRED_IDS_EFFECTIVE,
> +	CRED_IDS_FS,
> +};
> +
> +bool cred_ids_allow_signal(const struct cred *subj, const struct cred *obj);
> +bool cred_ids_allow_sigio(const struct cred *subj, const struct cred *obj);
> +bool cred_ids_allow_sched(const struct cred *subj, const struct cred *obj);
> +bool cred_ids_allow_ioprio(const struct cred *subj, const struct cred *obj);
> +bool cred_ids_allow_move(const struct cred *subj, const struct cred *obj);
> +bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
> +			    const struct cred *obj);
> +
>  static inline bool cap_ambient_invariant_ok(const struct cred *cred)
>  {
>  	return cap_issubset(cred->cap_ambient,
> diff --git a/kernel/cred.c b/kernel/cred.c
> index d01df40a9a38..5e10e0bdd11e 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -19,6 +19,7 @@
>  #include <linux/binfmts.h>
>  #include <linux/cn_proc.h>
>  #include <linux/uidgid.h>
> +#include <linux/vfsdebug.h>
>  
>  #if 0
>  #define kdebug(FMT, ...)						\
> @@ -541,6 +542,167 @@ void __init cred_init(void)
>  			      SLAB_NO_MERGE);
>  }
>  
> +/**
> + * DOC: One task acting on another on the strength of its ids
> + *
> + * A number of operations let one task act on another without any capability,
> + * because the two belong to the same user. What "the same user" means has grown
> + * separately for each of them and cannot be changed now. All of it is kept
> + * here, side by side, so that there is one place to read it.
> + *
> + * =======  ================  =================  ======  =====================
> + * Rule     Of the subject    Of the object      euid 0  Used for
> + * =======  ================  =================  ======  =====================
> + * signal   euid or uid       suid or uid        no      kill()
> + * sigio    euid or uid       suid or uid        yes     SIGIO, SIGURG
> + * sched    euid              euid or uid        no      scheduler, nice
> + * ioprio   euid or uid       uid                no      ioprio_set()
> + * move     euid              uid or suid        yes     cgroup v1, resctrl
> + * control  one uid, one gid  all three of each  no      ptrace, prlimit, keys
> + * =======  ================  =================  ======  =====================
> + *
> + * Where it says so, a subject with euid 0 may act on anybody. That is a
> + * capability by another name, from before there were any.
> + *
> + * These functions only speak for the ids. A capability that does as well, and
> + * the LSM hook that goes with the operation, remain with the caller.
> + *
> + * Do not compare the ids of two credentials by hand to decide whether one task
> + * may act on another. Use one of these, or add one.
> + */
> +
> +#define CRED_RUID	BIT(0)
> +#define CRED_EUID	BIT(1)
> +#define CRED_SUID	BIT(2)
> +
> +static bool cred_euid_is_root(const struct cred *subj)
> +{
> +	return uid_eq(subj->euid, GLOBAL_ROOT_UID);
> +}
> +
> +static bool cred_has_uid(const struct cred *cred, unsigned int ids, kuid_t uid)
> +{
> +	return ((ids & CRED_RUID) && uid_eq(cred->uid, uid)) ||
> +	       ((ids & CRED_EUID) && uid_eq(cred->euid, uid)) ||
> +	       ((ids & CRED_SUID) && uid_eq(cred->suid, uid));
> +}
> +
> +/*
> + * Is any of the @subj_ids of @subj any of the @obj_ids of @obj? No rule looks at
> + * the saved uid of the subject.
> + */
> +static bool cred_uid_match_any(const struct cred *subj, unsigned int subj_ids,
> +			       const struct cred *obj, unsigned int obj_ids)
> +{
> +	return ((subj_ids & CRED_RUID) && cred_has_uid(obj, obj_ids, subj->uid)) ||
> +	       ((subj_ids & CRED_EUID) && cred_has_uid(obj, obj_ids, subj->euid));
> +}
> +
> +/**
> + * cred_ids_allow_signal - do its ids allow a subject to signal an object?
> + * @subj: the credentials of whoever sends the signal
> + * @obj:  the credentials of the task it is for
> + *
> + * Return: true if the euid or the uid of @subj is the suid or the uid of @obj.
> + */
> +bool cred_ids_allow_signal(const struct cred *subj, const struct cred *obj)
> +{
> +	return cred_uid_match_any(subj, CRED_EUID | CRED_RUID,
> +				  obj, CRED_SUID | CRED_RUID);
> +}
> +
> +/**
> + * cred_ids_allow_sigio - do its ids allow a subject to have SIGIO sent?
> + * @subj: the credentials of whoever made the object the owner of a file
> + * @obj:  the credentials of the task that SIGIO or SIGURG is for
> + *
> + * Return: true if cred_ids_allow_signal() says so, or the euid of @subj is 0.
> + */
> +bool cred_ids_allow_sigio(const struct cred *subj, const struct cred *obj)
> +{
> +	return cred_euid_is_root(subj) || cred_ids_allow_signal(subj, obj);
> +}
> +
> +/**
> + * cred_ids_allow_sched - do its ids allow a subject to schedule an object?
> + * @subj: the credentials of whoever asks
> + * @obj:  the credentials of the task whose policy, affinity or nice value is
> + *        to change
> + *
> + * Return: true if the euid of @subj is the euid or the uid of @obj.
> + */
> +bool cred_ids_allow_sched(const struct cred *subj, const struct cred *obj)
> +{
> +	return cred_uid_match_any(subj, CRED_EUID, obj, CRED_EUID | CRED_RUID);
> +}
> +
> +/**
> + * cred_ids_allow_ioprio - do its ids allow a subject to set an I/O priority?
> + * @subj: the credentials of whoever asks
> + * @obj:  the credentials of the task whose I/O priority is to change
> + *
> + * Return: true if the euid or the uid of @subj is the uid of @obj.
> + */
> +bool cred_ids_allow_ioprio(const struct cred *subj, const struct cred *obj)
> +{
> +	return cred_uid_match_any(subj, CRED_EUID | CRED_RUID, obj, CRED_RUID);
> +}
> +
> +/**
> + * cred_ids_allow_move - do its ids allow a subject to move an object about?
> + * @subj: the credentials of whoever asks
> + * @obj:  the credentials of the task that is to be moved to another group of a
> + *        cgroup v1 hierarchy or of resctrl
> + *
> + * Return: true if the euid of @subj is the uid or the suid of @obj, or is 0.
> + */
> +bool cred_ids_allow_move(const struct cred *subj, const struct cred *obj)
> +{
> +	return cred_euid_is_root(subj) ||
> +	       cred_uid_match_any(subj, CRED_EUID, obj, CRED_RUID | CRED_SUID);
> +}
> +
> +/**
> + * cred_ids_allow_control - do its ids give a subject the run of an object?
> + * @subj:  the credentials of whoever asks
> + * @which: which of its ids @subj acts with
> + * @obj:   the credentials of the task that is to be traced, limited or the like
> + *
> + * The strictest of the rules, for what amounts to taking the object over. It
> + * fails for an object that has changed any of its ids, a set-id program say.
> + *
> + * Return: true if the uid @subj acts with is the uid, the euid and the suid of
> + * @obj, and the gid it acts with is the gid, the egid and the sgid of @obj.
> + */
> +bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
> +			    const struct cred *obj)
> +{
> +	kuid_t uid;
> +	kgid_t gid;
> +
> +	switch (which) {
> +	case CRED_IDS_REAL:
> +		uid = subj->uid;
> +		gid = subj->gid;
> +		break;
> +	case CRED_IDS_EFFECTIVE:
> +		uid = subj->euid;
> +		gid = subj->egid;
> +		break;
> +	case CRED_IDS_FS:
> +		uid = subj->fsuid;
> +		gid = subj->fsgid;
> +		break;
> +	default:
> +		VFS_WARN_ON_ONCE(1);

Why are you using VFS_WARN_ON_ONCE here?

> +		return false;
> +	}
> +
> +	return uid_eq(uid, obj->uid) && uid_eq(uid, obj->euid) &&
> +	       uid_eq(uid, obj->suid) && gid_eq(gid, obj->gid) &&
> +	       gid_eq(gid, obj->egid) && gid_eq(gid, obj->sgid);
> +}
> +
>  /**
>   * prepare_kernel_cred - Prepare a set of credentials for a kernel service
>   * @daemon: A userspace daemon to be used as a reference
> 
> -- 
> 2.55.0
