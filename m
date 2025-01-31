Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369251B87FA
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320828; cv=none; b=qRWhhqeUEoZzYJLDHDkK3Wsnofu7dl14btC95Kx2vjr2VdTPpp7KKKD2jed79Cf9ooxj3wmlTeJsQQvO/GHKpkSeEqZVh1+ozWrDhvfzbQH9rMMe7/DjVjDtlyY2ZZBFp/QKi5L7JosuTBupTTCRPRJuiXxFPeQiJbtF9oxbGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320828; c=relaxed/simple;
	bh=3hgXlMVhcYDMAsw2gDN/SsigYYRtx/3Q0mYMmRqGjPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNSXYiNjsAlRXftAT5A/il+PTF2K24DMFZ5dfDn+7YgsBe3t/1uD2dUfqq/H468BaH5M3qECDtRSZKIDtDZMNeJORHLGQe1sbsobxv9mzW9ttm+hZMF/CB69apiZaDgQrOayoOsrojHONCutgo/kATCZQYWWiIlNlO3Sb7booPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N/qek0Av; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N/qek0Av"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46783d44db0so16843371cf.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738320824; x=1738925624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gz7xi3O43Ehum+iPQ9UUZJFWDqVki37iCW9g6uPJck=;
        b=N/qek0Av7+ThM2uead7lhlFud0zEJBJUagVromze9POHfLyLSaESaINw8XPya2cN1i
         5U5ygAaaPDs0A2b2m7z9T/0l4mGhXpHS1V6UM3+9MmrBhzeOVn8+StKA2VVTyYzJhBcK
         giWQvA7QpwTU/ttu/AiS/jmYxgEjNDFCYtzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738320824; x=1738925624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gz7xi3O43Ehum+iPQ9UUZJFWDqVki37iCW9g6uPJck=;
        b=gCMl2DLuKXrZytfSI0/vdkN3tNo5tgXio21FSx9aXl/beVuOZ5gHRKHuwUvggyef8F
         DAd6XYeHUfltyVNLiv33SoA35zPeZP1y3HyDNOKH0iPksTp0OMMuPAlJkvWg5QRr3z7S
         ZhM1rIB9j8+uSvMg3wA8JhbDUpN1gwwESw5ZivRuo1aqcU1H/sofFuD9enr066GPwYek
         OEniiKUpvPafqqzM7oMsz7H2KtcKCBhOXY5PuatP1PuNn9p0YEr1F8ZuFCgjb6q9CLtz
         BMQbxqooDYijgEr1oO0WLdSBVmAK0zgVHdofNbneUpiRvaGZhZXyPjP9h/me9sq+0njy
         a+9g==
X-Forwarded-Encrypted: i=1; AJvYcCVLV/ZwYCN4qCoqfsEsGqhOrgSiUH+8Xj5lO2efFGWtysrWqKq1pgzzJ3YLh0Jsw9IRkoObxSOQUk+1OF8FikMisow9q14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1GLG7RsAZLaXrprJpxWmXVyotfaCjbzFomCsJwD3XFSVns5b
	t9MR4kXJHV/L6K0bpwQmEaMfSRB+LB8P/Mg+xcOTizVwel+bQ8YkZt3THBupN1iAk652HYpmMUs
	OPa5FZT36MC8f49mDNLjkgI4hAvVDmy8lQAUbVQ==
X-Gm-Gg: ASbGncvfMrtVoqQkpS+fLmd2N4qQKA47hMAC1Hpe/RBVCZsSwgb7KZ+FwcTohn1UtZr
	sMY/Cjnni44oGU86GoHx4Tbn3Cn4xy0CrV5rBZdCCnmohVJ6xExYwSA8N/jNicrFLVM8uPxCjs5
	4=
X-Google-Smtp-Source: AGHT+IGQs7Swg2gHWVL9TEZAftmQSjqdSY2+1HDzTpdlHt+nPPJXWc2CGYdtUcQGvQVdbfa8zhiVpNeTdhC3/S9tzaE=
X-Received: by 2002:a05:622a:4892:b0:466:a091:aa3f with SMTP id
 d75a77b69052e-46fd0bda639mr157983931cf.51.1738320823911; Fri, 31 Jan 2025
 02:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
In-Reply-To: <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Jan 2025 11:53:33 +0100
X-Gm-Features: AWEUYZnIaqZ2L8wnwxQyaF6vo-Q8TTduPo-90Aj83nHgX6WhuWWuru9KNDGRYME
Message-ID: <CAJfpegu3N9T4cTQ5z+a_nsTpK1KFNDL-NduhMp15stB3O31=+Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2025 at 22:06, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jan 29, 2025 at 11:58=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.=
com> wrote:
> >
> > Add notifications for attaching and detaching mounts.  The following ne=
w
> > event masks are added:
> >
> >   FAN_MNT_ATTACH  - Mount was attached
> >   FAN_MNT_DETACH  - Mount was detached
> >
> > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > FAN_MNT_DETACH).
> >
> > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT contain=
ing
> > these fields identifying the affected mounts:
> >
> >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> >
> > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these eve=
nts
> > and no other type of event can be received with this report type.
> >
> > Marks are added with FAN_MARK_MNTNS, which records the mount namespace =
from
> > an nsfs file (e.g. /proc/self/ns/mnt).
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/mount.h                         |  2 +
> >  fs/namespace.c                     | 14 +++--
> >  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
> >  fs/notify/fanotify/fanotify.h      | 18 +++++++
> >  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
> >  fs/notify/fdinfo.c                 |  5 ++
> >  include/linux/fanotify.h           | 12 +++--
> >  include/uapi/linux/fanotify.h      | 10 ++++
> >  security/selinux/hooks.c           |  4 ++
> >  9 files changed, 167 insertions(+), 23 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..06d073eab53c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path=
 *path, u64 mask,
> >         case FSNOTIFY_OBJ_TYPE_INODE:
> >                 perm =3D FILE__WATCH;
> >                 break;
> > +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> > +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> > +               perm =3D FILE__WATCH_MOUNT;
> > +               break;
> >         default:
> >                 return -EINVAL;
> >         }
>
> Ignoring for a moment that this patch was merged without an explicit
> ACK for the SELinux changes, let's talk about these SELinux changes
> ...
>
> I understand that you went with the "simpler version" because you
> didn't believe the discussion was converging, which is fair, however,
> I believe Daniel's argument is convincing enough to warrant the new
> permission.

Fine, I'll work on this.

>  Yes, it has taken me approximately two days to find the
> time to revisit this topic and reply with some clarity, but personally
> I feel like that is not an unreasonable period of time, especially for
> a new feature discussion occurring during the merge window.

Definitely not.

Christian is definitely very responsive and quick to queue things up,
and that can have drawbacks.   In this he made it clear that he wants
to get this queued ASAP regardless of whether there's decision on the
SELinux side or not.

What I think might be a good thing if Christian could record
conditional NAKs such as this one from you, that need to be worked on
before sending a feature upstream.  That would prevent wrong code
being sent upstream due to lack of attention.

Thanks,
Miklos
