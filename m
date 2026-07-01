Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA448164C
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912520; cv=pass; b=RmW5yqmGine/nOgmFT7RYofT7CGjFac1ge3O7pX+aq/M4ohI2HKAg40o5q0Y09rPWNr9EpOFOquU+TqhAYg4z8yW/6Tc6nqDuZ3w5jFJTfirer06jWMh3fefujS13xbf6QLKUMg/AJl0COffK/fWWJDNg94LH7HajNXcxFedmxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912520; c=relaxed/simple;
	bh=bj8dz0dNkNQf20yNhw2GSl+QGHWwTUPvPhjmw1s2sGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwXwuqmlTPJBprp4G5sPb2Y4YEh51miF7A6JsCnXx4uCsdlYP/eE9bUwbaWf1pD+f5FxRVgQn9MoQ/LxP1FJdpVUbtNFlCg1vu3d4hvy4z1Cb/PLwc1HrRpv/4SEnhqwZtLsdYL6H8fsQq3wIY5PfydAFAdoDE+t4Xtuiu0gvTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sg3LQItu; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sg3LQItu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso986947a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 06:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912517; cv=none;
        d=google.com; s=arc-20260327;
        b=DfYi1c07W1DZmXUrwqC6MdpIisa34esJQ++LnppcRQPxKzUaMwku6TDH/nwRdeAoON
         lGA2CDVqwppWNbBhWokWPH6UxBvhyV6RzQcjQh5IpmWKpbGR8GBOSp2j0fO8cRiMZiZb
         qMq5Z2Je74HVgKYGZkQ9af+O7ucZ0mR17r+PQcecX4MQnlQEKkKlPXuYG4Lc9rWb0VON
         lAC3u+lpQ0uuUBqW1y8ATSZv43Mo7OG21Oq9WJ4rC+zgLxUe9I1S8vMFy+HVgWMbz02c
         KphZQy0fSN6Oiytct6N/WbgX0dI587Mesazb6iovI09FcEm3tpWbqCfbI6J98qxo4XG2
         yh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7qXrY1GphC5/vec00qtpPY+1HhdLEpo4SYlrRMHO9A=;
        fh=/1OJT/NSVUSQl1icyDMR3ISw7N3d1EP3PnyDIzX9MXM=;
        b=hOxPJMIwKAaTtw1uPkfUfFdmuZKRf+g1hJvMjJc6lZPDmUiJgczL6bC35QCvYMzO9H
         UkFm7qRiPsbub+JqJpPQhdbVi/70GQfqQ4ghHi4fDkc1X/vndpTnOIFrE7+j4cMfQXhs
         7D6LynBxmaUshNhyuwCAO2kqoxAy3dBtUduQ85x3F2lpzkPMGKP/tATHENeoG8zy3m4n
         vjVnC1IZR6xQjfqUFee4ekgUc6jOtoHQ2OaLqwc6/s8TCp5mcXehFqxIUS0M/raA12pj
         RUFnpz4yef+3MpOG3tWlGIU39LjLCNRrVjbJUXQBdYKJRuP/HOPK1NIszR/NGWNHlkpN
         9LWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782912517; x=1783517317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7qXrY1GphC5/vec00qtpPY+1HhdLEpo4SYlrRMHO9A=;
        b=Sg3LQItuByysCglFb7zcrhwOYL9ae158GUkEWZQ42XEgh2jyE1jSROao82DLgbB3sx
         KihncwtkrF0p98wHShO8QWK9SQcIz1cBddpOP7rJ2h3+YkUXIM+W3nb81CdH6/d7EWEI
         ulyB9FGoFY0krM0XqtzuzgmN/8SHQZmo0NsjrS+xt9Lt733cw7nHK/rDTWYJAtuPURWa
         t+kob93HApHg/yHLI/Jxnn8Pua0j9lhPl47QQLMDrS/jtIU8LXvxILa8HLUE+GlBWzVC
         NjvLG4h0M5u1MrXbUA+1llAI1MK+92T5lmcNLz/5unu1oh3K1O5jE4kyFGxUVR3xgPkr
         DCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912517; x=1783517317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7qXrY1GphC5/vec00qtpPY+1HhdLEpo4SYlrRMHO9A=;
        b=d9PQYH/5veyrmdcxi3v1KTAPZGH70SoUu0jy7IIEyDyRryfG+KcM2CxjL9x3LY5v0k
         ik4uEkPp4QBbSW/GE9xWvpKHrpTwRmfGVmENinEwZp7IF8brX8wxQ/KyMZEyo/+CYFdE
         4Gfxk0bEoPXQMRr6oYhxEFsOa3Ty0Lw2wqOVfdt/pRiUkDNaUwAPMAf8TIsBHsduuo/6
         I0z+a70qtYxjv6yz3nhq7AT81XPHQGtBw12nrn4VrAM84N2OXAgqcmvH+1SnX9q+d6jn
         VCgV1uksUGxhvfeEgl5BLgTkQ3GU5eHj9RCpN11FeXR2DDelIzuz3uoBkMB6FeSbFc/i
         cXxA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6de0f01mQkXT/QKuMWtxhUmCl1eKKrthQA27ecCbbinrpPqD0i0QO8z+aSoAvf6YNP4d9Bf4qiSssrma5W0uQxcEuCoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26543EXRZOoeKFStAHMtX5Sow3JArf8GM9ADY43qpAUVD2Hxp
	IrIfucyP5cHfTChX+lGsiyrUSmotsNz3+69Gx4lI/1UCecyHRNGXW1jiW9i4QHtjNkt3G+MW7IF
	16Nw3ygfxuJ5XokdlKDWY2ZslZK1OrQmfduJZMWdH41/kRJOjRHi4tq/WL8o=
X-Gm-Gg: AfdE7ckTW+y88vhGLDz+kv7reqtT1YaHMGnxFeyabOAjzj8b6YlFMdbNjUXiQCUSTUS
	iK4N1Cwvad4JmVxpGHmUxAAfjzpj1ZPmbZdIm9jlcjf7uB0p+YOPFF2uI2wl8Hu4lD/8fYwFok+
	Wlvt6qmeBAAK9yG0tdzQja5gfOwFrhZeCtF8wnsjqsgnEkat4eBIjjayPcPQGomatsd8AaXrDBF
	HpK3NnD1M82P4hMo0cmW+UXBOmqz51IUoF6ooolV9A+yJTV0qwZoyAV8jeZ7L5qrYGRex2w
X-Received: by 2002:a05:6402:a29c:20b0:698:5e8a:2645 with SMTP id
 4fb4d7f45d1cf-698a2c5fe69mr229183a12.8.1782912516536; Wed, 01 Jul 2026
 06:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com> <akUH13qbsEnJLgQu@zenbox>
In-Reply-To: <akUH13qbsEnJLgQu@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 09:28:22 -0400
X-Gm-Features: AVVi8Cc1vT55jUxpGNkg-5sjvQ2eBr8E5cdvCjMEhHhjY5jPSa6NSmuXqY0WW14
Message-ID: <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > callers. Export an opaque struct bpf_landlock_ruleset preventing ca=
llers
> > > > from accessing unstable internal Landlock fields.
> >
> > Generally speaking we don't want to provide APIs, either in-kernel or
> > at the userspace/kernel boundary, that are specific to a single LSM,
> > see the LSM syscalls or the security_current_getlsmprop_subj()
> > function as examples.
>
> I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
> clear precedence for this. (BPF calling into specific LSM)

The BPF IMA helpers were merged back in the v5.18 timeframe when IMA
was still standalone, it wasn't until v6.9 that IMA and EVM became
proper LSMs.

> Kfuncs are explicitly marked as not being an ABI, and are more
> flexible for later changes / deprecation etc. [1]

The issue isn't so much the kfunc itself, it is what the kfunc
*calls*.  From what I saw in the proposed patch, the kfunc calls
directly into Landlock instead of passing through the LSM framework,
e.g. a function wrapper in security/security.c.

> LSM framework API can mean a lot of things. I assume you are meaning
> like a pseudo-filesystem mounted interface that controls LSM?
> Correct me if I'm wrong.

My apologies, I should have been more clear.  When I speak about the
"LSM framework", I'm talking about the abstraction layer that provides
the interface that the kernel and userspace uses to talk to individual
LSMs.  The LSM framework is analogous to the VFS layer/framework in
that it provides a single API for a variety of underlying subsystems.
While not 100% correct, you can think of it the LSM framework as being
the functions/hooks defined in security/security.c.

Does that help?

--=20
paul-moore.com
