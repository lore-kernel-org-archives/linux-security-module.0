Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308005;
	b=hosjDk0ZtPXyCz9qx5hxlk+JFBJ8BUJ/13EhS3kDQHaqm+HVzPb6sC/kWVW+O/Jx/tnL
	 Lnz9NuY3CbdkYtCQuWg+BVURCZCjnu6MgN7jFnpuXPOAJOy6nuXqEInLEGcSlIzhim3IK
	 onQWJygyJ6bddAyY/BWJhPxic/sBB9hHR6KhrklX2FKnPH+Twl5DzJmQ5mC621WINd51z
	 3IQbtaHeVhiORQOT33aRBmNPU1LPt9BLgPPIuWKr2k3cfYS8/bivFsOg4ZYw6tBHXgCzf
	 sJpkZlyrSMsabl7Binp7YyVY9/DbleRM89xLyBSTlAxZh2DmkteaCYNvcM2uXDbssSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
	b=KQnCrZCvwSDhO/MlnzBZYVi4kcdmnIOCBzU1ODq6o4iKlBzCKv8oh71Q0jxonXgiBMru
	 d6MlEQEYwUnKhpYUoGOQy3MF22mk2MRnQJfno0jOgVltZnLNoNqv9ssoqDGpqLkU2zvD6
	 Ai1/uILF0+NYzImy6gZ9hx1/NyXboAgV1nVbEHIkh+u273X1HkWjaZruWfQW/e3UAX0qE
	 cFTp7lcVQkaB4yBzOPVWkbWU/UxaKKD5099N7uztTdlBYdupxXrOpXWHHziVZg6suFlTc
	 l3l9VyYEGx2Fw6KRbRA7+GfteeI27pfUbcGWe7G0oCbs8NIssqAwHrRGKMbyMa4Vwjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SUMWHyeo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B8606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SUMWHyeo
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso1975369b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308003; cv=none;
        d=google.com; s=arc-20260327;
        b=q5W4gq0GI524ThZrC7dxOGjEJLzpPGfaSuyIIy346AOnHK6Cv+J10lzLUH1N6g8POF
         tg/PAMiKtDIpL5b3eXKAN0SRPF+t/qSVHhpXa5P392goh6Ya4iyjrxd6owrUKaCPdbgD
         1fAzOWi6ucva+3Py7lSz5bTCW/EZTTRfpVl+7I9bTgBvHzffOeiMyVbqqbA4ou2Yf/8N
         HnsITpifLuRmxDQHrW3h5T7gs3WMpVTxnuZR9icAL8oxdyE9LHMtBMbMtoBZPaXfUTb7
         3sRClq5d2Eo8vRTVyg4mESjnDd6GLC89iX6J6kWXZSmzyei5DYF7kEQnKx+g7kOtCpZe
         Lmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        fh=qMU72OeGw39cgeWWxWGRDhyixPaVAW6zQxfHcgUvkCI=;
        b=jLsS0cUgByEyQG2WQkrhdMpOaX/84CtpIfV7qvHI+Q8tDpUwiPUEIQ04a7XRf1cLux
         ZMgZ3QuWQIqAwY5B5oKyQXD6CKJSnn3hQfKpRAuS1LOIlEunp9TcUnk1xIlEHtz3BHuG
         LEqbPDMjXMi4tZVYSozrzW9dy0Fc+ndJFTku63rTMhVORFbOANMKddowD2Qm5r5NuBXk
         vtneb/dnuZy7BSF4lxh4rhHO/u1hnBhYV/hDniQ0aoIpwMPtrlLJ8bW9dNRkByIBoQXU
         6EP/WZhMswSKmY5owFMGZx/h4biCB2IQlcmsZxYIP9i0J6DOhIpM+T16trrJodZgd4B+
         XuHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793308003; x=1793912803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=SUMWHyeoy05LlaPkkQo68Lctqx8jCJMBTP5h1s5JBg1inkctrhBizK7c4vICrVd4ST
         tFgaTBblbt25voa4mPfQrBUwVI2YrctmrtYJ63fqjqiCjZArQrKO4OKXUqCQLnZIerKB
         9+pJORukUAKGMBg8JR8BdJgf1joFHY09BQARFm1AoO9N4jDb/hxCp5cBEDF6KEs4eZLA
         s5zDXJAWJfqzLNKMabhR+qdErWq+anDkdWSt4GGzkvx7RJRsY7B9xG6OwOuuiyrfA07o
         SZGBXLg0jYjyyW/ttddurHjHLMVw89R1WFqxnex86aQjNutVESFg8w7ztk95DE/2a0uq
         MykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308003; x=1793912803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvNRAljflILBTk2xcHt7L4MtTrvHvbzoZJJKtwFYnHk=;
        b=nZpmnHhMTMGTNUD++Lbmt/95cRX5cLX0hRxDbm8f5jOwhMeAf4dvb5vIaqB/ipzAZR
         oIGzgYBYiUP6IlS2c7gGAf/SDjXpS5xjM7eu7qUKVy3IMbckcFzbUng+RyBQgd7akX2i
         OWymOWil3v0m/y4GMq1gADFP7LI25Uj/+xod4x/I2J+V5Mh4Jly/sG+kr3QilrO3nLxf
         /UNtRUgUqS2gehXvNUHNDExSE1izdaiAgQrZPnvEaS1Th7mCl3fJ0b525fp7zcmTvVM8
         dQgjcy9lt1KyOZTAXA7u7RoLfmb0+ESyLmErKk4gUBtYCuKT7AyODK0DnyJb4KecyR/6
         YXnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8dEa5RAkVZjT1jV/BY6BIPLVfiY1QHxqyon945UhwAbt3ONIMDv/LxNqGuxV2VyIG/fNJQuKYjI6UevocoiuWowluJGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbWIcTqEnAO2gL7X5BUbNeEIpEKmTdlTSbtDxght86xng9knQU
	gKvNLqkM+ikC2MD8PMcXiPYKeWWNo45GcEnncXZtJ5nB2o70lu9POBMm3R94PpBAmep3whySEAD
	7pADlTUOg7EjKrnRJWsR3HqJ5nWqF5TMyKXJOD+ky
X-Gm-Gg: AYBFou0f8C8nnSGcxcJhRR+Owvir+VRuppNhC/3mUgrndNQXWmh3mAg93XrDtStRJMv
	tjoxDx2NBUShAVqmhhc6CNotZbdSb/CtnZFAeS6HBWzpAYXcpqWNvOy5zrAuEOv1pPvPE1+otD9
	V5FqvNnXvRKdKqLTaCjTt2nu955Y352gATc+nyirfRRS2G0SyM7pk8rgceRQYdMrg3qP/Zp9SZ0
	OL/oe6oD5EcMBPMyWztodNQRg9DOVaDeIRVRM4junPHD2+jSb4U6X2sABZLvAtWrHMgyJhdEi55
	0K6/298T+c+RaW7HAv2P1xlWlwplhRgw/3lL2CJ1InF9F1xE9lD+cCWTlkvHL4Cq4x6lDaXX5zo
	ymvcCTNQb3LM7Ssu0nxExuhBU86TAs2Ai6MXZ1UPQUad3Zp9T2DDP2XybF7Q/kF29qhQNHly5JI
	Lov64u2zm6J7b65g==
X-Received: by 2002:a05:6a00:1491:b0:8a0:5d6f:8a9d with SMTP id
 d2e1a72fcca58-8a9bcc0e982mr298168b3a.35.1793308002978; Thu, 29 Oct 2026
 14:06:42 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Oct 2026 17:06:30 -0400
X-Gm-Features: AclHuK_BZX5V0V1r5inK-ll44mPJ2Gl9ZXGK3V5AGh6lbgKe2qd3dfFfw4B3CLM
Message-ID: <CAHC9VhRwD1c1qKK4=Uc8cbMy27iF722C0DZeXy4WGtH-kOBOcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock now logs that id instead of zero when it denies the creation of
> a namespace.
>
> I'd want to get the whole series into v7.4 since the hooks are new this
> cycle. Otherwise v7.4 is the only release where namespace_init sees a
> zero id and where Landlock logs zero for a denied namespace creation.
> The systemd change I have for this uses the namespace_free hook whenever
> the kernel has it. On a kernel with the hook but without the first fix
> it would never learn about dead user namespaces.

I'm renewing my comments from the v1 patchset (see the link Christian
provided below) about the LSM framework changes being appropriate for
Linux v7.5, not Linux v7.4.  It is clear that the BPF LSM use case was
not tested prior to the merge window so BPF LSM support for these new
LSM hooks should be deferred to Linux v7.5, allowing for proper
testing.

Disabling the BPF LSM support for these new hooks can easily be done
by adding them to the bpf_lsm_disabled_hooks list in the BPF LSM for
Linux v7.4, and removed in Linux v7.5 when the LSM hooks have been
changed in a way that is deemed suitable for all LSMs.  The
bpf_lsm_disabled_hooks change would be substantially smaller than this
patchset and would be fully contained within the BPF LSM.

As a reminder, the LSM hooks and their callbacks are not part of the
kernel's stable API and are subject to change between kernel releases.
LSMs that wish to provide a stable API need to provide an abstraction
between the LSM hooks/callbacks and their API; the LSM framework is
not responsible for ensuring individual LSM API stability.

> - Link to v1: https://patch.msgid.link/20261026-work-security-namespace_f=
ree-v1-0-ffa3ebbf71bd@kernel.org

--=20
paul-moore.com
