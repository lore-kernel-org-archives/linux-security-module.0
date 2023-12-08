Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b199UgcL"
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97191998
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 04:48:01 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9fd0a58549bso234000366b.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702039680; x=1702644480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+kObd+JIGY2cM/glk/Q9xku9Pg0BTFZYmGYboEHbqo=;
        b=b199UgcLzy4cOonkTSI7UfElaAj1dTAbXCGT15gahTmP4S7GQ1LFDCFk7QmbtqY5LO
         O9I0ZekF4tRV3wlPUU4hkxwAIXw1ZoO2cxB+ZnpFo969gz19YvgC9NG6IiJJKn/pQ5hK
         5b/ohu47gpq0RwcJKl9DgQGO4ms27U2Ttx8AX9vWdeKHKISZEhH/BgwpPS3ryWuQXWTD
         O5iwRwpRVR2IvQpketEIHPQ3wrjK/avM6AoUn/ZR+423dNML6mNQGytQ81kgWRzQAcZk
         f/nJJwDyx3VALejAU11rkfqex7+XaD9SD5jTdjaGX8ga2+388kTP/bdJcmASTUnVbv3P
         JpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039680; x=1702644480;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l+kObd+JIGY2cM/glk/Q9xku9Pg0BTFZYmGYboEHbqo=;
        b=NkIitaLiDVXfBdqGukmP4vFtBLMWaWc5ggkiGFbE1Y2sJ3rEF9MUoZL6bRPFMYpO2B
         4YwYl+8hh2POuHt3NvyXwBslAc7R4JJpITFzPku1u/3/0lhQphsBBlNJFsjhXTt2YjQF
         E2ecQ8fy3IKMq1bkEGrJixlXrEsZPAh+LnQ4kNWviljSHiga8TeV0jdrL4fiLChce2W+
         TOi2S+AIFp3CtNg7rFri+usumci163tAaUhxjYVRPhladWjt/qehf3Vbj2ywFQ+SkAam
         iicMAaYj9gnr1ekt9j5t3EZeTwNN7ghVlUpUeYk8Qnk7rRfEkenSMejjkh6uNM/bYy25
         mK+w==
X-Gm-Message-State: AOJu0Yxyd2LcMvLfpIwJ4U5EBrAvw2UppUS9CnnTZxxqZXl0aLfuFV1G
	rQnu6U9n/zbnoor0bo7+QO6sQiNGmvs=
X-Google-Smtp-Source: AGHT+IFDOcr7bui5v8HTFE7vcdjUHf6o95K/2qxy45eb27If/ShRl0g/wHckFIuhMOF8E3rjyRhHDJTcSGI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a17:906:690:b0:a1f:70a6:dbb2 with SMTP id
 u16-20020a170906069000b00a1f70a6dbb2mr4282ejb.4.1702039680062; Fri, 08 Dec
 2023 04:48:00 -0800 (PST)
Date: Fri, 8 Dec 2023 13:47:50 +0100
In-Reply-To: <CABi2SkULCFBK0eBZen6Z7YSLnm_EcZqbmPN2fQ64bBbmX77uRw@mail.gmail.com>
Message-Id: <ZXMQdqeGH6i5aJd8@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-10-gnoack@google.com>
 <CABi2SkULCFBK0eBZen6Z7YSLnm_EcZqbmPN2fQ64bBbmX77uRw@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] landlock: Document IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jeff!

On Fri, Dec 01, 2023 at 11:55:03AM -0800, Jeff Xu wrote:
> On Fri, Dec 1, 2023 at 6:41=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.=
com> wrote:
> > +Rights associated with file descriptors
> > +---------------------------------------
> > +
> > +When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUN=
CATE`` and
> > +``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly creat=
ed file
> > +descriptor and will be used for subsequent truncation and ioctl attemp=
ts using
> > +:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is simi=
lar to
> > +opening a file for reading or writing, where permissions are checked d=
uring
> > +:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` a=
nd
> >  :manpage:`write(2)` calls.
> >
> > -As a consequence, it is possible to have multiple open file descriptor=
s for the
> > -same file, where one grants the right to truncate the file and the oth=
er does
> > -not.  It is also possible to pass such file descriptors between proces=
ses,
> > -keeping their Landlock properties, even when these processes do not ha=
ve an
> > -enforced Landlock ruleset.
> > +As a consequence, it is possible to have multiple open file descriptor=
s
> > +referring to the same file, where one grants the truncate or ioctl rig=
ht and the
> > +other does not.  It is also possible to pass such file descriptors bet=
ween
> > +processes, keeping their Landlock properties, even when these processe=
s do not
> > +have an enforced Landlock ruleset.
> >
> I understand the "passing fd between process ", but not the " multiple
> open fds referring to the same file, with different permission", are
> those fds all opened within the same domain ?
>=20
> Can we have a pseudocode to help understanding ?

It's a little bit expanding the scope here, as the documentation existed al=
redy
prior to the patch set, but it's a fair comment that this paragraph is not =
clear
enough.  I tried to rephrase it.  Maybe this is better:

  As a consequence, it is possible that a process has multiple open file
  descriptors referring to the same file, but Landlock enforces different t=
hings
  when operating with these file descriptors.  This can happen when a Landl=
ock
  ruleset gets enforced and the process keeps file descriptors which were o=
pened
  both before and after the enforcement.  It is also possible to pass such =
file
  descriptors between processes, keeping their Landlock properties, even wh=
en
  some of the involved processes do not have an enforced Landlock ruleset.

Some example code to clarify:

One way that this can happen is:

  (1) fd1 =3D open("foobar.txt", O_RDWR)
  (2) enforce_landlock(forbid all ioctls)
  (3) fd2 =3D open("foobar.txt", O_RDWR)

  =3D=3D> You now have fd1 and fd2 referring to the same file on disk,
      but you can only do ioctls on it through fd1, but not through fd2.

Or, using SCM_RIGHTS (unix(7)):

  (1) Process 1: Listen on Unix socket
  (2) Process 2: Enforce Landlock so that ioctls are forbidden
  (3) Process 2: fd =3D open("foobar.txt", O_RDWR)
  (4) Process 2: send fd to Process 1
  (5) Process 1: receive fd

  =3D=3D> Process 1 can not do ioctls on the received fd,
      as configured by the Landlock policy enforced in Process 2

Or, simply by inheriting file descriptors through execve:

  (1) Parent process/main thread: Spawn thread t
    (t.1) Enforce Landlock so that ioctls are forbidden
          (This policy is local to the thread)
    (t.2) fd =3D open("foobar.txt", O_RDWR)
  (2) Parent process/main thread: join (exit) thread t
  (3) Parent process/main thread: execve and inherit fd!

  =3D=3D> The child process can not use ioctls with the inherited fd,
      as configured by the Landlock policy before

The same is also possible with the truncation right.

=E2=80=94G=C3=BCnther
