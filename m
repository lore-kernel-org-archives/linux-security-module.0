Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4231E106
	for <linux-security-module@vger.kernel.org>; Wed, 15 Apr 2026 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287024; cv=pass; b=EJOLrvaDeKJM9Ldwtm+5LrjXi6Pc4WbsrcO/F19TYWPiOgL/oOAWuULPWiVg+8TuQwJNGSsdRe8tevtAB77KiK5yVNSIWQSOsplNNo5jlW/ynhLfTtMld9WQgRbAe1ZxJhi49kj1h81R/pOLAn3AUaZMcDVjgT901u7sY7yMYLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287024; c=relaxed/simple;
	bh=GaaNZcjpodnsAzv4m2iPX05Zq7otswTnvY9FgzS0EHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdgBZNUJ3E628rqEb8wBc5X9oRG+0/6NaGFxHNvu+QvPGnrB7LHSBiV0QcmChshnqe5oVvYPdNT9IVqy3eQQIEwJKuKxJ1n8ocwewUiKBBGBBwKlcYySNXa1y9MAVjCMnNbNDpzSHCsSqyLZwXnxM6ePp3t0yyorKj4ggU9Evno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XsRY/SFM; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XsRY/SFM"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1164a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 15 Apr 2026 14:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776287023; cv=none;
        d=google.com; s=arc-20240605;
        b=WY6DcxG2bbGghIHN/TuWam1ObGOvCUWf2lBMfa2h5huyauS4UcuWNXqTON02UM3TtQ
         CxttnEaVdECxYBchgmk3LVEotAzXnslCBGBdbElXA3lL67CuSJi61lO2EQI/5LXZhbcc
         orIP63UcF6/Z1Fou2MRcmRp49iB860Ly9K9fuYX+R0lShfJuo+pWaDcngqAtm8b+7sjR
         oT8kbW74hOG+Y8AivzvAE1Nrzq7SH02XE77FpmhMivntIXwvWRJWTk6HH5DUcvPMPWZE
         drqOEcJ64zpsz3EMFJkIMZ5+Uk7LOIWMVKcO9KTy5RY7OpSADfjscLo3N5cn5Rde4bp0
         Mo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        fh=nb2/BqVcxKQzYIFIQXYpHn0ZqiihztSEaqx/w+W6Ags=;
        b=P1qukOBiLxyd0mmIOlfgMdiU5Fs2lwjfX5+0uwgGLBrln9TIx1hnftkr1btf/Ce5eO
         5+1XkCr/TPauDw53z0iHeBhfq5FQWs8J5ZXS8sSRiWYt+Kkfv+Lmma0Lk8Tm1HCn6H5B
         OgVwHJDxkKBxXTA7ANDqVVTh9yOCy8n9MA6XpnYjsLWldO5e7ak5sVZzcwUXvn0a30E1
         fPxe/v9lsx82XgBBjmb54iXMgvoQEDGGnKMmpfksA0Ms3VsjdaON1OpxxJc9rXCRWZS3
         5nztR14iS/E3+BJkoagauiiS1oWTFXLOwsSSc7CswhDoMOjMbdnw55ufJB+1/Xx6U/Ae
         raaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776287023; x=1776891823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=XsRY/SFMGYJCRXoivRO3oa5bLJ71GiHRIJmHzS5CrF5VUjJdd+hV8k6h8Hc8acy5UA
         yzCv2maRQmr3UoQgWe2BwKVdIFSSWgXAb058iwgFF5JGOAuxjg1etk+/4PjX0jNPtUfU
         F196m2hDsOIS+hHWcXKTv65cuesfDho6jb7u0fZwDdvNVDz96meOZVK0rjbpVwrZzRTv
         T/LRK7lfQK/1zur7SEA8te1lqaqQp1WcYuRZzZQSO6vMSPwTZTOQtXueZqAS1KEiib8l
         St6JQ9G58yL/vXw8hfuKPmmqe3FCUg92QZH0BSvagOrhGJLUUSTgse7gFR8UZkuZe3mB
         snIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287023; x=1776891823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+83jR3u+OMYuyXETY5Yv8xOj3xNbNwA4cnwnv5DT6dU=;
        b=bBYXEKusMvkJ4wqpG97Wo2ZG35MFGe43M2ntsOOZ6sg4HJXx+zVV+YBViPYXEluVOW
         nDp9FY6EEoD3TzftNbjLCIuggdFlNWaABuF5iFc6TVToa7nghWSynDH94Bu+yJn4/mAg
         AmuHNaoaCJpCa0Hgw4JL87kfFxm8PIJ4cPTFIx19kNlSM0/2YW3fw6pxwJXBpJGzvZNK
         6lTLvyVxY51fLZcb1I0juLsECMRh7TsLXbMQL4GIIvInI7GuPephsCJRF6cU9j6s7tx6
         dr9tX0w0NIRvUeXF9ydoYT5yttyyY4t56f/FIsM39Rg7e/GfexbmU1Xs0Kj+z9qukHbj
         GtYg==
X-Forwarded-Encrypted: i=1; AFNElJ+K3ACFNkXx3dsz0f1HNsejBYb/j1hdmdduFzesgIwJKIdYD/1WsRJRlgRI9a3d+pwC5Z0G24vA8pZuk8h+AILA1tzvo+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09lfrAnWKjve/xVjkb34R7GKY6txONGT7ZKrHUMeTIFlpDiSP
	63eDE+X/KnkSe2w3RfwBBEydVwgUOgx4qvKguYwEmh9B1EDI4HFMk+WL6y+0wHTGRGou3KeYzgM
	hX5dXjbFVd0/ESIwLSBsMCPvMQTtptaDl/pqTFNul
X-Gm-Gg: AeBDievSNgNwoB6l0OTPZPzIiBNeEzUMWBWF6HDJte+gEKPYi+cgSy10WzxhXTr3ddH
	kmN/G/IYLxycDAZAfR7RzBX3EvXXucK4+5j7hQNGTIWoatRwzQmKGhxqWyk6UFnM0pu/Gk8qfcq
	uAquCLDH279OM4Czoh6ueJKznj8vBNH0KWS8l+NRf2NJsZI6f+BlNFhfD+dfpDfDN81Q6CF33SG
	JAiVpJ0KQJ/SrxH0dScliSgwOAZpxHyGV+VgkxF8mQ14fCcfgAAec8JNavhveLh3+d+9zfmPheG
	9NIHS8g=
X-Received: by 2002:a17:903:2484:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5eaa22380mr5127465ad.3.1776287022908; Wed, 15 Apr 2026
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
 <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com> <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
 <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
In-Reply-To: <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 17:03:30 -0400
X-Gm-Features: AQROBzBz2q68BZW8dTm1i7JCyf7T-jJ8N457zfM2449jgU9ei1obevOWDfD4MWI
Message-ID: <CAHC9VhS1sVMGHpO-5Zn0K0w6suTB-i_SwvouDpEmT8sXffsRfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 6:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/14/2026 1:44 PM, Paul Moore wrote:
> > On Tue, Apr 14, 2026 at 4:10=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 4/14/2026 12:09 PM, Paul Moore wrote:
> >>> On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:

...

> CMW MLS and SELinux MLS can be mapped. They have the same components.

Yes, one of the fields in a full SELinux label can be an MLS field,
but that doesn't mean there isn't translation needed.  The important
point is that security label translation, mapping, etc. is necessary,
possible, and has been proven to work across a variety of systems.

> >> SELinux transmits the MLS component of the security context. Smack pas=
ses
> >> the text of its context.
> > Arguably the NetLabel/CIPSO interoperability challenge between SELinux
> > and Smack is due more to differences in how Smack encodes its security
> > labels into MLS attributes than from any inherent interop limitation.
>
> Yes. That is correct. The big issue I see is that SELinux does not repres=
ent
> the entire context in the CIPSO header. Thus, you're up against many SELi=
nux
> contexts having the same wire representation, where Smack will have a uni=
que
> on wire for each context ...

That isn't always true is it?  From my understanding of the "cipso2"
interface an admin could easily map multiple Smack labels to a single
CIPSO label.

It's important to remember that if you wanted to utilize CIPSO to
communicate between SELinux and Smack, the label translation is not
between SELinux and Smack but rather between SELinux and CIPSO as well
as between Smack and CIPSO.

> >>> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> >>> require some additional work to convert over to a lsm_prop instead of
> >>> a u32/secid, but if you look at the caching code that should be
> >>> trivial.  It might be as simple as adding a lsm_prop to the
> >>> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> >>> and not just a u32/secid.
> >> Indeed. But with no viable users it seems like a lower priority task.
> > You need to be very careful about those "viable users" claims ...
>
> Today there are no users.

That you are aware of at the moment.  You are also well aware of my
feelings on this issue and ultimately I'm the one who has to sign off
on that stuff.

> There are other problems (e.g. mount options) that have yet to be address=
ed.

The existence of one problem does not mean another does not exist.

--=20
paul-moore.com
