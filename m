Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6B40DFB3
	for <linux-security-module@vger.kernel.org>; Mon, 30 Mar 2026 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774832211; cv=pass; b=nZF6yjTmN8lJBVVqExXtRML4838gblJA+SsrePj3qFYXfGPM2zojIQuu6JcrJAh3qWkb4e0VAcrpCh6rPQcIZqI4Tg4QN1IF+U8TNSwHoOTnHF4d91oTiyMmpGHPm85bSdFt/EbQUcISaTMvEhv/6rDwAWh2x99HGZzqpMuZFzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774832211; c=relaxed/simple;
	bh=+gY0MT6MJ5l44x6W7iWbR1pX77B3dO+X60SXXqY5wW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+wgsUvQhI8zznG9iqs3pcZzhHZ3Qw23+mHNP6ZWwMwXUHRY5vg9RrffSQ3uZ0G5GEbeE+X5hQKBEzaevdl9IC6GuRlIdrdbrxCOXjbqlG3QLa9Ei7Aqsz41WyuaMeIrCynxLwWAR1rlXyefFgbVaar2pUhQM97TctNfYNKxHzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V9CrVeKo; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V9CrVeKo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d9827661bso539409a91.3
        for <linux-security-module@vger.kernel.org>; Sun, 29 Mar 2026 17:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774832209; cv=none;
        d=google.com; s=arc-20240605;
        b=Qe7Hadx3aw/g0EZKHs+x9MJJytjuwwiCBBL/Km28tsNxB+I3HZ9J01kIdK8ww4C59y
         K6F8RXBlRjj8A8wd5O3ekfqetNjz5r5oo9+KMlkJFw1ATZWP2UMw4PjxgPnxrm3/dKwv
         nS8EfFOjcuDo4WWewuicZjavUFeqnJuhmHBvhFYuxkrMooxOyOMMhjgYJsvfrD4AVV4k
         VgzCWBkLe67EAF9lTr8TqYgHSSHjDyIhuESRpohl1OlDuLagB+HqRRrzX0HDS5x57Yc2
         eE4YT57bUQEXA07oUh9frXf9xqBf7drkndQBUshAxbUxjJxAiFUh+5ia5VmXU7z4saLr
         /o1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oVsIusJ/ds4O6uOVMLEimKHm0Xs+T3Tfxu8zJ0saMKI=;
        fh=vIqPEBGPJ2hfPACo/ALO0913AC8wfsLl+8Nmn0a9BBI=;
        b=RtEdxTLe9pMVjf3DXbSVXwrBgzAcGW+5+kX3nwtPeTkMue/M5wkk9kqBo80WfX1gT1
         sKtsWOBkepgISIk1PWT/Nsm4RlkbgVMMbRLFd1F/P/li2cExBa9e4Vwbm8ko+8ATfH4A
         OKbohgAJOtmNerZl8pEKCd9peHA9mhBoZxHXoVm2WEWYCjMKRLR4xOWoCQPuwULywJ0r
         X+7wLou0xwY60Q2AI83FN9Y4P26ij2jfd9ur8PcK8VbVPU5Hr/ZA26bBLxRSXCw7fJL8
         I36L89uuv28vASWF1oMkC9C5fdQY5HJ3HqAzQW/ENAnd0ap/kICP/4Re13hQTcsTQiSq
         5WqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774832209; x=1775437009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVsIusJ/ds4O6uOVMLEimKHm0Xs+T3Tfxu8zJ0saMKI=;
        b=V9CrVeKoazfPOlhlmWeQqRZwc/zkUbMkkJe00sdGgfBhzkHL1cPJOwRRItRY9Pd7k+
         qoV6SoWYm2Ignau1NFWRLXDKi/nVrCAhkz0XD/XvGmtodhMbyFLZg5f6GLql2UrbTsF+
         BLm4ewxoBs0GA/Fq1cpm2gX3lnXEZJRJMIcboFv3jaC+iN3gUwENtIcg+86KMlWmi5Xw
         PK11cjIUOixxtsiYJ2Voszy35qfdUqKs9a2XuKxnF2JLwOWY5CWZwHj9qHYFGVERgt9S
         ZvDmk0cT95S92EOdvfgyD89zaTvfm8JSDjczbJjfSYEQ1K8gTGaKRlkrf8dD+zRkuZLk
         ZKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774832209; x=1775437009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVsIusJ/ds4O6uOVMLEimKHm0Xs+T3Tfxu8zJ0saMKI=;
        b=brER/p3AhgtsrR+2Z9lttwgi0lC6lumfK5WK+u1tKLBsjZzsfwrHs9fp0+6dmkmDZW
         kwj2ouo/GE/HqpPTaChz7fMTCBJdU8jC7go4rGDP6GfxoADI8ohFVba1aX/gWRSh4efk
         TinhbN7VU8QVUPXHK39fg4/xFlzGzWSR0X2Byo148YnopqVMZ1DgNnk0E28/55NDhyUk
         CstJbjcD6o13GnirJAELWpgJzRFg6I5JOLceAbibKe9QVpQt/eimjKUCT4cU0CexE2vE
         5yLoECDw+uhhm2mo9yAMgQ9M/oXPtaeRSZ/rLr7sA9RnfSVqQlMhq91GEFDPfL694jEV
         PnUw==
X-Forwarded-Encrypted: i=1; AJvYcCVZg5Q1DQ4hMq/7y5w46Fbk1MyLs23pMFkBaVaJ6cerwDaUBnmeEGGzs6c7Sr0MePOLQXGgmJq88IPKq19PEyOqzrERxeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DmV3dcTtFBD23n8yAETHGZDm5qI2ZW97MtpgmgT5ia683Azf
	qJ8q58lJWgkESz09bXfrju72CPJF0u3nWiMpdrDxMfVd4gRlNtjmDn14r4Fqwn358O69p3tQgdD
	gYt7a4Ca4WTUXaJ9/FqI0mHLRT3K/qEQlza182za/
X-Gm-Gg: ATEYQzzWgndeAXfPXIgk9c3a8DB5+5WNFvoz3p9MOS7NEaT5vZnPFS0p5PZh2c3xkbZ
	tlZN/kFMIfn5WFxVBRnVqYTTQ2fYmUxZ9n9LV9I+Mo/ee/VU95TBYDIjA6BWEAhbn/vMK13uKuA
	4fPTNSddG1UFqd612E5y+wwaUwE0VuETYqD0+UuBHvb+xHUlfmEprr/gT08HRNNWDc3+f4cU56J
	kK9ZoAgIf6lzROEr8UsCERNDseFfY30H2cYk5hJqamFPzHObZPzXyryQYCJ0rj3NoohsboKJc+O
	S5heboY=
X-Received: by 2002:a17:90b:558d:b0:35b:9d97:63ac with SMTP id
 98e67ed59e1d1-35c2ffa82e2mr9906829a91.7.1774832209113; Sun, 29 Mar 2026
 17:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com> <aclOtS61nbG5Wf3p@wind.enjellic.com>
In-Reply-To: <aclOtS61nbG5Wf3p@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 29 Mar 2026 20:56:37 -0400
X-Gm-Features: AQROBzD9FzEFkyimY2Lccn3_z1xWQGyQq7Ywtdybxzj40CoXr2I98B9x82Oe6xE
Message-ID: <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 12:09=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote=
:
> On Tue, Mar 24, 2026 at 05:31:09PM -0400, Paul Moore wrote:
> > On Tue, Mar 3, 2026 at 11:46???AM Paul Moore <paul@paul-moore.com> wrot=
e:
> > >
> > > I'd really like to hear from some of the other LSMs before we start
> > > diving into the code.  It may sound funny, but from my perspective
> > > doing the work to get the API definition "right" is far more importan=
t
> > > than implementing it.
>
> > It's been three weeks now, and I haven't seen any strong arguments for
> > supporting the clone() API at this time, so we can leave that out for
> > now and stick with just the unshare() API for an initial attempt.  We
> > can always add a clone() API at a later date if needed; going small
> > and expanding over time is usually a better decision anyway.
> >
> > So to quickly summarize, here is where I think the discussion landed:
> >
> > * Implement the lsm_unshare() syscall
> >
> > I expect it would look something like 'lsm_unshare(struct lsm_ctx
> > *ctx, u32 size, u32 flags)' with @ctx specifying the particular LSM
> > being unshared, and @flags being 0/unused at this point in time
> > (unless we can think of something we want to specify here).  Like
> > lsm_set_self_attr(), only one @ctx can be specified at a time, so you
> > can only unshare one LSM at a time.
>
> Unless we miss something, it would seem that there needs to be
> additional thought as to how a process moves, atomically, from one
> effective security configuration to the next.
>
> At a minimum, if we restrict ourselves to the model of simply changing
> the namespace for a single LSM, there would seem to be a need to have
> a 2-step process in order to atomically transition from one security
> model/policy to the next.

That depends on the individual LSMs, they are free to interpret the
unshare request and handle it however they like.

> The interim between the first and second steps would allow an
> orchestrator to configure the new namespace and load new namespace
> specific policy into the security namespace ...

As discussed previously, the LSM policy load syscalls might include
some LSM namespace options. However, I first want to focus on
finalizing the most basic namespace API, which on Linux is arguably
the unshare() syscall concept.

> It would seem that the flags variable might be a good option to use to
> handle this 2-stage transition, for example LSM_NS_INIT and
> LSM_NS_CHANGE, respectively, to specify the initialization and
> execution phases of the transition.

No.  The lsm_unshare() syscall is intended to mimic the existing
unshare() syscall as a single step process from a user's perspective.
If it returns successfully the caller will be in a new LSM namespace
as defined by the individual LSM specified in the syscall.

> The other unanswered issue, or perhaps we missed it, are the security
> controls that should be associated with the unshare call.

Each LSM is free to implement whatever access controls it deems
necessary in its lsm_unshare() callback.

> Will there be a new LSM hook that allows other LSM's to veto the
> creation of a namespace either for itself or for another LSM?

I would expect the lsm_unshare() syscall to operate similarly to the
lsm_set_self_attr() syscall in this regard.

> Is there a need to have yet another kernel command-line parameter that
> would completely deny the ability to create security namespaces?

No, at least not at this point in time.

Individual LSMs can decide how they want to gate their own namespace
functionality, if they implement namespaces at all.

> Is CAP_MAC_ADMIN appropriate as the required capability to create a
> new namespace or does there need to be, for security rigor, a specific
> capability (CAP_LSM_NS?) that gates the ability to execute whatever
> form of the system call is adopted?

Once again, this is up to the individual LSMs, not the framework layer.

> Should there be an option to completely compile LSM namespaces out of
> the kernel?

That doesn't belong in the LSM framework layer, that is up to the
individual LSMs.

> > * Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
> >
> > As discussed previously, this allows us to move a process into an
> > existing, established LSM namespace set.  The caller cannot
> > selectively choose which individual LSM namespaces they join from the
> > given LSM namespace set, they receive the same LSM namespace
> > configuration as the target process.
>
> As an initial aside.  It would be assumed that a positive result of a
> setns call would be to cause the calling process to atomically change
> its security namespace set.  This would further suggest the need to
> have the security namespace creation process also execute atomically
> in a multi-LSM namespace change environment.

In the setns case no new LSM namespaces should be created, the process
simply joins an existing set of LSM namespaces.

> ... That is the concept of whether or not a setns
> call, for any resource namespace, should also force a security
> namespace change if the security namespace of the calling process
> differs from that of the target process.

That decision is left to the individual LSMs.

--=20
paul-moore.com
