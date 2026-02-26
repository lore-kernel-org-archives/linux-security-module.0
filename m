Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9715E8B
	for <linux-security-module@vger.kernel.org>; Thu, 26 Feb 2026 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064315; cv=pass; b=abWCbAtX9kKGa+qvpn8T9bce1sMTGuDuuW1NfNigGJUxEbUNppRL22VL+D5kK/20vY+r3LFoREk+ywtcA6N6fsW/d0pyioAgbFccxrHbs3iYJM94yupZwUasO/qH60PmF+lMr/IEwjnfIQNHcaV2ZRuDP/TqortiHxXTtRE19M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064315; c=relaxed/simple;
	bh=be7FPiPWe1/11EBo1DumJ14D6YL2yIf6xGwLC8NbK1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3w64Y/i2+yx/HfH8Nt7oUPmjEQi32m7uC3X3W/stwaydcTeCVUq8rSL8pyy6rBzT2ASZcOrXg68Z6+GfsaqEHhjm6w3LQhzXupQiPjRP8DxtNlG5humlo51UdPauah8207B3Err6K1ooy6O2MEd4HSvjFplEAKptXktQ3pREo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ywoj3TGD; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ywoj3TGD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3566af9900eso53814a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 16:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772064312; cv=none;
        d=google.com; s=arc-20240605;
        b=d/i9IkAhC9EbZ9TUHQdla0x8//NWFCKZ8n1kTVTefH3/2wdY4MitNvHjELZiLqzx8i
         /tPUHURTRHiLkTDUShxF1Twgbv4gX18nEQznzKIepxFSa1RAqQEt5FOXaY7VLcieVuJw
         7vI5FCgME+X+ZuCpDJM+iOpxClRPNedAST8AdLvbRSyDOuAB48+smWf9/pAVMTXbQA0o
         a+x43sLIsje3agl88GYjM2L9EkHch0zCR9Cnk1vPlXt6nbpjRT19Z3s8aS/mVC6PNzm1
         A+5ZA6cobCUTcJvHMXPTxveZTQxytlNvR3XWnPc6kYCO4HCPDFNr8FT1chqSn+8+qg4e
         bbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        fh=mXHLjsYMhefv2yVZDLdz+LWnW1ecjUJO8T5wx753O8Q=;
        b=lbv3M0UCxkMQWaKyGmP38O4/6wFY2Ryu/eb3c/2JlaByKAZiGESpO2FtuhgaROj5UF
         1hri4Kg0zriUgNDC3catp4QpLQFGFGPmWO2Fw8PJ55XYH1BviblI8e6Y1j0xVCsZqkLe
         OViwYgQIricDD74DVd9j0M9+n0gzyiOD9KOi1hGPVQVoCZ7DKekgiT063x/vZvNavxIi
         hBbGEs9ZUBOSD34pH6k7XHTWjYnUH9HU+kE0PH3BUrv0ep93nJVN8LXVIjev2wWHIEUS
         y9koSmMTOLSo8knGPu3K3Cx3fwvjitrCX7kktU6ZF+NxKYKQT8U7QgA/5rCw4wONj3XV
         t5kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772064312; x=1772669112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        b=Ywoj3TGDpqLyuiOjvkC7+ZjN8a9xQZ3e8MIVgsAofq69tc0acw6Cs5/6I92WL2bLeQ
         etGejhj4+g3HiSMhmnQVMSWGp3CRj5ipsrnR1NcNOdwNekVGS22IEjwrPO362Nwyy9YL
         tEt9TYw+mgu1svp8KkxmiEXfm4Zp+Kl/eOqo/b6Vj2/okz1B9URW3XnBnvEHAfj2YKUD
         MiZ5nedzuDGjRTcjVzuDXicXdzsdtIpZD0zLfHb/Kr4CB7+A+FAR+gkO4PTdncyqCZXX
         kOKi61967uk7fsO0B7n1BvS5i0N3G9++cv4Vph/5achC4RteAE/13JBE8usjFvr1xVug
         AEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772064312; x=1772669112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        b=L5acancwzeFxiJVDT7/mYiYCAMbDDRSfctr+eGfIcBSU/NDmNTWd9cmJE8T5VvY3Fd
         1lmUcGs/kF2jsE0mAqcOY7Jhj62hT0T1pNBT+VJr+PoV3UO5/c+NC10Gf/h7ZEeGmvUt
         PZzxDfmtFkCAC8c4AT388+CQXHqH3YiPMpNgRgWCFSmPaX/rYI7xcAstT8u1Bil79K9c
         2sJK8D4MH3VA7LCfAuxMSryf4ebmWu03p0OCVpfTrQlK21v5TLbZsABNknsNYs78QHjW
         L2Zuc6LEsEISPhfbgEUqtUAY8JO9VrH66gPzmXNZYKS2HLcy/ErniMmb2PLIita8Wa2t
         ELrw==
X-Gm-Message-State: AOJu0YyP2Xnfp/rGSF9ldUvgqOnBnfn07rYk9DWx2VRhUrnPabsam5IN
	FSN8VkNkP2hXWUcw6WVjrEfbVQmvAj6RSoLTJ3PuSkq0M7HmjbiKE32e/4ykcHpA+6Wih8WSaDt
	1CPm6tSoHvFxIcxI/kjIJdUfBywlTqfIYxJMizOfHO6dDE3m60iE+SA==
X-Gm-Gg: ATEYQzxu+a6WeYG57d16V+44SS2ImqtFkmmGARUtTcLeaCsWb4RzD4vw+5A9maZj3GL
	9+afrfPsGbkPgL6C0Zu/JgE9aoulQyfr4jqrBC8W+LVP8f+l1k0nBW0Sj1jAMJ89ixGlNgq5GIb
	A30yrGzGkqRhZYQ4DP8AhpkmZXjm654sZmb4tj0BTbzdTb3rdzCkEmbGZGytaySfr4ziq/bssoZ
	iKFcT/AszVrKBDYcPUooDOYof8oLCjZFimTJ9h6LFmgMunj/5oJQ8aYFIANZ79D9IiWFfpXkevn
	3cpi0oM=
X-Received: by 2002:a17:90b:4a05:b0:354:bf10:e6a4 with SMTP id
 98e67ed59e1d1-3593dadfe0emr390882a91.9.1772064312452; Wed, 25 Feb 2026
 16:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Feb 2026 19:05:00 -0500
X-Gm-Features: AaiRm514ql28YykxQ8HO37LZr8RwO7Lk9Xi6HuiY0qbXHJIk_QejzgpYvk-NvTo
Message-ID: <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:56=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hello all,
>
> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted ...

I spent a few hours this afternoon re-reading this thread and tweaking
the original proposal to address everything discussed.  The revised
proposal is below, with a bit more detail than before, please take a
look and let us all know what you think ...

* lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) and clone(CLONE_NEWLSM)

We would define a new LSM_ATTR flag, LSM_ATTR_CLONE_NEWLSM, which
could be used with lsm_set_self_attr() to request that an individual
LSM create a new LSM specific namespace on the next
clone(CLONE_NEWLSM) call.  LSMs may choose to perform various sanity
and authorization checks at lsm_set_self_attr() time, but they must
refrain from creating a new LSM namespace until clone() is called.
LSMs may also want to ensure that any state associated with an
lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request is not carried across
an exec() boundary, however, that decision is left to the individual
LSMs.

We would define a new clone() flag, CLONE_NEWLSM, which would trigger
a call into the LSM framework to invoke LSM specific callbacks to
perform namespace actions specified either by the LSM's policy or an
explicit lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request.

As with the existing LSM_ATTR support, this is strictly an opt-in
mechanism and individual LSMs are left to handle this request as they
see fit.

The lsm_get_self_attr() syscall could be used to get the
LSM_ATTR_CLONE_NEWLSM value(s) for the current process just like any
other LSM_ATTR flag.

* lsm_set_self_attr(LSM_ATTR_UNSHARE_NEWLSM) and unshare(CLONE_NEWLSM)

This would behave similarly to LSM_ATTR_CLONE_NEWLSM, but the LSM
namespace changes would take place during an unshare() call as opposed
to a clone() call.  This is kept separate from the
LSM_ATTR_CLONE_NEWLSM flag because the behaviors are quite different:
one creates a process with a new LSM namespace set, while the other
changes the LSM namespace set of a running process.

LSMs are free to implement support for either LSM_ATTR flag, both, or
none at all.

* /proc/pid/ns/lsm and setns(CLONE_NEWLSM)

The /proc/pid/ns/lsm file serves as a link/handle to the specific LSM
namespace set in use for the given process.  A process wishing to move
into the same LSM namespace set as another process can use this
link/handle (or a pidfd) and setns(CLONE_NEWLSM) to change its own LSM
namespace set.  It is important to note that using setns() it should
not be possible to change the individual LSMs that are part of the LSM
namespace set, the calling process' LSM namespace is set to the exact
same LSM namespace set as the specified process.

Affected LSMs may choose to enforce access controls on the
setns(CLONE_NEWLSM) operation according to their own policy.

* Policy considerations

The mechanisms above provide for three different scenarios: a new
process creating a new LSM namespace set (the clone case), an existing
process creating a new LSM namespace set (the unshare case), and an
existing process joining an existing LSM namespace set (the setns
case).

In the clone case a new LSM namespace set will be created when the
process itself is created.  It is up to the individual LSMs to
properly initialize their own namespaces and load any required
policies.  Since the new LSM namespaces are created at clone() time
and before exec(), the calling process, or another trusted process
using a new yet-to-be-finalized API, should be able to configure the
newly created LSM namespace before exec().

The unshare case is similar to clone because a new LSM namespace set
is created, but it is a bit more challenging because unshare()
modifies the calling process's LSM namespace set, not a newly created
child process'.  For simpler LSMs this might not pose a problem, but
for more complex LSMs, developing meaningful applications that use
unshare(CLONE_NEWLSM) and properly initialize/setup the new LSM
namespace set may prove challenging. Developing applications that use
clone(CLONE_NEWLSM) will likely be much easier.

In the setns case the process joins a properly configured LSM
namespace set with all necessary LSM policies loaded, there shouldn't
be any additional LSM setup required (although the work to change the
individual LSM namespaces on a running process may prove difficult).

--=20
paul-moore.com
