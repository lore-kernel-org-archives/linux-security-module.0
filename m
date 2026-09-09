Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828443D891F;
	Wed,  9 Sep 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985809; cv=none; b=fDefFYM5ZjKCFyfw4Q/TG2mvjB9e3WxSd/cDTwwEyb9PacM6oHMRyMtN48/yPjg9ka0nkLNrxo4zWZ0Ox8VEk/c5Zgay8W4ZQArDYZwJmZdBT8ovENOGJXA6zdYbyx6BXJWqLr/r+v6wk8W00s8nWY64gzwae7dZ8f98yXSRrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985809; c=relaxed/simple;
	bh=LUW9blyzptk4HsE9LoNq5R7NnAuWEIQDcieUUqUIpno=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=a1bOclQpPo7AfmGxyVoI4hZEzculH8S9jXMi8Vig9FJ9UJ/b7qopNlCX/ivf+WgziHvUw8/BST3ltSnZZQ+WcyyO045kOUFFt0bX9ygxrWqnlptpay3DlCP4W69I4ryGyQUKYtBsjewfNX4vsdQ/xdcTPA3lK/NpNn0LO2WsJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMgRHHQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMgRHHQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039571F00893;
	Wed,  9 Sep 2026 20:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985799;
	bh=aTWX8ZK3SRUzJbhZ6s4IYzymPNc6ElS2hGL84OX1tow=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cMgRHHQNxWONTT5JPvW3fza/w7/x4aKy2gv/34dFP8qYEGXQrPFVQ8MV68D0MzH/j
	 hFLHJREyIWFBv5HnjMq/0kphL/qcvCJARoldSkfeWBRvqds54L34Awctdu5J7/QDBh
	 f7aYVWv0Mc1o3ds5cOvl5CAtbekhkMu3RzwRzVUBU6kFpwbDw5h7RyyfN0ZanCUa+n
	 bM2t50t3IHhpnIP++CEO2bRdU6A6po7Np8fcIj1H7iiFOJ+RRzccXB/p55572X4ozc
	 m9OCg8xecbMFcmHNN+otsxOc/xRLLPj7Bu0u+GcOG+N/uVMzPXZfHQyhvkgpU/1FWw
	 77kbVLDROxv4A==
Content-Type: multipart/mixed; boundary="===============1320981898347451360=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d529f10c5c661c68be37bf896d36bde678171fa5b23a820d0493abcbda48fc60@mail.kernel.org>
In-Reply-To: <20260909193719.518517-5-utilityemal77@gmail.com>
References: <20260909193719.518517-5-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release kfunc and policy object destructor
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:29:57 +0000 (UTC)

--===============1320981898347451360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> policy objects to BPF programs, with the first of them:
>
>   bpf_lsm_policy_release(object)                KF_RELEASE
>
> The kfuncs are the LSM framework's own BPF interface: there is no
> per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> walks the matching hook's implementation list and calls the one
> registered by the LSM whose lsmid the policy object carries.  Calling
> a kfunc for an LSM that is not active or has no policy object support
> fails at runtime rather than hiding the kfunc at verification time,
> so BPF program loading is independent of the boot-time LSM
> configuration.
>
> A policy object reference is meant to be handed over through a map
> kptr field, so also register a destructor for struct
> lsm_policy_object: map-held references are dropped on map teardown,
> possibly from a context that cannot sleep, which the
> policy_object_put() hook contract accounts for.  For the same reason
> the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> releasing a reference must be allowed wherever one can be held.  The
> filter itself is needed because BPF_PROG_TYPE_LSM and
> BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> kfunc lookup buckets with other program types.

Is the justification for the kfunc filter fully accurate?

Looking at bpf_prog_type_to_kfunc_hook() in kernel/bpf/btf.c, bucket
selection shows:

  case BPF_PROG_TYPE_TRACING:
  case BPF_PROG_TYPE_TRACEPOINT:
  case BPF_PROG_TYPE_RAW_TRACEPOINT:
  case BPF_PROG_TYPE_PERF_EVENT:
  case BPF_PROG_TYPE_LSM:
          return BTF_KFUNC_HOOK_TRACING;
  case BPF_PROG_TYPE_SYSCALL:
          return BTF_KFUNC_HOOK_SYSCALL;

BPF_PROG_TYPE_LSM does share BTF_KFUNC_HOOK_TRACING with TRACING,
TRACEPOINT, RAW_TRACEPOINT and PERF_EVENT program types, so the filter
is required for the register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, ...)
call.

However, BPF_PROG_TYPE_SYSCALL is the sole program type mapping to
BTF_KFUNC_HOOK_SYSCALL. No other program type can reach that bucket, so
the filter's SYSCALL arm simply allows the program type that already
owns the bucket.

The code itself is correct and matches the pattern used by
bpf_ksock_kfunc_filter in net/core/bpf_ksock.c, which registers for the
same two program types.

Should the changelog be narrowed to say the filter is needed for
BPF_PROG_TYPE_LSM specifically, since that's the one sharing its bucket
with other program types?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============1320981898347451360==--
