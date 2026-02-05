Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6639E6D7
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284251; cv=pass; b=tw089BNs3fYU2m6JC2aercf0ra2xDOKpcg3MqyGrJZK9BjLw2kgp6MUBARmTp+Kd82oxt8WteGE0yi/6+rfVUvRD1cezk3LL5qbFJif4jL3uOjJB+q1Remenm+Q2XaculopCf3ppYE5/TybIn9BsI5bB4PFYZmOHUZBbsel61ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284251; c=relaxed/simple;
	bh=O3zjcpb1gIgdrnZIOWkOIcCmTAMhdJCAtczZfkl8Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAzYR/ZgXqDUhQfl0FcWGaky8U5CYVpZtKdwoWWc0pXwiOqhxQUKA72zFm5xTrEgiS9Z6t0FrhTrjwSpcsqBmHXn+gTRucJ192H+l76+PGFfVcj0nELJ96/zEv4ceKfwKxpJjQSwZQ04l4ksDArzNMn2EdYxI9FzfLjxvniLD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUGTiXw; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUGTiXw"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-659428faa2bso1273469a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 01:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284250; cv=none;
        d=google.com; s=arc-20240605;
        b=SfrFC1QS9Yu6HCfDHsDHNn4CAlnzx6arA+LXOc2gzx1AgSziAzIZJNxJgYFuQRs1AW
         0MsbACqu7eCX7nBGXxSSJ6DDzdfx73tdB7KyDzNR1QMgh902k7PaZt9gj0ckJDMVn0DO
         kqs4UUuAN+uCTtv0k+8debLqLf+wxvPCt7Ozj918bzpuDdLuVmUXNXofprt8jHdhsoa+
         BzSuGWJH/xzFhICnleauwzv/FFUkqAZoxOcW2vD+1gzFHMvvt7zq7Kkf72DvlLtQqhSX
         6d9hV9QT1PjEEbxxRQIljnVS4S7Zz5BIppCioYkwD1Hp9FOK327TO4rcd2/VddN3IUAt
         +QRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        fh=5S5XCB+6mpv83heIeLFy9KFxvyO00CEM89jKcOd9Xvk=;
        b=SXJyncOG4MCDCZKFp1KvNDntOUCqIPbz97M4bZiqPZsoVzCZESaPe56t6NrL1IQlmh
         GfIQbJ19U2HYwIs5td0TY0BdeEiP6qlp1KRyMh7mZoLCiz46TeU0/QECWG+gDaGfRCSE
         2P7UneOCe1jAEdF7c8aT5sxOnAoem5fJqx3iabKHyz2GkYMaB0NwUj0++u8l64iLAX29
         wAPrEFEHL3tX2oXHPo4vhJpaK0J/SrEAYcZ5duQzLxQbqU/jrIG5aqouJXxOF/AvxolF
         5knymNP/WEDH/tp3IQRj7MimejWBdrtGgMeLIAVAafa5l55eFx46BB0ipGrlsDkptU3x
         90ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284250; x=1770889050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=FjUGTiXw2YWjuQ7I+GqvszU9ONy2XE3+0JTAxPXHkvt5eZPZz+J5Ufml3pqOgP8T2L
         rGpjc6btwhogLQMha/Jf6R6/yMMHusEbVvvB9GvauRcrLVSE37m/5NRzEmxkn7UFT56a
         iuPSJZkpndM52iukwsc73xY8GdCH4GozIXR7BrzDyyEcwiI2UfOmNraXaq/qo6qKWX5v
         Js4guz62jAPbbEGBBruoJBw9nESFq2rhHfK5hAw/E3v3AMLBniyg3HEQD/EO70aNkSpl
         fnmqT9r0YmS9KqEzDR/y8yvYgP0e5gBj2781l3djCI2R2Qr30Ey5NTf0YpiUPWKYhCsR
         bKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284250; x=1770889050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=M6V3sn5iiFSVvcZC0nrm4mxbzpFBQ0xjUqEPivT2+VvONW0smmAyHnd4YnsjD6NMBX
         xoWAT0beT3CX7HxGTkCHBlsBZXujaDPFy9pndezU/OWQUWfaEXis8FDmGfrEU2TRT7gv
         zT9zSALrlfOtOZVlkAqIUQceFtVTrFd42qAUwGJKQB/88agdV2TFmm45bDjyIImxk8OG
         ezfs2WghCHcu5oGlitOGxf3p9wBToqc12lCBew+a1oC3O9tiVinl0QbgmtQLNZO9OUPj
         C1ru+398EULzpyKAUA0VTNgpDXzG14lTGTDYlmWfCeaZwBo/v4UzhL48rLxmDQ+NBqaj
         4xqA==
X-Forwarded-Encrypted: i=1; AJvYcCWVAB0qIbZMsvRstZwcJD00ITMymL+lxWRui+8+hL+g83U7llle0ZP+8r4LiA0/U0orOh8E7zfSKn+t7vkqe0/DZdTG1rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sH6t8shYQ1kUIzrpKk2FsyqhiPEK94xWtsaGeH816BvIcbW6
	2CSjk+ftU9hrMjB4YkmS+qxdui4vCfymisJMNHkCtauF3gG1hKPQemKYXiyUiKWuhHDLL94/N0x
	dyIxpZG5ADuZfNcHWprYtszTbTGE01QM=
X-Gm-Gg: AZuq6aKnwgSAvyK5PlcUuehtnYcPvZea99GXiVgPeUU800+wPsXFY8w3ueEG4gu8pnG
	/O19RorSFpzN+h3BaeSyXV1lJ+gjz13fccbvMMLgtnOlXAwfObdamE1DVa5XQxkfWnegQxeCs7s
	kue4rwYs548MC1sY8gfERUiLur7rzLJp1vMLiOCnrTRWP1TSdSY0y9ewPvJlXzQ5VNGfKGg46Rc
	ESzAbgLeKFLQP7HO1sJxTiAAEHM/vQdM+BQJEuDcJbcftTALJ6vL2AvPSywx3maJ77Lg2nrGn6B
	WlSw0bPsHZjJ7xxC9cwpBy+Wu6KTJQ==
X-Received: by 2002:a05:6402:2688:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-65949cc1e5emr3920680a12.15.1770284249654; Thu, 05 Feb 2026
 01:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-12-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:37:18 +0100
X-Gm-Features: AZwV_QjDs8XEOiRuWGAHzisKUrokVjcatEGo5N0FYjLzK48UQXH5p374RE5BkHo
Message-ID: <CAOQ4uxiYUTi=8BjRFbY_GdBZR_5CuP6680me=_xQaPcQk7EFuQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> As this is a point-it-time sanity check and does not provide any
> on-going guarantees, the removal of locking does not introduce any
> interesting races.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ba9146f22a2c..2fd3e0aee50e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const st=
ruct path *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/*
> + * Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>  }
>
>  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> --
> 2.50.0.107.gf914562f5916.dirty
>
