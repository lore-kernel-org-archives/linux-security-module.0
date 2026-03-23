Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE51376BCA
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300014; cv=pass; b=SISzjVN47RYF2PPpBC1adDKYL6ZIVnAw0fhvBKYitI97g7BWL3tau1o44pAIu9mdajHCApbMNUlegEXkTDedZwAzrA4fvqYJkqarZSnd61gtGCozPvxMFMkR2JodP9Y4IhFT1PAMusJpvK7K5W1u17P8SlvFMaV5Jy7yL9kCYxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300014; c=relaxed/simple;
	bh=lj1WSksNK02aO4n5dob09BxWp5H6I1TYco9D2RasOo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAFFWjG96DsAsyZIsbvyGztLj8/x7REPJDMwMzMbjdGAlzi+EuPcCjRGVOIbFxXHuvaHQnRsqsxCow9kiP+E/ozpbfOOn5gwen7nc2iSvB/EXFCgzyFFuV1QW8gUqu2Y47fwuj/yK/kopPW1wZSgtkihmFfdE6YCvCRjepkM+pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBtcS8Hv; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBtcS8Hv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1267855a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 14:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300012; cv=none;
        d=google.com; s=arc-20240605;
        b=a2g028wNbecAESWwqfpLuudllntxjecUhrY1uX21cE5T0LIVAXZIOFAqZpWaaAZSdt
         NIzf7E3fxyiEwueo3eerb9lBqI0dxx/5g1HU6ypgHnEEfR7SfkgEPXfsUEYfiszQ9b4B
         t5n64J/4SwQVIDUKo6eFZYkuqpllqJ5kHDCubIg5CGXiVsWS3bObyIBxKoeP/jUmzjbJ
         tDisIC26FKSczxywlHpj7abXmXD3OJd0ne3JF57+CrRn47g+olZpGpghPQCSZOSUDT+V
         cdzmoPpx/22hSngl/ctUcalqjB8FrJZnOTk55kc1sYGanRUWcVgb4M+2wFH6/3FgMULg
         ODjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        fh=/XpAAIYvsh+24QrHGHWY/Lehbv+i1IXtGhm0V3NZrs0=;
        b=GmhTJbBrGvCwW9/+aF3yqLVf95UddRjDVzKBJpRO6ie3WpFCT9lzihNqCh6Y0cnjtk
         PpwEAXaOaxJUJ57eYDASVMzM1nmoBAIsVuxwE7eQfbSPKVc0zrUc09U2dKkUuXcXWUSj
         79fybYWvNBH8QEHvAxuk+yy6wvyTzzp5/+sb/aB/GncTR/hbJCY1B3dhEB+W+hjaphhL
         Y9rqsl6eChx1GANKFS2D+qOPXZDokWEn2LsNVTwD1h4PgUagZXJStHrwo4D8VzA4iQKo
         HwrzGYnbgqXyOizZi10NeGLuxRzN5LdWfRxy9GyLd4po4VltcUtZhwRrDobCQi+FW0A2
         QQmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774300012; x=1774904812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=QBtcS8HvpXO9IbViIwHmSUEd1cdHjK9S4SFD+KrQZ8bhDITcqbTe3aRVCdBgTe2A3n
         yPEMyrAXW1HDf/yOqvfhmV0UV6nsguDlNnwsiu12fdLFTcyQQDeLoE4ppjSujK/vYbur
         6Vh4bHjxQOGvJNvQcmIiGYefdfM6j1bAXms/E3+nKb3ABshNU1uhN6kg/vVgaD/GcP3E
         akpfjZl48gVESxxOIaGcrKwYKHddzWZAykOpSpFzHdXM1Jum5FB6rgUjQu+UPGDg6Q7/
         V9guohjp86bKIOaGeatTnM/vNT8vs82Ng13J8AmyBqJbn+u0bMDJq0vLUZtTY+smpY03
         GnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300012; x=1774904812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=Q5YyUwb+7LGY3aKh1UPFc1lryLAVtfd7DSfxwiOXPLRErsB03/8GJn8+Kp12RYSw1Z
         DO+jleKmMLqsAFBFOIWOvE04OzzCOBkUeFwT/Ki4k6mTDTXJWil406jDc/Kbghz3Gysg
         oR4r8kZrxI8aP+zBXU5u5LuowG8UZlx/8QPESaO4auoJxZWC968EXnZcI1K4MzIakrsv
         35qLV0FuNbwLW7NpzHU387MUKiXm8R8PogaATNptFotrd7OKSc2ZIW7r7A9Y8fCxa50g
         5f9FxZf5ndhbcMEUnYtEf/QWiAHPTfKr7TY7QHXWNQM6oAhczqHADfD16U0ljLJ29ZLs
         gbXA==
X-Gm-Message-State: AOJu0Ywno+vuHoADhK+2P8czuUHKECUfUl8G7+HJoDipfrhSSAm/aHx1
	m3X5YkPct49/cCvooB66gEzKi8dtZCpehOiD2v+n2cL4E+U+CwmBmSZ1dmwoEGQjvYz2RkU7TUK
	eyABGYBjzEML68JDmq1kYtEY3qD8266rIPjG8Wk9kn3jULsVcrFA=
X-Gm-Gg: ATEYQzw25RoN7BPtK6xoGpXhVBDnuquXy+VvZzMEWKr1zs33YEX9oHWlEIKzcPtVaLF
	nVLl3G9TMV5whb5gFfDYL0hufvkbwoJ+tlQR3Gd+zXTkkjSe8WSamG9u6JWjyfRfYsrcgO6qb9M
	RyvNVcfoz44PBsgaKAfatA+YeP8q44gN2E0ADk3nL7fHvvz9Kc5FhA6a/MjNIiaa4pvdbAvqPNL
	exFkgUCBsux7E0k42PhHKH+FZO9ONEQr8ymaP4HblvcOU4FT2gyIfF638sEE7CmiJz8+a2H5dQK
	Ny9JYr4=
X-Received: by 2002:a05:6a20:a124:b0:398:9923:749f with SMTP id
 adf61e73a8af0-39bcea1d2c7mr12205176637.20.1774300012580; Mon, 23 Mar 2026
 14:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-6-paul@paul-moore.com>
In-Reply-To: <20260323042510.3331778-6-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 17:06:40 -0400
X-Gm-Features: AaiRm51oMol5rD-3lC5JmUxYQEOgP29lPad5MhWEYDTptj6N_TPcJrob_X8Dy0s
Message-ID: <CAHC9VhQJcuA0VTpGSD0-x+Z5a__SQBiYfwc9zWwLMDa6THfKPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:25=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c          | 252 ++++++++++++++++++++++--------
>  security/selinux/include/objsec.h |  17 ++
>  2 files changed, 200 insertions(+), 69 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..2a3d524dce24 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(bool bf_user_file, const struct cred *cred,
> +                          const struct file *file, u32 av)
> +
> +{
> +       struct common_audit_data ad;
> +       struct inode *inode;
> +       u32 ssid =3D cred_sid(cred);
> +       u32 tsid_fd;
> +       int rc;
> +
> +       if (bf_user_file) {
> +               struct backing_file_security_struct *bfsec;
> +               const struct path *path;
> +
> +               if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
> +                       return -EPERM;

Based on other code paths, we should return -EIO here.  I've updated
the patch, but I'm holding off on posting another version for a day or
so in case anyone else is able to take a look.

> +               bfsec =3D selinux_backing_file(file);
> +               path =3D backing_file_user_path(file);
> +               tsid_fd =3D bfsec->uf_sid;
> +               inode =3D d_inode(path->dentry);
> +
> +               ad.type =3D LSM_AUDIT_DATA_PATH;
> +               ad.u.path =3D *path;
> +       } else {
> +               struct file_security_struct *fsec =3D selinux_file(file);
> +
> +               tsid_fd =3D fsec->sid;
> +               inode =3D file_inode(file);
> +
> +               ad.type =3D LSM_AUDIT_DATA_FILE;
> +               ad.u.file =3D file;
> +       }
> +
> +       if (ssid !=3D tsid_fd) {
> +               rc =3D avc_has_perm(ssid, tsid_fd, SECCLASS_FD, FD__USE, =
&ad);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* regardless of backing vs user file, use the underlying file he=
re */
> +       rc =3D bpf_fd_pass(file, ssid);
> +       if (rc)
> +               return rc;
> +#endif
> +
> +       /* av is zero if only checking access to the descriptor. */
> +       if (av)
> +               return inode_has_perm(cred, inode, av, &ad);
> +
> +       return 0;
> +}

--=20
paul-moore.com
