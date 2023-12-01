Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX5+BHEB"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51610F4
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:05:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb6271b225so36610997b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701439507; x=1702044307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ck7o7kI9SnFnJk6SFmDVT9+oFCJ/ZmbOezGf884RAo=;
        b=qX5+BHEBh08Gt2+wEHzOjDLU+Uv1oBfq8h2CkSMSqEYP1XqJmq8Fmg/5p+V4Wp/PKo
         MIydRT2eu7PLOFrLIkTEqwI57V3o+i0HrBtKNoZPGeXuq7Yux4iaJb+AmNWDrPkQi0Aq
         +KsWBxet5rcf7VioKatXE4PaliJ08sTLpo4m3MY6MEY8NTJ7rbFv1T62rlXyJ8nRIhPT
         UarH2yDy4SRZmF8UBCgMwLVPiHEDF9XP876LQrpRTjYHc8evBmIihRHReFrLczckl4+J
         n+OU/cwZSzkz6I/kP/inBu+bJorjedlXoC1NU3DzTT+oP4ZcBWpOJgqx/sgKN/n4vouF
         XiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439507; x=1702044307;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Ck7o7kI9SnFnJk6SFmDVT9+oFCJ/ZmbOezGf884RAo=;
        b=HrXel8iqp0uQqTTZO6MskEdjJiwg+zbWeRdx/yt+L14+P7X6Kb0rf4aqZ57yU/yFFV
         B/7XfaLUbtWRSKUBuZzw3UW5TOVm/AQpbpPrpw2r24s1PmS/jn6y3SJ7RTvgN+X6xjR6
         CKYJkjqaGCtOL3ZmeCXPFB4iR2WOLwEgoX68+PrNJd43B11D5Kxpq4nEkdUzSU3KH3BN
         PkBAZVbor9m5+9KBTa6vgDj5rftoGCfg5vNK0PhmOmLyOCRNUiKaJZxD4GN9+KsGZehB
         ckTQEwxEuZqK/hTAVd0n8Tnumskv5MmMuADXNEQHrtQIXCrB2ySVtfqhNBF9s7IoHiRN
         Y//g==
X-Gm-Message-State: AOJu0Yzl8+u5FITwyT3QovDfRB0YWfIpRIvQ3/sIBQJHGEVCj4iqQaaq
	9feqxJ2yJ26Z9I3zlnaCtGYcg9n54bk=
X-Google-Smtp-Source: AGHT+IEDTXef090ns3czt4xFymV+h+doe56IvFV/gKNeRnFUlPiuYPYjzfvCC9kmYK4JNbW4hlYYhjdbcXE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a81:9852:0:b0:5d3:5a95:2338 with SMTP id
 p79-20020a819852000000b005d35a952338mr168788ywg.9.1701439506934; Fri, 01 Dec
 2023 06:05:06 -0800 (PST)
Date: Fri, 1 Dec 2023 15:04:57 +0100
In-Reply-To: <20231128.ahdoSh2bag5u@digikod.net>
Message-Id: <ZWnoCYXcS74axxA8@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com> <20231124173026.3257122-5-gnoack@google.com>
 <20231128.ahdoSh2bag5u@digikod.net>
Subject: Re: [PATCH v6 4/9] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:28:44AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 24, 2023 at 06:30:21PM +0100, G=C3=BCnther Noack wrote:
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -83,6 +86,141 @@ static const struct landlock_object_underops landlo=
ck_fs_underops =3D {
> >  	.release =3D release_inode
> >  };
> > =20
> > +/* IOCTL helpers */
> > +
> > +/*
> > + * These are synthetic access rights, which are only used within the k=
ernel, but
> > + * not exposed to callers in userspace.  The mapping between these acc=
ess rights
> > + * and IOCTL commands is defined in the required_ioctl_access() helper=
 function.
> > + */
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1 (LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2 (LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 2)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3 (LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 3)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4 (LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 4)
> > +
> > +/* ioctl_groups - all synthetic access rights for IOCTL command groups=
 */
> > +static const access_mask_t ioctl_groups =3D
>=20
> I find it easier to read and maintain with an ORed right per line, which
> requires clang-format on/off marks.

Done.

I turned this into a #define as well, so that the static_assert() works eve=
n in
the GCC9-based PowerPC configuration where the compile previouly failed.  (=
I
have not reproduced this, but it seems obvious that this is the problem; th=
e old
compiler does not realize yet that a "const int" is constant enough.)


> > +/**
> > + * landlock_expand_access_fs() - Returns @access with the synthetic IO=
CTL group
> > + * flags enabled if necessary.
> > + *
> > + * @handled: Handled FS access rights.
> > + * @access: FS access rights to expand.
> > + *
> > + * Returns: @access expanded by the necessary flags for the synthetic =
IOCTL
> > + * access rights.
> > + */
> > +static access_mask_t landlock_expand_access_fs(const access_mask_t han=
dled,
> > +					       const access_mask_t access)
> > +{
> > +	static_assert((ioctl_groups & LANDLOCK_MASK_ACCESS_FS) =3D=3D ioctl_g=
roups);
>=20
> You can move the static_assert() call just after the ioctl_groups
> declaration (contrary to BUILD_BUG_ON() calls which must be in a
> function).

Done.

> > + * Returns: @handled, with the bits for the synthetic IOCTL access rig=
hts set,
> > + * if %LANDLOCK_ACCESS_FS_IOCTL is handled
>=20
> Missing final dot.

Thanks, added here and also in a few other places where I missed it.

=E2=80=94G=C3=BCnther
