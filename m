Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5E13C9D9
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jan 2025 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735881080; cv=none; b=dwIgfpDrpnqvv8eEMCXlDYzy5vGkqWCHm+TMVC6qUQ6TocmnuXUd40lu8q3N0VfGVQw10+Hivm6gEdHgqaVJ+PAVMyDZQP7ieLle+flF8ZoYorF+iHaRU0KFSeJuSD8iB+jkD31nwjacD06a/bZxW2bNCaoiBOx7t+Qi5pBS+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735881080; c=relaxed/simple;
	bh=lTiAkk7GDhDm6A2A1LdAN7rKdQW4LefYtJBW8i34M9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFImkXBf3OEtKpdRZzHat4D6C+hIkT8mh3RqvYsZ9iiNa4BzZ0mZ/VtJrf69Zee6VcIh3FEDCWslXq5Rne4AKiNXUHfGPlORZSHfaSAb7A61tJ435rK04FTdv8j/V53EVBasdakTO3uJCFyNX+3cWiWnpsXNOAgs/yiAKT+qF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eJ5UMSPq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eJ5UMSPq"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso15356045276.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jan 2025 21:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1735881077; x=1736485877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyUjB1kVxcHFpQ1CRCh4A/RpULQsoGV2kHxd7se2sWU=;
        b=eJ5UMSPqN+F+9EJUqGDj3rkzALOrwla8q2e3EbQj0R9wtdLLFL7rVmpGpU8j6CMJtf
         NY773Ja3CuvlmxTHX2ZhjFIUdD/dVmXesaON9EahBW/qsfeOjvf4+/KVW5WxZxqtypwU
         6N6+zdPIu5tEFgCSPd2E2qS+RssQLwkElclvtArkUvvXfZIHEJTGeWjpXfkh82ndpGJd
         pKlubHqWGVRxoEu3UqJ0UzNRIJN3rMMENvXGBi1H9QK0KIRGF+BTV93c0kwzd4FMb2Sj
         f5H5iTvtlJ3hrMn+flrz9TprEmABqRK8PTfthsJPbI+AXvMUFttylt1y2pgKZeZJ4P9B
         Ty/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735881077; x=1736485877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyUjB1kVxcHFpQ1CRCh4A/RpULQsoGV2kHxd7se2sWU=;
        b=wz0/oBz+ULZBgpB1tVXHWLMi5keZLGKeZ6BZPM9rb5l3DnCaKFuXpj0X7o+zwiJqIh
         xRMe8x8NwJXAddDNxAwfYx7tanAd3S7u7/o+G/XDMJAk8NF8Uf5sctorminddf+WLSEw
         TbyDkY2YLqugjChcCRIPQKP9lOt1DFc5tPK0531mz7g2O0oy9/UpcecEhrRlifCPwWH7
         M4b+JZ01/tlbdVLBS1raIBL9Yv+1dW18xu4taX0aGyaLE1WFqaF4gWhzEZXrNl0bFy1e
         4jEFFmCFLrghfB4m+h5FY6Eludd80JykX+d/x0fbrPdpX5N0+dEedlqtIFOkmN/WfccU
         mXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVcjR1tXCldvTeloaN2qrf0b5PUficOmLyuaDWr/vxpx5By1WYSHiu7kScrmHl1Dhq/rV3i27TdMK83rAN0ziihHB20aCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+PxFYFCUZ9oE/wVgGp0Vy6/7vQsBR2zdn9Rx95U+nD3E87xy
	1bRAmxFsdRv595CIsQUWTVyOYOcH2VYwYg1RVAZ8yF+h2zrQXxenp6Pq6RtImSJCFQ1h1b5Tvb2
	qxO9Lz+OUILMY9tx1iZrHGyAH64mBGwUQSviH
X-Gm-Gg: ASbGncs4vcHWzXjQK5y8VUjUCmqUfNZogQBiMIiIaVZk0wEuRtot2UyiLHuriN4u3O3
	Zom51PhTXZnM7BY+vtLqcK6nLArZgx+ZyOzc4
X-Google-Smtp-Source: AGHT+IEaG1QHaplbyTdibz5moObmuj2MxywH20fhgd3U9cfVIq3ontjJAuQ13WjWl7C70U4yunqFQJZcp2eV/KWGPPM=
X-Received: by 2002:a05:690c:6208:b0:6ef:4b3f:3bc3 with SMTP id
 00721157ae682-6f3f811507amr351018307b3.16.1735881077374; Thu, 02 Jan 2025
 21:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231014632.589049-1-enlightened@chromium.org>
In-Reply-To: <20241231014632.589049-1-enlightened@chromium.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Jan 2025 00:11:06 -0500
Message-ID: <CAHC9VhTHviBcqhC=iOgD0R2Z4XqQifd-F1NysaX2C8oaF00oXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
To: Shervin Oloumi <enlightened@chromium.org>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, gnoack@google.com, shuah@kernel.org, 
	jorgelo@chromium.org, allenwebb@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:46=E2=80=AFPM Shervin Oloumi <enlightened@chromiu=
m.org> wrote:
>
> The main mount security hook (security_sb_mount) is called early in the
> process before the mount type is determined and the arguments are
> validated and converted to the appropriate format. Specifically, the
> source path is surfaced as a string, which is not appropriate for
> checking bind mount requests. For bind mounts the source should be
> validated and passed as a path struct (same as destination), after the
> mount type is determined. This allows the hook users to evaluate the
> mount attributes without the need to perform any validations or
> conversions out of band, which can introduce a TOCTOU race condition.
>
> The newly introduced hook is invoked only if the security_sb_mount hook
> passes, and only if the MS_BIND flag is detected. At this point the
> source of the mount has been successfully converted to a path struct
> using the kernel's kern_path API. This allows LSMs to target bind mount
> requests at the right stage, and evaluate the attributes in the right
> format, based on the type of mount.
>
> This does not affect the functionality of the existing mount security
> hooks, including security_sb_mount. The new hook, can be utilized as a
> supplement to the main hook for further analyzing bind mount requests.
> This means that there is still the option of only using the main hook
> function, if all one wants to do is indiscriminately reject all bind
> mount requests, regardless of the source and destination arguments.
> However, if one needs to evaluate the source and destination of a bind
> mount request before making a decision, this hook function should be
> preferred. Of course, if a bind mount request does not make it past the
> security_sb_mount check, the bind mount hook function is never invoked.
>
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> ---
>  fs/namespace.c                |  4 ++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  1 +
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+)

Like Casey I'm not really excited about such a specific LSM hook, but
unfortunately we can't simply call kern_path() in the existing
security_sb_mount() callback as that could end up resolving to
something different than the call in do_loopback() which would be bad.
Moving the kern_path() call up into path_mount() just looks like a bad
idea anyway you look at it.  Unfortunately I don't really see an
alternative to what you're proposing, so I guess we're kinda stuck
with this as a solution, unless someone can think of something better.

I'm going to need to see an ACK from the VFS folks on this before I
merge the new hook.

I'd also stick with the security_sb_bindmount() name as opposed to the
XXX_path() suggestion from Casey simply to help distinguish it from
the pathname based LSM hooks.  Yes, this is operating on the pathname,
but bind mounts are a bit of a special case.

Unrelated, but I just noticed that we are calling security_sb_mount()
*before* may_mount(); that's the opposite order for most LSM hook
placements where we do the discretionary/capabilities checks first and
the LSM checks.  That's something we should look at, perhaps there is
a good reason for the ordering being different, perhaps it's a
mistake.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..c902608c9759 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const ch=
ar *old_name,
>         if (err)
>                 return err;
>
> +       err =3D security_sb_bindmount(&old_path, path);
> +       if (err)
> +               goto out;

I might make a mention in the commit description that the
do_reconfigure_mnt() case (MS_REMOUNT|MS_BIND) should be able to be
handled using the existing security_sb_mount() hook.

>         err =3D -EINVAL;
>         if (mnt_ns_loop(old_path.dentry))
>                 goto out;

...

> diff --git a/security/security.c b/security/security.c
> index 09664e09fec9..bd7cb3df16f4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1564,6 +1564,22 @@ int security_sb_mount(const char *dev_name, const =
struct path *path,
>         return call_int_hook(sb_mount, dev_name, path, type, flags, data)=
;
>  }
>
> +/**
> + * security_sb_bindmount() - Loopback/bind mount specific permission che=
ck
> + * @old_path: source of loopback/bind mount
> + * @path: mount point
> + *
> + * This check is performed in addition to security_sb_mount and only if =
the
> + * mount type is determined to be loopback/bind mount (flags & MS_BIND).=
  It
> + * surfaces the mount source as a path struct.

I wouldn't mention security_sb_mount() above as that makes the comment
somewhat fragile in the face of changing hooks.  I would suggest
something along these lines:

"Beyond any general mounting hooks, this check is performed on an
 initial loopback/bind mount (MS_BIND) with the mount source presented
 as a path struct in @old_path."

> + * Return: Returns 0 if permission is granted.
> + */
> +int security_sb_bindmount(const struct path *old_path, const struct path=
 *path)
> +{
> +       return call_int_hook(sb_bindmount, old_path, path);
> +}
> +
>  /**
>   * security_sb_umount() - Check permission for unmounting a filesystem
>   * @mnt: mounted filesystem
>
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> --
> 2.47.1.613.gc27f4b7a9f-goog

--=20
paul-moore.com
