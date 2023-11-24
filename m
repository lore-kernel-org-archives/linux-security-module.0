Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzbxQ+3y"
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C81717
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 06:04:09 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a04b426b3c0so283307966b.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700834648; x=1701439448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr2IrRVnHygGQwZnPc3Doulu3eD6g2JaFbhbMU861po=;
        b=lzbxQ+3yS1mjqJs5yqI6zxlLVq+8EQdbSt9ZHnkYGslwJqOLBUK1lJRZVhQSexldFT
         NS4Gh1VjEz7Klf3XDR1cqlIPQwgCUf/cNUji/hEyvOYwjwSutfa8WpmW+UmMWBoQz90X
         DDvFKW5detL3IgSNEPV/nzx+yqXePqCAUl+279l57V87VP/iXwvP/nFmdpG4v4h/Os1b
         x+e04GXs35GIZPYGCyldckT1h1ESByzopOiPa73UOTm41CUxL4zrLnzw5PhTFAAyaHqz
         z0IcwFtZBSel44X9PuLa40MyHpkXRFA3s9edtgVChhVWIHDuGqN3T/1xcI3VyONGpMki
         fVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834648; x=1701439448;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fr2IrRVnHygGQwZnPc3Doulu3eD6g2JaFbhbMU861po=;
        b=EhyePdU3oCf23wC351LRTuT7WCVr/G6Hd/W1uI+HGDqPCm1523tvqPmhvM3snKJMMV
         2iSh7DBiciY2COicS7xyyVB3KaPlJXQ8ijMhbYQunmIK3+Emt3HnVrqw+yJ9UOiVGqA7
         jWXZN9/I8lgTM+uSuzyV8JvWbGNb16jNlgv9SEX8ik46uyfCLmclOyronIIVsIbp8ZzQ
         nagVYVf0N0gQuP7SfQDYptlXWCRQMAT/ThyLJm+J0V4CadNRO3nBlKS9hZRLNZlx03Yh
         xDkDeDhBUXaBYDcL+LpEduK5iZ09oy1OfrfaA9BqH0XCq99KMcQzqu136DJCB7flBY5P
         lhfg==
X-Gm-Message-State: AOJu0YwK3UJOJfwuo4bAjxHhTgOv1f5vfsmIE3ch2dq9zH3/+gMj6pBS
	TDGZ4KK4SxJU/6iAjxaQHKu1rrX040g=
X-Google-Smtp-Source: AGHT+IF+FqpMCwIlNhqiRw4ZLjdqNBVASa0/H/osupW5IIKccBTleXoXAOYJzPb1nw+LfyirOWjL26tdMbw=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:907:cc97:b0:9fc:b396:1718 with SMTP id
 up23-20020a170907cc9700b009fcb3961718mr61316ejc.0.1700834648250; Fri, 24 Nov
 2023 06:04:08 -0800 (PST)
Date: Fri, 24 Nov 2023 15:03:58 +0100
In-Reply-To: <20231117.aeZ3koh4bu2a@digikod.net>
Message-Id: <ZWCtTnkL_aYA9cdQ@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com> <20231117154920.1706371-3-gnoack@google.com>
 <20231117.aeZ3koh4bu2a@digikod.net>
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

Hello!

On Fri, Nov 17, 2023 at 09:45:47PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 17, 2023 at 04:49:15PM +0100, G=C3=BCnther Noack wrote:
> > +static inline access_mask_t expand_ioctl(const access_mask_t handled,
>=20
> Please remove all explicit inlines in the .c files, the compiler should
> be able to inline them if necessary, or it my not inline them at all
> anyway.  It would be nice to check the -O2 code to see what GCC or clang
> do though, and I guess they will inline this kind of pattern.

Done.


> > +					 const access_mask_t access,
> > +					 const access_mask_t src,
> > +					 const access_mask_t dst)
> > +{
> > +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> > +		return 0;
> > +
> > +	access_mask_t copy_from =3D (handled & src) ? src :
>=20
> Please declare variables at the beginning of blocks.

Done.


> > +static inline access_mask_t
> > +landlock_expand_access_fs(const access_mask_t handled,
> > +			  const access_mask_t access)
> > +{
> > +	return access |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP4) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP3) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1);
> > +}
>=20
> I'd prefer to keep the semantic definition of these groups (i.e.
> required_ioctl_access) close the definition of access right expantions,
> and also close to the ioctl_groups veriable. Actually, ioctl_groups
> might make more sense close to the group definition, and then probably
> another define... What do you think?

Done, good idea. Thanks for the suggestion!

I think this makes sense and the code looks better when the IOCTL-related
functionality is grouped together at the top of fs.c, including ioctl_group=
s,
the LANDLOCK_ACCESS_FS_IOCTL_GROUP1,2,3,4 #defines, the expansion helpers a=
nd
the required_ioctl_access helper.


> > +	/*
> > +	 * It is the access rights at the time of opening the file which
> > +	 * determine whether ioctl can be used on the opened file later.
>=20
> s/ioctl/IOCTL/g

Done.


> > +/**
> > + * landlock_expand_handled_access_fs() - add synthetic IOCTL access ri=
ghts to an
> > + * access mask of handled accesses.
> > + *
> > + * @handled: The handled accesses of a ruleset that is being created
> > + *
> > + * Returns: @handled, with the bits for the synthetic IOCTL access rig=
hts set,
> > + * if %LANDLOCK_ACCESS_FS_IOCTL is handled
> > + */
>=20
> This doc should be in fs.c

Done, thanks.

(I did not realize that the convention worked this way in the kernel.  This=
 goes
on my bucket list of things to double check.)

Thanks for the review!

=E2=80=94G=C3=BCnther
