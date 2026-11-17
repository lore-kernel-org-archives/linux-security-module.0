Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794943828;
	b=LdAiXn+Y+pQSL7QU6FYxs9FNphPZ8reCQI1hpzTNEJoO0GBEoDO3wsubodHjJNV21NOH
	 hP77ErOLWcnbbpemO9l5L9SiCyZJKye8LHb06W4WP1gV1JnNDNWFYY9LXsWqG5jjDqQjT
	 ybhYqtJBUeh2I4TJunzHRQYa6Vyz5qpXB+HN13Jb3qzKYyS7pmzI5753tB6soUh9bRVPj
	 o9eb070BMl058WbHOBfFCVJHXPnh4N1k9avifAyvoVMrpxKIze7/2His/NY35nV43KZ8k
	 gP8bJaJkfD5Zsyv9NAtZIdh0c7/bpGIvpY88XBOhMhELfAyHJbB4/oblp6/qGzoOKsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
	b=tVOuWurzBwVuha9GbKGqi2fvLc3HL2Us9+nRgiO8qXJwOClsOfu9eHBov5Xcm2X27jS7
	 joyqIK2am55MIjXCxLxgkdVqp+jH4iuRDx2lY+EgQrVyqINKQniRe7bHZ39Jds5o0G8Ff
	 WTJlBSNjp64m9GBAUvn5V6h8N5+ifNrJYusY8VN/gGx1JMeGFtBX85AtUmsSPCegRRt69
	 d/tgUxZDf4Yf2pHuGXZcvH+QVxTRvu0mcKM/VyZ+aGjB9HlsmXJX4+6KNHWyoAqPvXxW+
	 H22dGKf6lY4Xx23yfWXBzRrYyc1Z1wJB/hOX/W0U+bSewghGCloeervLKeXmRKhrhGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=VR8IlJuU;
	arc=fail smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A4606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 19:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=VR8IlJuU
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89d6bd67045so50275b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 11:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794943827; cv=none;
        d=google.com; s=arc-20260327;
        b=kvHQPBsBaalJYlyq1lc7KePmcTp3L74r9KkMR25tJhrTyVYEW+2YMCM65SGeIhEqBo
         sReokils/zTDxUbMT/IPXQM0NfKPsvNQk1TAPn212uW6ckL0Bdriuyj6jPGx2ObYllGX
         pBYH7vvd6ydBTByW0sDCLYc7WfYIrIRV1wL4cxuX2z8GG9Cjujn9BVXCxk+9JDp7F58z
         2jjv2IrYSu/CbiDnLikWeLk+h3z2TgeFmOJ7ilwf9TUM20LhypepfJwW2+iMUu3gx/cE
         o40jHwIxzSXQSQppVeyHDEN9XKRaDl2t/i4ekCBrs9KVaGJHw6AayoN0iSyC1LaEPdjw
         AdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        fh=FU7pYq31Nb2LM/gf8gI3pitf/LgitutNIArCs5IQ/rU=;
        b=kZ9Djr9zRxt45xlkkcgzY1DKIdVkTzIncgI916wem1NM+BovtIkAXIZCHI2tYWS24Z
         l13RKk4oOYrA+01NFH2MNcyLh9KKKYput5Oj13Yk18t28JLOel/U4fV/BJpFg3IQHdT/
         YUk095OvU72VWUCd9XgaL/ayZY47usqmFmKlF98II4kvKHrWE4L9pYqrKYALdukapHIc
         8U2AgE6jFWhLVDj46hZdRC3BSvuUO1itvZKuaGNIyAKhxETcQ3cLuObza98QvPuJEuFH
         XqaN8EUX3SreImtM/SsP2P8U8WbYSAPz6VAtcyb7bwHMW7RhSk53M9cIynYkakAcFAqy
         BVVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794943827; x=1795548627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        b=VR8IlJuUxEu9TYzVDniE5LhVZ+4g7Nr7Fd7jiQAG2y+N/K5TwpW3dJQNxvjxL9x9Yc
         +/LAooYdXV5cRrLaQgZlAAgRbONAt9gBIuqKMTtyIvJByYGewNc0cGzjkkJlCyenH09E
         73gfP+kxEkfcIEEdvAjz8Xt6zrVvuiIIqhOx1qZYt6o/SQYoeIeiSGiuTqScWZhhCCO7
         U4QMhJAeN1EXrwhX92FMUIb7d+vlrGGqcG+Tvg2bxgxRo6DIj1686baaVBKFXKA2ef6+
         3qPQ6s2zWSAqNdbNHheWFCbTUdmtVaxhlKbtz/qkAp7qAPyaoR+Xq638oKhLGTwZ3fjO
         gNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943827; x=1795548627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        b=0jwJrfUw2cd51kudQrd6wLaJ8nLBlfbqM78xies+SQ/BIddWyWnuesu/FuFLn0nELs
         GxqPTcKec9w+7G/s6AIqDyNS5tEUoxrWDsY0qZp3H78G7W4GP+XpInYsP5SMwg0sbYYS
         zT5iHdPMKGHpxgMtis4OXcuPgTG4xtJuazR/l064tcdw7OR172QKtnoN+I3aB3t8DTl1
         01tu6w1t5fu7UE0+l+fUaglXP9uhdpGlcbgdAgXwNBgP07eC8izo3+hPycWkWTQNWYsI
         0pvTTNJFnf/FwTju2Sp8qO2ZBSbP97nXJf4hNSLXweX6fWXEG6hEC/GpNti+Edp5FJNJ
         W+9w==
X-Forwarded-Encrypted: i=1; AL+hErEhvxzYQ9ylOHyGRe4UlwCyF/MYHh2VdDLBg6izcKsgbeNs9F16UxDiDHySw1lMSzX0GJwGeM2VHd+EPsG9xcRA+7WwIxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EfvrwT8kIukXFxHfFWKNeP71LXZnv/Ee48NK8ewiGOdECDt0D
	BPhhFuzzJWrrlywPuPC6rWDQ3gApVWtndKD6ptaDdcw22dIKC54r+ZDUa1Ju+EkFVhy3MZ94gh+
	xz9SwO7bZ6TvxSe2gdW/o9yhhIN4aMKCEZCLM8mJv
X-Gm-Gg: AYBFou2kc2tEljqaXc2i9VSqjOSMkf26AJFyP4r0NcQTh6xsABaEsARpYNTcYx01T4V
	xVWf07Cu1lgxIrvYT7hpWEpdigYB7nrpi12rdbI5crpt0mFKzDF5ZovALp1BAHXDGa9TRybUfSk
	+XCytm02IYM+nLHNx0yTjWbxkTZXUnDH9Zb5YPAKsf5HLKPqt+w0hKugEWAx7qHE2m7JJy40LOm
	mh35GWQ0se7CmO2ShylavINIjkmFP3dsYi1adgg2/FGhr9Mv6R7lf913Of7LDok9W+z5P6SHPh4
	KlA6nh14PW43UljwQpCC6kMASxaQ7XhUtdivrIsoSGZIl4s3V030eh9H8wRZpAE31Cfonaqt4Sr
	Q5ZlZdWF5TMuAU09fFMg7+kGcO8MeYm6t3prBFusCRyD2ePY00r4cjZSRMksFr8myCrzO
X-Received: by 2002:a05:6a00:1f11:b0:8b5:a10a:a3e8 with SMTP id
 d2e1a72fcca58-8c457e2e17amr2269626b3a.44.1794943827559; Tue, 17 Nov 2026
 11:30:27 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com> <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
In-Reply-To: <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Nov 2026 14:30:15 -0500
X-Gm-Features: AclHuK-RtKReAlxzWgT2ghpIFsZj6qbY4_JP5P0ehVqwzT5eB9L_2z4RTCFLPcA
Message-ID: <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wro=
te:
> > > >
> > > > Hi,
> > > >
> > > > Thanks for the replies!
> > > >
> > > > > LSMs that need to provide a stable API must provide an abstractio=
n
> > > > > layer between the LSM hook callbacks and their stable API.  The L=
SM
> > > > > framework is not responsible for the stability of individual LSM =
APIs.
> > > >
> > > > Understood, that lines up with my expectations. I think the biggest
> > > > thing here would not necessarily be stability guarantees, but rathe=
r to
> > > > make sure that the eBPFs fail to load when the compatibility is bro=
ken.
> > > > But that's probably a problem for the eBPF side, and not LSM, I ass=
ume.
> > > >
> > > > > So, in short, would it be possible to send a follow up to Daan's
> > > > > commit and move `struct mnt_idmap *idmap` to the end of LSM argum=
ent
> > > > > list?
> > > >
> > > > If this is possible, that'd be nice so that we avoid this breakage =
in
> > > > the short term, since the change isn't in a released kernel yet.
> > >
> > > can you please send a patch proposing that and we can continue
> > > discussion there? please cc me so I can follow along
> >
> > Considering the original patch was submitted, reviewed, and merged
> > with the BPF LSM being the only user (none of the existing in-tree
> > LSMs use the idmap parameter at present), I'm a little surprised this
> > wasn't brought up earlier.
>
> Yeah, unfortunately this was missed. Not sure it's surprising that it
> wasn't detected immediately, though, because unlikely someone tested
> an unreleased kernel in production. Luckily, this was still detected
> early enough before the final release and this gives us a chance to
> fix a mistake.

I've been surprised lately by apparently how little the BPF LSM
program interface is tested with real BPF programs before landing in
Linus' tree.  I know the BPF folks have a pretty good set of CI tests,
bots, etc. but there do seem to be gaps relating to real world usage.

> > Beyond that, from a style perspective, I think I prefer the idmap at
> > the front of the parameter list in most (all?) of the hooks where it
> > was added.  I'm not interested in moving it at this point in time.
>
> So on one hand we have a real user pain which is easily fixable
> without burdening kernel and LSM subsystem in particular, right?

Arguably changes that negatively impact code style and readability do
affect developers and maintainers.

> On
> the other hand there is a minor issue of argument ordering with
> mnt_idmap preferably as a first argument. I get the preference, but I
> think fixing an unnecessary (but easily fixable!) user pain should
> come first, don't you agree?
>
> Can you please reconsider?

The user pain exists because there is no abstraction layer between the
LSM hook callbacks and what the BPF LSM makes available to BPF
programs.  That's a choice made by the BPF LSM devs, and while it's a
valid choice, it does have drawbacks like we are seeing here.  Changes
to the callback arguments and/or the semantic behavior of the LSM
hooks are going to continue to happen regardless of what we do here.
It's better if the BPF LSM figures out how to deal with problems like
these rather than relying on a set of bandaids at the LSM framework
layer.  If the decision is to push the pain up to the user to keep the
BPF program interface thin and flexible, that is their choice.

--=20
paul-moore.com
