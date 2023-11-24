Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNr9RKGR"
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5510E7
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 07:39:19 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a01991968f5so150307466b.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700840358; x=1701445158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MdY+CEN7lfJq7E8LmxU/yKl+DLnEKriP7xWtMKyRLI=;
        b=HNr9RKGRXJwapoKyJR+qMqL/0whUhS20vQf6uKw9t+utB0G5kgaa5l47Scy4qh/PHH
         yBS7QhGgV1oY4JTEDtc9gFktzBn0wVVne+CsT4i+eIR4Jg5FB+pSYGimy8Liatp1V3gB
         ciYhMYE1smCvV7jNgan/PiJEbMwRij818KjLwGdn5BJWBiflTEyh0U4Oqz9+j4Pd/jo6
         X3TPEbylCYcSM867ICph6PbYA+bvuT3LUHgcR+t+1nYx5vMg1hc8ZN7XT8sau08OLO0t
         Q0GJLqLF2ETAyj2V//JJ7MJtkvwR5W0VmEZ1oYsm0RUPpP4ZW1IbT2tQ9A/RaMoBzOFm
         gTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840358; x=1701445158;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+MdY+CEN7lfJq7E8LmxU/yKl+DLnEKriP7xWtMKyRLI=;
        b=LZWxvXvqmqkSSioo6GLvFWYPAcxB0ypVPMs1NJT/Wq44lJ7h0hYbgpwdJSX1zyFAMR
         OTho5r13N/FTfefaPcY3+KLnI7vOmbp/uwYrX9vP1TY30EKlqvty52Dh9MIRFJriWlW2
         2iCX8cagzenM27JQvUEGdxiNPyDyCpwJPhiB4KKxVFIbkz7CukYOE7jcxRNe/mOfDahN
         5Q7t7ANqsEGLHJEeOR+S7GaurJzii7Iq9mTe3w3b17TZzRBK18OmVO5/9mxnKQ2P45iR
         0D9+0E8vl/t21EVd9tYEJb0zT6rSs3FGU5i8stTsFpbJWbjIQn8JYslYBEpFTQJSYTrV
         AhFA==
X-Gm-Message-State: AOJu0YxERAqn/OrXI6kFLq/XDWQXFxLy0MxNHrDNYe/P6zSk5MmuHrOk
	f7d2hG6/+MouFqGVMUZLKGVRd5Xg0kM=
X-Google-Smtp-Source: AGHT+IHnNoF6BgJwUOugkI+xgyGHb4W13m56l8pHQe9JmK/keKOh4nXrtdmg1SmVuxwcdqwLJoPICe66tEw=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4402:b0:54a:e7a4:e56 with SMTP id
 y2-20020a056402440200b0054ae7a40e56mr46013eda.2.1700840357610; Fri, 24 Nov
 2023 07:39:17 -0800 (PST)
Date: Fri, 24 Nov 2023 16:39:02 +0100
In-Reply-To: <20231120.fau2Oi6queij@digikod.net>
Message-Id: <ZWDDlvXCdShpFIZ5@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com> <20231117154920.1706371-3-gnoack@google.com>
 <20231120.fau2Oi6queij@digikod.net>
Subject: Re: [PATCH v5 2/7] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:43:30PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 17, 2023 at 04:49:15PM +0100, G=C3=BCnther Noack wrote:
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 2)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 3)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 4)
>=20
> Please move this LANDLOCK_ACCESS_FS_IOCTL_* block to fs.h
>=20
> We can still create the public and private masks in limits.h but add a
> static_assert() to make sure there is no overlap.

Done.


> >  	/* Checks content (and 32-bits cast). */
> > -	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=3D
> > -	    LANDLOCK_MASK_ACCESS_FS)
> > +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS)=
 !=3D
> > +	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)
>=20
> It would now be possible to add LANDLOCK_ACCESS_FS_IOCTL_GROUP* to a
> rule, which is not part of the API/ABI. I've sent a patch with new tests
> to make sure this is covered:
> https://lore.kernel.org/r/20231120193914.441117-2-mic@digikod.net
>=20
> I'll push it in my -next branch if everything is OK before pushing your
> next series. Please review it.

Thanks, good catch!

Looking at add_rule_path_beneath(), it indeed does not look like I have cov=
ered
that case in my patch.  I'll put an explicit check for it, like this:

  /*
   * Checks that allowed_access matches the @ruleset constraints and only
   * consists of publicly visible access rights (as opposed to synthetic
   * ones).
   */
  mask =3D landlock_get_raw_fs_access_mask(ruleset, 0) &
         LANDLOCK_MASK_PUBLIC_ACCESS_FS;
  if ((path_beneath_attr.allowed_access | mask) !=3D mask)
          return -EINVAL;

I assume that the tests that you added were failing?  Or was there an obscu=
re
code path that caught it anyway?

Thanks,
=E2=80=94G=C3=BCnther
