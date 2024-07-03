Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D43A8D0
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047670; cv=none; b=bAUtWJJQDyIra9FuOrBZfhYzj9yyF1cQFI8OAm9IoAOrRtiuKqm/DswRFUlcuTbY25J0+dmgcvJm0NmpPWIL/p3fqwn4Hc+VDIoUjlnVLeDgA0YE3m6H7ON+inxoScqakRn7QhOCRuERk1+14oP6skLW1FBIzGcU4SV8OUruQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047670; c=relaxed/simple;
	bh=bUTbTvzj82LJV3RkK+LQb2gR0EFbWiO3r4bl0COLezw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7jy9bpsumDeovpcSVUsXbmDBiXm0BiOe7YBweR9p9GlKPSkguA+K8ivoN3Fvpk4jrl7yollm70HLnftopmaxB8Q/si468iSG0kXlkQySgqrFH31iBxmQbxhcOCr+p2wNudx/RTWEbSdkez9nlVRqgivnr9fXLkYBLTaTq6V/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SFwr8sac; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SFwr8sac"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so25692276.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jul 2024 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720047668; x=1720652468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6juE3uWpR8vi0HecVzx6BeVrOtW6clnNJqbZGyj11g=;
        b=SFwr8sac2DGIwD8MAYPXnX/ihb19SoiznR6UYrPlyn6aAZyteWIqknjhI3k7L6xGn9
         HxmK8K4PDcfm2XZmAVmY1MZ//9JW9nh9Ri05jw3/7KqtZojNcJgDpBfsOCtC+fmWtF2S
         FbvYLS3tOeWP9Uk7ZrE5enPbhoOXl8ht2XHM5IXw1fZFZUCU1nC9YAJYvbmUNQkJmvPv
         KrQjFgLnfgSgyFH4I1HIW+9UVUuZiMq1S2yFCMaMXLqZAR4MgWfPf/vQL+Z0amQe5VEO
         mta+GsgZKj7gDEfXh7utMTM6oHxcUsmq4yoMVc3mi4lEyhwGNN9h812f+gt/YKleZMFo
         XZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047668; x=1720652468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6juE3uWpR8vi0HecVzx6BeVrOtW6clnNJqbZGyj11g=;
        b=Dx6iGaFnHDVm9gouBvmvrlulw4M+LpKpgyv2OXdGxONRvNIRTjkh8Fj+iXnQVCLaOS
         eFs/BO4PZweaVSGOwf/xf3+QE7A9BBPv/HccUvDEK6uL+JYTwdo1ip0xKDg3mx0M2N3b
         pWg/qieFmAZ4n6zzk9XRi+4Il9RBN31arQFFnVWKOzHgHGeXRAQiH8DiEmuq2kxQ+JlG
         q3cQLYAAE5M/Up4jKllQyjd1ZeGzghSTghjv0KGDezpHtEl6zhteW8GwyQqGNg985eA/
         1gAHDwF4tJHPhSS0tOpufd2yfNuhH1N+31eLvCX+bCjU4O3FA+KlbNidmw+C4wfF0AWk
         GNmg==
X-Gm-Message-State: AOJu0YzBA1SUW3XDGkGX5+YFNYSaBNS0FV0wqtReWrkR4uVnxcOGOOkR
	pBBoy/achg9sGLKTPKLI/DQIN9MOHd6X6Y+tLx/cTed+uV6FANBkIPO6+/7WP4tPAxvbs3AhzYC
	9OSxRuSzZngRjG+rhWg3lRqDwz41S/Dr/QoZwt3fH19XoWf8=
X-Google-Smtp-Source: AGHT+IHlw5TKJf6IMqAed1Vi2Ai3i8Ur7WHChBmTXeHOEhRKNmzxeBjFEpH88VIG0Rp7pZvbfI94DImgAdCx+5A6J+U=
X-Received: by 2002:a5b:f0a:0:b0:de5:5693:4e96 with SMTP id
 3f1490d57ef6-e036eb67f53mr13564734276.27.1720047668247; Wed, 03 Jul 2024
 16:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com> <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
 <30fe42db-461c-4716-8874-ff78baf4b14b@schaufler-ca.com>
In-Reply-To: <30fe42db-461c-4716-8874-ff78baf4b14b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 19:00:57 -0400
Message-ID: <CAHC9VhR0Dt9_HO_Ym3oJa9FqBoP3Av73Rwtj_Y-U8YhhkR5pVw@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:55=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/3/2024 2:14 PM, Paul Moore wrote:
> > On Wed, Jul 3, 2024 at 5:11=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> >> moved the responsibility of doing the inode xattr capability checking
> >> out of the individual LSMs and into the LSM framework itself.
> >> Unfortunately, while the original commit added the capability checks
> >> to both the setxattr and removexattr code in the LSM framework, it
> >> only removed the setxattr capability checks from the individual LSMs,
> >> leaving duplicated removexattr capability checks in both the SELinux
> >> and Smack code.
> >>
> >> This patch removes the duplicated code from SELinux and Smack.
> >>
> >> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/selinux/hooks.c   | 10 ++--------
> >>  security/smack/smack_lsm.c |  3 +--
> >>  2 files changed, 3 insertions(+), 10 deletions(-)
> > FYI, this is still untested as my test kernel is compiling now, but I
> > wanted to get this out onto the list before the holiday in the US for
> > folks (/me looks at Casey for the Smack bits)
>
> Let me know how your test goes, and then I'll have a closer look.

It looks good - my SELinux test system booted up, appears to be
running normally, and all of the selinux-testsuite tests pass.

--=20
paul-moore.com
