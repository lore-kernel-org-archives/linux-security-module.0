Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1146C85E
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436449; cv=pass; b=lcMsUeJhEIhoONUTRV4x/CWtQzUW3CmFsIiUnmy+hY8t4xYw8daEEyXd8DNS3UOb4W04Sk0054hb+9bA6rudNqVJ93Rrz1ujjrYEtmg8uu/hANnmusLTZeP8+7jU2JE7Bs45el7OqECHIMcZU83865Nzmnk8KHNkpZo3gthw4rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436449; c=relaxed/simple;
	bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpcIMzZp7HTYdgyT7ARXW8CesdUASgNkSYuTC++z+jsrtPqQ4NvuW1JxNmAmutBfpNmu/T2/dmJn3fbIN5Oi7+dMGB97ka+XXMLCv7ZLFGylw1/mvzhFUjQp7eV1VKsoKChUco7pDe7xF/N5E2E2bm4FwCL2btHkXojU230tv5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOZQS0+y; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOZQS0+y"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3418188a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 04:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788436444; cv=none;
        d=google.com; s=arc-20260327;
        b=juJSBFouKFJSihXZ66Gmhy8cwW+sEGAN0SffR7pu+W6lMdyEZuC+gnhEv7qbwv+IxC
         /U2F7akKopDiRFbL5H6nj2CQ0rgmC9gJG6PrwU4eTfweHx6qR1vjUEvNEn7BtOk7+wFq
         liDdP2U9x5ay5RoM6Yoe20w5L8uP4foBWOOo5XqnjJvBEv8v/+h36fRIh+9MLt1AVLs6
         Quyj4pNN8KUrSvksvBEULIvrGvmpXRf4WjahldChwdbivST6l+yOtCDygL3DZ1tQ976D
         52Gw4TqWkOfHrwkogU44cSn0nOfMmZV2NEkPHH3hRRLoqqlhfrouM/v3BaqPSzEQ921O
         wZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        fh=PwCKF2IR0RHvoOjme4HhzjFMqyiLmJTaJ8ga8j0nRKE=;
        b=GPkP1T5ud5evM7P5DLhn4n7foonB7iz883sP6itvecH6idnMA1YUVY5BOSgluEKSjN
         K2jQ62eJ1iheTazqqNRswOYXfIRBbXRgYfjBof7GW6+fc9+ztnv4WSki7nqCkbVFxQcj
         7MFI35MG/3KopeAKAEUsNv1uhMLlKx8rFdQY9V35etn8/RcBHomzzZW2p2fqXLU5Em+q
         SszkEPPXo3GcpVwlJitInpMQoW7aXsBVpZxgNRH9hWXIz1XP3NJXYcZLK5V8gUBm148y
         flP0djwfiqMFRRkY2sfp576/G496JBnpqogMJRPf/seV/PfYPn+GaXFYQ125fqvFmdwL
         SwBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436444; x=1789041244; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        b=oOZQS0+yEEfqtdVqvAymA2Od9R+g4vrT7ueq/oiO3JMQMeeGJ40Pz4OGTuAGPLyCHj
         ymIcM6kIKVrV5Uszp3m5JS0XeFTpwf4uASQqxaR3izCkjrQgpRCxr+dAQo4XeNIyjtZp
         oZlWCy8YwSzynD3HY8Vm3vSvH/u/LkavcPV90Dn9RR0u3Jv2jhQzbJVSYQjmY0fTABMX
         BFs2a8UEfAK1X9rW0E9/Buq/BVagjM6aazbhmfoSCIo/TawQ4Hn8d5c77O8FOHt+YCo9
         WzdEdlpt7P4556g7/1Txa4K68HGt3k/4n254vJYROLSdlXFaUJSy77ZH1PnVpyN1igvC
         AEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436444; x=1789041244;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cmrmJFgNXl9cwByq4wccjkamqLrAgOAlhe3K+qkWDxo=;
        b=LQRRS1sukRVrvAClSuGWsgQ0YnWOt86RWdyFytK8XK7U3wVTj2Yy67jKFnzPVr/m76
         1yBWn9UjkjdMLbNPwqb/tij3MIR0gJwzkbHW2VlKyujWFkL1hrXtgRz3HEX9gZcpG9Cf
         2Uztq8+MSHljFxg44jS2Nd3+UucW6wQVUxBfcm+exrpoiJ6/TWd9R1VMcQD8zZ0XiIyM
         Nf2jPtqMifwyxRQomfUlauWRcdfYyi8iyVQuheKHHOkFtz1jpHQF4pStRj3949fbgULO
         WsWoGeD36sOO1M+1+QUh39yqQEehS/Z3NFk3UqzNlG42MwIFOWtzj2gIdkJb7rxwDa2f
         7S9g==
X-Forwarded-Encrypted: i=1; AKwUvBxN/cumnFbNHcYCZnzUU+k2DGgTZ6tA4EkCFmFg4AkhZ9cDMAJXsioBURYE3Enu0ZIxVLOghaDhZBz/nXh/Ntz/mk3HeFg=@vger.kernel.org
X-Gm-Message-State: AFuF++mo6vwF61bkBKUtstTjIDoioHFXtV6sYWzopJvsDqnqIVQ5NROK
	mhviHPo+iABYZ+O2VhGOYDXfHKUvawGxsaM1nfX6bRbH6ngAz//MppXNHAjxUtV25gkOn5gPsff
	FbGsC/2QwT/g/x7U2rH/slRhZq1qdssVmYZOPpjU=
X-Gm-Gg: AYBFou1d79bIPieKcf+DG5M+Mpvivjher+VIEJ26gQLt57YDXyVfxJD5/MAsgXIUnqD
	g79JV/Y7gYqcowhNG6k+N5izVvEqc1iYMQg22WnEjRNXjSQ5pB2bHuUkU8/62CRMcV1MRpIaR8F
	4ZWW4j4ZjagylOlkwT3Gqp67XQoL130NZCKmx5+1Pw+nlViBCLu04rxAPHp9yFjJgpOiklMvIe2
	B+/kdcDT4+8R+yicvGN1CwmT4Sqmg8RPA5mGg2BCUdWl16HXdRAFlvqErN9uDKhpPHh7BKiWmYx
	ZNVdci7MrYZ/gfIh2nblXkoT0F7/2WGjEWC+K3jlQnadDaeqz4QDOIR2UVdL0yehe7ewYyOAoxI
	A
X-Received: by 2002:a17:90b:3d89:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39aedf89bc9mr18610572a91.5.1788436443559; Thu, 03 Sep 2026
 04:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
In-Reply-To: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Thu, 3 Sep 2026 13:53:51 +0200
X-Gm-Features: AcwNN1UoWZTfWh3agR_jdxc3Q2M3uh3UgHIHKTZhxeYlUtsA2KRhKMGejWfjeZo
Message-ID: <CAAUqJDu1R0KjX+-zj9in7sCN+2XPcqE9Uc34GNPZ+209VFou0g@mail.gmail.com>
Subject: Re: Heads up: Moving to a different email address for my Linux
 kernel/SELinux contributions
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Due to certain upcoming changes to my employer's work laptop usage
> policy, I'm being forced to more strictly separate my work-internal
> vs. upstream/personal environments/identities and in relation to that
> I'd like to transition to using my personal email
> (omosnacek@gmail.com) for my future kernel/SELinux (or other upstream
> community) contributions.
>
> My work email address remains tied to me for the foreseeable future
> and nothing really changes in terms of its abuse potential or
> whatever, so nothing bad will happen if someone accidentally sends
> anything upstream-related to this address (or continues an existing
> thread), I'd just prefer to use the personal one as the default from
> now on.
>
> I'll soon send patches to update .mailmap and MAINTAINERS in the
> kernel tree and SECURITY.md in the SELinux userspace repo accordingly.
> My future git commits (e.g. on SELinux GitHub repos) will also start
> to show my personal email address in the metadata + Signed-off-by.
>
> Hopefully I didn't miss any important detail and the transition will be smooth.
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.

Acknowledging this from the new address as well.
