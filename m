Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027A1A680C
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544637; cv=pass; b=qHCSZFczScWXMWaJZFBiPK2oaAcytJOSygqV6Vy/dboJcxY8CbZzV+2tM1TnmLS2YQCUjb2beDbcUx15bbUETiKBqxKsvh6zcnJuRc5lmHYUJQEisux8Mkn2Ozq1IAum06ACtXq0Am7bBGtKwms22HSOHzmsgMrDlMS8O1RwJAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544637; c=relaxed/simple;
	bh=TPmZuENf+xpPALFd+K4N9NZreHNFZW4jsYUsnEcVgMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzpU85f5QbUkuRCLR5bmyRpU8RM+wSg7efP3qO7Kl4LyIETri1uaWFgmwCJo1nQObV6gmUKsZHwWvr2QkS9uqVi5Vw4/0a+WG7IPypZb09fw58IRLI36Ps+ZGVNw6fsOEWdb8rVqcd7p2ZTcZF53VMxexmBDM3TnP1bVzd8X1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd7bNDFr; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd7bNDFr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2294009a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 05:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772544636; cv=none;
        d=google.com; s=arc-20240605;
        b=LxoRQugsHvr06Uf80IYmhjOTZmG8VM4QXqfvEPHgbkHvXZBSkI0KWW5qPLv7yd85w+
         JpLvoEz8ttYHGW3hiuXwcc/c0nXwUSKMWBp4bgYUsuvAeRnLPaDrL2luTuok1xiTgKmB
         e+8w328zXrtYJUrn39sDSagWi/SHiiEH/IlRNBXotPb2MwtiGdSleGOoqPgmk4bDYC1e
         hCcbvvLddc71Lv1JVx7+aHpCbS612t0LdyF6uBak78BuuabvxZ4oQnZijVu7A1Pokm9A
         VPgrZAmUVrO+BRP2/joBkGvWJ3zcZaJ79VvtwifLjJObXOUrJMytgQjlKp4o4i6wBW3A
         F1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        fh=bmdDGKnlVvjZrik9saqkaKxuseHUWq4uxLz7DIUryE8=;
        b=Y7MavmYdQMlpPchbZ2DvGGd25Eqvr1rLZNm78EyTc82IIEaRn9ITGIfsf5JOm56kc7
         LuqwqRaxD5ZdjcZp/EmB7QR/ie8cTkBr1HvXwPUo/rugaUSwbUzC0h0G8QJouM1/LNmA
         2CPOdrQLR25PeC8pPfjItxKBC5+4aYNUKH0TpMdkpj41t6XSg0grZJ0Daugk7y9JGkr1
         aD6TX0SC5XxvczSJBrSii+8ifW3NY62CaYHgBmVdjLKk6d0JCcpArF0maekRhXltkoVS
         wg7kYNmFH0qTej6OCdzYpQy/JAjz1lq8LIP4wtDR7S2jYn1dNCO96KLFC8Rf9SeIAb9W
         pXxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544636; x=1773149436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        b=cd7bNDFrtZ9DOd7Hf7c9wgs0c2t3rBvGgP9FILNdX3drqHcO8BnxYbOwGtDTMn0egR
         he6kb6ov1USUpQpAp7iSZQj7ByX35/mnI2r3oeIvISrc28JFPFE6ZwNwm+r0NgsyBm0C
         c84StJFOU0+q+E9gwM0BfcGP7CqIhSvp9bczi5mcZ/uleiOCnX2xKJ+NylgF1RfeYVhO
         EH6XqwLjVIfzKqp5Gfz2oDDEPGUX4ihrMc4W1SGZiL9Q1V7bYfOfz3920rZW/QXRY2ND
         sX0CTy5sZB149obp2Pi66apFo6cJIZFa8uYSI1CH2WCOTSXaDhOa5iTS4B3/SCOeCh8m
         0eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544636; x=1773149436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        b=Xus5ICZzT07x9FJvl/S44k0hewUlu847u7uQH982pwtkgJRkKc+TLvCVJD7YegJSCf
         06D2xRqZEVYA/P9eWE+3LYGcZbuiJp5c/dd0/4ObTRuyTgiSr6vOVXiuuhYDQBzRnCbZ
         htgGv1i5eR04Y5sIFobAvQbJlvDLtwlC2aicgZrMwbnNpi4LSFNIvrytAdd70oZAYxor
         ct9hPmzOkUJuqGTOLl6+cA7/GpYcoILEkiqFNRbLjmyFyoIFRM51btg4qvwzqHxoCqXV
         u1+4CbAkcKvmGbHHmUhREzjQkihb7v3hCrzHXn4CHjz9WA3bCPIsj+7Q0Ufrnuchou1h
         UGIg==
X-Gm-Message-State: AOJu0YwDvL+knR7E9SGf21KpsQn4rpd+9AUIaOWZ75ZTxiImKjPPPoeR
	xMxSDqLRlt3d+RcWXQSfOMMf3gmDzByHgQDYN68F9eWo15tfPT1E/YlxVAlWdShrdMiaQTd8+vU
	0wiKhbnqo4UP3QmV+P0Qmmk0b79p9y4U=
X-Gm-Gg: ATEYQzyi+PlKAe0NrO3sFUIc6K4nyJGuWJpA6Qd3pc4QPTqGHfuy5X7HdEMHgusVUvM
	j2P+dMU9pb3vNss8UJMvB1timvstHVX1cEl1YGpellFg8YtQOZoy+qxbRBuucUFLlPklOxizcvM
	xhLo9uttpstgricNl5zK1cyjptD3gAUJVmmt9RFKCTICZpwhdSy8yAi6+ilqRwRq/KPvygCdecA
	eVawKhSGGEjFRF+BwAy9b7IpJwzF5qt/bdGOvu7ImUAjtKZPLK9l0hFm/CnxoBzD6XI9IhGsaFD
	ZWMD88M=
X-Received: by 2002:a17:903:22ca:b0:2a9:42ba:b093 with SMTP id
 d9443c01a7336-2ae2e417b93mr176357345ad.25.1772544635624; Tue, 03 Mar 2026
 05:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 3 Mar 2026 08:30:24 -0500
X-Gm-Features: AaiRm51B24m8BS1lm-W8zAv3yrpHDogeldeLu1r_WUIc-okMyPG_92haWYA0IL8
Message-ID: <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 7:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I spent a few hours this afternoon re-reading this thread and tweaking
> the original proposal to address everything discussed.  The revised
> proposal is below, with a bit more detail than before, please take a
> look and let us all know what you think ...
>
> * lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) and clone(CLONE_NEWLSM)
>
> We would define a new LSM_ATTR flag, LSM_ATTR_CLONE_NEWLSM, which
> could be used with lsm_set_self_attr() to request that an individual
> LSM create a new LSM specific namespace on the next
> clone(CLONE_NEWLSM) call.  LSMs may choose to perform various sanity
> and authorization checks at lsm_set_self_attr() time, but they must
> refrain from creating a new LSM namespace until clone() is called.
> LSMs may also want to ensure that any state associated with an
> lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request is not carried across
> an exec() boundary, however, that decision is left to the individual
> LSMs.
>
> We would define a new clone() flag, CLONE_NEWLSM, which would trigger
> a call into the LSM framework to invoke LSM specific callbacks to
> perform namespace actions specified either by the LSM's policy or an
> explicit lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request.
>
> As with the existing LSM_ATTR support, this is strictly an opt-in
> mechanism and individual LSMs are left to handle this request as they
> see fit.
>
> The lsm_get_self_attr() syscall could be used to get the
> LSM_ATTR_CLONE_NEWLSM value(s) for the current process just like any
> other LSM_ATTR flag.
>
> * lsm_set_self_attr(LSM_ATTR_UNSHARE_NEWLSM) and unshare(CLONE_NEWLSM)
>
> This would behave similarly to LSM_ATTR_CLONE_NEWLSM, but the LSM
> namespace changes would take place during an unshare() call as opposed
> to a clone() call.  This is kept separate from the
> LSM_ATTR_CLONE_NEWLSM flag because the behaviors are quite different:
> one creates a process with a new LSM namespace set, while the other
> changes the LSM namespace set of a running process.
>
> LSMs are free to implement support for either LSM_ATTR flag, both, or
> none at all.

I think my only caveat here is that your proposal is quite a bit more
complex than what I implemented here:
[1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley.w=
ork@gmail.com/
[2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley.w=
ork@gmail.com/
and I'm not sure the extra complexity is worth it.

In particular:
1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
the caller to immediately and unambiguously know if the operation is
supported and allowed, versus having to wait until a later
clone/unshare call and decipher whether any failure is due to the
unsharing of the LSM namespace or something else,
2. Immediately unsharing the namespace upon lsm_set_self_attr() allows
the caller to perform the operation in any desired order relative to
creating a new process or unsharing other namespaces via explicit
ordering of the call with other clone or unshare calls, providing
maximal flexibility/control,
3. We don't need to introduce a new CLONE_* flag at all or introduce
new or changed LSM hooks to clone/unshare,
4. Implementing unshare-like behavior was in fact quite simple for
SELinux namespaces and no more complex than doing so at clone time,
4. Any perceived atomicity benefits of delaying the operation until
the next clone/unshare system call and doing it at the same time as
creating a new process or unsharing another namespace are unclear -
unless we were to change unshare/clone to completely rollback all
changes if any of them fail, they won't actually be atomic and
unshare/clone could fail with an intermediate state left behind.

All that said, I'm willing to wire up the SELinux namespaces
implementation to the proposed interface if someone implements the
necessary plumbing, but I'm not sure it's better.

> * /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
>
> The /proc/pid/ns/lsm file serves as a link/handle to the specific LSM
> namespace set in use for the given process.  A process wishing to move
> into the same LSM namespace set as another process can use this
> link/handle (or a pidfd) and setns(CLONE_NEWLSM) to change its own LSM
> namespace set.  It is important to note that using setns() it should
> not be possible to change the individual LSMs that are part of the LSM
> namespace set, the calling process' LSM namespace is set to the exact
> same LSM namespace set as the specified process.
>
> Affected LSMs may choose to enforce access controls on the
> setns(CLONE_NEWLSM) operation according to their own policy.
>
> * Policy considerations
>
> The mechanisms above provide for three different scenarios: a new
> process creating a new LSM namespace set (the clone case), an existing
> process creating a new LSM namespace set (the unshare case), and an
> existing process joining an existing LSM namespace set (the setns
> case).
>
> In the clone case a new LSM namespace set will be created when the
> process itself is created.  It is up to the individual LSMs to
> properly initialize their own namespaces and load any required
> policies.  Since the new LSM namespaces are created at clone() time
> and before exec(), the calling process, or another trusted process
> using a new yet-to-be-finalized API, should be able to configure the
> newly created LSM namespace before exec().
>
> The unshare case is similar to clone because a new LSM namespace set
> is created, but it is a bit more challenging because unshare()
> modifies the calling process's LSM namespace set, not a newly created
> child process'.  For simpler LSMs this might not pose a problem, but
> for more complex LSMs, developing meaningful applications that use
> unshare(CLONE_NEWLSM) and properly initialize/setup the new LSM
> namespace set may prove challenging. Developing applications that use
> clone(CLONE_NEWLSM) will likely be much easier.
>
> In the setns case the process joins a properly configured LSM
> namespace set with all necessary LSM policies loaded, there shouldn't
> be any additional LSM setup required (although the work to change the
> individual LSM namespaces on a running process may prove difficult).
>
> --
> paul-moore.com
