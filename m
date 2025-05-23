Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2635976
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033008; cv=none; b=usWkcfAiKv7ygd7y+wMbl9M26Df7Ed74pBHAjPinWt8VzEExToQnZD38BVD/qwmoooqgcRNMopFj5LxiqfuJ+T3xoBcqbdhVlFJue9ly9D2H5Blz1XvodDUbGgV6KHlKdVwTO3mBWR/I3TRE3l2kvDoC8sbm8aQbOU4nkXgesW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033008; c=relaxed/simple;
	bh=IQQ5Gml4d4nATh4PJxOs9VSscMda4Kz8hyfwAvAZ2aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYTwmfsJtKADCQD4evC1DrqIC+AypPh4hHIAkfEBx4ekm4yhcfuhISDvrwrcjT8Qxh18IeQwdxtH+fTj/iww9ZLqCeUnCT9a/04Nshn+3dv7+1K+tmSXLQKmnh7YGNoxGkBZNUhzMrzFyfUP8pqKfrqn6dtDvZE/MXnlXjzPeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GZwfgOSd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GZwfgOSd"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7c5d470a8bso268161276.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748033005; x=1748637805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgVK3bXgdFmMSLvGUClwgqIlvHhHuSibeAJvANyHISQ=;
        b=GZwfgOSdqD8tmh82PDNNIDTcI5wROq5ovDDUf+NN19jMKq1NZ+sht9RpYaJ8CCc99J
         wc2AEir5nXEpnBi5xuqHeIMUmvJE4eVO+z64VWnlRZslXr8A4iX8/NPYUyVxgHrR8Qty
         aM195RH1g8rF2qJ+cspbHb9YT+BLGAFIxB9Idu0XCVU8Ub5ZPGphK/ck4YYUVflOyk4j
         Y/S+B2H+n+/sAFPgKE3ErN6ZWWVgr4Mijl81qOFmCmvUvDzqzWU/XtZ7L17OVweiOhyB
         +SQxZo0v4C6malTCJcOYRofMsIu4BJUekUzruDWdbi9iVs2lsMBdkQG9TMVM0zL4iCGJ
         J8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748033005; x=1748637805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgVK3bXgdFmMSLvGUClwgqIlvHhHuSibeAJvANyHISQ=;
        b=KT2MG/AO7xJwRBGx5tMCwIliZkVjLAgmUq8ls+euIEvk5y/eMDMixus3+rAcS1pbOa
         lNA3xTUc6qbswFb02sRIB/k/LC+Q5stalNukA2KeohFmqm8O8xSzoTZMwrvyBQO/HX7v
         lCYY+KytIwwA4CqpkRK/pdHjRHLjETlKiiWe/DUL/3PjgP55n9PuvF/8XiyZTB15394+
         9svS5okFM6RQyi38yS1BmHnNL6l4hlbrNm8TpnFW8n3EQ90cnkmGx8+b0UjiLpdeM/jL
         ga/DTxV5qb58B2FjSrcZhn4JO0MD3g4Gask32LmlGd9n6f/JYf1BVqfONNlwWckD1lER
         HxIA==
X-Gm-Message-State: AOJu0YwYCA3y3zfcMIb2/buyjbDX3EhDpDwrc8WDjNXc+1LDscSyQoJ6
	R7++2/qnav/8BPbSGfwCpwre1LtjDedB3d860fv4WBud96HO1sMfEZYdw7y21dTup/1jPKlfNnc
	rHapPq73srmEeEsrrQD5HcEs7tUcWfo5XSEkjl4J5DLkfUCY1VdrFCIrH
X-Gm-Gg: ASbGncvmPTNL99NlkleSysIvTk0RSr5LySj8u0TjSw70gtwofCFeBK/Asx5kRWk6x39
	z9hyEu7hnJNMIsNIAsMXluYFRokroMObOib1icYALT4zFB1Q56sbU6PgkDX2XanEEkkibXkH1Wp
	gC7JxFC45SMiH6bpWInIzxdNIjT7+JILnG
X-Google-Smtp-Source: AGHT+IHjTfUv1j9vvwb4oN3VJa3hUHu79iYXLPPnK/Ie/ruJV1dU94vpc/J7qIwRgdYkXUm9QsKRVKPPfT7vhONlLlo=
X-Received: by 2002:a05:6902:188c:b0:e7d:5e41:a8ba with SMTP id
 3f1490d57ef6-e7d91a2a204mr1086068276.34.1748033004966; Fri, 23 May 2025
 13:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
In-Reply-To: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 May 2025 16:43:13 -0400
X-Gm-Features: AX0GCFsAWh6Nidgy9JyMhVJ3HKjHmDOb3_BOmntvPEk7Qz68FRUothIeet7hE_Q
Message-ID: <CAHC9VhSXNwG+3i2__aJoi7nV9tuh0KNO69O706mAkE-Xq+uVEQ@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: linux-security-module@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Hello all,
>
> We've worked in the past to document some of our policies and
> guidelines, the result can be seen at the link below (also listed in
> MAINTAINERS):
>
> - https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>
> However, one of the areas that has been missing from this guidance,
> are policies on deprecating and removing LSM hooks as well as LSMs
> themselves ...

Here are some slight revisions to the earlier draft text based on
feedback.  I'm also including a section on LSM hook modifications as
suggested by Casey.  As usual, feedback is encouraged.

## Modifying LSM Hooks

Changing the parameters, return value, or calling locations of an existing =
LSM
hook can impact individual in-kernel LSMs as well as ongoing development
efforts that have not yet landed in the upstream Linux kernel.  Developers =
that
wish to change a LSM hook should work with existing in-kernel LSMs, related
development efforts, and any associated subsystems to ensure that the
individual LSMs are properly transitioned to the new hook.  Any existing ke=
rnel
selftests should also be updated as necessary to ensure they continue to
work properly.

Due to the potential for cross LSM and cross subsystem conflicts when chang=
ing
LSM hooks, it is possible that patches which modify LSM hooks may be staged=
, or
delayed, for a period of time to allow for a more manageable transition.

## Removing LSM Hooks

If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing =
work
in progress involving the hook, and no expectation of future work that will=
 use
the hook, the LSM community may consider removal of the LSM hook.  The deci=
sion
to ultimately remove the LSM hook should balance ongoing maintenance and
performance concerns with the social challenges of reintroducing the hook i=
f
it is needed at a later date.

In the case where a Linux kernel selftest has been created to verify the pr=
oper
behavior of a LSM hook, the presence of the selftest alone should not preve=
nt
removal of the LSM hook.

## Removing LSMs

If a LSM has not been actively maintained for a period of time such that it=
 is
becoming a maintenance burden for other developers, or there are serious
concerns about the LSM's ability to deliver on its stated purpose, the LSM
community may consider deprecating and ultimately removing the LSM from the
Linux kernel.  However, before considering deprecation, the LSM community
should make every reasonable effort to find a suitable maintainer for the L=
SM
while also surveying the major Linux distributions to better understand the
impact a deprecation would have on the downstream distro/user experience.  =
If
deprecation remains the only viable option, the following process should be
used as a starting point for deprecating the LSM:

* The LSM's Kconfig description should indicate that the LSM is being
deprecated and the LSM should not be built into the kernel by default.

* Entries in Documentation/API/obsolete should be created for any user visi=
ble
interfaces associated with the LSM.

* When the LSM is enabled at boot or runtime, it should display a message o=
n
the console that it is now deprecated and will be removed at some point in =
the
future.  While the message should be displayed without delaying the boot at
first, after one or two kernel releases it may be helpful to add a small,
e.g. five second, delay after displaying the message to draw attention to t=
he
deprecation notice.  The delay can be increased in successive kernel releas=
es
until it reaches a level than any reasonable user wouldn't be able to ignor=
e,
e.g. 30 seconds.

* Finally, after an additional two to three kernel releases, after any
deadlines listed in the Documentation/API/obsolete entries, and once the LS=
M
community is satisfied that all users running modern kernels have migrated =
away
from the LSM, the LSM can be removed from the Linux kernel and any entries =
in
Documentation/API/obsolete can be moved to Documentation/API/removed.

It is important to note that the steps above are intended as basic guidance=
 for
a generic LSM; it is likely that changes, including additional actions, wil=
l be
needed for individual LSMs based on their design, implementation, and
downstream usage.  The LSM community should take the process above as input=
,
but ultimately the process should be tailored to the LSM being deprecated a=
nd
the associated environment.

--=20
paul-moore.com
