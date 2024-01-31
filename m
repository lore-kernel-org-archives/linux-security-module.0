Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39521101
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jan 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667591; cv=none; b=Fja70+W/Ja6vt0DQl4m/9LzZNhHlbSwgo+YCIXEAVOn3hcxdRsm8PasrPZ++zcjwsXAffNwW7fhjLEa4zKdTipSupeTrRMVZz5QRabMsrxufrGWeZNjYmEsXY73WjgGO0bd4uzM+tf0j2Wu4P7W43nhAnxiwPnKVqhcd6FMNDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667591; c=relaxed/simple;
	bh=9g3zWjacXY9yAiyjAJJZuEKjloyNlGIzsfzmlsD/p50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEZIhJ50gzywHdxecSnQdwDrTBdxgyRuzmU7KcCpG1u15cDzeaglOf0dpzBLAIqpKtvlBmD74E0xLjHeX6DBkYRDcNUHGZ4I8rb7/jB67tteoYSasmPPOXN5SV0jhfu5A0ZbRFwn9P9mU/7BvFgPlyEGjt50qiFJStJPLLWKsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XaLrbA3j; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XaLrbA3j"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6bad09398so310307276.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706667587; x=1707272387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZdvENlLRcApd2T67MYqo9J3s0IjigqVsNbUgSKEM18=;
        b=XaLrbA3juqJ7/rhuVXN3NZ9/josykqmvYmsxa/GwIy75UomqGBDdo93dIx43N0jzJS
         lJ1NDRWQlZ3JOhonRnAIPgGDIs4l7YkHL/uzJOct4/u9g3DcDvlD+/oGXs0gxBzUOq9b
         u7+N+QUzNcfAl4VoxzIqnUWAIy5gEoqfgzpfWP6yEzFiGzchT81li8BdEznhWHZN0Nir
         hPygUuxzA0PCOowYPTvObaE0ppLuIMh/MIquP2wFHoatgdmqwqOOsQ3kz774lv21X7gR
         NE1V8Z4EskJgOKLrZgWYH40pcQTvVSGFy+6v6Yh0R4l71cZF222DhV8UN6J6LQM8FW+1
         fTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667587; x=1707272387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZdvENlLRcApd2T67MYqo9J3s0IjigqVsNbUgSKEM18=;
        b=S3P080w7P56kCq+6dJjeC0QR7GYtS8cseWz3WcCTNmuZtOU9CeexvOUZtdSFPHPZ2J
         5GmKiJkQhM11PsFjZMfJwDLxRmnn6iLXTkQmk9Q0rhtDaraBvnKWg49Yn1PXAwHjYvPm
         TjK+wbmLAP0pFsm47rvPibzfyZm74E0IWAocrPhgebJ5ApKEAWtmel0uIYMAEUwrQ/zj
         33O8OrDG72zC1tgFc4EWYN7Cgqz6yrOn+TF9LaQAIDjPEkGOc6yyJJNmYugLgzhKIw6e
         YGMaUxhKfZxjg9xEiDwQ/98XsI934bpMzi9uSDMydjV7A7ueqaTp2gHwf4JkfKglLCpH
         zmkA==
X-Gm-Message-State: AOJu0YwV/zvzgo4IrLY/IRFE9nd7D2bw9xVpSHnHbRIKHGDote9cTBJl
	xy3EJsTQ8os3oCq4gCm16Uyr6d5V/4u2LwfN6xCZ5cWjU8VCdT613197Qgm6FznG4tpkDGHZBgG
	LBiMh2waKWN9DTDuHzniMUV+2aLs1HN3SkCtD
X-Google-Smtp-Source: AGHT+IE737YYBvQ3Pul890Pk1OpdRVeqvK7t8FBJ1ULHG2/iAxR72EdAX3aTOsm9KGR/net7/hWOilqhOWg08e+YBDU=
X-Received: by 2002:a25:add8:0:b0:dbd:4dca:7082 with SMTP id
 d24-20020a25add8000000b00dbd4dca7082mr356154ybe.34.1706667587505; Tue, 30 Jan
 2024 18:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
In-Reply-To: <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2024 21:19:36 -0500
Message-ID: <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jan 30, 2024 at 7:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Jan 29, 2024 at 8:31=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > These two hooks currently work like this:
> > > 1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
> > >    called.
> > > 2. If an LSM hook call returns 0, the loop continues to call further
> > >    LSMs (and only stops on an error return value).
> > > 3. The "default" return value is 0, so e.g. the default BPF LSM hook
> > >    just returns 0.
> > >
> > > This works if BPF LSM is enabled along with SELinux or SMACK (or not
> > > enabled at all), but if it's the only LSM implementing the hook, then
> > > the cap_inode_{set,remove}xattr() is erroneously skipped.
> > >
> > > Fix this by using 1 as the default return value and make the loop
> > > recognize it as a no-op return value (i.e. if an LSM returns this val=
ue
> > > it is treated as if it wasn't called at all). The final logic is simi=
lar
> > > to that of security_fs_context_parse_param().
> > >
> > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  4 ++--
> > >  security/security.c           | 45 +++++++++++++++++++++++++--------=
--
> > >  2 files changed, 35 insertions(+), 14 deletions(-)
> >
> > Thanks for working on this Ondrej, I've got a couple of thoughts on
> > the approach taken here, but we definitely need to fix this.
> >
> > My first thought is that we really should move the
> > cap_inode_setxattr() and cap_inode_removexattr() calls in security.c
> > over to using the LSM hook infrastructure just as we do with other
> > capability hooks in commoncap.c:
> >
> >   LSM_HOOK_INIT(inode_setxattr, cap_inode_setxattr);
> >   LSM_HOOK_INIT(inode_removexattr, cap_inode_removexattr);
> >
> > ... of course we will need to adjust cap_inode_setxattr to take (and
> > ignore the idmap) parameter, but that is easy enough.  It looks like
> > cap_inode_removexattr() can be used as-is.  Modifications to the only
> > two LSMs, SELinux and Smack, which explicitly call out to these
> > capability hooks looks rather straightforward as well.  Doing this
> > should simplify the LSM hooks significantly, and lower the chance of a
> > future LSM mistakenly not doing the required capability calls.  There
> > should also be a slight performance bump for the few (one? two?)
> > people running both SELinux and Smack in a production environment.
> >
> > My second thought is that we *really* need to add to the function
> > header block comment/description for both these hooks.  Of course the
> > details here will change depending on the bits above about the
> > capability hooks, but if we need any special handling like you're
> > proposing here we really should document it in the hook's header
> > block.
>
> A completely untested, other than compiling security/, patch is below
> demonstrating what I was thinking ...

... I built a kernel and did a quick test that failed spectacularly :)

Without looking too closely, I'm guessing I forgot to take into
account that SELinux and Smack don't normally apply the capability
checks if it is one of their xattrs, and installing the capability
checks as hooks means they are always checked regardless of the other
LSMs.

Bummer.

I'll come back to this tomorrow with some fresh eyes.

--=20
paul-moore.com
