Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904D1A2392
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159324; cv=pass; b=jZmyGY403ErgLt2Hr/vOz+OuJaLjCNnhJKrXOvalGMqm4K406I1zmY6RM8PFyhbNGBzQg41ELbTHgICvpXQVXusSNQamIph6VmDwcsFWtI7J5hJEHFVWPz6yhjkH4oJE/NAFRLDGza9cAgpAySNyYDgPs5IesOIGyFDIOpNR+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159324; c=relaxed/simple;
	bh=7UyJCqBRdDQbRUMfdCvNywEZmQykXXP5gBZZWpmEPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX2il3HHfz/M1Esjuuecb3mkUXrOfrMwRP8GiIGTyPlvrLeq9v8UZlVNcuK5hb7Pdf7nokk8WwFDC8/kAFEl5RLPo/I6pVeSGIcdjT+ehUWvGP4xbDfN3r00yybsPyPAVze4N3cYGReLwJsAXj85ml0vNxV9ZRYloQlAv8Ph2DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LHig9NhB; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LHig9NhB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b941cd869cso17303785ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 19:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779159323; cv=none;
        d=google.com; s=arc-20240605;
        b=dtrJsoXhZKu5IJyEh2i3paTnMurTdzh54BRGJEHpx4GpW9ARHheZUiaUlbpchLpi+i
         6FOnMYx0tqzhSbP7o4k6gTNJPmHa/jlrzl+ciQaVlgyD+vn6DkBaraNMNqMMgbLP39jk
         Fw6AONr51kFs+YOKnDWnJ9NlaHUeUkX6bOx62vp7ylQnJ70QLOMjVRal3/+r53NJnAUN
         E24cOZ3v1JXlG7pIyIJiUNkSKw0OsXcHmZUxNnL+tiTUqgBgpf24b5IAhcLEgkEm5cFO
         A8GAgLMbDS4tY8R2CzlE3ILO4kRIR1Sdx6WWzqJlClEXWPeD89vcqRP0nkqIKtBfAkZf
         V2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=48t5Wp7GpUaD4JVHMYGaZTa+PdE+2hwEulXY2P1l2dE=;
        fh=QICmiwijudy/m1XKeMVvcCnKFRSEigUqry9CkT3tS0Q=;
        b=FP0O5d0ShU7S56soAbGYTy5KdzrA1lp7zSAiaLVGhvqMIPNCHcxChTngcKVdh6DFtD
         hFnPXp0wBYcN0tYgXlhVnMEQVSpSmGITmAFzgDcstJYkm4ej9ycjw3mGjojvTBImjyBH
         RlJ2AtThIMClbRDijDxR/kR3mOku/4GDwI+YF9rUegdXzfaIizkBToRwLGDB9qUyrol7
         PZp3usqWnyyLbmV8Om2xuDqfIkm3IUbDGq7xg1Ha3qr6Qg+oqS77SX7PherXgtrJhYnT
         dWLwhYRCRweFCGqTEvtcM6+ypH3WOLxwTuAs45WNE62Q9t42x3tYTqaJTEuQzBw+HL7i
         f82Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779159323; x=1779764123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48t5Wp7GpUaD4JVHMYGaZTa+PdE+2hwEulXY2P1l2dE=;
        b=LHig9NhBYcp4lvu9FsDgRb8HDOdpTciWKsFU0bX2LCajRvpkNxObfIMDmhbSB8zXoM
         y7KuHzobb9crsODCEHkINJ38esHDaFhWFxEsNa/7rSvANhMEbWEOjH7/CUoPeU01RGz2
         orqC8Np5R/PrR6zsxIfNkWHQc2puRSbAmXmob1Jvx2P0JMBZj16WkbRJobH2GXBGpbUq
         AaJuMKdEsWXtAV2E7Uq3T/B9Y1otAYfrPiruwuhkQXXK3IOAY5heSjjvxAkbq2biXcQo
         CHbyGUzBuM8FEuHef0eEWxXyqV0D7IG3N4PKmgkIiEtcb8LPpw9+5aB0+qaDFmanYJVr
         0ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779159323; x=1779764123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48t5Wp7GpUaD4JVHMYGaZTa+PdE+2hwEulXY2P1l2dE=;
        b=b6PpOBNNo5W50zotsMOCIAsx2yG/Z07cdHHjI/pD4TNuPN6Y+g3JX1zBa/yAYQ5pDf
         RaUElf2LDwluHpYSO5AdC3UlYiwjoOuRQ8V0E4VRJMkVg9gBliV+BFZuB7J6AtrcU8AG
         wE2nYvGvL8seC0E+FC0eBdVA6g595h1RWo+I9m+kopQiyZIhq7tG9PRkgsNlky4JO8BR
         wXLoquDJkPOSoUD2z4HagHIOmIQK8v5xUp92J7cvPxCQQaPvWfQkYFXGUT1vgotvsRtO
         5Sht7c7BQQDznss5FcudR4F+ydvBkwuNg4LX29auHnXjwMdnbRAP9QWAw+t8u647p5O3
         Zzrw==
X-Forwarded-Encrypted: i=1; AFNElJ9jBmqB+LmbMswRrTt+tCesm4SYV4swUV9zShf5R74em1C1+5sM4aeuLVcOwpF4X7GvT46SJi4rzFg3MNntHqc/J0w1dSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YYoNFAbk8RjkgbMjk4q6Xv0GobhlWd5WV8G90yv/CoxB7yhO
	emjQSyWYdWpTEU9L9jTyGBQE2LidqkTT17ZkRGhrev75k+FYDUArs3Oe+dKRn3UNBuTFl2iPn6e
	Z3m4vcuUGIptwt9L+leSJ3RrJTGympqmGVZ5oYv2y
X-Gm-Gg: Acq92OFYVG1s6Ffh96+9YIFsatAbYdJXC1Pu2bTNcbhQDvkF/6En2P0iNPf3FTMHZwk
	F28DUZWC203mxk8cQYDyOdaO+Bh35LwbqbhA5gOePeG3LQSk4gn6WekhALgHrgGihaicbIG/0gV
	7n2Yda/+6ZVxi7PBe28ICY/HTNY9irPI8Tzgx4TubM4xsMyXDgg4T2baNX+pnAYImXyJzeg03cL
	FM0Q53jOFqKRLpfqCqdc8w4EnftnlU7Pl7PrtziC6knwBuSuXR1CwevPIWJdtVSdoO/YvJy7KRQ
	H3ZxZrI=
X-Received: by 2002:a17:903:17cd:b0:2bd:8938:b811 with SMTP id
 d9443c01a7336-2bd8938b845mr174842955ad.34.1779159322627; Mon, 18 May 2026
 19:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
 <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com> <CAPhsuW7Js0Z6tU30RphbUjWsJXETkxaGOArfGZpDjNPmZFUpuQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7Js0Z6tU30RphbUjWsJXETkxaGOArfGZpDjNPmZFUpuQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 May 2026 22:55:10 -0400
X-Gm-Features: AVHnY4IvhqH391i3RQ33XvQXVamFfTLljbGCppZ7t8Skv2w-HCikKnYPe2_pXNI
Message-ID: <CAHC9VhRiDyGT6R+yqxS_oMBSiD6x01HNTb9jWq6B55sfdDkqbw@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Song Liu <song@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:01=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 18, 2026 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, May 18, 2026 at 7:23=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Mon, May 18, 2026 at 2:29=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > In my opinion, making killswitch an LSM is more of a procedural ite=
m
> > > > that deals with how we view a capability like killswitch.  I
> > > > personally view killswitch as somewhat similar to Lockdown, which i=
s
> > > > why I made the suggestion.
> > > >
> > > > The use of kprobes, while an interesting idea, presents problems as
> > > > allowing any kernel symbol to be killed introduces the potential fo=
r
> > > > security regressions.  As a reminder, some LSMs, as well as other
> > > > kernel subsystems, have mechanisms in place to restrict root and/or
> > > > enforce one-way configuration locks; while many people equate "root=
"
> > > > with full control, in many cases today that is not strictly correct=
.
> > > >
> > > > Yes, kprobes have been around for some time, this is not a new
> > > > problem, but killswitch makes it far more convenient and accessible=
 to
> > > > do dangerous things with kprobes.  If killswitch makes it past the =
RFC
> > > > stage without any significant changes to its kill mechanism, we may
> > > > need to start considering more liberal usage of NOKPROBE_SYMBOL()
> > > > which I think would be an unfortunate casualty.
> > >
> > > I don't think we can use NOKPROBE_SYMBOL(). There are functions
> > > that we don't want to killswitch, but still want to trace.
> >
> > That was exactly my point, but we need to figure something out so
> > killswitch doesn't make it easier to cause a regression.
>
> killswitch is making it easier to fix a CVE. It can surely make it easier
> to cause a regression. AFAICT, the only protection here is "it is only
> for root".

As I mentioned earlier, several LSMs have the ability to restrict root
beyond what is possible with traditional Linux accesscontrols.  For
example, with SELinux one could deny root a specific privilege while
also blocking changes to the SELinux policy; the root user would not
be able to restore that privilege without rebooting the system.

On a killswitch enabled system the ability to restrict root is lost as
root would be able to kill the enforcement of those access controls.
Presumably one could have the LSM block access to killswitch in this
particular case, but that defeats the purpose doesn't it?

The audit subsystem also has a somewhat similar one-way configuration
lock, which when set does not allow even root to unlock it, a reboot
is required.  By a bit of luck with regards to how the code is
written*, it may not be vulnerable to a killswitch regression but I do
wonder if there are other similar things in the kernel which would
have the same type of problem.

* This is probably the first time I think I've ever considered myself
lucky with respect to the audit code implementation.

--=20
paul-moore.com
