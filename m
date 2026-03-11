Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316736495B;
	Wed, 11 Mar 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266899; cv=none; b=PVSte4hFntb8d/5zClivXoFP+mOZv5kawyGcZZ4ZKUNlDIWnZSk2pDGnUvwIhWDl00Be6KpGQMmmrMwqdVIcM1kP+ZRxHRmoxgRAqKMKxYRQAVLObzCBQn+44qOpVxAlugJhfmVnV12KZB1aXvrwEzHaal3vAD4goQpFs+P5Uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266899; c=relaxed/simple;
	bh=7MinZtbTOnSEroZFGxvPjQMjUpkX71RK8irsfC1OcsI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nw+DmXJ7gCW6C+169F96YsG5NmZif+RrgGp1rCCdLG+hQDerOx4bcN1acAHpyy3tifPtcuYvki90LQb1oCf3i9IesOz9nK5/Zxndb5hpXtKSLqbVRaAt4iU/eu+aEQNjja4lU5aNHcn7PUcaNT7faUHbl5UxeXCwTMO/IUx02wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRUEpgI3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRUEpgI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1114C4CEF7;
	Wed, 11 Mar 2026 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266899;
	bh=7MinZtbTOnSEroZFGxvPjQMjUpkX71RK8irsfC1OcsI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XRUEpgI3OPcXoBcHD4j6uu0bANlDWCD4rOaew4yJNklK3JIWA0ntp55NyT8d9Zyko
	 yq6ZLHPJoaiuN3bNX/k5gNVLg5Q1sjBkHwNxQyJEWMBEkMQLtuGszRGojliqYzMs/O
	 0/CCOMIrAbcbr3TOHULNSohzITJU7DLawUHYHmyLLKtqJt7nHR0hdQRz+ljjSr5ci7
	 4JUjWtW4Mzo3cHqkL6miz/2XWI+6VeU+i77vjeeg3n7OgmT6Ia0Yv6jwbA7Jh5RvnX
	 vFmJ20DOph3ga1VSbt3iZb2lHqUn/QsX5XZq8txdJAunfJ7iRpW9mQqQSgjTA8Wx68
	 IiMueA4lBaIQw==
Content-Type: multipart/mixed; boundary="===============6615031658577929282=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69cbf119c9c3fb5ebcfca4a19d3cfa8ef6acb2bc1e9b0c9b20cce726266b303c@mail.kernel.org>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 1/4] audit: Implement bpf_audit_log_*() wrappers
From: bot+bpf-ci@kernel.org
To: fred@cloudflare.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,eparis@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,mic@digikod.net,gnoack@google.com
Cc: linux-kernel@vger.kernel.org,linux-security-module@vger.kernel.org,audit@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-team@cloudflare.com,fred@cloudflare.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 22:08:18 +0000 (UTC)

--===============6615031658577929282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/lsm_audit_kfuncs.c b/security/lsm_audit_kfuncs.c
> --- /dev/null
> +++ b/security/lsm_audit_kfuncs.c

[ ... ]

> +__bpf_kfunc
> +struct bpf_audit_context *bpf_audit_log_start(struct bpf_prog_aux *aux)
> +{
> +	char comm[sizeof(current->comm)];
> +	struct bpf_audit_context *ac;
> +
> +	ac = bpf_mem_cache_alloc(&bpf_audit_context_ma);
> +	if (!ac)
> +		return NULL;
> +
> +	memset(ac, 0, sizeof(*ac));
> +	ac->ab = audit_log_start(audit_context(),
> +				 (aux->might_sleep) ? GFP_KERNEL : GFP_ATOMIC,
> +				 AUDIT_BPF_LSM_ACCESS);
> +	if (!ac->ab) {
> +		bpf_mem_cache_free(&bpf_audit_context_ma, ac);
> +		return NULL;
> +	}
> +
> +	audit_log_format(ac->ab, "prog-id=%d", aux->id);

aux->id is u32 -- should this be %u?

> +
> +	/* Audit may not have a filter configured for syscalls. Include
> +	 * potentionally redundant pid & comm information

Minor typo: "potentionally" -> "potentially".

> +	 */

[ ... ]

> +__bpf_kfunc int bpf_audit_log_net_sock(struct bpf_audit_context *ac, int netif,
> +				       const struct socket *sock)
> +{
> +	struct lsm_network_audit net = { .sk = sock->sk, .netif = netif };
> +	struct common_audit_data ad;
> +
> +	ad.type = LSM_AUDIT_DATA_NET;
> +	ad.u.net = &net;
> +	return __audit_log_lsm_data(ac, &ad);
> +}
> +
> +__bpf_kfunc int
> +bpf_audit_log_net_sockaddr(struct bpf_audit_context *ac, int netif,
> +			   const struct sockaddr *saddr__nullable,
> +			   const struct sockaddr *daddr__nullable, int addrlen)
> +{
> +	struct lsm_network_audit net;
                                    ^^^

Unlike bpf_audit_log_net_sock() above which uses a designated
initializer that zero-fills the struct, this declaration leaves
net uninitialized.

In particular, net.sk is never assigned anywhere in this function.
When audit_log_lsm_data() handles LSM_AUDIT_DATA_NET, it does:

    if (a->u.net->sk) {
        const struct sock *sk = a->u.net->sk;
        switch (sk->sk_family) {

Since net.sk contains stack garbage, this will likely dereference
an invalid pointer and crash.

Additionally, when only one of saddr__nullable or daddr__nullable
is provided, the corresponding sport/dport and address fields for
the missing side remain uninitialized, and audit_log_lsm_data()
unconditionally prints both sides:

    print_ipv4_addr(ab, a->u.net->v4info.saddr, a->u.net->sport, ...);
    print_ipv4_addr(ab, a->u.net->v4info.daddr, a->u.net->dport, ...);

Would initializing with something like
struct lsm_network_audit net = { .netif = netif }; address both
issues?

> +	struct common_audit_data ad;
> +
> +	net.netif = netif;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22976062351
--===============6615031658577929282==--
