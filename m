Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B12C08AC
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779577551; cv=none; b=VWs6AJGbxD9QZDn54aTXD2MBCc0AsnHP2vLnSuZXMyRhLIYgUGJxiNhtnyU7fjqv7ziuqoKqgUZTT0HGizq4/ZvTB5Jv/9wM9+CpfnhyI2laal5KkLfi0hmZmVYuaABt7chOXj4EMXP4Ei/NaTVA5MV7eupEujHwoNsBd2KVuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779577551; c=relaxed/simple;
	bh=tqE8ukYlgE5uSxi/mnaEIrdPmiJJDsUwIIlHtDjFeFE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tUAqj48cIsMM7qWWeeRok81AFhXFSZ9BWkM6CkJFGVl/m8DyQuMnSokW3oQ0E9nMU1qyokfizLe3mUzEWecyLzlLx14toYmcrfBYYNF3AGnCW/QqASE/oxMDI+NJM0jF643F1+GcAcBk6EBfgy864tALwGdeV88J3aQwuGnHoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ih88Zft2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ih88Zft2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so115161306d6.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779577548; x=1780182348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7lGslmrZFIO/3JxtZpEJwJWyJoRNBrRJ8JaCYMEwYI=;
        b=Ih88Zft2J/zzmGjb407lWrgfbldLeklfUPgP2Adl59l3pGjaNWA7dUL8UHb1O1n0GY
         yV59pkPMRkF6PVepZ3ljf+kAGGzjm7PdjRFBMd80zmwh1uQBqLCSvonu/2r7d0PzPsHo
         HKtU8VdFzHPKUBYTO1emkRNb/YWjy/lVxMsbVSDV9neUZOgE9F46ABHOtJ4t1Jlrr3dV
         QBkZx3vPLBhcjcMKAMuNq9EKT7y2uQFb/ffQhEP28uJZAUr/SH3InHRfhNLHuFUSnY3j
         ADv14DosDYSQPhI4O/Du635Xxpy4FomkR/E3g9kIWZuw70HNiwyjqP/GrcytDEtotZ2U
         8OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779577548; x=1780182348;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7lGslmrZFIO/3JxtZpEJwJWyJoRNBrRJ8JaCYMEwYI=;
        b=ROmE9J9xw2JDjJ/XhcZHW89LGDhYDhhGgTQKr+nw2RyyWUjdKIQkk2bHx8C+MHWQA0
         2ARgmgqVGRblqylhHprFsCoKSGSYiU2N8zbquIK85nH1NAEICo0Oe5Lbb+6MxAQH4RWf
         olUI7M1iHxO8cG976B9KDQLTLINR3cGYVgMwF9x/jOSAdQeyakWMH7lQJcy8YhkITrRC
         zsqQ+urbD/6wFmNvJ1u2BiP4HX0hj+u7Kw296HkmjHhC/NbDy3nqcs+j4r4uMLI/5tll
         J56dDgNEju7Hll0n4le/2asi2BgkkGnP/q2hW3plqkdljYy+Qx5pvKBPHTkmOJvxuJDv
         MjTQ==
X-Gm-Message-State: AOJu0Ywt138IrLXHv+5CNPbQrP0v1grQjBxGGZPcv05GFnDwizriIEXf
	qItbogpMu5ZOHnWmCXKQstkCLYEp/WlPNgLscdJrovEGBtgSeZTJANh3zNW710r2YZMpAwpAhCP
	eqMY=
X-Gm-Gg: Acq92OEDDAFmR4nBkjwLxW4Zbg3fhmhEt1UdCHj8naAoci647C2IAWP9V5JNU1TSpiU
	wcyk3qB6V52VlyxhTssacMI+TJfSBKGCOs8+39i9oe8cwqJCUozlzKisRM5Y1BJmevr1zeyuCom
	NJXomwNzAaC3qY6GDwaskK7R+sCBBN5Rvt0aJk0rsnt+YR+vNxu2LdfHwEkhm2Zf8WpztALXCBI
	3QY/wF8AfguUHgUxJeSC0tGD6N90gPE6V48voJsNfuAsZ942hzbD4XxPd49SWD3rbz07aJmgYY2
	F12SUkdvrxyQcuCxH6tqTIwHVxpGRK/kGox8uaKilDOVT5bfY/d9uwWAxa4u5ZbiI7vQRtuhT8W
	G6hyRgG5oes3OzhAFyRmrtu4QqYxS23VtV/bJJ0XNyg+ss7BnzBgyuQED7GNxMT0vfVA/+ctp+X
	zzfXw/K4GYjaBMkmBQtkTxCScoairhFLsoAsA=
X-Received: by 2002:a05:6214:468a:b0:8ca:10c9:845d with SMTP id 6a1803df08f44-8cc7b5b5382mr151231946d6.31.1779577548192;
        Sat, 23 May 2026 16:05:48 -0700 (PDT)
Received: from [10.76.87.206] ([166.196.113.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm67508176d6.24.2026.05.23.16.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 16:05:47 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: <linux-security-module@vger.kernel.org>
CC: <wufan@kernel.org>, <bboscaccy@linux.microsoft.com>
Date: Sat, 23 May 2026 18:05:46 -0500
Message-ID: <19e57166510.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20260523200859.13527-2-paul@paul-moore.com>
References: <20260523200859.13527-2-paul@paul-moore.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [RFC PATCH] ipe: support multiple BPF integrity verification LSMs
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On May 23, 2026 3:09:05 PM Paul Moore <paul@paul-moore.com> wrote:
> Currently IPE always records the last BPF integrity verification verdict,
> which is reasonable with only a single BPF verification LSM, but it
> becomes problematic when multiple mechanisms end up submitting BPF
> program integrity verdicts.
>
> This patch updates IPE to record all of the received BPF program
> integrity verdicts, along with their associated LSM IDs, ultimately using
> the "worst" verdict in the policy enforcement engine.  Policy support for
> selecting individual integrity verdicts was intentionally omitted from
> this patch to keep things simple both from a code and policy developer
> perspective, however future work to add selector support should be
> trivial.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
> include/linux/security.h | 14 +++++++-------
> security/ipe/eval.h      |  7 ++++++-
> security/ipe/hooks.c     | 20 +++++++++++++++++---
> 3 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 598cd2eb1dcd..6a987a0347a0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -103,13 +103,13 @@ enum lsm_integrity_type {
>
> enum lsm_integrity_verdict {
>  LSM_INT_VERDICT_NONE = 0,
> - LSM_INT_VERDICT_OK,
> - LSM_INT_VERDICT_UNSIGNED,
> - LSM_INT_VERDICT_PARTIALSIG,
> - LSM_INT_VERDICT_UNKNOWNKEY,
> - LSM_INT_VERDICT_UNEXPECTED,
> - LSM_INT_VERDICT_FAULT,
> - LSM_INT_VERDICT_BADSIG,
> + LSM_INT_VERDICT_OK = 1,
> + LSM_INT_VERDICT_UNSIGNED = 2,
> + LSM_INT_VERDICT_PARTIALSIG = 3,
> + LSM_INT_VERDICT_UNKNOWNKEY = 4,
> + LSM_INT_VERDICT_UNEXPECTED = 5,
> + LSM_INT_VERDICT_FAULT = 6,
> + LSM_INT_VERDICT_BADSIG = 7,
> };
>
> /*
> diff --git a/security/ipe/eval.h b/security/ipe/eval.h
> index b061cb5ade27..90c7b66b9ca8 100644
> --- a/security/ipe/eval.h
> +++ b/security/ipe/eval.h
> @@ -8,6 +8,7 @@
>
> #include <linux/file.h>
> #include <linux/types.h>
> +#include <linux/lsm_count.h>
>
> #include "policy.h"
> #include "hooks.h"
> @@ -39,7 +40,11 @@ struct ipe_inode {
>
> #ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> struct ipe_bpf_prog {
> - enum lsm_integrity_verdict verdict;
> + struct {
> + const struct lsm_id *lsmid;
> + enum lsm_integrity_verdict verdict;
> + } verdicts[MAX_LSM_COUNT];
> + unsigned int count;
> };
> #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>
> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index 9271e129a2cf..143bb2ae2b12 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -9,6 +9,7 @@
> #include <linux/binfmts.h>
> #include <linux/mman.h>
> #include <linux/blk_types.h>
> +#include <linux/lsm_count.h>
>
> #include "ipe.h"
> #include "hooks.h"
> @@ -355,7 +356,8 @@ int ipe_inode_setintegrity(const struct inode *inode,
>  * so that ipe_bpf_prog_load() can later read it for policy evaluation.
>  *
>  * Return:
> - * * %0 - Always succeeds (policy is evaluated in bpf_prog_load)
> + * * %0 - Recorded the verdict (policy is evaluated in bpf_prog_load)
> + * * %-ENOMEM - Exhausted room for recording verdicts
>  */
> int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
>      union bpf_attr *attr,
> @@ -365,8 +367,14 @@ int ipe_bpf_prog_load_post_integrity(struct bpf_prog 
> *prog,
>      enum lsm_integrity_verdict verdict)
> {
>  struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
> + unsigned int count = blob->count;
>
> - blob->verdict = verdict;
> + if (count == MAX_LSM_COUNT)
> + return -ENOMEM;
> +
> + blob->verdicts[count].lsmid = lsmid;
> + blob->verdicts[count].verdict = verdict;
> + blob->count++;
>
>  return 0;
> }
> @@ -391,12 +399,18 @@ int ipe_bpf_prog_load(struct bpf_prog *prog,
>       struct bpf_token *token,
>       bool kernel)
> {
> + unsigned int iter;
>  struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
>  struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
>
>  ctx.op = IPE_OP_BPF_PROG_LOAD;
>  ctx.hook = IPE_HOOK_BPF_PROG_LOAD;
> - ctx.bpf_verdict = blob->verdict;
> + ctx.bpf_verdict = LSM_INT_VERDICT_NONE;
> + for (iter = 0; iter < blob->count; iter++) {
> + /* pick the "wosrt" verdict */

That should obviously be "worst" :)

> + if (blob->verdicts[iter].verdict > ctx.bpf_verdict)
> + ctx.bpf_verdict = blob->verdicts[iter].verdict;
> + }
>  ctx.bpf_keyring_id = attr->keyring_id;
>  ctx.bpf_kernel = kernel;
>
> --
> 2.54.0

--
paul-moore.com



