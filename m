Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76E3ACA77;
	Wed,  9 Sep 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986808; cv=none; b=io1Zx9V7/hS/wTXv01XJjc6QfnJekdRiuyV+l/yKqBsIZ+4CZ97VhdKvn400SUCrB6HgC8YScOstatkFtuqJD14rdyrBPJNeB4bg4hZm7cQK2EbZxH5WJ+VPLL/KXS2f6wzqylzJA7+sqsWn00uefYkEptAx/6rRzsz1rdXSsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986808; c=relaxed/simple;
	bh=qKlZmENngD+RbPfuDERzbgeCtGhOEA6PR8/60dlQ5SI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sgJuCs/av5ggjy5K3LZpM7v7SgkMysGlsZE/I0P80JOTQ1/xCfnpyaSqLb/3qq7oZjYrokv0wFMuJS3SGn/oc7dQEtJp359izMfdSL9+4gQXxLoMJz7ZT5bGG6QSQ6rWI/FfoRTDP/GokWpfx5mpeglnN5sgq9WEH1HA1C4HjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRY5Iw11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRY5Iw11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808461F0089A;
	Wed,  9 Sep 2026 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986794;
	bh=Ffn5L8gdj37vMhQbFrOMi3Fu0UfAVCiA7fXhViVJC4k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bRY5Iw11FU9q1uK4YXoKCvxCtqb5jXDl+47x6XPTq7tZUxMwk9cm0CnOgucRt2/D4
	 Nndfwn32w6ktnN0FMulRq5WxtMvqSk8k78qUbDzae1m21uiz3gg968fwvUXS9Xih7A
	 ZmhXLUDmIJFuib4vsNKP+5mdR80/PWvjfRNzgMr4tsP1frx8XmT2TPZZ2IyJHPxnXv
	 lC+bZoOyZZnkJo04yDGQZJtSp11VRK4jCZLFJB6e+LCXDT0iQasawYhn34sv+VcZfC
	 ojDc2vA+FWECM9HUkUS5kwJsfKIZncjlTzV2WtH17jnKSYhlYKm0IGd9je1cKgKeok
	 H/spsSpINzMpw==
Content-Type: multipart/mixed; boundary="===============7768260903692279173=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3f645f8f6c007dde4eea8821037ea535d3ee88cc71538dae13487a9800d0a52@mail.kernel.org>
In-Reply-To: <20260909193719.518517-14-utilityemal77@gmail.com>
References: <20260909193719.518517-14-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 13/15] landlock: Implement the LSM policy object hooks
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:46:33 +0000 (UTC)

--===============7768260903692279173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index 88fa97fc3bd2..9a2971197892 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -59,6 +59,16 @@ struct landlock_cred_security {
>  	 */
>  	struct landlock_domain *domain;
>
> +#ifdef CONFIG_BPF_LSM
> +	/**
> +	 * @staged: Restriction staged by the bprm_apply_policy_object() hook,
> +	 * owning its domain reference, applied at bprm_committing_creds().
> +	 * Only ever set on credentials prepared for an execution; committed
> +	 * task credentials never carry a staged restriction.
> +	 */
> +	struct landlock_restriction staged;
> +#endif /* CONFIG_BPF_LSM */
> +
>  #ifdef CONFIG_SECURITY_LANDLOCK_LOG

Does adding the staged field here grow struct landlock_file_security for
every open file?

struct landlock_cred_security is embedded by value in the file blob:

security/landlock/fs.h:88-90:
	struct landlock_cred_security fown_subject;

and security/landlock/setup.c sets .lbs_file = sizeof(struct
landlock_file_security), so that blob is allocated for every struct
file.

struct landlock_restriction is 16 bytes (domain pointer + u32 flags +
tail padding), so adding it grows landlock_cred_security from 11 bytes
(8+2+1) to 27 bytes (8+16+2+1), making struct landlock_file_security
grow from 32 to 48 bytes (+50%) when CONFIG_BPF_LSM=y.

The struct's kernel-doc says "This structure is packed to minimize the
size of struct landlock_file_security," but the new field is documented
as "Only ever set on credentials prepared for an execution; committed
task credentials never carry a staged restriction," so it is always
zero in the file blob.

hook_file_set_fowner() at security/landlock/fs.c copies this blob with
raw struct assignments, so the 16 exec-only bytes are copied on every
fcntl(F_SETOWN) and socket-owner set. hook_file_free_security() only
touches fown_subject.domain, never staged.

CONFIG_BPF_LSM=y is enabled by mainstream distributions alongside
CONFIG_SECURITY_LANDLOCK, making this the common configuration. Could
the exec-only staging state live in a separate structure that is not
embedded in the per-file blob?

> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 1465f8a5c464..22edb140bb7f 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h

[ ... ]

> @@ -146,6 +147,16 @@ struct landlock_rules {
>  	u32 num_rules;
>  };
>
> +#ifdef CONFIG_BPF_LSM
> +/*
> + * Landlock's lsm_policy_object types.  The namespace is private to
> + * Landlock; 0 stays reserved as "unset".
> + */
> +enum landlock_policy_type {
> +	LANDLOCK_POLICY_TYPE_RULESET = 1,
> +};
> +#endif /* CONFIG_BPF_LSM */
> +
>  /**
>   * struct landlock_ruleset - Landlock ruleset
>   *
> @@ -157,6 +168,17 @@ struct landlock_ruleset {
>  	 * @rules: Red-black tree storage for rules.
>  	 */
>  	struct landlock_rules rules;
> +
> +#ifdef CONFIG_BPF_LSM
> +	/**
> +	 * @policy_object: Identity under which the ruleset is handed out
> +	 * to BPF programs as a referenced kptr: the LSM policy kfuncs
> +	 * dispatch back to Landlock through its lsmid.  Kept outside the
> +	 * union with @work_free: RCU readers may read its lsmid while a
> +	 * queued free waits out the grace period.
> +	 */
> +	struct lsm_policy_object policy_object;
> +#endif /* CONFIG_BPF_LSM */
>  	/**
>  	 * @usage: Number of file descriptors referencing this ruleset.  Kept
>  	 * outside the union with @work_free: RCU readers may still call

Should the @usage documentation be updated?

The comment says "Number of file descriptors referencing this ruleset,"
but after this patch a reference can be held with no file descriptor
involved at all.

hook_policy_object_from_fd() calls landlock_get_ruleset_from_fd() to
increment @usage, then the BPF program parks that owned reference in a
map kptr field with bpf_kptr_xchg(). Userspace can close the ruleset fd
afterwards, leaving @usage at 1 with zero file descriptors referencing
the ruleset. hook_policy_object_get() also increments the refcount for
an RCU reader holding no fd.

The rest of this struct's documentation is maintained precisely (three
members carry "Kept outside the union with @work_free" rationales), so
the stale enumeration stands out.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============7768260903692279173==--
