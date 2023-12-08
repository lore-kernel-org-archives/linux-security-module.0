Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsf9QDnZ"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48080173C
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 02:20:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso23226197b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 02:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030853; x=1702635653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySaFJ2QFmUuvPKAGDmyec7fNSS8cS31F+E74vXYhN7o=;
        b=Hsf9QDnZNtsMD6pnQdNBDizK3m7D9IhO2uCvJ7FVERE3l3AT7B2htznIgn19FbhPBh
         otGweY69GKwQWT0Ux7zVYV5C67otVq0JV3StN8d0Vcea/9SmIydeKZUcSWdP4oMVEP7x
         XnA9J15QPbNgBjZg8nzgArU1sHXzqV8NSPi7ODixelFzKSO/UXXlmltzoDxvhUuHNJWN
         yAOyzMV69qvga0PtFSbUzGDZZswRZbFd7q+Wo1o6NpJ0Tn8tSWDtDmUrepjtpOS9ASqy
         2FdaTEJrpgaocja2bYln2YUCd1Yep1x3mo2L1t+l2G/A7kHINXYqKUlPG0/7LUO4ER00
         wVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030853; x=1702635653;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySaFJ2QFmUuvPKAGDmyec7fNSS8cS31F+E74vXYhN7o=;
        b=tSwCkCOpg6Se/P6sVXQm3qLz90qk0n3SxLuC4XRUsXtnb33l4OfOVo3oMXXLBg3DLP
         2Y51ScsiMwV0pOnBi0KIdy1v0Ofn8bY38EeVmSS6dSEjTibjkg5l+dx9FmAi//9e/8mI
         Vk6UDrMMQ1HsaeHaSqqQJSNOS4LpxKysH8hLGn0QttyhgB6MSTKAmkXOQBiksiOlN0RZ
         Fm/tHcKYmgd3/9MgLaY9GsySUA/So08E6Y4Zwl6LYqxIe6eGp8r/Rt8Y0MfkxvfffvL/
         9AwkYjPj8WmKlhLK5sLz/8fMx25uN/yJOZwAouFqkvoTtaMvZLdtU3OgbeVYyIItc6tL
         LoXg==
X-Gm-Message-State: AOJu0YxX+pwLyVeo9kY4PQP1maVG+7lYc6YxWPa/Y4OGsfhbIqRItNSF
	9/Buc22dwFFDyPDwKpN8z4B4PgtNFgA=
X-Google-Smtp-Source: AGHT+IEIBJSHoHcB6uCL6FpS7AscAT4qpHma+cr8VFsmorCTLSRFzVjs6l0QTo9cfENLMZ1tCqAXOBRYhn0=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a25:d096:0:b0:db5:3e28:4893 with SMTP id
 h144-20020a25d096000000b00db53e284893mr46663ybg.12.1702030853455; Fri, 08 Dec
 2023 02:20:53 -0800 (PST)
Date: Fri, 8 Dec 2023 11:20:44 +0100
In-Reply-To: <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com>
Message-Id: <ZXLt_GB-3ngyMM2O@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-5-gnoack@google.com>
 <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] landlock: Add IOCTL access right
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

On Fri, Dec 01, 2023 at 11:51:16AM -0800, Jeff Xu wrote:
> On Fri, Dec 1, 2023 at 6:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.=
com> wrote:
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -18,7 +18,10 @@
> >  #define LANDLOCK_MAX_NUM_LAYERS                16
> >  #define LANDLOCK_MAX_NUM_RULES         U32_MAX
> >
> > -#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_TRUN=
CATE
> > +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS LANDLOCK_ACCESS_FS_IOCTL
>=20
> iiuc, for the next feature, it only needs to update
> LANDLOCK_LAST_PUBLIC_ACCESS_FS to the new LANDLOCK_ACCESS_FS_ABC here.
> and keep below the same, right ?
>=20
> > +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS ((LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1) - 1)
> > +
> > +#define LANDLOCK_LAST_ACCESS_FS                (LANDLOCK_LAST_PUBLIC_A=
CCESS_FS << 4)
> maybe add a comment why "<<4" is used ?

I'll add a comment to the section explaining it:

  For file system access rights, Landlock distinguishes between the publicl=
y
  visible access rights (1 to LANDLOCK_LAST_PUBLIC_ACCESS_FS) and the priva=
te
  ones which are not exposed to userspace (LANDLOCK_LAST_PUBLIC_ACCESS_FS +=
 1 to
  LANDLOCK_LAST_ACCESS_FS).  The private access rights are defined in fs.c.

This should clarify both questions, I hope.

You are correct -- the private access rights in fs.c are defined relative t=
o the
last public access right.

=E2=80=94G=C3=BCnther
