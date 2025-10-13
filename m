Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C1547D2
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393524; cv=none; b=XTTZ7R1e4BqRtFYXcpaqSsAl26Am3U65NEDQPY5dS+DydOkJaH02OSI709rT6XbIkYOW0F2LAIz9dbstvHtyXTTziPrA1Xlq3Mh/xcpcpF3i1tFnM0894GfklUYOAxbrIugUJr2IvoA1Yu0itvTQ6qWWeCtun0QyfaEAyGLO1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393524; c=relaxed/simple;
	bh=be2JClIJrJxBvNDhrBkl734DHApdgwSRd2qYm+Z2B4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcG3mU6MjWX3y8SUQpFnP9G7dZU3xu7k3x2mUqP9gG8bncijrEE97aNYIjnK6bOYxKFuIZBCz7i9ehSMlbBhRWOFx3nGjr34mdKnDb4gVSxHGnhToid//F0YS1VlXmnyPoXhD1GTI9y9gdJACTDPZg817jNevdR3LxDnveGoA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BUS+a4Ef; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BUS+a4Ef"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b593def09e3so3098152a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760393521; x=1760998321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV4/lwpAKyOkjUBhIKqRVppxc4INpbpW5Cdx7jCocQQ=;
        b=BUS+a4EfvbutITz6O72lNnqLkt3ORJXUbag3z9Sn8rk40Bu26MKuLYsJcOoLbpXnmR
         94je4MotmuBNbXpDtKpGw7cQXH4Aln0mo3i26KZdYmwmOk0PMtKYGlP/Q3W2Ogg0GZtV
         HhskKH5pHEWireG33pp/8AWzZR6W5AXEW58P0TFugQ5QaVIsnoQKZHK7BMkVAZLRFR6j
         alRFAYhYw5AXVpVIHeRg4VBN4/8J6wS+gY156NXobkGj1iIsFChkM1LsSPkXEpCmWZ7x
         WETdfcu3H+ConbM+ZXnsGbF4e4rkBAQl6I+TqUEldmToBDwCe8kT6jsungwFc0gNt/z1
         qzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393521; x=1760998321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV4/lwpAKyOkjUBhIKqRVppxc4INpbpW5Cdx7jCocQQ=;
        b=WnUvUYabc/i19fwHqAKvX0QunWOnxdUFgHrIYGoX0iKZ9imBxzxCjHRA0v/5Eql+RM
         nd1l6pQNvVZjNlmGX5PnXIHsSL4SBeyEUkS6WGK72fnxgnt7sK+vrWAm7LEaBvItdypE
         2F5JZTZzC3PjLV/hwwhxs/kFz08IB/PdLzd4rG4bqAgpJ+hlj0iBEhGveiVInYyQa8fu
         Y8p3GbMuAuc9ZH4Nqq3kuiKv9OgZQSZdnp7f76CPsn5sS1DKdjXcsC3Sj0S420LvFQQG
         HWpIPW0RauPtvRXhGqYFTPD/HZ5FdLHXUwrhrrR7cGzMTmacoIY147Osgi8pgvXsqA5w
         qhbw==
X-Forwarded-Encrypted: i=1; AJvYcCXtzdJrNgkqPIPl4CA6EsRWBxDHG+2KQgv09S7Pti9uRGXBv/0n6A89CiMAB/BMJKIp/GA0QJaVIt6Pd4+RyxP1xAogp6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdbtesJa0s6dpOdTidJogBTCopCq9XuTZAlsYckNqSaL95xWO
	w+UZJZENO9/zyAU7mtR2p9lHr4NcDU6yPEBxU1Q4FcBVODDNf3Put4JzBF2X5V9aNKt+noHY/fT
	W75/rkiWSVBRsc5ZkkrzTegsPv5vWEl48SsiwKWCq
X-Gm-Gg: ASbGncvhwTu8Bpe7SMDbBBJrwh86xiRNpULE/XLadmZxi6siCJyl5j8DgCHenNIKnXq
	1/fADkQKBqurMRr6Q0ucb26i/9ZQFaoXFEjAqu8vK3BizIzFPNyhVbA9e/fU7jNzVotJ1xLelgk
	LQNPfenQ3e1gNfsYqDXI35bgaMFgDGjl2an2QM4iOST8VNa11QZgcS+1mL48G+se0FwFLKBy+e5
	iAOJnvvWNpNSeT6YyQQ6TOmAH8qnyIRmSb8
X-Google-Smtp-Source: AGHT+IFThnEwReVhjbUWRuYz3JPM9/iH4m5a/UxLJsLUrdJeFsAXhN7ECjBnR6NRtSdH/5tYnnD056fNYIQ73AAr1cI=
X-Received: by 2002:a17:902:d50f:b0:246:4077:4563 with SMTP id
 d9443c01a7336-29027344a82mr330497705ad.34.1760393521514; Mon, 13 Oct 2025
 15:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-2-casey@schaufler-ca.com> <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
 <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
In-Reply-To: <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 18:11:48 -0400
X-Gm-Features: AS18NWAJfwOwScl7pg4qOX9NfCT3x6SC4JsaXLI_2aS9YiVP27tKLnaQy_hL_Ec
Message-ID: <CAHC9VhTr_0XtFfp017vXmaQVm77kkN+4ZqxNqNnBOW6MpFQqkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:03=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/9/2025 11:49 AM, Stephen Smalley wrote:
> > On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> The network secmark can only be used by one security module
> >> at a time. Establish mechanism to identify to security modules
> > a mechanism to inform security modules?
> >
> >> whether they have access to the secmark. SELinux already
> >> incorparates mechanism, but it has to be added to Smack and
> > incorporates
> >
> >> AppArmor.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h        |  1 +
> >>  security/apparmor/include/net.h  |  5 +++++
> >>  security/apparmor/lsm.c          |  7 ++++---
> >>  security/security.c              |  6 ++++++
> >>  security/selinux/hooks.c         |  4 +++-
> >>  security/smack/smack.h           |  5 +++++
> >>  security/smack/smack_lsm.c       |  3 ++-
> >>  security/smack/smack_netfilter.c | 10 ++++++++--
> >>  8 files changed, 34 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/security/security.c b/security/security.c
> >> index ad163f06bf7a..e59e3d403de6 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_=
blob_sizes *needed)
> >>         lsm_set_blob_size(&needed->lbs_xattr_count,
> >>                           &blob_sizes.lbs_xattr_count);
> >>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> >> +       if (needed->lbs_secmark) {
> >> +               if (blob_sizes.lbs_secmark)
> >> +                       needed->lbs_secmark =3D false;
> >> +               else
> >> +                       blob_sizes.lbs_secmark =3D true;
> >> +       }
> >
> > So if I understand correctly, the first LSM to register with
> > lbs_secmark set wins.
> > Not sure that's a great idea - seemingly some LSMs may want to insist
> > that they get to use secmark regardless of registration order?
>
> But what if two LSMs insist on getting the secmark? The whole point
> is to make it possible to use multiple LSMs that what the feature at
> the same time.

My current thinking is that if two LSMs *insist* on access to the
secmark, one of them has to fail to load/initialize, even if that
means a panic on boot (we should flag that as an invalid config in
Kconfig).

Perhaps the solution is to have lbs_secmark as a tristate value: don't
use secmarks, would like access to secmarks, must have access to
secmarks.  Upon registration a LSM that requested "would like" could
check to see if they have been granted access and could adjust
accordingly.  A LSM that requested "must have" would fail to register
if the secmarks were already taken by a prior LSM.

> The limitation on a secmark being a u32 is a huge problem,
> and Paul has battled with the netdev people over it for years.

I suspect the only way forward at this point is to convert the secmark
field into an IDR* that we could use to point to a LSM security blob
that could store LSM specific structs for both secmarks and general
LSM state associated with a skb.  This would also allow us to do some
cool things in the forward path that we can't properly do now and
would make it much easier to handle a wider variety of packet level
access control scenarios.

It's on my todo list for <hand_waving>someday</hand_waving>, but if
somebody wanted to do it that would be awesome.  Just a word of
warning, this is not a quick task and it is probably only suited for
someone who already has a few netdev inflicted scars.

*I see that IDR is now deprecated in favor of XArray, I haven't looked
that closely at XArray but it looks workable too.

--=20
paul-moore.com
