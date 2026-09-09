Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70541BA81;
	Wed,  9 Sep 2026 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985812; cv=none; b=n5ErjnEcvrPEuCT3aQ2DJJJCwbOCv/i8iYOuABBQTtXBEYiVMHhIQZuXyXk4Jut3nZlPcXTJpu360YCPPMxcgZb7Jio8mDtHaF01ZOX6d2TtpxWsHyFaB31f4kqORgQS1WCGBAy4s4RspsWqA8oyqldxag2Yk2nGHrUUUdK9GM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985812; c=relaxed/simple;
	bh=rPkAujITE7i9u31o6ZiwCibdSYQWVGevQAnP4+K0KZ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DHm4wadTRH8MSVtB1QtVxe7qSFPnwVap/ELv7ZWdY9Aes+X6G9GT5+di5m7GzMmQ3aDgwBL+E6oCSzAc3ClFExESq3apgy5U498QeVQ+BnQtUsHXn+ld+CRpiFEjNoM6GgWuJlWPxv3np9ilcyXI9H+LdbXHMgfyVNhT38O7DS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI+PJqxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI+PJqxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96421F00899;
	Wed,  9 Sep 2026 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985802;
	bh=Lyv0L/4ipysGiQ6qRhyrfrKEyetbfGfMfzVdFDDzfwU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PI+PJqxm85SiYlzlYSHjbIR837OvMEhO35NIBQBASPB19FGGP8pogFsMdmkRDmwlr
	 BiW1UnN3rIUjO2feRD4KYY4QqWkTULFQuXeL6XWc+ODhfbAbZyMMVYvRXbruVv5XQ1
	 i62Wqi1Zj8ATIDmOxW41qSb6ngU52PLqj5NswCgZ3uGjMKi+e7rdw2h+LYAEH6+p59
	 6aQ0EUmefJEOTOHt+6dNwVOYFDRcnFFtVwn3mKiBirFCPQLwTvxOoxj0Ugl20yS7rX
	 uJk1NkrbQ8yk1uHIOzWxGimYlFxBNN+wN3bTymB9Jl01okPS5sME6+SbOCbANtIHNz
	 +1hWNBr/Ydm6w==
Content-Type: multipart/mixed; boundary="===============8517157787774259594=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <023aac007780af00c0060b296fe83c373e580c42836e08807ca1f61ce82ca009@mail.kernel.org>
In-Reply-To: <20260909193719.518517-7-utilityemal77@gmail.com>
References: <20260909193719.518517-7-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] lsm: Add the bpf_lsm_policy_acquire kfunc
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:30:00 +0000 (UTC)

--===============8517157787774259594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> index 988dcd6f4dd9..43a4bf57fd31 100644
> --- a/security/bpf_lsm_kfuncs.c
> +++ b/security/bpf_lsm_kfuncs.c
> @@ -14,6 +14,36 @@
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * bpf_lsm_policy_acquire - Acquire a reference on a shared policy object
> + * @object: RCU-protected pointer to a policy object, e.g. loaded from
> + *          a map kptr field under bpf_rcu_read_lock()
> + *
> + * Acquire a reference of its own on a policy object the program does
> + * not own, so that any number of concurrent program executions can
> + * use the object shared through one map kptr field, without emptying
> + * it as bpf_kptr_xchg() would.  The returned reference stays valid
> + * after bpf_rcu_read_unlock() and must be released with
> + * bpf_lsm_policy_release().
> + *
> + * Return: A referenced policy object, or NULL if the object's
> + * reference count concurrently dropped to zero.
> + */

This isn't a bug, but would it be worth spelling out the other NULL
cases here -- no enabled LSM owning @object->lsmid, or the owning LSM's
get hook failing -- the way bpf_lsm_policy_from_fd()'s Return: section
does just below?

The current text names one of the three ways the kfunc yields NULL. The
body also returns NULL when no enabled LSM's policy_object_get static
call matches @object->lsmid, and when the owning LSM's hook fails for a
reason other than a dead refcount.

> +__bpf_kfunc struct lsm_policy_object *
> +bpf_lsm_policy_acquire(struct lsm_policy_object *object)
> +{
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, policy_object_get) {
> +		if (scall->hl->lsmid->id != object->lsmid)
> +			continue;
> +		if (scall->hl->hook.policy_object_get(object))
> +			return NULL;
> +		return object;
> +	}
> +	return NULL;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============8517157787774259594==--
