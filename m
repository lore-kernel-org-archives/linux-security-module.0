Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375093890EA
	for <linux-security-module@vger.kernel.org>; Fri,  8 May 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273629; cv=pass; b=ePw508x7nIvOZ2WfvSIz6smEsbqBpzzzPjU/d9TXaxxZx1h5bpxYhey5UGlXbOLJtqOmFtC9o4qgxbCQIpfxV7w4SSP4BkOdKoerY9W9ZOoX6F43CJfkbW1tZtT8yCS/vwyUbeso562WDjWyaNrkITxznc5CSrYEf/ym0MaUMdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273629; c=relaxed/simple;
	bh=95IVxcvqWG/JPgHLoMmXlIvgmhSj0ZnffrludpYS+b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7t1SYU/U/P0BDuoGZf2pW7a7xeVia5McTe4oOeUR9Y1yxlCOMwSlVaaJTSIalPThpXOhmqMsLyGSxNIxFXvoKk5/hp+v1UQbGHiDjvbrxsoq47zJWnWXqntwpp2ius7xrz5lnvRbFiq23IPTFVQsB9SQ+IL4xisVmnLpFHm0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dO9DTlgQ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dO9DTlgQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso23786385ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 May 2026 13:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778273627; cv=none;
        d=google.com; s=arc-20240605;
        b=HqL2mjPxF0ESwCnlCVp335MxrL6GbHXDaW3JV9pb1NGMhSIn9eRD/2T3r2XhLdsTnc
         ErN62XWsq3IvjsIhbLEkE0hO4b2VT08PI2DyGLJWQEhqfQFuhwgSTHSx5Af5TTbb0wTa
         Ntx8y374i7AEsX/i9yO58CpnucrGEkUbegJqPgBS/O44euDLbN+nOaOKzQ3KkkDY34lz
         wMeNck3UZLR9G3kCwMD94xpQetxfFZFAHX3A/Pb8FF/leSD0T4YotfhbenYEWXCvS9/N
         h33BGPYpGXNoB+dm+QFkjdUuJ7LW5ebf3/7tsjLNZQ2+WQg70OQsv8w38B5nChspse4o
         V3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        fh=97bavFZaQtKuelV2NmX4bNKgv1zqm1NxDd44Jjr83HE=;
        b=AVBBmF96LE+v9xz7DjfITHzbPUO1FO2E33AK2umQqAXA4pKuq2F0dWkqwLIs92hU8J
         4PL29OvHDbOpz8sUAPtYEyoiXOWcX5I68uf94uiGsHq0LpijXEFOSeh03OI4jVdld+po
         JSdLakdN3a1a1HYtuomQyEhHMxlWVqGWpVnlx+x9dNbXYi15D761qhSZC+jGyFwq1JuM
         N4dTXTuzPk/QCju45JrSY7llbVPCtiV48xPShH1qSJQ3zcU9GLouCCf8XGkYHBWl5IjQ
         R/Dtr7ieet8DgLEaRfHmTdUU66dtTgoDXZrkbdXaoGy0KUTL1tpz3vsb1sOqBDm3UMHJ
         QdBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778273627; x=1778878427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=dO9DTlgQfsP6r2/MbL7aMUDkGQ4OLsZv0vYaf15PRIss3gRaJnowuxUHcSTUva6W85
         j/J+VjqQFgVev2klxrYTwwe7wgIO74KBi8ycfATzCDimRON9YD75IEBw3xION86Y4N1t
         NjrhyMDHgZmXM4viWlybsq1Qt9tp3H+flY1WSkGRX/mJRBqcNybrwAi88BJWKbzj7tx4
         VLh0co/3VJAuzXKuJWe+SzfSACIdNtKXKNLmK2ezmduu2usGOLUfBvb/q7sVfyYt6BpJ
         FXSWp4s7M9aklH2uiCsBM/jSbStdmCIISoPD+PHofmTIhlSMS4yGPETjhs7ejJOMsnJ+
         YokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778273627; x=1778878427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=oC213TiNLnOA9Ky7Rcwxq9YE8QOs258xySzw4/xGiI4LADo7hZFtKdP9IqBUFyAinv
         759qDgvimwNw23+v3Q017VwiXwoedZQLfGu8qbfI7ZJFGnCzKVAV6nIf/eQuACNvMfp6
         Zfgbv6sAkj1V2aNpLvd+2Eq9PZUL+4D0e2RP5S1j5eeC6MB4e3s2pcpWQxSxo48dCDfK
         /ZTB0zIn8WTtAXVB10DAOebvw8cvhqPIgBR7jkRQMhB46ohVpLKuTXgR1gWAwz38AFye
         0vj+JxzDf/1QNbFsdYG/x5fEGlQXvpRKhzX1SRhR697nPnr7sncOBeu+4I5uFe0nJuf/
         YN9Q==
X-Gm-Message-State: AOJu0YzJD8hq065Ibh5Qvn0qFwVIRM0dM0I5vPwXK4BUeRjEAKmSbtSS
	dSdGF64NXekEX3tmvQ4I8Cmt/E53rcIb9IpEjXZimjHzqAYKfnThBTsfyT93tCJb7YTLQ4XLjN3
	iTha0YFtl07JjNbEIUmxkPcnpA+RzX4r6lTBl9yFh
X-Gm-Gg: Acq92OEVQu4WWXge3Y0xENgXLWvqJUntmVaAvNL/dDv+qTSm+9SKrdj8pmD0g85RLt3
	Y8VLrehskn5r7exKgX/hfFWB3oUo3kWxOQMQ2uOgCNSlGQ/htuz0GaAw6MZ9GIVhlPqnvzLJL5s
	nrpLCaa46il9IvnFgCXp2Uxyd2odB+NC2O8cbAvlnqxVc49hE7rUPb33YyU7Qqwz5UF0MChjoMy
	rYAtFszTXuo6NZLcClEK9djRHa1YTanyNnnYQRnjOdneWZsq0EWN41rUh0zYnYqfa60A2XIM4KG
	6onwxfRfq8DeAh1v5v/DDTqqrx4u
X-Received: by 2002:a17:903:1b07:b0:2b9:eb6a:68b5 with SMTP id
 d9443c01a7336-2ba7a36022amr136938945ad.38.1778273627590; Fri, 08 May 2026
 13:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
 <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com> <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
In-Reply-To: <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:53:35 -0400
X-Gm-Features: AVHnY4JRDMNUmX4JH5JunmLlULux3slQY9_dADVN9V7Jbwgw1Y6mP1Hb0ty2Ukk
Message-ID: <CAHC9VhQ237o27ej-_0tgv08KF-FaX9nrRyUF_9pE4uaVMGqU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:29=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Fri, May 8, 2026 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Add six new LSM hooks for mount operations:
> > >
> > > - mount_bind(from, to, recurse): bind mount with pre-resolved
> > >   struct path for source and destination.
> > > - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
> > >   mount options are parsed. The flags and data parameters carry the
> > >   original mount(2) flags and data for LSMs that need them (AppArmor,
> > >   Tomoyo).
> > > - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
> > >   called after mount options are parsed into the fs_context.
> > > - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
> > >   (MS_REMOUNT|MS_BIND path).
> > > - mount_move(from, to): move mount with pre-resolved paths.
> > > - mount_change_type(mp, ms_flags): propagation type changes.
> > >
> > > These replace the monolithic security_sb_mount() which conflates
> > > multiple distinct operations into a single hook, and suffers from
> > > TOCTOU issues where LSMs re-resolve string-based dev_name via
> > > kern_path().
> > >
> > > The mount_move hook is added alongside the existing move_mount hook.
> > > During the transition, LSMs register for both hooks. The move_mount
> > > hook will be removed once all LSMs have been converted.
> > >
> > > Some LSMs, such as apparmor and tomoyo, audit the original input pass=
ed
> > > in the mount syscall. To keep the same behavior, argument data and fl=
ags
> > > are passed in do_* functions. These can be removed if these LSMs no
> > > longer need these information.
> > >
> > > All new hooks are registered as sleepable BPF LSM hooks.
> > >
> > > Code generated with the assistance of Claude, reviewed by human.
> > >
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for sel=
inux only
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  fs/namespace.c                |  35 ++++++++++--
> > >  include/linux/lsm_hook_defs.h |  12 ++++
> > >  include/linux/security.h      |  50 +++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c          |   7 +++
> > >  security/security.c           | 101 ++++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 199 insertions(+), 6 deletions(-)
> >
> > ...
> >
> > > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path=
 *path, const char *old_name)
> > >         if (err)
> > >                 return err;
> > >
> > > +       err =3D security_mount_move(&old_path, path);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         return do_move_mount(&old_path, path, 0);
> > >  }
> >
> > While the security_sb_mount() hook calls into do_move_mount_old(), the
> > security_move_mount() hook calls into do_mount_mount().  As you remove
> > both of these LSM hooks in patch 7/7, should we consider moving the
> > new security_mount_move() into do_move_mount()?  If not, how do we
> > ensure that we don't lose coverage when removing the
> > security_move_mount() hook, or can you explain why it is not needed?

Ooof, I just read my comment above - that was all mixed up, my
apologies.  Evidently it's been a long week ...

> Patch 7/7 _replaces_ security_move_mount() with security_mount_move()
> in vfs_move_mount().

Okay, at the very least you should probably change the subject line to
patch 7/7, or ideally move that hook addition/modification to patch
1/7 so patch 7/7 is purely an unused-hook-removal patch.

> IOW, security_mount_move() is called from both
> vfs_move_mount() and do_move_mount_old(), so we are not losing any
> coverage. Did I miss something?

No, I assumed patch 7/7 was doing something different based solely on
the subject line.

Let's also put the vfs_move_mount()/security_mount_move() change in
patch 1/7 so that patch 7/7 is simply a hook/dead-code removal patch.
This should make the patchset much cleaner.

--=20
paul-moore.com
