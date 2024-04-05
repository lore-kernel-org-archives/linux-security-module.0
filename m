Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EE16FF4B
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334176; cv=none; b=H99CdrkUbXXGjrJhsHJg2eeSA7aE0UPy9jgpzOkSBNoYbDy8gpYzccNtjry4O0pV/ijYJpoaY8EDSxOjrpIeiLmDVsjDlGALzuI/IuqkKhmm37Sc7dgLSx55K9GdxU9bp1Fp7zkJutWnSwdnE3n0dX2t/Hr4CURJzy1Uc7T0eTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334176; c=relaxed/simple;
	bh=CkzMuNkj3cN8dIvITeM7UFTZGwxWNHl9NlYw4/h6L8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FwQe8PwDK2u7VlfaXmxCecXdq2Gql5cnCLzVqheyi11dFmycrD4Iw823eyRkzX8HIlre1w2NsZn8ZangiFjQJiHOZpJNMjAC7hGWsaGhuSDHUoE9RYXYyOEBg5Xh39MoTWlLhgpY9I/d6jAe7mY8q2n1F0zg51ARAnlyVDNHX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJjXdnjY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJjXdnjY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6144244c60cso35059347b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712334174; x=1712938974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwUrlMvM+rXEVIqWbsl+r+Hr3twGjCCQJKVxaKiZeNY=;
        b=vJjXdnjYWh26PYgS5D2QFdJlLeq3g2D/U7LzrK9NA5IVvImQTNuSKTKALSerVj1Y+v
         FCAQ+R+NjH0ygHEj0HLolllP8Fic3OKSMfWrXIsSQMam+f/D2q3yNuMRbIAM/fPz1us2
         sG24mlyhDlU0rQz0uAZ6aYOevHLTceuRtxDz4z6TqmJfEuXm3+ygiRb5fe/ds7DYvwA8
         LN9uO4PDl2aRHNo4v9EmQOP9PhUpZOBlDrKWADTibY/W0/SDYGXEM+yS01p87ZfO+4tl
         MaEFwRrH/agSQxFvZQvdZCQRB/8//flXJleXAL9dqJUDUyS/jQJuWswZ5fLZ07yFKh73
         pn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334174; x=1712938974;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwUrlMvM+rXEVIqWbsl+r+Hr3twGjCCQJKVxaKiZeNY=;
        b=n5f8flxt8wtzWO6SVCqVbEdbyllZZxZ+oAkCPv6nrYmg5+4ujPZjO/BhTgx4mvzY8w
         iPRjhlbpRqkt9RQGV5LIDPjI+BAnILkiBcLZxyAXipW8GlclPbjLpRBHlLIxkfRtMWd7
         0GVRKWRaaAv4pKzbxT2HSPanLLltDKhf7PGVgF18mKRlPH1T7EnCijLdMWB2HDF1zUfA
         X0w4ADwF9gC7XSglJwZ/npsjC9DI0y9GZq/H/0FNoX3l3DONg4QfSgoOjGail9sibLIT
         3P7fomCtf+37Y8w4Op5SyWTEBbUcKq34bYL0apkUMb9tq+KZDYHR3x+o4Ih4mJzNF7Zl
         TUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWUgfK5Grw1KXOlf7V3HHSOkFcZmVHFnkJFrRhaX9lHauvGZW5EdVVZBBXpPqtP9AgHWVSoA6mG4joPgBq8WvdejihG6yYBiuabSZb2un51JuAvwCeP
X-Gm-Message-State: AOJu0YwkLDjUpyA9f3LNUgwK9+1ZpNsBLMOfd0eQq+VRwsaen2XWmZ0V
	lNVDUuv/LvbPL86BwxMkuo2zkMqqRmNWciKoN2qUnwov7Rm6/7+wtoCPXNHHw6n7fLvAj2eYciA
	LBw==
X-Google-Smtp-Source: AGHT+IFfkEHDkX6cNGYdslsDw+WZb0VcpM/Aaw+gxFd6VQjv9bI2I2bG+UOudCm0AIdGM7zAUTf1V2A/KwM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6510:b0:615:fd8:d65f with SMTP id
 hw16-20020a05690c651000b006150fd8d65fmr412530ywb.4.1712334174325; Fri, 05 Apr
 2024 09:22:54 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:22:52 +0200
In-Reply-To: <ZhAkDW2u3GItsody@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net> <ZgxOYauBXowTIgx-@google.com>
 <20240403.In2aiweBeir2@digikod.net> <ZhAkDW2u3GItsody@google.com>
Message-ID: <ZhAlXB3PWC4yyU8F@google.com>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 06:17:17PM +0200, G=C3=BCnther Noack wrote:
> On Wed, Apr 03, 2024 at 01:15:45PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Apr 02, 2024 at 08:28:49PM +0200, G=C3=BCnther Noack wrote:
> > > Can you please clarify how you make up your mind about what should be=
 permitted
> > > and what should not?  I have trouble understanding the rationale for =
the changes
> > > that you asked for below, apart from the points that they are harmles=
s and that
> > > the return codes should be consistent.
> >=20
> > The rationale is the same: all IOCTL commands that are not
> > passed/specific to character or block devices (i.e. IOCTLs defined in
> > fs/ioctl.c) are allowed.  vfs_masked_device_ioctl() returns true if the
> > IOCTL command is not passed to the related device driver but handled by
> > fs/ioctl.c instead (i.e. handled by the VFS layer).
>=20
> Thanks for clarifying -- this makes more sense now.  I traced the cases w=
ith
> -ENOIOCTLCMD through the code more thoroughly and it is more aligned now =
with
> what you implemented before.  The places where I ended up implementing it
> differently to your vfs_masked_device_ioctl() patch are:
>=20
>  * Do not blanket-permit FS_IOC_{GET,SET}{FLAGS,XATTR}.
>    They fall back to the device implementation.
>=20
>  * FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH are now handled.
>    These return -ENOIOCTLCMD from do_vfs_ioctl(), so they do fall back to=
 the
>    handlers in struct file_operations, so we can not permit these either.

Kent, Amir:

Is it intentional that the new FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH IOC=
TLs
can fall back to a IOCTL implementation in struct file_operations?  I found=
 this
remark by Amir which sounded vaguely like it might have been on purpose?  D=
id I
understand that correctly?

https://lore.kernel.org/lkml/CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqawcu+H=
-MC5g@mail.gmail.com/

Otherwise, I am happy to send a patch to make it non-extensible (the impls =
in
fs/ioctl.c would need to return -ENOTTY).  This would let us reason better =
about
the safety of these IOCTLs for IOCTL security policies enforced by the Land=
lock
LSM. (Some of these file_operations IOCTL implementations do stuff before
looking at the cmd number.)

Thanks,
=E2=80=94G=C3=BCnther
