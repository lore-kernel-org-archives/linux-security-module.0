Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7D36F90E
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565589; cv=pass; b=BLNX3Rue8EqbZTAaI3F+LNlzZV7aeooIJ4PNjGmffdiLVvJJJa7MClVntDNMan9k6ER0/fnebsgwMh4yDX5E50JB5gpuMLNRly9fl7Ozfgu7E/xf7BQ8PCWPzaFkp7mebQ/L8uVaphKmyVjqW77NINFjIlI0ajIgXMGG2jJ2Ock=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565589; c=relaxed/simple;
	bh=6vtPzW3BLAZJvbosFnepUcNFqKS8viZR58AfCdehFwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS5AcHdpJN+Z3ab8typhTWQoLjA7gu+9wUTrp4lddb8FB27VQh9SsC2D2CLpdneZF2GKIyvZdeM++f49I19IOIHasWhgdNCOLzyAHSTFHXyWhC23fNigQUu7oUql1y8PdDVCtkL09HOgdZgsBiQQbOz5Rp/Mmop77gCOoauSvn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HYw1pfDw; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HYw1pfDw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9aea40d799so578684a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 19:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783565587; cv=none;
        d=google.com; s=arc-20260327;
        b=jtcoxwT69UyYo35mvX88iwTYIydvdJ+TlpNg6SuNe0/VntfJKFNWCcxn9KIRchjzbB
         iyQ2aBXVHDK+S0nmNh2oRY8IPmBt1ldp8qE3fY0xaOK929PzF/KCNU5GfR2vrW7TqUE8
         B0JzTXSIml4HyCJ0pQzogasI8BVXLM3yyfYqsOSelpqhzRp3eDmN1PZ2XCrKIHV4HkxE
         H6pDohhr/uYqTrnme7az22ozaqIXL3hzCyXbT1NYsK05ovYUGyPBm+1zi6OcEBDoS2I1
         Q7zYwShinkkviLmofSw/GY0SUchvrd7KPQdcgSEkJKA7ruLUhVrjQ1VOwjC2EGLO1V8/
         uW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/rnSd50l0fY6Fhy3RQxnUKN81hq3H8y2AV0VfD5Brc=;
        fh=rM7ft62c4pYRcnbqAE4GknJcA8PX4YrfX93MdE0bBZ8=;
        b=aF629x+pZfs7vFCNC5zBp1314MX+0m6/lQjhBfOiSSasMc2/Y48DZSDzFqi1sV4mWA
         QrdUyUpzcaGtZf77em+Z+HGCbBHm9m4Szyl0isl5FpBaFK2XH629uf4Yed32SGprdsJ5
         lPn1y3gyc0zMeaprJpJ3BotaM97J6h2fVu4QrybMZAJjAkTfgYPT97RQp+8MrCYJIurP
         ZbCkWcse+kijlSgEYKbvHaYw5T611BW2FTnhze/ZFZ1DBFlk2vYgUCFIu8zq0mKD7/dr
         SLjfvhRAcGE1T2eNtYACdubkskMNQnbcQVoUPrb3Zo99fs+e7tQIKo2HOhxTF7V5U+AN
         3W5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783565587; x=1784170387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/rnSd50l0fY6Fhy3RQxnUKN81hq3H8y2AV0VfD5Brc=;
        b=HYw1pfDwhtyBzauG4n4g8U4mokBHhzuIoV/N7ItbzXiK98HSzREteb2B7oPJNLeJH7
         togrJI+B/3f17ERrTQZtV/8v2d4yyTapr09CUO7VO9Q+S3gNgATPYao+IXJMJQsoWZMY
         J30xEZl9YN2wTJ9WZJ1UVZVMV1WcZKF1rvBGMy6KN2Z9WTVX6SIQTFhz6rZYiHkaHH4U
         1hd/F8dfTeJ8clt5/BUmaNY/1nAI8qoUlqLAV4fQ84a6E6hgh0l7jgh4ASDz4R9dbAfv
         NFH/3M4uYDHaxEr8FQbIH+h6b7D7X1iaKXDgrcLFlqRAZ2bqwLxQwKuTa9HZwDAou6c1
         Zzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783565587; x=1784170387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/rnSd50l0fY6Fhy3RQxnUKN81hq3H8y2AV0VfD5Brc=;
        b=Oc91pqRMN9zedYbzgisDQCNyZgcqat8i7ovhMWUwuGobQzTUShBegh/F9xZPDimZax
         8Bg8a+3A38pwY078IN5r4efqh+X5IDo3VIwZFR/PlIcxC7EPW9ifkhhF1rdUAw6R38pc
         rRlkvs1LZdP8jKaGJmIkwyJfuWvHcnUeox0ovxEqbo/M+2xcKrogJS2xDGc1BJ0EuDe+
         u/lSLBZ/u1sFt+c+VrPMJZ3w0XAnuUVRwOm4zOY1wqkw9e/DVBmB65AH10esAeR3CMpr
         vi+p2yRzpEZ9BrwjgyjbEQMp01H3a8kcq7b6cbyGYFutv57zqjEgeZDf0lUkKUX+3tx7
         scoA==
X-Forwarded-Encrypted: i=1; AHgh+RpBxK9ABzpN+ZKfZXviAQmiXz+4TMy54CtkRbMIsHAqIqu73VKpUGUN6YYrRi3OWgjPu0ZWqxsYNsRSD8dyZ5rHVVUh49g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeQcPkzGgnwz6+RiIPPDOh1J6yfkl2pNwphkolKBPHH1ji/O7
	bZNW8ZL2LVQMSu9JJb8qox9gtx8JxI4Gbo9tHSDIigdDsmv968ZU7cB0Jrj70c3FkcQDBdGBv3/
	suDFG4rKS9RgdoRRM1o889Hbku/UbUUBzwmIemq7OsSgVM+x9sSOeIA==
X-Gm-Gg: AfdE7cm3NHpLURlv18ZmOMAGR1OxQqhr+nNVSclkxIfPAledI+nVsnaAgIXfzghXZeR
	LerwvRVcbKBzGdsJZsuqmqAjalBcBroCtQJLWUQ8icfdZuDQno/y6Pqi4T/NPr/ZmTZHBYsLcLc
	ZLcNluck9V0uIt3jCO8x+Vbt+9cQJ426KNJPIv99FLWStK7kUSJ+hRSi6PwvXmXtov+jnNW5+Ko
	/E1p19Lc6YKBfZYBjg8qCOuURhNWracBRJUvGuppNaD3w2+Ng1uNR4BNj4QZjviMZNWKm7txplT
	MqYNCaM=
X-Received: by 2002:a05:6a21:490d:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c0bd1ed9cbmr5867993637.53.1783565587305; Wed, 08 Jul 2026
 19:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
 <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
 <20260701.aeghohNoe3ek@digikod.net> <CAHC9VhSYJPdn3Y+C1s8VExQ0DhV9Kg-NZiWhhOA657JeHDnzjQ@mail.gmail.com>
 <20260702.ierahzaiLub3@digikod.net>
In-Reply-To: <20260702.ierahzaiLub3@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 22:52:55 -0400
X-Gm-Features: AVVi8Cet7E8ABcl8Ux2CRhKcxFYH8qIqCjMSTSpB0Ub1kYwM9xMPWRzNBAjhVgY
Message-ID: <CAHC9VhR62pAC1CLUhGhVTVpmCtkC3GeqHGdxbjgNhDe54NrGYg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com, 
	andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 5:53=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 07:32:57PM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 5:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Wed, Jul 01, 2026 at 04:02:36PM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 3:55=E2=80=AFPM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > > On Wed, Jul 01, 2026 at 09:49:07PM +0200, Micka=C3=ABl Sala=C3=BC=
n wrote:
> > > > > > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > > > > > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > > > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <util=
ityemal77@gmail.com> wrote:
> > > > > > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wr=
ote:
> > > > > > > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl S=
ala=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Su=
ess wrote:
> > > > > > > > > > > > > Create 2 kfuncs exposing control over Landlock fu=
nctionality to BPF
> > > > > > > > > > > > > callers. Export an opaque struct bpf_landlock_rul=
eset preventing callers
> > > > > > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > > > > > >
> > > > > > > > > > > Generally speaking we don't want to provide APIs, eit=
her in-kernel or
> > > > > > > > > > > at the userspace/kernel boundary, that are specific t=
o a single LSM,
> > > > > > > > > > > see the LSM syscalls or the security_current_getlsmpr=
op_subj()
> > > > > > > > > > > function as examples.
> > > > > > > >
> > > > > > > > This patch series is not about the LSM framework, only abou=
t Landlock
> > > > > > > > and its specific model and use case.  Landlock using some o=
f the LSM API
> > > > > > > > is not relevant here.
> > > > > > >
> > > > > > > Based on a quick look the patchset enables BPF programs to ca=
ll
> > > > > > > directly into Landlock.  For the same reason we discourage ot=
her parts
> > > > > > > of the kernel to call directly into individual LSMs, we want =
to
> > > > > > > discourage BPF programs from calling directly into individual=
 LSMs.
> > > > > >
> > > > > > We're OK for a dedicated kfunc to call directly into Landlock (=
with a
> > > > > > tailored interface).  Landlock is designed around its syscall i=
nterfaces
> > > > > > (well documented, tailored, tested), and this would be a new us=
er of
> > > > > > almost the same UAPI.
> > > > >
> > > > > Paul, Micka=C3=ABl,
> > > > >
> > > > > I think there's a cleaner way to resolve this.
> > > > >
> > > > > First, walking back my earlier email: I was wrong saying that we =
need to call
> > > > > into security/security.c to check whether Landlock is enabled. La=
ndlock's
> > > > > init only runs when it's in the active lsm=3D list, so I can just=
 test
> > > > > landlock_initialized directly. There's no per-invocation reason t=
o route
> > > > > through the LSM framework for that.
> > > >
> > > > The landlock_initialized flag is not really a LSM framework API, th=
at
> > > > is still Landlock specific which is something we try hard to avoid.
> > > >
> > > > > Rather than routing each kfunc *invocation* through a security/se=
curity.c
> > > > > wrapper, I think the right place for the framework to be involved=
 is
> > > > > *registration*: have the LSM framework own registration of an LSM=
's
> > > > > kfunc sets, e.g.
> > > > >
> > > > >     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog=
_type type,
> > > > >                                         const struct btf_kfunc_id=
_set *kset);
> > > >
> > > > That implies a set of LSM kfunc APIs which Alexei has been deadset
> > > > against (see other ongoing threads).
> > > >
> > > > > Each LSM calls this once to register its sets. Because registrati=
on goes
> > > > > through the framework, the framework gets to decide whether to ac=
tually
> > > > > register them so you could, for example, run an LSM while explici=
tly
> > > > > opting its BPF kfuncs out. (something that should be done at the =
LSM
> > > > > framework level).
> > > >
> > > > I'm not opposed to the LSM supporting a set of kfuncs, see my comme=
nts
> > > > in other threads, but we should treat these kfuncs just as we treat
> > > > other LSM hooks today because that is what they are: LSM hooks that
> > > > happened to be called from within a BPF program.
> > >
> > > What an LSM hook is or should be is the crux of the misunderstanding.=
  I
> > > explained my point of view here:
> > > https://lore.kernel.org/all/20260701.jei4Paej3zen@digikod.net/
> > >
> > >   LSM hooks make sense because they are designed for a specific subsy=
stem
> > >   (the caller) and their goal is to return an access decision or to k=
eep
> > >   up-to-date related states, which means that their API is designed f=
or
> > >   the caller, with its own types and specificities, not the other way
> > >   around.  This case is different, the kfunc is strongly typed and ti=
ed to
> > >   the Landlock (subsystem) semantic with an API defined by and for
> > >   Landlock.  I don't think a multiplexer would be a good idea.
> > >
> > > I'd try to explain better: in a nutshell, an LSM hook exposes a subse=
t
> > > of the context of the caller, for any access control system to be abl=
e
> > > to make a decision.
> >
> > That is true for some LSM hooks, but not all of them.  LSM hooks are
> > really just another name for the functions that compose parts of the
> > LSM framework API; it isn't always strictly about access control in
> > the kernel.
>
> That's why I wrote "in a nutshell".  Concrete examples and the rationale
> for such hooks would help.

See the LSM syscalls and the discussions leading up to them.  See the
LSM namespacing API discussions.  See any of the hooks in
security/security.c that aren't strictly about access control.

> > We leverage the "hooks" for the LSM syscalls, we've
> > discussed "hooks" for implementing a common LSM namespace API, and
> > there have also been early efforts at LSM policy loading via "hooks".
>
> All that is doable, my question is: why a kfunc multiplexer?

It's an interface into the LSM subsystem.  Don't think of the LSM hook
interface as an optional, or nice-to-have, it *is* the interface to
the different LSMs.  There are some legacy reasons around
configuration, and some of the userspace APIs (which have been a major
source of problems over the years), but we generally do better when we
find a way to develop a unified interface rather than separate, LSM
specific ones.

I'm not saying we need a LSM version of ioctl(), but we really must
look at developing LSM-wide APIs (yes, that includes kfuncs) first and
only if we are not able to develop a LSM agnostic API then we can
fallback to LSM specific interfaces.

> What are
> the pros and cons?  I only see disadvantages for now.  Please, convince
> us.

This logic is backwards.  Work to develop an LSM interface first, and
then if we are all convinced that it isn't possible, or practical,
then fallback to a Landlock specific API.

--=20
paul-moore.com
