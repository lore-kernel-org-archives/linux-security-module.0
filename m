Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E6223339
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715455; cv=pass; b=rTHW+JcxJJ4iYB/0He60T43gwhAUSfC5MMXDS1GO1Ore9fFRRby9jY9CQUpN1ipfRR3mxW218/wKW67/dWd67erFxjhOy9ko9CnTeB4C3Rptb1f7r0aXyjOFumVmwE7Dr4bt+MMxVY8bkr74yy9kESwW936VGKKio+moVdzq8CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715455; c=relaxed/simple;
	bh=sKwd1vQmDHai1b7yhMZ04Vlhn18rbe5n5SdllC6ho5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOhmojLHxhyxVw0f9uiwaP3M+bwCN7FM1BD4YZMnaZsmkNO7l6foxb0tiOdiXmEKxbnWIpCXRoW4z96mwlKxkewhADgE1oPvrARz1OY2QPi9iKS75L1TIonZo0DLcmXcTXtZr6WQampW6r2fs3RzGh70RB29bAVpDoPZvzO88us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME3/0nTD; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME3/0nTD"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so5153769f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 19:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773715452; cv=none;
        d=google.com; s=arc-20240605;
        b=QTiKfK4vE4T+I99kYBB0EJf2Ttqp86RKZ26HJDStoPZEsVmVeRWstOI/E3qSzNYYK+
         zd9v2CIOh9GGII7UVN+k5/1vSlVvzEFrPzs3QQo+nCfYx16J8+Z1VMXUJFAjhelIXAKg
         6Lra7HrgqUCz1oNaFkUxQ3Ebby85x+3DVUEGobcUDd47tochqwyTRFgEj4kXwbr7vBHf
         06Pjs5VRgr+1d3LUC4+gzm38dMsDykkZnz5xe6VHL4/OjGkc3tQO2yInJWgy7njOiweE
         46uE8OgiPO5415d1ObEjLZbLSMTdDfZHi5pEz47WHphHZeVZFe+pVSrcc9N2n4cb59QA
         A6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+KG1TUIaaSVcjY5CkalZriMJmA+CKJA0WRQluiX7M9s=;
        fh=Qpt2g1pMyuqEdpdrlHmU7ZqTdabOiFmc9iIxQXDabdM=;
        b=jYI6VlOW+pj5aFZ1QQfID93F9f0G3vquPiDDTJncywmMkUleMfNM1oDGL5WftP6gS8
         lCBBlyUN+3NvMhdOOLxxV5i8hopuUt6IEvrz1LHyMpjZT80wLOPeWTWaAAXRU1NgZoVj
         laTsFRkM/Fh3dR++7cWN775QGTkqqTNBCv3XGiUAK/2jjhM9Ue8wVn05ngyWpKmAef0i
         M02xAmQS+zlRKICu9ehqWlo2NmW1KytYjfpCNc06ZBcmC1DMwXx/l+v/TKjBCpXnKeh+
         LZNr7/7dIvj67SNDwL22ZVOGIKZBlsebc/8oDF1Qfp7OuvpdSnQFJeyNvPz8qVuGeder
         QmvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773715452; x=1774320252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+KG1TUIaaSVcjY5CkalZriMJmA+CKJA0WRQluiX7M9s=;
        b=ME3/0nTDwrDUBMRhLFVuBRZqUtLoU4vo2culv+RcRWRo3CQEGiM/ev2Ms5xsksMOWJ
         JbRxqvIN2vEz5Yc6l8LhYmsYY0WC40CTYTwTVO3uJFoyLqx9JGsFTJ0ltfT+lYKw33OB
         QdQD71BVRhXogTyjc3rZ/pmbF9UZKU22YBArYKBbCMfGkE7Vm8ykHAcmTep9EbHGSg8U
         j7tOtRx6YEDsgLHP5qEIo5C0hl4t1BOsKWWm0bjsw6JOBEX4PhA2Xk6TMy1ZN3u1TxWl
         npo2vzowezghu96tvddggw/K/XPvvjkyOaG2pWXKfuyB2cffsFoMM6wo6NpD7kz0YaGL
         6+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773715452; x=1774320252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KG1TUIaaSVcjY5CkalZriMJmA+CKJA0WRQluiX7M9s=;
        b=Aj3Lsi6DLcMIRI8HHg/9Yf5CKOBg4oHpqflrjIEE8G3FbwwKS/MbNqdt6W/eydY25U
         DXzY6YmbPAAlQBzhq/PgAIl4J0+b6Mjy5+l/mtmfAjPLuKtP9ndZLl/1QRhrEKL7vILP
         xYTNCajxAuiYdxl2mHc8s8uOR/Mt0q56ZZeWy+wiXgzby6uZV2SxMvF0QPOz+VzoHPDI
         p509ZtXao6j12H2pxlUefWkHZMHHW7j3X0d5BT3CTxfCVQvAdqIgf8ZmCQe31IM1+XVb
         DY+qUhlXTsaNXuh3ltYTqu40tmnzQuzUgK0T2QV7yHqhjJhlzTUTKAlgKK9Hbaknqkt6
         O65w==
X-Forwarded-Encrypted: i=1; AJvYcCXPWdWbr60RCiLfRKfbzgcTd0kFpXfVPpowzWOJ5yu2O7PTSqBFEaosPMS4cMRQp+kRA7g+8i4IPdvsSZNKPQNSVt2+MkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdJM6dqaQYo17hou9iHmqH5kmLg044YIbzSgK4y6DxtVef/BA
	94WYtAU+WmDG03CqDV7ZWRLJy4UNUHOtS1LwwyY+r4fMm5NuTsVtsNmL7D0gSPvoVLBNZYUdsEA
	Qu8UCh8BHhqbIdZufp4FcBXGaKr6+wUI=
X-Gm-Gg: ATEYQzxGRO4TCJkeBf56VcDHJniN7oNgkw/Hh7avhfNUt8xPrlnqQOjl/oW+PKgrA3k
	+r+8Tga0SRfy3D7RmU/tzudd6DeQo22jpqR0AhkYyJl83aNbZxDsKzT/1GrWrr9sF+TmtBDeCk9
	AXS2tPPxxeHokkJq3IuF7AT3ojqn+TQrZrUzCwaiQeXpzm2K5CvGx1sUUhNt4bYDNGZkCYVfbO0
	0uPAe25b7AJTSIlno/5e0X/DX/pE7W/lcIPfiPy5awviGisuFGxAd2D2ewnh7XMqkkORAVf4LPQ
	Q2CzSKwUGTSCqfjqnLm3MuX0Qy6Er3XT4A2ES6ANQXIJdDCh2sOVuFtp39Q=
X-Received: by 2002:a5d:5f46:0:b0:43b:3eef:acdc with SMTP id
 ffacd0b85a97d-43b3eefad8dmr14199623f8f.31.1773715452298; Mon, 16 Mar 2026
 19:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 03:43:36 +0100
X-Gm-Features: AaiRm503_pD4wgV7GNSzVXYmQwYnJwIKieOHwAp2XOE6TWNB4pmOA9FL8mUmiUQ
Message-ID: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
>
> The motivation behind the change is to give BPF LSM developers the
> ability to report accesses via the audit subsystem much like how LSMs
> operate today.
>
> Series:
>
> Patch 1: Introduces bpf_audit_*() kfuncs
> Patch 2: Enables bpf_audit_*() kfuns
> Patch 3: Prepares audit helpers used for testing
> Patch 4: Adds self tests
>
> Documentation will be added when this becomes a versioned series.
>
> Key features:
>
> 1. Audit logs include type=AUDIT_BPF_LSM_ACCESS, BPF program ID, and comm
> that triggered the hook by default
>
> We wanted audit log consumers to be able to track who and what created
> the entry. prog-id=%d is already used for BPF LOAD/UNLOAD logs, thus
> is reused here for this distinction. Though, it may be better to use
> the tag instead to capture which _specific_ version of the program
> made the log, since prog-id can be reused.

I think just id is fine. Whoever is watching the prog can also watch
for LOAD/UNLOAD events and detect any recycling.

>
> 2. Leverages BPF KF_AQUIRE/KF_RELEASE semantics to force use of
>   bpf_audit_log_end().
>
> One side effect of this decision is that the BPF documentation states
> that these flags allow the pointer to struct bpf_audit_context to be
> stored in a map, and then exchanged through bpf_kptr_xchg(). However,

Yes, it is only allowed if you give a dtor. No dtor, then no kptr_xchg.

> there's prior work with net/netfilter/nf_conntrack_bpf.c such that the
> struct is not exposed as a kptr to support that functionality nor is
> that supplying a dtor function. The verifier will not allow this use case
> due to not exposing the __kptr. Ideally, we don't want the pointer to
> be exchanged anyway because the reporting program can become ambiguous.
> I am sure there are other edge cases WRT to keeping the audit buffer in a
> strange state too that I cannot think of at this moment.
>
> 3. All bpf_audit_log_*() functions are destructive
>
> The audit subsystem allows for AUDIT_FAIL_PANIC to be set when the
> subsystem can detect that missing events. Further, some call paths may
> invoke a BUG_ON(). Therefore all the functions are marked destructive.

I think the first part makes sense (i.e., the policy simply configured
the system to panic on failure).
However, in the second case, if the program is somehow able to trigger
BUG_ON() relied upon for internal invariants, it would be considered
broken.
I tried grepping through and didn't find anything that would cause
this, hence the whole thing about BUG_ON() in the cover letter only
adds to confusion.
Please drop it or describe cases which you were concerned about.

>
> 4. Functions are callable once per bpf_audit_context
>
> The rationale for this was to prevent abuse. Logs with repeated fields
> are not helpful, and may not be handled by user space audit coherently.
>

This rationale feels weak. What abuse are we talking about?
The LSM program is already written by a trusted entity.

> This is in the same vein as not providing a audit_format() wrapper.
>

I think the format() helper would allow for more flexibility.
I would like to hear what others think, but IMO we may not even want
to hardcode any fields by default and let the program decide what to
report.
prog-id, pid, comm, everything can be logged by the program itself, in
whatever order.

> Similarly, some functions such as bpf_audit_log_path() and
> bpf_audit_log_file() report the same information, thus can be
> interchangeable in use.
>
> 5. API wraps security/lsm_audit.c
>
> lsm_audit.c functions are multiplexed and not handled by BPF verifier
> very well, thus the wrapped functions are isolated to their sole
> purpose for use within hooks.

This part makes sense. I don't think we can (or should) support the
same multiplexing.

>
> Key considerations:
>
> 1. Audit field ordering
>
> AFAIK, user space audit is particular about what fields are
> present and their order. This patch series does not address ordering.
>
> My assumption is that the first three fields: type, prog-id, pid, comm
> are well known, and user space can make an assumption that other
> fields after those can appear in any order.
>
> If that is not acceptable, I would propose that we leverage the struct
> common_audit_data type order to be the order--much like how the type is
> used for log_once() functionality.
>
> I am open to other ideas.
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> Frederick Lawler (4):
>       audit: Implement bpf_audit_log_*() wrappers
>       audit/security: Enable audit BPF kfuncs
>       selftests/bpf: Add audit helpers for BPF tests
>       selftests/bpf: Add lsm_audit_kfuncs tests
>
>  include/linux/lsm_audit.h                          |   1 +
>  include/uapi/linux/audit.h                         |   1 +
>  security/Makefile                                  |   2 +
>  security/lsm_audit_kfuncs.c                        | 306 +++++++++++
>  tools/testing/selftests/bpf/Makefile               |   3 +-
>  tools/testing/selftests/bpf/audit_helpers.c        | 281 ++++++++++
>  tools/testing/selftests/bpf/audit_helpers.h        |  55 ++
>  .../selftests/bpf/prog_tests/lsm_audit_kfuncs.c    | 598 +++++++++++++++++++++
>  .../selftests/bpf/progs/test_lsm_audit_kfuncs.c    | 263 +++++++++
>  9 files changed, 1509 insertions(+), 1 deletion(-)
> ---
> base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
> change-id: 20260105-bpf-auditd-send-message-4a883067aab8
>
> Best regards,
> --
> Frederick Lawler <fred@cloudflare.com>
>
>
