Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377D14E2D4
	for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257949; cv=none; b=HvgXiCoaSxkM72jR/lVCZGpcvJmpXxFS6Re9Oj1BDuv2V9Hv1xiSehFiHJo4KuklJd79TLFii2TNeA4Dz56iQej9lMARH1jB8D+9RFZ3peDMp1nKoBIEoJAgNSPPjBS8j0/6TmeMFtJzxNelIbIRNZuwZv+1i2qrrF4cTdyjpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257949; c=relaxed/simple;
	bh=y0LywhCmh47VypaLFq+kEyR/qD8qT8iwJl5GVT+ZjgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAiicIscRhaOUOmLoWzr2B1Vnuy4NLEJMdATCGY7yGJnTVjoYo8wlwWtDd1QFtKSQpU6XeqWT1dB8KaSpDcJG0GbgU6AAHH2OG82NDBjjWeu6VP6fHGry3wRVEIOEAXr6x6mSi2B6Z9If/EEC6suQREisRwOwNakrDUfx/WZF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fBcubZHl; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fBcubZHl"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6aab656687cso8527607b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724257945; x=1724862745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKjQ6emtyPrVDj7dWj9Yt0Rk11OdLkP0YY5ZqjmKqLI=;
        b=fBcubZHlN2QMKZFq5CpzyjFAB2tiH9uV96sIzPZKB98i4e/2bsr5SN9faq9iEbK5pN
         4qMwjofgBWfDXHK5pbQm0fuhyFnjfhXvy0d+gs4gPcgkToAFtju/sKhZcQnaOyP5wCNN
         SpiFKG6nZbcyoHFXl04TT9MuKXb8F5gueWYid0M4SrfBV2rmCz0PaVBgn/JTZ2mnlC91
         N5rMEkRLdDSAJ1zSwczEV/KoL5YawJj8Wm+sT80loWm4w6DeueosadS582iMaVci5CCV
         IGKB7458UsdDqrbD2A1+YdOXMAhx0lmOKb09Kfcan9KofMy3afq5zRu5dTnr7eQEYMhE
         stKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257945; x=1724862745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKjQ6emtyPrVDj7dWj9Yt0Rk11OdLkP0YY5ZqjmKqLI=;
        b=C+6re2KTugAaF+lLqCmwKqzvIflLI9A9vcUjHc2JaLDS7kVs1ZgEXa2jJPvDFExmeX
         o/786o2PVhpQ/XMqm+y0Vl0Ggjw49inku+6N6X5ladUQrPWhm9njKby+inJeY57Alg9e
         QAZ+EDdUa1K4xv+T6LBo1R9GaBmsxCHBv5THoGuUaqLp997PuDrax1XEXrsNJ4Nhl6d2
         Wlq+AEDVWJ78RjhEFLT5ONwej5YoUeuOSMFtujHqDafWPSqGOR05lLDJBOMXKj3RiA6r
         mqeN6lrJ3HSH/JjS2GYaKAqOSS3bYtuh/P5Bo9s45g8tIZ6vpjvydwFiYL6GLHVvP+SE
         NT1A==
X-Forwarded-Encrypted: i=1; AJvYcCWQcENA3BviNHQ7vV8HH+d5z5w1zq4erPVCEPq8PlPAA5rm7jX7NBQjwhf8SePjBvNMrxJjcLXjAAgNdBTYUJZwWAYvQEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFHCVgt2UUJYE8qKZ+BApbAmByds9FU3cx81siasHZHmauWyd
	LMgTuw1RKJA7Smi22RJ0rymfwry0j2YtaglucCcT9IwrE2V4Qy2U+ZGPEtuaeCQ2EbwAcLnMapv
	+jvud0z3au5Uicsgm7pKhOcVAH1bQGIuTWywJ
X-Google-Smtp-Source: AGHT+IHqtEaRs3bfyjoduUwqbGszfFJZ/MXDKylcokqkjlSrKLoHtDO/7RqpwJwZHHVzLv9J+rL+3ZDsUcQ+ap2YLkU=
X-Received: by 2002:a05:690c:908:b0:627:7f2a:3b0d with SMTP id
 00721157ae682-6c304879b22mr2005647b3.14.1724257944842; Wed, 21 Aug 2024
 09:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net>
In-Reply-To: <20240821095609.365176-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 12:32:17 -0400
Message-ID: <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
> for the related file descriptor.  Before this change, the
> file_set_fowner LSM hook was always called, ignoring the VFS logic which
> may not actually change the process that handles SIGIO (e.g. TUN, TTY,
> dnotify), nor update the related UID/EUID.
>
> Moreover, because security_file_set_fowner() was called without lock
> (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a race
> condition and inconsistent LSM states (e.g. SELinux's fown_sid) compared
> to struct fown_struct's UID/EUID.
>
> This change makes sure the LSM states are always in sync with the VFS
> state by moving the security_file_set_fowner() call close to the
> UID/EUID updates and using the same f_owner.lock .
>
> Rename f_modown() to __f_setown() to simplify code.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> Changes since v2:
> https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> - Only keep the LSM hook move.
>
> Changes since v1:
> https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> - Add back the file_set_fowner hook (but without user) as
>   requested by Paul, but move it for consistency.
> ---
>  fs/fcntl.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

This looks reasonable to me, and fixes a potential problem with
existing LSMs.  Unless I hear any strong objections I'll plan to merge
this, and patch 2/2, into the LSM tree tomorrow.

> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..c28dc6c005f1 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned i=
nt arg)
>         return error;
>  }
>
> -static void f_modown(struct file *filp, struct pid *pid, enum pid_type t=
ype,
> -                     int force)
> +void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> +               int force)
>  {
>         write_lock_irq(&filp->f_owner.lock);
>         if (force || !filp->f_owner.pid) {
> @@ -98,19 +98,13 @@ static void f_modown(struct file *filp, struct pid *p=
id, enum pid_type type,
>
>                 if (pid) {
>                         const struct cred *cred =3D current_cred();
> +                       security_file_set_fowner(filp);
>                         filp->f_owner.uid =3D cred->uid;
>                         filp->f_owner.euid =3D cred->euid;
>                 }
>         }
>         write_unlock_irq(&filp->f_owner.lock);
>  }
> -
> -void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> -               int force)
> -{
> -       security_file_set_fowner(filp);
> -       f_modown(filp, pid, type, force);
> -}
>  EXPORT_SYMBOL(__f_setown);
>
>  int f_setown(struct file *filp, int who, int force)
> @@ -146,7 +140,7 @@ EXPORT_SYMBOL(f_setown);
>
>  void f_delown(struct file *filp)
>  {
> -       f_modown(filp, NULL, PIDTYPE_TGID, 1);
> +       __f_setown(filp, NULL, PIDTYPE_TGID, 1);
>  }
>
>  pid_t f_getown(struct file *filp)
> --
> 2.46.0

--=20
paul-moore.com
