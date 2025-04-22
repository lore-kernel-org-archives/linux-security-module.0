Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1825C806
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356418; cv=none; b=U/X+P3iFoQ0zs2AbfuIbzNeX7pAHS3ivSx162Uy8/W1DYc+sfRsJAUIGefAlFsw9f53pZGJyGDGOsUscKGqSk02yPlAbrWCarZzXzfdKQec3u15/pBLfeUszK99RV9Jv1WjnkccQOVgPUVY0yIgYiElC5KiBZMU84uh+XRJqcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356418; c=relaxed/simple;
	bh=sW+znyryRbHyW0IOmp1mYsbB6AfOwYiGpr+d1KBJZqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYqL/jEkDDXGAO+QR2sP8ThQFR7y6uPnIt7jB2N41qnvd8GEaBNMOdg/qAwhPiDlSGKeZ8CzfJp+SAiN+NEud6TVzmhqGJ079InBeNfocMhitQsjdr8JqHfYcTGbt/9uLNCx4u/dIub/8jAhO6fq/x/+P1FbNkIeePd22vRE78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KB89PNLG; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KB89PNLG"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53a91756e5so4624324276.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745356415; x=1745961215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t905J/9Jzq7QDEnsFpl61V1PC44MZDButCS5FbcwW0I=;
        b=KB89PNLGIldjGjk9oK120x442MqBQnLZSfDXvPhxSuw1L1JqYL26d1jKN2kd90hFMx
         zx6rPhsESS80iutBi8g1POTyCb457AiDX3v/GaxgcDizN2/HPxRreyoaYNuAcUU7WSMK
         c4et6iG/XZZykSpetc1GJ3UyyBvtvR+iPEuSDRQRwzX+eDewU4J1iAp9eHkRBUdRw/gV
         vU/nAKh4qtHVEBm/8k2/MQHNS7qL7jvL/GNJ5ZtlrJtyBlL1nUoYHBcYUzXPG8+6cHHs
         3DxVsHSxTtLidR4tnrjW+PqoCudr7We96BSJOPYDNRF2DX27yHcJD48ndyEHmbeUyJFO
         8fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745356415; x=1745961215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t905J/9Jzq7QDEnsFpl61V1PC44MZDButCS5FbcwW0I=;
        b=vhGkfzwYK28mkQYYc+FKDy3WPhtyoIAn4HlX9xr0y5Z3zeE5G2gpU17Tr/6Gb65cCX
         ff+7GSDar7h71mlg55SVfm6fnhbGcl4foc3DB74DgSmWDJTazVM0GXN1vcSESwWyplWU
         P3e3fZaqjyeoa+TJ0YUz+5KT9tXhEySGmPH6xW0qm+JkwTVFBfFYtIbOzd+3VymuT8wC
         JQ66CR+zlG1EyOOziPdvnwXtBmg9WZbSjw5iCatKUeAKe5LxYEqQrbIHCFIZHsA/zvYq
         0sTlY7ptMVVC0Xg919YWEcCdQ9nMMzjnQPsYFuRenHkncwomhDeQ/OZmkokF+WLcFU5Y
         emMw==
X-Forwarded-Encrypted: i=1; AJvYcCXiV+cvn9tr6MrrvdJW5Hmx0goIEGl+Pdec8fbBzHAU+3u6pTz2JDZFlDK9enz8cyLowYKORrX4H5GUGI+trsyJfxKFu8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mdWZnnpwQmMoy8fKNnTmeVVmkA1pxGdxlOXSa5GsX9YhSjbv
	JY3MPTJqxDGB91lFEWSafTy6xINC4uCdoazgzBIg6wuE+h5YoeAYYIFK72tOPtjWaWI5ab+Vegf
	ODHkUYtgfugO+1IUkmdCo30qL9OwYxQjrMU9UN12nppbdcH4=
X-Gm-Gg: ASbGncsMmyDHG5LH7JMYMwyHtR8utjaFK03B01dkiF4urDGoPbX1aoI6MVuMzdaigqW
	2xNgDYsXAlK4otuGE2/BuLPWfY1yXWc/eKgtmmDL3XsyjHK7T2FWTj+zMo7m27A6uTXTFZth16B
	A/VJl4kMBkuqnUpkTxd+LoJw==
X-Google-Smtp-Source: AGHT+IFpDAoQj0jr+Kv0AOnO0Nh+mRGr9KGlxsTyZYi64JoPDslfEoy79qoTOuJFCrXFxAKORL0eJr3ROIZtfNxV0gA=
X-Received: by 2002:a05:690c:688e:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-706cce45279mr213438847b3.38.1745356415570; Tue, 22 Apr 2025
 14:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184407.3257964-1-song@kernel.org> <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
 <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com>
In-Reply-To: <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Apr 2025 17:13:23 -0400
X-Gm-Features: ATxdqUHgxA_WRa1zOdkgmVadFw5u_hgT8n18gbvSTKUzcvTal2wjXMVtF9IqO2U
Message-ID: <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:31=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
> > On Apr 22, 2025, at 12:53=E2=80=AFPM, Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Apr 22, 2025 Song Liu <song@kernel.org> wrote:
> >>
> >> Only TOMOYO needed CONFIG_SECURITY_PATH when it was introduced. But no=
w,
> >> AppArmor, EVM, IMA and LandLock also need it. And kernels are likely b=
uilt
> >> with at least one of these enabled if CONFIG_SECURITY is enabled. Let'=
s
> >> simplify the dependency.
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> This was initially proposed in [1], but got Nacked by Paul.
> >
> > I chose not to merge the patch with the following comment:
> >
> > "If a Kconfig option is only needed by a subset of LSMs, which is the
> >  case for CONFIG_SECURITY_PATH, it should remain a build-time option."
> >
> > ... and that reasoning still sounds reasonable to me today.
>
> I agree that a way to disable some LSM hooks at build time is valuable.
>
> >
> >> ... but it is really up to the LSMs to decide how
> >> they use struct path.
> >
> > LSMs are currently free to select CONFIG_SECURITY_PATH as needed.  In
> > fact, if you look any modern Linux tree you'll see that TOMOYO, AppArmo=
r,
> > Landlock, IMA, and EVM all select CONFIG_SECURITY_PATH based on their
> > individual Kconfig settings.
>
> However, I don't think existing CONFIG_SECURITY_* are doing the right
> things. Among all the configs, CONFIG_SECURITY_PATH is the most awkward
> to me. Say , if we have CONFIG_SECURITY_PATH, shouldn't we also have
> CONFIG_SECURITY_INODE? IOW, something like:
>
> #ifdef CONFIG_SECURITY_INODE
> int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
> #endif
>
> #ifdef CONFIG_SECURITY_PATH
> int security_path_rmdir(struct inode *dir, struct dentry *dentry);
> #endif

Without putting much thought into what would fall under
CONFIG_SECURITY_INODE, I think it would be interesting to see what
hooks one might be able to make conditional on such a Kconfig knob.
Using security_inode_permission() as a simple test, it looks like only
SELinux and Smack provide implementations, spot checks on a few other
security_*inode*() hooks shows similar, or even more limited, results.

You would need to spend some time to determine what LSM hooks are used
by which LSMs and adjust their Kconfigs appropriately for the new
CONFIG_SECURITY_INODE knob, but if you do that then I think that would
be okay.

> OR, maybe we should just remove security_inode_rmdir(), and users of
> security_inode_rmdir() can just use security_path_rmdir() instead?

Those two LSM hooks are called from slightly different places in the
codepath which has an impact on their environment.  For example, the
inode variant doesn't have to deal with directory inodes that don't
have a defined rmdir op, whereas the path variant does; the inode
variant doesn't have to worry about S_KERNEL_FILE files, the inode
variant has a refcount'd and locked dentry, etc.  Moving an existing
LSM, especially complex ones, from one LSM hook to another, is a
delicate operation and might not be worth it for such a small return.

If you are interested in reducing the impact of the "inode" LSM hooks,
CONFIG_SECURITY_INODE is likely a better place to start.

--=20
paul-moore.com
