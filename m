Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C208171C4
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662419; cv=none; b=pxJjEadg3ROS72KKG81DOAup1JyVi5QC6I5PtN4q4wsayxH6M2Yqqf2yWKa7RcCtmey3kSe+ZSWrQMiEpEjEa4nY9GEAFGuMcmEpHcVBAHpUMGs4fZr+Iqu4W0S1NS7m6ZC6d9kQEsTYlcFjmG1mvXw6ANSI0okVT7OkIS0C6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662419; c=relaxed/simple;
	bh=CyJ+JVpGoJ4qDpCfYN+TgGsjupl/TFtO0j1iKddU+ZY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Gne4KX6ID32jX13XRELKTeUSRIj4PB/6M3J913jZoe9UIIWjFKU3o+T/xY/BSeMdO51KY9aHkFIDFPPO6iaDTPgaA2sXyX+jOUuPKsySCCBB98wEP+46nF/McrUR57Z1BZWkgZ0NfrrHyx0GLfHK4zEoECJXYlbWE44/QGi1irk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mRPyIU+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mRPyIU+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so1660655276.2
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2024 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709662416; x=1710267216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PGdbsMXUiUuSsiQWp5Jqqrn2fXA5rzGMtAum3VRSFA=;
        b=0mRPyIU+kSE6PlGTrbhQceT7nigp1dlHdeEWS+s3kM4a9v7kD+oIdQ8x4b4lA3I3oo
         bwloyGO+/NeBHm/4DvfXSthgirSKKgFmegkdqHgQClNZu/DN1SH0GEbu/yXCmH97yjsR
         3WJID2IF30bFyPU7xrcS3af3EYu/PCTtd4cyuTK4/s+NCKekz8g/YM3r1uQ4HC8cBJeh
         Uk7ywsBDjbGy2y6YxQ1ZsmBhOwjc/wm063sCJIlVY/buWAcGT6MxX7E0dKRs0LcaVh2d
         neuSoQbtb+tw/dw1qy/SGbZ9M36J8qmO0oxCI8H3IIg7eRvPcCe8E0CEKcC2I+M/A4VO
         QgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709662416; x=1710267216;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PGdbsMXUiUuSsiQWp5Jqqrn2fXA5rzGMtAum3VRSFA=;
        b=FkXUY10JqmuqV4vZ0FG7EWRVxiyRub8KmZhC/UZsHvVGnu0FxKWGgGm+f4msmHLV8B
         bCdu7hnQNB8RbUpNEQ05IYURqYgUo1A7smE6vySnNp27jy7ot55lEgeWb3Ciq6fZUnr+
         plpyaPCf8Tt0YBpVEnsPHO45lIwlLP6bIDeGf0vXBKTt1NKSW7xnfsT9H1MB5l+a6x76
         aOdEQ0kthVgG/Himzm6/heacQ/opBGPZLtsfjdOjxCH/yyaN2toCcPFcUb68hrD+Vbwj
         lpcdhcVjOnqGOUwMcxcPI6OoluoyVp9TyCvHgsKyKiHewct9lNx8G0ZDEPYPw4LJ4Ymo
         F8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW94uX/s1zvbX04oIup9exBQLOCa0FSNxI5ArkQNdfitnCiNDsltZ/XYeiowCzV9u1udv10hhBG4ZV72/tB0buBZG/2qnzNTxv3spNU1wnVYIqJQkRU
X-Gm-Message-State: AOJu0YzM/ucLs0YmTl02cj0YaCxG9y5QOiuzC4TO2EinGpJg8J7sFjmj
	YO+5P1QDyRi5gmizznfAupsOiT9FX9VSZYj8/GzsDjV228Bfw+XS9x52UfoLMgjPa8UFHBTkV/4
	z+Q==
X-Google-Smtp-Source: AGHT+IF6z+F2YOlwKgoVBTrvWxNMHsOF8Ll7r5c+S4i+fsZtpxIxP/lO6puQn10mOk+wsifGwq1vHUdZF6M=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:bb98:7678:19cd:5dec])
 (user=gnoack job=sendgmr) by 2002:a05:6902:18c4:b0:dcc:c57c:8873 with SMTP id
 ck4-20020a05690218c400b00dccc57c8873mr3464476ybb.9.1709662416601; Tue, 05 Mar
 2024 10:13:36 -0800 (PST)
Date: Tue, 5 Mar 2024 19:13:33 +0100
In-Reply-To: <20240219183539.2926165-1-mic@digikod.net>
Message-Id: <ZedgzRDQaki2B8nU@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219.chu4Yeegh3oo@digikod.net> <20240219183539.2926165-1-mic@digikod.net>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

More questions than answers in this code review, but maybe this discusison =
will
help to get a clearer picture about what we are going for here.

On Mon, Feb 19, 2024 at 07:35:39PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> vfs_masks_device_ioctl() and vfs_masks_device_ioctl_compat() are useful
> to differenciate between device driver IOCTL implementations and
> filesystem ones.  The goal is to be able to filter well-defined IOCTLs
> from per-device (i.e. namespaced) IOCTLs and control such access.
>=20
> Add a new ioctl_compat() helper, similar to vfs_ioctl(), to wrap
> compat_ioctl() calls and handle error conversions.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c         | 101 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/fs.h |  12 ++++++
>  2 files changed, 105 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..f72c8da47d21 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -763,6 +763,38 @@ static int ioctl_fssetxattr(struct file *file, void =
__user *argp)
>  	return err;
>  }
> =20
> +/*
> + * Safeguard to maintain a list of valid IOCTLs handled by do_vfs_ioctl(=
)
> + * instead of def_blk_fops or def_chr_fops (see init_special_inode).
> + */
> +__attribute_const__ bool vfs_masked_device_ioctl(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +	case FIOQSIZE:
> +	case FIFREEZE:
> +	case FITHAW:
> +	case FS_IOC_FIEMAP:
> +	case FIGETBSZ:
> +	case FICLONE:
> +	case FICLONERANGE:
> +	case FIDEDUPERANGE:
> +	/* FIONREAD is forwarded to device implementations. */
> +	case FS_IOC_GETFLAGS:
> +	case FS_IOC_SETFLAGS:
> +	case FS_IOC_FSGETXATTR:
> +	case FS_IOC_FSSETXATTR:
> +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL(vfs_masked_device_ioctl);

[
Technical implementation notes about this function: the list of IOCTLs here=
 are
the same ones which do_vfs_ioctl() implements directly.

There are only two cases in which do_vfs_ioctl() does more complicated hand=
ling:

(1) FIONREAD falls back to the device's ioctl implemenetation.
    Therefore, we omit FIONREAD in our own list - we do not want to allow t=
hat.
(2) The default case falls back to the file_ioctl() function, but *only* fo=
r
    S_ISREG() files, so it does not matter for the Landlock case.
]


## What we are actually trying to do (?)

Let me try to take a step back and paraphrase what I think we are *actually=
*
trying to do here -- please correct me if I am wrong about that:

I think what we *really* are trying to do is to control from the Landlock L=
SM
whether the filp->f_op->unlocked_ioctl() or filp->f_op->ioctl_compat()
operations are getting called for device files.

So in a world where we cared only about correctness, we could create a new =
LSM
hook security_file_vfs_ioctl(), which gets checked just before these two f_=
op
operations get called.  With that, we could permit all IOCTLs that are
implemented in fs/ioctl.c, and we could deny all IOCTL commands that are
implemented in the device implementation.

I guess the reasons why we are not using that approach are performance, and=
 that
it might mess up the LSM hook interface with special cases that only Landlc=
ok
needs?  But it seems like it would be easier to reason about..?  Or maybe w=
e can
find a middle ground, where we have the existing hook return a special valu=
e
with the meaning "permit this IOCTL, but do not invoke the f_op hook"?


## What we implemented

Of course, the existing security_file_ioctl LSM hook works differently, and=
 so
with that hook, we need to make our blocking decision purely based on the s=
truct
file*, the IOCTL command number and the IOCTL argument.

So in order to make that decision correctly based on that information, we e=
nd up
listing all the IOCTLs which are directly(!) implemented in do_vfs_ioctl(),
because for Landlock, this is the list of IOCTL commands which is safe to p=
ermit
on device files.  And we need to keep that list in sync with fs/ioctl.c, wh=
ich
is why it ended up in the same place in this commit.


(Is it maybe possible to check with a KUnit test whether such lists are in =
sync?
It sounds superficially like it should be feasible to create a device file =
which
records whether its ioctl implementation was called.  So we could at least =
check
that the Landlock command list is a subset of the do_vfs_ioctl() one.)


> +
>  /*
>   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBO=
L()'d.
>   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> @@ -858,6 +890,8 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int=
, cmd, unsigned long, arg)
>  {
>  	struct fd f =3D fdget(fd);
>  	int error;
> +	const struct inode *inode;
> +	bool is_device;
> =20
>  	if (!f.file)
>  		return -EBADF;
> @@ -866,9 +900,18 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned in=
t, cmd, unsigned long, arg)
>  	if (error)
>  		goto out;
> =20
> +	inode =3D file_inode(f.file);
> +	is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> +	if (is_device && !vfs_masked_device_ioctl(cmd)) {
> +		error =3D vfs_ioctl(f.file, cmd, arg);
> +		goto out;
> +	}
> +
>  	error =3D do_vfs_ioctl(f.file, fd, cmd, arg);
> -	if (error =3D=3D -ENOIOCTLCMD)
> +	if (error =3D=3D -ENOIOCTLCMD) {
> +		WARN_ON_ONCE(is_device);
>  		error =3D vfs_ioctl(f.file, cmd, arg);
> +	}

It is not obvious at first that adding this list requires a change to the i=
octl
syscall implementations.  If I understand this right, the idea is that you =
want
to be 100% sure that we are not calling vfs_ioctl() for the commands in tha=
t
list.  And there is a scenario where this could potentially happen:

do_vfs_ioctl() implements most things like this:

static int do_vfs_ioctl(...) {
	switch (cmd) {
	/* many cases like the following: */
	case FITHAW:
		return ioctl_fsthaw(filp);
	/* ... */
	}
	return -ENOIOCTLCMD;
}

So I believe the scenario you want to avoid is the one where ioctl_fsthaw()=
 or
one of the other functions return -ENOIOCTLCMD by accident, and where that =
will
then make the surrounding syscall implementation fall back to vfs_ioctl()
despite the cmd being listed as safe for Landlock?  Is that right?

Looking at do_vfs_ioctl() and its helper functions, I am getting the impres=
sion
that -ENOIOCTLCMD is only supposed to be returned at the very end of it, bu=
t not
by any of the helper functions?  If that were the case, we could maybe just=
 as
well just solve that problem local to do_vfs_ioctl()?

A bit inelegant maybe, but just to get the idea across:

static int sanitize_enoioctlcmd(int res) {
	if (res =3D=3D -ENOIOCTLCMD)
		return ENOTTY;
	return res;
}

static int do_vfs_ioctl(...) {
	switch (cmd) {
	/* many cases like the following: */
	case FITHAW:
		return sanitize_enoioctlcmd(ioctl_fsthaw(filp));
	/* ... */
	}
	return -ENOIOCTLCMD;
}

Would that be better?

=E2=80=94G=C3=BCnther

