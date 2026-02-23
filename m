Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADD34F247
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839328; cv=pass; b=KXqSg51ADfUhRWj8T6OBFKP49CqXZuZE8Ir4XcktKLCDMR6CCDpo2vzYEaf0TtUqOmbMbnFJGWye9gNOqolZm7mAqrMyWxq5axsK/hz9jhmKgVugirj4PC8tYkgqGqyxirdQpumbAmdWv+3xAIdmDPES7jSIzGF5sVtTrWRlFzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839328; c=relaxed/simple;
	bh=mAAOjC5VpT1HkXsRAwtGw0eUE/35I2Skqe677nArRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvgkJLyGgNlE1jxFTKHuF08XuXeEBoAUS0TNyQ8C92mJWOkTP7B5gJU5lp8sLYPO1kpmLGclvSLrKHfdfAs+Ubh/L9pS4wrXmXL//b23kWDu+uvxuXxVklM4Lrc947eLv1Zz+dk4skdPpfBcJPUEcbgWivlCGjjmcSlDDsdyjfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvjUXwJM; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvjUXwJM"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f9b5240a2so524393466b.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839326; cv=none;
        d=google.com; s=arc-20240605;
        b=dgVGU2C2TDSyGR59Iz3ocLxxzCTeBNlfQiSFgIPrbC5phtAIE/gogLiR+Novn/7y5h
         6CF9e/R000PpbImSUM17K3xeR0tq7KI69UcVVlDek+WrgPjN9A3YawtXS5BIRoQa9yzH
         yJscq+hs4oqyS0pPHQ+9qFC0j/HL/jyyds8m+QGPvFjRRW+aDx9xv9ehAbbR1E/IkH5q
         fVb4u9bKrCpc4kOxwPtfgLBGLiAQEx9gf6Gbq7WsEojc6wMh4VB2OgE7zqXXYcpZWpOj
         EeSOtzePkaMFaj10vxhH5bgTEC9b3zk0nJNZtpnlnBGhJE3VIek4dzO71iA4fZpiaAKy
         EwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        fh=kqY0Yo1jJ2KtKs78xzYCy7VH86Vn9jBHHK4fqyqUxkw=;
        b=Nlnn5UIi6wy8NFzQN14Fzh2HPxtnnKqFranxyw9/67FDszJXLe/fB4FA5SQ7Rw75jx
         L3gLw8buFGfKrmZQVs03lHCh6Ad62QN6seRsT101AHDfbDfyn5n5Ob8Bxd2bRm6dK47W
         tO4hpBHsdIdPMDZnlmg7vMz4gAVjXaCGE0j9YY2muFDe5m8/krCsT7bHTZ7VhsRzQ4J1
         xXzmptrjDHAi+DZOpO5qBlB38V96R9c4N4pi3R7myUdV4/J1LlUpSJp4tBBmpRLRf/Go
         40LX+DG6ghiHU9OR/IACbk9EehWoRUBfCbH+y0aOV+vY9RzRSyrYG0f+gaWohSOkVj60
         YD/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839326; x=1772444126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=lvjUXwJMFDUVNdE9/6JGFIIEgXAr+NW/nxJYiNKP83A2h2rSdOYnS2Qap5SEi8qvuc
         Xvv8mX7Ib5UTjZ2Ntgfe8sP1Y8sbStPRBVlVXYlUG96b6S34FcSJuKZLdABzCTwQSawB
         6kEeAv1Xy3QQTZBXYrCOuzdG6KW4vFjs2HUXgSqvz4TtzIzp1VaFIlsTAa6b5Sp1Jd34
         8+G7qchOZolFb2NrtqZ2ma6izvwW8ElQncc0YNDtZAtfeVwNdlTIquDlE1K/HvvMVBW5
         MVSWix+ReYo/KfT3GNcH4MXXhrxRSIQZW2RW+9DJtcTlAkJOfHQiKIYj+U2ejfaspoaD
         g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839326; x=1772444126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=w5pjMttIcq85Yk/Fj9CDADRxMRut93sTb8SB4OLxtmlMv/n6NJHvQwQ3TkxfhFJ4L8
         KEuljcfXoNelp14ysqqYHQsYUyBo1vZj/s8KVofvGbinDPdjaNDFD3BOcnj2VtOVieqr
         LZH0DFbN22WeIc0yH10NZaZ7qUmCR4gJpQU+W1D5s7UZ2eUz8VoNnBlnf9ehsspWM9iK
         7th+Rj9B2diqRh9EoWeHlDUJbEp2lf96NU2yy+KeIpL6+BWc8MGU7SiGeYpnwnc4SMBZ
         Xp7j7IR3YaPF8D+ApoMzA3i7xQ/BWYRPLMMJGjQO7vUDBppfjIsgWbjQOGHIaJyBwZYJ
         1APg==
X-Forwarded-Encrypted: i=1; AJvYcCVKcHhp0BZ4sV1GxycqRVyi6aLKqNom2osVbPNBYUK5oczrpaeryAYC1AWF30W6DdYGvujs8kdypmheUNcQB6oLGMc3saU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDUGzZrMJDWJNGIFF8rZDgHYyHpG/6rfEGIuqpHlN2b7CRVOb
	Cx0G5U/ouDSyGjG0z0+LaE0sLMEwhdfsAvoKI7NzIltv+RdZgeXw7EN1x9ncT1WrVA1JgoJUZMn
	REBxqeXwhBbUDlYI/tJ1zEil31PNdwDk=
X-Gm-Gg: AZuq6aI9Ct/MiXXzdVDprqaoKMPVn9UzyHZkr7TJlo373eTqix4FogKj7FzGbhWIkXw
	Rvr8Nhgb/TPpgPP+IeA2fIiW/Qtaceu0IGoBMuRS4zg2NlbIibWh0oZOlTESVutaNFt5QfssFlZ
	3xOZBJYcdGS7of5i6TroHHx4QCYY5aldn90UN+4djjMKkxGDgbF6yKhn9OnyaXlo2nYYIrqPd04
	xHzOyXQqiTt4sMibOuEVybtLEzp7ycGfuie3HTybm+yUa/74aGcMsD12NI6rJXkKkU14dfkLTH9
	6TXKN+7FmtFtjqmT/8h7DizXtGnoWAAA6hsjLrVwnA==
X-Received: by 2002:a17:906:7307:b0:b88:5002:50c0 with SMTP id
 a640c23a62f3a-b90819db296mr564028666b.20.1771839325394; Mon, 23 Feb 2026
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-12-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:35:14 +0200
X-Gm-Features: AaiRm51zLgcrRbPb_4HmwkH5uY0J9aukMWrvlX2vP_E-cCHRJFMZshxY7_A02Xw
Message-ID: <CAOQ4uxibL=2Z0FZMz5wMAo=JMaJouOVo3p7t3Fi3FR59U5Tu=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:14=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now ovl_start_creating_temp() is passed a buffer in which to store the
> temp name.  This will be useful in a future patch were ovl_create_real()
> will need access to that name.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..c4feb89ad1e3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  }
>
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> -                                             struct dentry *workdir)
> +                                             struct dentry *workdir,
> +                                             char name[OVL_TEMPNAME_SIZE=
])
>  {
> -       char name[OVL_TEMPNAME_SIZE];
> -
>         ovl_tempname(name);
>         return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
>                               &QSTR(name));
> @@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *whiteout, *link;
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
> +       char name[OVL_TEMPNAME_SIZE];
>
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
>                 err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> @@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               link =3D ovl_start_creating_temp(ofs, workdir);
> +               link =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(link))
>                         return link;
>                 err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
> @@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ret =3D ovl_start_creating_temp(ofs, workdir, name);
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> --
> 2.50.0.107.gf914562f5916.dirty
>
