Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870373346A5
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100625; cv=pass; b=ocPG90PjUWn4Uqnu3ZF52kDfuHPW6GNnCxy6HoAu3oAJlrmbjxD7ACfJ0HS10atSDQI+iB+X0R2vJPJVlWDIqqxbv+6cq6PNe2boDbaQ5J0LYZTHgVWPPr6AtfHjgskAqdNhPFLsQX5Sy3mlBZR50S9LJtLX6uXEQ6Xqze4JgAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100625; c=relaxed/simple;
	bh=Z+b0ZECAqJfNW/F2wJOeNwpfdYXiYK+ERVdEdDe+Zms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Oegb7G8zqqa/0qH7lS4xE3l/w/NMKahsuQrHYc7coORb9UNp33GkGh9cqZvpVw9333QSzfsdNDJ5dMWogzUSNWfX3M6ohpLsWu1hHLYzP+RC+laJZ8zpo8LlsuFi7H3NGSpc9racBoGv8HmGHEpAGjIYJKuk+pH+44fbHQ7LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg9yOP+a; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg9yOP+a"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso3062578b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 10:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100624; cv=none;
        d=google.com; s=arc-20240605;
        b=eX7EBtxiEYzSUu+7hZDBW9TsRusk2c1Uf94CsiXIpxpvDbQUfKqMJr3ruF/mhWhSTa
         v7wh6v0dcURTuGvAbDkOZJbVI4+OD9watSShLc9jnRiPM9SbDfHfYHop2WtgBcK95xGl
         qj50LIEOT07cA0231ZSLwalAi2a8EM+r2ThrzPuT5/pbwoSoZXQ04cP67p0IMgeG6yXq
         T8HZUaDzRzTiMMjXVhifDi6F0n5j5UY/lxDThVVWJ6ynqX55tuugBw8N27u7cRErpAyU
         egRpgt0etPCZNDqjPDGG7Ilodwz8Tt4liZMOHNiNJ+u0BQxG2aHH6vynyzD2DqozkpSP
         rdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        fh=x/au59C+7T0Gu7SbWj4G0ojQGYS9OhBNNkKbceNbVuo=;
        b=ZgRm3LDEX0sfUPaq0tM3jDASv8XzBhNdqLPIfpQgMhLVWPNSXXLC3NsuS4WnTK+fuW
         4cL+4sukkYq+NCS1inWKOTT0iw9CRcOXlpwfkZ0YgpNEWuODY8KOaia4zJcLW2vmO3J7
         F3ogQWHlBpoIpPSqwTpcx4GZ2WXRCWgX3AdvvOgRvlDa6s4Dqz9eEo5lOSZvmuoJHxTU
         Ie8Lq7tyVhBGqe69jzS4ORqmrhW6yMLsnQGAhtfDrIUuy6XWZ1i6aO6gkmWPLUSG6iAx
         v2jhV2ZL0vA1gTM2SKcj3ye3cPiQfehGdLVsqiALCCASddb/4I87Yf0fjQkFVZYt9d+Q
         gbPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100624; x=1776705424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=mg9yOP+aAdi9JL4gAaBghM3CSTkqAHQhe/NqMu/v5a4EKu/UYxDhF22zW2WGJXB4vb
         7LtCysAvS5QvrEo5JrbLKKiepmxSwrWwJgDdC8oRD/7+0RVe2pGDnXlFpSCsQ+DI2VFm
         /SSljwPCGkOSp29sUFIycWEWEbL5TqJkGAOrPq3OlOzuBiNaAE5JAqTQ3S/buc92OKw9
         TLFzsW7lFbsAaY3UpljzYcaG88O1rqy8VwHK1WCUnoUqtpfHVQhAcU7iGYHHUW3s503d
         hcw3gKI/ykxXG8EdqTOEu2IDAK8yf1uagWc9i6pWdM0eRTr+pSXt5nqIKBxCIy5KorQn
         Ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100624; x=1776705424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=Zb8Q6m4sA/eMTGyxQkDBEynFXBK0/oAJNDCJ/FczogyLZyMAHSD9MdhgfPTGIQIEe1
         +Xnc+SU00otDOe7CZvQSMeEOMVmesLsP5gnDnKrYcAjJA1I/buQTxtSpHWBBqn8ushQK
         /FVAPzT+mzXguNBirSghgsbKEgJhHiZNEhUvVz1vN3G7sBMTG7a43DZYm9mACQEre2gR
         WqfpFfBzpY1LKluOoY/qU5vAWGUwssXClAo6vrNHQm6b0Y9BxCagKIqa0LDvOmHf4bH6
         FIn5Is6ekr4aw37483YyIQZs3GjQr4YMycvNTBsRcQXy9JsiQn3ASbMadz1f8yp/fXVY
         oPZw==
X-Gm-Message-State: AOJu0YyZJg3H9SBje8LqnA2ImTlHlbzxcWICmV81PM0HhTBGqco5VXQa
	zrktB14SNBXG/tiTuGlQajwS+W9yrK2yC6Isu8SX9buFqoenZ1GZ0Ec9Mbmq9VBkQacpb6aFDpN
	X/fycv9fx84ENGGY+qWXJEEqAjM+0TVs=
X-Gm-Gg: AeBDiesFkNsMU5+OWeyd65UtbKxzztJpGklr7i81czutpZzFf8mJ3IbBbiFXL9JX7KD
	ijnYhk2FdbaMyKF5yCwMuyU94frEe1DLBKP29jjKvszxOkTjW2ZV8RlZ05/IybjG9EOe/Cw/TSA
	1Wsv14487qrSyHQEojb8cRAmp6hbuXg3wyd3SyRtbqBQxCBYK2cTHDSytZBdHRgk3dDcQuzdwGl
	2BOBZ4QPqPW2OSV0ImHnR3CxxUfk3hQ2imgqNoqHp2qIlbzjKj4xrz2MAz8cg2tYNFG3dMSdghw
	NZ1N85I=
X-Received: by 2002:a05:6a00:1f0e:b0:82f:5125:a327 with SMTP id
 d2e1a72fcca58-82f5125a71emr888914b3a.27.1776100623918; Mon, 13 Apr 2026
 10:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-5-song@kernel.org>
In-Reply-To: <20260318184400.3502908-5-song@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:16:52 -0400
X-Gm-Features: AQROBzD6lyXWHoKW5RWqw1gdlCZn4rvcVErICJ7ENPulk3A0gDivj2NjCp7Gp1A
Message-ID: <CAEjxPJ5iDbnZj9gXb=GHORoXGwRP4EG0yUEH8MPmGqJWZEONWQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] selinux: Convert from sb_mount to granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:44=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Replace selinux_mount() with granular mount hooks, preserving the
> same permission checks:
>
> - mount_bind, mount_new, mount_change_type: FILE__MOUNTON
> - mount_remount, mount_reconfigure: FILESYSTEM__REMOUNT
> - mount_move: FILE__MOUNTON (reuses selinux_move_mount)
>
> The flags and data parameters are unused by SELinux.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Signed-off-by: Song Liu <song@kernel.org>

Not expecting you to do this, but after this lands, I think it would
make sense to revisit the SELinux checks and further specialize them
while providing backward compatibility.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com

> ---
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..415b5541ab9e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2778,19 +2778,37 @@ static int selinux_sb_statfs(struct dentry *dentr=
y)
>         return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATT=
R, &ad);
>  }
>
> -static int selinux_mount(const char *dev_name,
> -                        const struct path *path,
> -                        const char *type,
> -                        unsigned long flags,
> -                        void *data)
> +static int selinux_mount_bind(const struct path *from, const struct path=
 *to,
> +                             bool recurse)
>  {
> -       const struct cred *cred =3D current_cred();
> +       return path_has_perm(current_cred(), to, FILE__MOUNTON);
> +}
>
> -       if (flags & MS_REMOUNT)
> -               return superblock_has_perm(cred, path->dentry->d_sb,
> -                                          FILESYSTEM__REMOUNT, NULL);
> -       else
> -               return path_has_perm(cred, path, FILE__MOUNTON);
> +static int selinux_mount_new(struct fs_context *fc, const struct path *m=
p,
> +                            int mnt_flags, unsigned long flags, void *da=
ta)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
> +}
> +
> +static int selinux_mount_remount(struct fs_context *fc, const struct pat=
h *mp,
> +                                int mnt_flags, unsigned long flags,
> +                                void *data)
> +{
> +       return superblock_has_perm(current_cred(), fc->root->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_reconfigure(const struct path *mp,
> +                                    unsigned int mnt_flags,
> +                                    unsigned long flags)
> +{
> +       return superblock_has_perm(current_cred(), mp->dentry->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_change_type(const struct path *mp, int ms_flags=
)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
>  }
>
>  static int selinux_move_mount(const struct path *from_path,
> @@ -7449,7 +7467,12 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>         LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>         LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
> -       LSM_HOOK_INIT(sb_mount, selinux_mount),
> +       LSM_HOOK_INIT(mount_bind, selinux_mount_bind),
> +       LSM_HOOK_INIT(mount_new, selinux_mount_new),
> +       LSM_HOOK_INIT(mount_remount, selinux_mount_remount),
> +       LSM_HOOK_INIT(mount_reconfigure, selinux_mount_reconfigure),
> +       LSM_HOOK_INIT(mount_change_type, selinux_mount_change_type),
> +       LSM_HOOK_INIT(mount_move, selinux_move_mount),
>         LSM_HOOK_INIT(sb_umount, selinux_umount),
>         LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>         LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
> --
> 2.52.0
>
