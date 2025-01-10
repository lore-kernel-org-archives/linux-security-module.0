Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AAB661
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736482461; cv=none; b=E4QfWPjkUekAfU5wbETo0aNgBQqAn4q1H/yYsJ8KCQuSbuX9RYaBNKHQ9pIg25FWRZFu4+SdzXQ3W+Gm9F6j/78qAMLkEOWpPcZRvdXq/Dxrbl/oaftAx/s1k/d6TMNGHq1/aPVE26EJUH9OZ/jVitO8aW/KmMZ01ogJgfpsspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736482461; c=relaxed/simple;
	bh=rKde/vScUaA8n1F9yCocNUUEF2MI7JsDEALXqG0KRAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYdcEUIDQe009wyMnmViuvTaUC6VFldYuekn+EAnUavjinqt01xGoTNhlhFFnI0OCw9BKoB0YSwV+dGIlgCDD0wrHNHvn7WW1XEsbMqONgJWpbtGXx3jTmEhj+IkGomYs390+9h0qBNCI+eH9q38LsJ/fMdNLgVH8Fr08/cPuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BrbVENMa; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrbVENMa"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29e5aedbebdso813295fac.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736482458; x=1737087258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ottIiiil7Y6TARNn3P9202RaeajOs8YU2PtCXXybCHE=;
        b=BrbVENMaXHqRbh7CYRcSc8qNvuEekW5LScijORTOy63tLyp+2MncpbUISgVKan00f+
         /Mx/1bM92ARhQUWMMET7ngBxzmpRE7pzSWHxmmhOqIL3l7ormgiJ2+gVbLyYhDrule1F
         +/pU+YxiQu3uV4Ppkhp9tWrNw063sFsoXc5sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482458; x=1737087258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ottIiiil7Y6TARNn3P9202RaeajOs8YU2PtCXXybCHE=;
        b=t8nWuQb7PsZZUMUO5mLzeVnZgtC+4ssbOeldb4AbNXlN0MbkcvXqRzWvd+ol3ONcLn
         EX8vw0fGvJRV9SezWoN4G4g7Y5j/nXVfpLsh65mAaLdF1Avk4fkE1gql/9sSRq5Injt4
         OnOYTSLFXItaHbtLu3ZI3gSPYiwC/dzNCX7qz98l3Iml7wrZNlPsZcNz45y0V+6DNki+
         zZkHw4auXoTkNUZ89DPwTv9117ci45WsNSRDXCQqpYkmnTzByGfSHOOmF5XACSDiJlrl
         8ds+aSvkE/Lzg+TPvAxL1zR4YzDCXTv9vVwDfcfnDPFpEz1ggsRfGFw9wNq7eZGo5sMU
         +7UA==
X-Forwarded-Encrypted: i=1; AJvYcCXOWEGjqABhjxsLRmb6yRAbroGVvLt1Khs8fM44I2uQXbx2Tl+VaUhRT7LEJuilAnzKWi08DAMHpAEUNzV8qT540DQMm/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ikoZJKfnM8k8xAtigh23Dfyuoa8Xq8xIOMMAKrm/N6iDsV++
	sFYkWKBn8es3cbFe0vxjiUCkxA3UEpHaGNbrenAdYouKWj9tyRwWvM8UotRUmH2rF+KD+mZhSS0
	WoIxxAAkAo4i9QYmDseEwDaNYwQQYmtJKtrxCRIVGfaTEskmU3Hea
X-Gm-Gg: ASbGnctHiUKa0lQtYT6rnmfeiW2JCCjLvySj9GKpqy5hUls07LXvaA5wIqmpXbzxrr2
	m7sWa1ue+hk4nDE8fFjK27C2592f4diHagUYh71JnGQsCuw9fy4TiLcH8Dcf8f+7j
X-Google-Smtp-Source: AGHT+IGzb5RQzOQ97cmbpaK99mk5M46FiupwMe+2Mk4nrc96XXgdB6uIh4GAXjSMmsnZb1QNu+nuo7WeOXoDqtktDOw=
X-Received: by 2002:a05:6870:1712:b0:29e:6bcd:3ba7 with SMTP id
 586e51a60fabf-2aa069191f6mr4606933fac.28.1736482457757; Thu, 09 Jan 2025
 20:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231014632.589049-1-enlightened@chromium.org> <u6jt67meocvhxlzx4bjt7dyba2piipfznrml46lkv5oi4ft4u5@cbqocdezi7is>
In-Reply-To: <u6jt67meocvhxlzx4bjt7dyba2piipfznrml46lkv5oi4ft4u5@cbqocdezi7is>
From: Shervin Oloumi <enlightened@chromium.org>
Date: Thu, 9 Jan 2025 20:14:07 -0800
X-Gm-Features: AbW1kvYMfzBdXX-e8RKktdLyXJh17sP7rg5jMljFclLqdgQ1EuGnt3B59LyzNOk
Message-ID: <CAMb9sTgEjNk4X+FLwpmi56z+LDV=gYOO=qN5AjQSN4Erw-SUaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
To: Jan Kara <jack@suse.cz>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gnoack@google.com, shuah@kernel.org, jorgelo@chromium.org, 
	allenwebb@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:11=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-12-24 17:46:31, Shervin Oloumi wrote:
> > The main mount security hook (security_sb_mount) is called early in the
> > process before the mount type is determined and the arguments are
> > validated and converted to the appropriate format. Specifically, the
> > source path is surfaced as a string, which is not appropriate for
> > checking bind mount requests. For bind mounts the source should be
> > validated and passed as a path struct (same as destination), after the
> > mount type is determined. This allows the hook users to evaluate the
> > mount attributes without the need to perform any validations or
> > conversions out of band, which can introduce a TOCTOU race condition.
> >
> > The newly introduced hook is invoked only if the security_sb_mount hook
> > passes, and only if the MS_BIND flag is detected. At this point the
> > source of the mount has been successfully converted to a path struct
> > using the kernel's kern_path API. This allows LSMs to target bind mount
> > requests at the right stage, and evaluate the attributes in the right
> > format, based on the type of mount.
> >
> > This does not affect the functionality of the existing mount security
> > hooks, including security_sb_mount. The new hook, can be utilized as a
> > supplement to the main hook for further analyzing bind mount requests.
> > This means that there is still the option of only using the main hook
> > function, if all one wants to do is indiscriminately reject all bind
> > mount requests, regardless of the source and destination arguments.
> > However, if one needs to evaluate the source and destination of a bind
> > mount request before making a decision, this hook function should be
> > preferred. Of course, if a bind mount request does not make it past the
> > security_sb_mount check, the bind mount hook function is never invoked.
> >
> > Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
>
> Christian is much more experienced in this area than me but let me share =
my
> thoughts before he returns from vacation.
>
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 23e81c2a1e3f..c902608c9759 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const =
char *old_name,
> >       if (err)
> >               return err;
> >
> > +     err =3D security_sb_bindmount(&old_path, path);
> > +     if (err)
> > +             goto out;
> > +
>
> So this gets triggered for the legacy mount API path (mount(2) syscall).
> For the new mount API, I can see open_tree() does not have any security
> hook. Is that intented? Are you catching equivalent changes done through
> the new mount API inside security_move_mount() hook?

I am not very familiar with the new API and when it is used, but LandLock d=
oes
listen to security_move_mount() and it rejects all such requests. It also
listens to and rejects remount and pivotroot. Are there cases where bind mo=
unt
requests go through open_tree() and this hook is bypassed?

> Also what caught my eye is that the LSM doesn't care at all whether this =
is
> a recursive bind mount (copying all mounts beneath the specified one) or
> just a normal one (copying only a single mount). Maybe that's fine but it
> seems a bit counter-intuitive to me as AFAIU it implicitly places a
> requirement on the policy that if doing some bind mount is forbidden, the=
n
> doing bind mount of any predecessor must be forbidden as well (otherwise
> the policy will be inconsistent).

I need to double check this with Micka=C3=ABl, but I think it is safe to al=
low
recursive bind mounts. If a bind mount was allowed, let's say /A -> /home/B=
,
then we already verified that the process did not gain more access (or even
dropped some access) through the new mount point, e.g. accessing /A/a throu=
gh
/home/B/a. So with a recursive bind mount, let's say /home -> /C, once we c=
heck
for privilege escalation as usual, it should be safe to clone any existing =
sub
mounts in the new destination. Because if access through B <=3D A and C <=
=3D B then
access through C <=3D A. So back to your point, there should never exist an
illegal bind mount action that can implicitly happen through a legal recurs=
ive
bind mount of its predecessor. Regardless, I think it might be useful to kn=
ow if
a mount is recursive for other use cases so I added a boolean for surfacing
MS_REC in the new patches.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
