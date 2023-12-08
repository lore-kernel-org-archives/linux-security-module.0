Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yr2TB4rA"
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4819A5
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 13:58:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b9e07690ccso1349003b6e.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702072692; x=1702677492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XdTauwQnJn/usd+gP9F/Q41agpmKDU73FQORLroO8Y=;
        b=Yr2TB4rA14PVmn5QoN3pY9GxRyXvlLkQ6CF7N+KZoHgqNJhLQTpVhCWKOB6d6MxbsF
         AT8MrIeA1cWYCPlsH9ecas6qTn6Di1209XrQOnfHiRPDhrcf2148BJjCqiILjZyAW4h7
         XL56u92+tkaT/sJM7uG84hj4F80c5Ukwu0Ihk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072692; x=1702677492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XdTauwQnJn/usd+gP9F/Q41agpmKDU73FQORLroO8Y=;
        b=IV1IkvuwTf7dSyFJj86mairIA2rP0wPVm+bXmUL7v3F9LonxRAmuBRqYHeW3+tLnxX
         D8uLY90OfCsYivXhs2BvAM7YBG5F1Kkgh+Rd+tvsJUuPohwyPL34B9hfFSPncuDN8fNr
         sD1uWXTeGa1yb11WiGXpOIXETIJaAN4YG5819Wz9VsX0wVZ9tet7uZnvheqtLmHVq1GK
         22WOC1YtTBYMRw6oSzG3D+BaDsEhK75plHFRR+iJm/tD//2Z3Y59XtQRTW57tq4e7+Hn
         BazWL63y5NtIDYvAYAApt7MF1uMq+Ursuq3vpEG3hz6Nn5mjIU8WoirSRNNoZHK3OCqP
         xFXg==
X-Gm-Message-State: AOJu0Yy5tj/CcQxP37n6s2Gs9ZFyTU2HOV5jVibBf6ufEmU9DUAqTa5C
	BVxppYjVzQNAKOQvu9X6fwXELMvp4Ql5v6Y5QOP/vQ==
X-Google-Smtp-Source: AGHT+IGajzN9oKKGmFkf+vWwD8eZFOYLubpVb9mzv1HXSiEf1fjI7rDsNVdcScv16C538G4At+IlFPVHnYTHno7LKKw=
X-Received: by 2002:a05:6870:1711:b0:1fa:f387:e0ab with SMTP id
 h17-20020a056870171100b001faf387e0abmr827203oae.46.1702072692203; Fri, 08 Dec
 2023 13:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-10-gnoack@google.com>
 <CABi2SkULCFBK0eBZen6Z7YSLnm_EcZqbmPN2fQ64bBbmX77uRw@mail.gmail.com> <ZXMQdqeGH6i5aJd8@google.com>
In-Reply-To: <ZXMQdqeGH6i5aJd8@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 8 Dec 2023 13:58:00 -0800
Message-ID: <CABi2SkXoJN6tEaM_=kKPQVmQ3+xROkNGb0XotwM9xSyTZr1FGA@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] landlock: Document IOCTL support
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:48=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Hello Jeff!
>
> On Fri, Dec 01, 2023 at 11:55:03AM -0800, Jeff Xu wrote:
> > On Fri, Dec 1, 2023 at 6:41=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > > +Rights associated with file descriptors
> > > +---------------------------------------
> > > +
> > > +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TR=
UNCATE`` and
> > > +``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly cre=
ated file
> > > +descriptor and will be used for subsequent truncation and ioctl atte=
mpts using
> > > +:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is si=
milar to
> > > +opening a file for reading or writing, where permissions are checked=
 during
> > > +:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)`=
 and
> > >  :manpage:`write(2)` calls.
> > >
> > > -As a consequence, it is possible to have multiple open file descript=
ors for the
> > > -same file, where one grants the right to truncate the file and the o=
ther does
> > > -not.  It is also possible to pass such file descriptors between proc=
esses,
> > > -keeping their Landlock properties, even when these processes do not =
have an
> > > -enforced Landlock ruleset.
> > > +As a consequence, it is possible to have multiple open file descript=
ors
> > > +referring to the same file, where one grants the truncate or ioctl r=
ight and the
> > > +other does not.  It is also possible to pass such file descriptors b=
etween
> > > +processes, keeping their Landlock properties, even when these proces=
ses do not
> > > +have an enforced Landlock ruleset.
> > >
> > I understand the "passing fd between process ", but not the " multiple
> > open fds referring to the same file, with different permission", are
> > those fds all opened within the same domain ?
> >
> > Can we have a pseudocode to help understanding ?
>
> It's a little bit expanding the scope here, as the documentation existed =
alredy
> prior to the patch set, but it's a fair comment that this paragraph is no=
t clear
> enough.  I tried to rephrase it.  Maybe this is better:
>
>   As a consequence, it is possible that a process has multiple open file
>   descriptors referring to the same file, but Landlock enforces different=
 things
>   when operating with these file descriptors.  This can happen when a Lan=
dlock
>   ruleset gets enforced and the process keeps file descriptors which were=
 opened
>   both before and after the enforcement.  It is also possible to pass suc=
h file
>   descriptors between processes, keeping their Landlock properties, even =
when
>   some of the involved processes do not have an enforced Landlock ruleset=
.
>
> Some example code to clarify:
>
> One way that this can happen is:
>
>   (1) fd1 =3D open("foobar.txt", O_RDWR)
>   (2) enforce_landlock(forbid all ioctls)
>   (3) fd2 =3D open("foobar.txt", O_RDWR)
>
>   =3D=3D> You now have fd1 and fd2 referring to the same file on disk,
>       but you can only do ioctls on it through fd1, but not through fd2.
>
> Or, using SCM_RIGHTS (unix(7)):
>
>   (1) Process 1: Listen on Unix socket
>   (2) Process 2: Enforce Landlock so that ioctls are forbidden
>   (3) Process 2: fd =3D open("foobar.txt", O_RDWR)
>   (4) Process 2: send fd to Process 1
>   (5) Process 1: receive fd
>
>   =3D=3D> Process 1 can not do ioctls on the received fd,
>       as configured by the Landlock policy enforced in Process 2
>
> Or, simply by inheriting file descriptors through execve:
>
>   (1) Parent process/main thread: Spawn thread t
>     (t.1) Enforce Landlock so that ioctls are forbidden
>           (This policy is local to the thread)
>     (t.2) fd =3D open("foobar.txt", O_RDWR)
>   (2) Parent process/main thread: join (exit) thread t
>   (3) Parent process/main thread: execve and inherit fd!
>
>   =3D=3D> The child process can not use ioctls with the inherited fd,
>       as configured by the Landlock policy before
>
> The same is also possible with the truncation right.
>
Very helpful. Thanks!
-Jeff

> =E2=80=94G=C3=BCnther
