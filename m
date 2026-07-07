Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A543F4B9
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460453; cv=pass; b=fT96bMi8f76Zx/nMWb/Eg+LS1IkO9mDjHnJ0g6/aVNrdldMuA4wmN99BEdokUWx2lhRByYI5zkwhyexlnA6ihiBnGX9Q6OuMCZbjfaMmVtelIYOyMd9xfCEp8EsSKorr0/ssmDPrLq9gDaME9g0wQcfka6q7NfSMBj3fLpZBElA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460453; c=relaxed/simple;
	bh=7s0j3gs1q8B0kvELXLVyzmwUipBlWc1iwp8X7x5EAP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDDoHmGQRaUQ+f5dH3qavJgyXwR58d6HlcLY6fmPaY8yBgo+2hcLWN4z9VikHhW4VuEhCJA5Qw41J+3AOPgk51qCt1fISvB0nec61Ibu/1wABxNgyCJx4WSaixdpvxbkIdk769ButS6CVdCobyPoawT8ImT74TRnSYPYgnzZ9eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bj1ouXvi; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bj1ouXvi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-470174001a0so19971f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 14:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783460450; cv=none;
        d=google.com; s=arc-20260327;
        b=HaAljlKeujGjM+eUxqtRxlTzWJcZvh1x0pXimVL9CW3pWM9pG7NN4kXaf6XjcffPnX
         swjlDRjHVnEJceTZRkrp4a2kf/r/u8yemoLZD3sS3+Y7K85hvIBM7inLQHc/JLxV39Xy
         k6nwO9EUe9+oymsv+oZdv71ugGDj/r2a3LckWvOqkDH6UbWliAlxbIe6P8QDCkYxdMEC
         hmJJGY43TlapcqaCo75j/1Bth32AYYayIGbucXTyM9yuARMdsyhaGtGwEOiJqYt+eLli
         Ud31ByTkGCgqxi+xdEP8wH9TdazF8Neg7Ibr1+OG8Epko+VgH98Y40LH67mTVSkmWPoE
         Dy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+Ok+D3VRtxGi9vtZTj6D7dsuUylLhpT+aE8x8yKCk0=;
        fh=Kj6ObZ7pGIZbZeSU0l9WO9hUHIWe1ZseR0NKqknS4rg=;
        b=V22DAcOeT6/NsnC0IlCHvxXjvo8s9r3Sm7WQytNSK6GF9p4p8ZFJee3LbwL9ZyR/FU
         O7R7qw/lHkV3MNxFEzR1o5v7HfddDxGO05tRdcQ+4JNTipotAq72YgQVGK8YyW6VMJzP
         s4bZgOjdJlHsf7xihjf0hufCK/Mbqodn3joooWDlYTXcisPAIhN1O4g2e5DPo8+zXdNY
         wStDuSR3UYCXCZT+3uF7SAcqCX6IJGIOWY841XPtQ34mtnYiiqIIEEzrEOHWAep6cxHJ
         ogK/6joZhpSB6ZWdIvfdQ56Zjr2abZENWshl9lRcZRUy65e6yvFlfo9X/poFsSD8vJWn
         sWUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783460450; x=1784065250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+Ok+D3VRtxGi9vtZTj6D7dsuUylLhpT+aE8x8yKCk0=;
        b=Bj1ouXviKQhPARvNlmOCUKPFeBmCZEQqS0tNDUQN0HhxTuVwDlMO74CRcXdCdgLSRN
         9m06Z+e5fs2pCv45gZpKuzTTUZpp2KQb//dQpAXslcelr6dfoxZBCE+kAqxBpspnXfuR
         4iA9YRsIhhKTXpZFKrzQeNvg396CTpg7WmKglmhlchrzq+tIss3NNA/ET6SUpke/UXlp
         RHEA9u1rlS759AyKjMjLjyguXYll5fANIswitRM/wSlLLDBMxNQlFBneoh+2ihYe2brN
         tQIyge8+e5wfDaZ9Wwc6GufDCkQzngxli57QPQL78gGmOqxOTCbkPYkcPXaLlYxfq5en
         XfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460450; x=1784065250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+Ok+D3VRtxGi9vtZTj6D7dsuUylLhpT+aE8x8yKCk0=;
        b=AIvDLAJEbEt6kC2ONWmlaZ2WuwcM0o/HY5KvOm0a58nefjDT0uIDoRRUILJkN5xgWT
         JdE9I07RD3c96xC1yitztmR07AEzlwY7dCWnYQafxf6SHUVn8zBBb6Nwyop2go1q2bSV
         yzsW5dhABdHS28yI090xPAdOIpTdrP8GbhP/di9vFH89uTxzSPaW9wgrh2xivTz7HLYg
         2h7iehcn4MeHMl5NnOSfKZMk5tIPxikztzSW3eBGMXH41d8slYwwBE8yaoenSC3s6LlM
         xKUKX+ohlglwu2iZJoqic3UWcVmLSNsjA5x42QJAz5WAdbEo8G9dE0p5PNOCbZ70lVZ4
         alOA==
X-Forwarded-Encrypted: i=1; AHgh+RquMkStUFv2jQC563IlK1z30fPx5icAQi1GT5censnOKwkDQXisXGchkxLIdQZxVoejMwaJ7DGdCDkhobq4KTWZL639WtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNetYZZD8GX9fHjn/mnpaekgVxMa3JoCbZABDX6SsERvnnlDiF
	F6+Ma0mffzSq/Xhr0i/OQk6NRPYG+gCbRCs1PJYzCuaFukcE+ST8DVH6Qq21gGwknxx6vKADu6d
	bZ6UVYEpgL+hr5SvdtVaREzF1xUu7TbSVVehtBveo
X-Gm-Gg: AfdE7cmE9N493tmMWuPikwtA31fncCcfqWgyRA9r1jWQTX55RQmvTRef53APi2O9C6l
	36HDkeIua42+FPXm0pxcxKSr5FcpALBM+i+wqBqkmAsCZWFyEUYRGj4kHae+RhtbuF/Pn1tsxF4
	DuzHrO6BPJ/Qzx5XFsntjhNI3DPaYkRQGatRAsrw2n62w58FnGhYZA7esjOrUCdFSKlLCr+pu9g
	yvBMEf7kpyX62EvJnJvojvurm49syyPBcgj2SDFTKGrJuRRZeh5ooEBHEX/+OkyXoq8xFkc2rtw
	MmGJEz1vLhur8ohNAcPkH3BppXg=
X-Received: by 2002:a5d:4207:0:b0:475:f0f0:9ecf with SMTP id
 ffacd0b85a97d-47de6723eeamr6198466f8f.58.1783460449777; Tue, 07 Jul 2026
 14:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-remove-task-euid-v5-1-c90c7e2ddf54@google.com> <c49545c6c69225bbc7e93cac58d58cd3@paul-moore.com>
In-Reply-To: <c49545c6c69225bbc7e93cac58d58cd3@paul-moore.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 23:40:37 +0200
X-Gm-Features: AVVi8CfXuyQpigqlnMZkCqwD23ax4BF_tMVmnmNSZP3qMxiXiu7h20uznVvLHgE
Message-ID: <CAH5fLgif5aEVPeD+-jq3e73OVX0uzcEYwggMyF5v_DbZ=3f_Og@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: task: clarify comments on task UID accessors
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 9:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Jul  3, 2026 Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Linux has separate subjective and objective task credentials, see the
> > comment above `struct cred`. Clarify which accessor functions operate o=
n
> > which set of credentials.
> >
> > Also document that Task::euid() is a very weird operation. You can see =
how
> > weird it is by grepping for task_euid() in the history - binder was its
> > only user. Task::euid() obtains the objective effective UID - it looks
> > at the credentials of the task for purposes of acting on it as an
> > object, but then accesses the effective UID (which the credentials.7 ma=
n
> > page describes as "[...] used by the kernel to determine the permission=
s
> > that the process will have when accessing shared resources [...]").
> >
> > For context:
> > Arguably, binder's use of task_euid() is a theoretical security problem=
,
> > which only has no impact on Android because Android has no setuid binar=
ies
> > executable by apps.
> > commit 29bc22ac5e5b ("binder: use euid from cred instead of using task"=
)
> > originally fixed that by removing that only user of task_euid(), but th=
e
> > fix got reverted in commit c21a80ca0684 ("binder: fix test regression
> > due to sender_euid change") because some Android test started failing.
> > It was since fixed again by commit 65b672152289 ("binder: use
> > current_euid() for transaction sender identity"), which uses
> > current_euid() instead.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Originally sent as:
> > https://lore.kernel.org/r/20260212-rust-uid-v1-1-deff4214c766@google.co=
m
> > ---
> >  rust/kernel/task.rs | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Merged into lsm/dev, thanks!

Thanks!
