Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498146A5E2
	for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852503; cv=pass; b=QRUSp9sz42j5ZGDjEqU6NQggqnUBr9q2Ke4L3fQkQWDVgNZdsqI83daHlcZ28zVCKccNVvRIqGNHX5JWPxfqgZlDDz1SYaf7YKS++2Feosk6R1IqYBqyQzmpCEob+BXQqbZH2tkbGq1xCSE5QSYcx4GkTW5lsU0MI66JML3nVKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852503; c=relaxed/simple;
	bh=rHrQjw+x2Rf/S8DrC1bp8MY57mue7A49MndhDYwvcgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qzlt+3uY23hoWFPEJitaqJwxm6UdWtqBe/gS29RIrQ1vW/SCO8fhd3K54BKE21VN5qxIHTiui6YYp+Q9u1AVj8myh8eSmri3a4u7w5RxZCn6+SK6Uhb3niJ2Rr3jz6z6QXwmT5MFYExmyZqHqV/sv6D3myOTVPlow8s22vitaYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq9WPYNd; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq9WPYNd"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cb057311bso2713780fac.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2026 07:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852500; cv=none;
        d=google.com; s=arc-20260327;
        b=i7zjo4kSUxO6sTI6D9AZ/F/14YA+ff4MIwv8ricUdKb5fgHD7lK/IdPx6xYLESvmPy
         qO/wHquKjUVAkyxShM1wBxyJOdwemw7Ow7ycwlZGECcARkL23mWTMd9yzerlG79fuNzG
         t/8SYCbShmQXnjMVhvGgoJanNvTIU45wWzZB7WQSHdPkgQXdMSQbZ+LUq+Pk7Bcn21G2
         +qtcRnLWMJFmm316+nzoVRAd/qNnaz8hioxpRAOFKkuLMr/MM0Ndysl77+2Y+8Y4fngo
         WVX/vTcUHK4CtdPesAsDpmygZvFQqWxwJfNygVw3+T29ZrC3J+eXiJQU1c11vAnA+gKj
         tILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        fh=JdsJOIhfR9iZHMRwUaNyMyJzadDN9SBZwIQSC3Yt4N4=;
        b=GofODUaUYkXcykw6dceLlUiKWU+GpgifMjthJfoSNr+9gvWIP4Uzra+9SubbhAc4Xe
         BQFPYuFaNIXfG1yiqJAUsy22MoyM7qfRAp5paBpYesknie6A+8Us2IJRxTLeq7aABgIN
         n4dSdf8Ge+louZG56N51JYlPCOy1pT9nZ52S3c1ZW0oEy+kIxaJn/PW2mrZaMHcxQY5U
         Y5kLg2LoXGdezJg5P/gD6sKlMocwrFBb2Snq8OdUmDpp8F8b22exKA6Hr4JIJsc6zsB+
         kykjQzXdqP7FiBMaTPmVziND6K7QtPAkfNTLNhWIsVHL8Y4Y3eYCk9ngImMr4HTxYhNz
         ag4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852500; x=1786457300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        b=Wq9WPYNdXoQZFIlLKt4ukvwmOeG26oimNF8NHxlLv1cZnPTkwIn5ysx/qSxJUtCCw+
         qpylGWzwp3jNuh8AlKPWlxNpPmrJIu91B6tGa7HOIGstp3BEAMSAjbMW0ZshygqhdHnS
         LscEgWX9MiMpU5S56aZwJmSlnOAuPXFm6jB4QTc+CPATFgZtrkvoz2fqqt79zkGJYEJl
         WErrQ/HfUO1QkcEiOgo6P1mAyB1e4DsxDMWa2up2fOictgkkm0ki8YYvKH/+e1qzt07O
         Al7aib5YKuD+K+1KooGnfwxwY36Uk7TjGsS0RNn7XFEAIkI/AoMf/Xkr8frnaI/m5283
         X1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852500; x=1786457300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        b=Cdre1PIEujHwyuhfW1U0AHBY4IUG14h+0ypdSA7NIUufUiSntAFi75OSTEKDlH60GQ
         +mnvfgauGo1YMtu6m/P0jITkOxTXMQXzEtmhExcEqv9qxs6/fXvJd62uKZbES3HF13SW
         W80gTs7nD2YxMxNJQmTWC7Ry3g5Dcop94KQbwdy4Kyj23ueDMNKnsXdEuyc8ANRqN7nZ
         DKc23RUReNmyP+5T5JT1VxmEW2BOOoCtRu9E7HBvqb1FT8Pd1lx5LLcc1j8zs1Y78tfK
         09FZeU9pKCkC2Y2kAwzXqzTV91Fzhm82k/GAfEYJiRuQfP0jKmXd0g9NLzPkZnRP7lbO
         GS1w==
X-Forwarded-Encrypted: i=1; AHgh+RqtWkaP+BLn3enq1PrqXmwe3IrHSBFBknJiweRQD0XdjB8GYnjYKvLeNHjwfCAN6WTgVp6m1Qx6hZ7m33XkOz5zLBgbOM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyao9u5NTbdnrXRSFaGutqLBaQeTBXYNgogCeND7ysAtrL15+Du
	motpZQqoWhp0Qx8e0gXs58FsqBP6ryBE/QguY9VfqKvSYKo70rcP8xCkYxfJtkEjsBQ7imUAUF7
	WCFn8lq7/JefO5euMMWY9NScZ7Xrfpwo=
X-Gm-Gg: AR+sD12EXK5ycbuvj08RU9j/mGMMeEpT1tFz9fXZ/ZTml74VqK3REhyLR26RVYcF0Su
	E5j2O85e9M7qSFph21kfsTDI+7GDeEQvoRps7LLeWze93fKAkj5DfrNMATUhY770wJoyZZFaKqu
	vL/78DZrnkBzjk7dOR0KrzSOriUEZMeO4uKcUDGroLla4eD2xa1Zy44YV1WCGX4oD8tbfzBw8dP
	+0XuLMdFgkxyac9rZGfu3cnf3mQ2z6HUk5g1SvDbWr8Bt29RX5cXFrH+r6Q/9QZw4rzuEm4o8k+
	hdHJFgXlmQw3Fetw5uLvx9IzLSjVrd5rpR3x/rJJHADm
X-Received: by 2002:a05:6820:338e:10b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6ae4317ba0emr15478298eaf.6.1785852499973; Tue, 04 Aug 2026
 07:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
In-Reply-To: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 10:08:08 -0400
X-Gm-Features: AUfX_mw3HU1op1eOeUEisujY4Qy8U6HBZBPlyvmGjA5z9EhXfEhUAxovCMnHzQE
Message-ID: <CAEjxPJ6mxnTnvvVYZRxe1OYArbCWeaO1VeC6qxu02F+rEKLckw@mail.gmail.com>
Subject: Re: Subject: [REGRESSION] selinux: ~90% throughput drop in System V
 IPC (msg) since commit 7edea6e8c8e8
To: Jiri Vozar <jvozar@redhat.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 8:17=E2=80=AFPM Jiri Vozar <jvozar@redhat.com> wrote=
:
>
> Hi,
>
> Commit 7edea6e8c8e8 ("selinux: beef up isvalid checks") introduces a new
> loop in mls_level_isvalid() that causes ~89-94% throughput regression in
> System V IPC message queue operations (msgsnd/msgrcv).
>
> The regression affects all architectures (x86_64, aarch64, ppc64le) and
> is independent of SELinux enforcement mode (enforcing vs permissive).
>
> Upstream commit:
> https://github.com/torvalds/linux/commit/7edea6e8c8e8944e060da6b0b81d66db=
8d5fffcc
> Merge commit:    https://github.com/torvalds/linux/commit/231e9d447ea9
> (selinux-pr-20260615)
> First affected:  v7.2-rc1
>
> ## Regression data
>
> Measured with stress-ng msg stressor across multiple machines and
> architectures. The percentage is throughput change vs a v6.12 baseline:
>
>   NUMA config | Max drop | Avg drop | Hosts affected
>   ------------|----------|----------|-------------------
>   1 NUMA      |  -94%    |  -91.5%  | aarch64 5/5, ppc64le 3/3, x86_64 6/=
21
>   2 NUMA      |  -94%    |  -92%    | x86_64 5 hosts
>   4 NUMA      |  -94%    |  -90%    | x86_64 4 hosts
>   8 NUMA      |  -89%    |  -89%    | x86_64 1 host
>
> Architecture-independent =E2=80=94 confirms the regression is in the kern=
el code
> path, not hardware-specific.
>
> ## Root cause
>
> The new loop in security/selinux/ss/mls.c mls_level_isvalid():
>
>     ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
>         if (!sym_name(p, SYM_CATS, bit))
>             return false;
>     }
>
> iterates over every set bit in the category bitmap (~1024 bits in
> standard MCS policy with c0.c1023 range). Each iteration calls
> _find_next_bit() + sym_name() (array dereference into
> p->sym_val_to_name[SYM_CATS]).
>
> The function is called on every IPC operation via:
>
>     msgsnd() -> security_msg_msg_alloc() -> selinux_msg_msg_alloc_securit=
y()
>       -> security_context_to_sid_core() -> mls_context_isvalid()
>         -> mls_range_isvalid() -> mls_level_isvalid() (x2 per range)
>
> This adds ~2048 iterations of bitmap scanning + array lookups per IPC
> operation. SELinux permissive mode does not help (~0.6% difference)
> because the overhead is in the validation path, not the enforcement
> decision.
>
> ## Perf profile evidence
>
> Single-threaded stress-ng --msg 1 -t 60 on x86_64:
>   - Baseline (v6.12): ~67,000 msg ops/sec
>   - Regressed (v7.2-rc4): ~7,400 msg ops/sec (-89%)
>
> perf top on the regressed kernel shows _find_next_bit and sym_name
> dominating kernel CPU time during the msg workload.
>
> ## How to reproduce
>
> On any machine with kernel >=3D v7.2 and SELinux enabled:
>
>     # Install stress-ng
>     dnf install -y stress-ng
>
>     # Run the msg stressor
>     stress-ng --msg 1 -t 60 --metrics-brief
>
>     # Compare with SELinux disabled (requires reboot with selinux=3D0):
>     stress-ng --msg 1 -t 60 --metrics-brief
>
> Expected: ~67,000 bogo-ops/sec (as on v6.12)
> Actual:   ~7,400 bogo-ops/sec (on v7.2) =E2=80=94 approximately 89% drop
>
> The regression affects any workload that uses System V IPC message queues
> at high frequency. Other IPC stressors (sem, shm) may also be affected
> to a lesser degree.
>
> ## Suggested fix
>
> The ebitmap_for_each_positive_bit loop validates that every category bit
> has a corresponding name in the policy symbol table. This is a property
> of the policy itself and does not change at runtime. The validation
> should be moved to policy load time in
> security/selinux/ss/policydb_validate.c (e.g. in validate_level()) and
> removed from the hot path in mls_level_isvalid().

Thanks for the report, should be fixed by:
https://lore.kernel.org/selinux/20260804135700.3713-1-stephen.smalley.work@=
gmail.com/
