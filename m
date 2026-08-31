Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8B3E51E4;
	Mon, 31 Aug 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177039; cv=none; b=EcM7pY/UriqaqIR/aG9zd3c1qiuIJJW5Ke4tyobZjhCAbv16CCiN7triqZXe/8ez5xGBkf4BVutd69iM3zefN526k2mRZwFJszftWL5KWS5tz+KbguKcGb+vSkENT4uUTaZMRtUp8PfXVumnnFVhsog7f7QomB5mStZPSfox3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177039; c=relaxed/simple;
	bh=cfWBcOASOzKuRqammOALbQZ2Ne8/rzaU7Fz5ETt1BMc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YObAZFNOTZzvPqhDgw/C+ZxoxKlHDcK3bGupaMk7m/tzgJb+XnSjh0xrCfbAx0p0tiPsEPxGHHBWcC/Ym/xuGeYXrzkeb+Atcj9l9af7/gEjbf8osyiE/4hW6WMir1uy/CM2OsWiA8dE0DEALbjghhKFjSnXeRL5VgW488NpoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exXUEbYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exXUEbYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2271F000E9;
	Mon, 31 Aug 2026 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177036;
	bh=/qki8Ak/UpGyTQ0kiXEyNF6XoCNkLdUSr1yKapMlqxs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=exXUEbYMQXVA3wnlJs96Gq0o9ZhiDmGCMXGWSmVe6vBpdqgMxoNvIJtBKpikb7q1P
	 x+82n/19h3EtGt/Mq8qDaJhxnzLNHnt6SLJrhAeF98sHTSRB6N7RUWKRNkdo99HIV/
	 5aDtkmtc4GdANcbNQiLNFrp7ZviNXe+3hXKtiYy1/koN1dLzwBoAutIN4kCXjEPR5a
	 HU0HjMTxvdmHaOocG/sUhJ9Q0mxrHrovsGrxuYJCv5GdlNaH02Lavz4/OgNMTgmuJ8
	 Qgz++OCg/EwQZ32zgg6fnraiaeSypRdtKK+fEyEDiB8DmeR2YXBBuu/pXsMAiDYim4
	 /1Qd3eyOlgsYw==
Content-Type: multipart/mixed; boundary="===============5687862971082144044=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32309c5bdc0ed0566f6c7f8d133b4cbf781236c0d4fa76bdd43d0805224f89eb@mail.kernel.org>
In-Reply-To: <20260831110934.241898-2-a.s.protopopov@gmail.com>
References: <20260831110934.241898-2-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to more hooks
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,john.fastabend@gmail.com,brauner@kernel.org,paul@paul-moore.com,torvalds@linux-foundation.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 11:50:35 +0000 (UTC)

--===============5687862971082144044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 460cb72688450..d01dd1f096fc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5035,6 +5035,7 @@ L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/bpf/prog_lsm.rst
>  F:	include/linux/bpf_lsm.h
> +F:	include/linux/bpf_lsm_hook_defs.h
>  F:	kernel/bpf/bpf_lsm.c
>  F:	kernel/bpf/bpf_lsm_proto.c
>  F:	kernel/trace/bpf_trace.c

[ ... ]

> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index dda272d78f013..1e54c7cca27ad 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -16,9 +16,19 @@
>
>  extern bool bpf_lsm_initialized __ro_after_init;
>
> +/*
> + * Technically, checking bpf_lsm_initialized is not necessary.
> + * But if it is off, then this means that all security_* calls
> + * do not call BPF, and it doesn't look reasonable to enable
> + * only "non-LSM" bpf hooks...
> + */
> +#define bpf_lsm_hook(NAME, ...) \
> +	(bpf_lsm_initialized ? bpf_lsm_##NAME(__VA_ARGS__) : 0)

Does the new bpf_lsm_hook() macro constrain what hook declarations
can appear in bpf_lsm_hook_defs.h? The macro hardcodes 0 as the return
value in two places:

1. When bpf_lsm_initialized is false, the ternary returns 0, but when
   it is true with no program attached, the __weak nop returns the hook's
   declared DEFAULT. This means LSM_HOOK(int, 0, ...) behaves consistently,
   but LSM_HOOK(int, -EOPNOTSUPP, ...) would return different values
   depending on whether 'bpf' appears in lsm= - 0 before initialization,
   -EOPNOTSUPP after.

2. Because of the ternary, LSM_HOOK(void, ...) cannot compile at call
   sites, since the expression `cond ? void_expr : 0` is invalid.

3. The CONFIG_BPF_LSM=n stub at line 128:

   #define bpf_lsm_hook(NAME, ...) 0

   discards its arguments entirely, so call-site argument checking only
   happens on =y builds. Does this create a risk that =n configurations
   would fail to catch type mismatches or side-effect issues?

>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>  	RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_defs.h>
> +#include <linux/bpf_lsm_hook_defs.h>
>  #undef LSM_HOOK

[ ... ]

> diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
> new file mode 100644
> index 0000000000000..29bc0b514d168
> --- /dev/null
> +++ b/include/linux/bpf_lsm_hook_defs.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This is a set of BPF LSM hooks, which are _not_ fully implemented
> + * as LSM hooks. Thus, they only can be used by BPF LSM programs.
> + */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82c5988417a0c..add344ea26914 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -28,11 +28,13 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  }
>
>  #include <linux/lsm_hook_defs.h>
> +#include <linux/bpf_lsm_hook_defs.h>
>  #undef LSM_HOOK
>
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
>  #include <linux/lsm_hook_defs.h>
> +#include <linux/bpf_lsm_hook_defs.h>
>  #undef LSM_HOOK
>  BTF_SET_END(bpf_lsm_hooks)

The patch adds bpf_lsm_hook_defs.h to three of the four BPF-owned
LSM_HOOK expansion sites, but not the fourth. Does this need updating?

Updated:
  include/linux/bpf_lsm.h (prototypes, lines 30-31)
  kernel/bpf/bpf_lsm.c (__weak nop definitions, lines 30-31)
  kernel/bpf/bpf_lsm.c (bpf_lsm_hooks BTF set, lines 36-37)

Not updated:
  kernel/bpf/bpf_lsm.c (void_lsm_hooks BTF set, further down in the file)

The void_lsm_hooks set is consumed by bpf_lsm_hook_returns_errno() in
bpf_lsm.c, which feeds cgroup_lsm_atype[i].returns_errno. If a hook
declared as LSM_HOOK(void, ...) appeared in the new header, wouldn't it
be omitted from void_lsm_hooks and incorrectly reported as errno-returning?

This is latent today because the four hooks added later in the series all
return int, but is there a reason the fourth site shouldn't include the
new header, or should the header document that it only supports int hooks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074
--===============5687862971082144044==--
