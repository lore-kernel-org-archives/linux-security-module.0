Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6687249E5
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jan 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386937; cv=none; b=ZJo+yiZVgo7EylVVDwQMTSrSAdJy3oAzQKgUKuzbpcmO1JFsp1wxES//B+4dZwgguzIe6PFVeuxXFsUyfFwO3EIwa1wZWlxYfhB7wxiX4aAmzvnkhzebKw3+gFGfhGJEGpB8Rgc+OtIHePIgAPcBnG/KQ7GFxAnYaAThsuZimNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386937; c=relaxed/simple;
	bh=zfeDX5addQPMOrAdOMKXjx8Mmkk8MvfM4ueVtIIUTr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMrSxzJNzzxpnAqNoPSM4/V9+8OOfCNZZllvRfYp6lOWwBnah+0aqzPULUsMA1wrJ0d7/ElltaqLU4k7sQ14HdktMN6ZepxN+1McUdLhHCmfwOF1JOFdF9uEV2TQ3AeRtCvHVZ82nUpXsOaf+w3nBtzK2pZzaksNUjA6MiAVE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BR5ROd2X; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BR5ROd2X"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53a91756e5so659187276.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jan 2025 17:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736386935; x=1736991735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4g1ykfPq95SnXVLikXosC+HM7OajCsrb3rQj4uRrmA=;
        b=BR5ROd2XWbzMMmg50oJbwb5RQZ5QlEjXZ+qayfshUFH3Wnw7OQjjLVmvqgBoEDwA5m
         PNadrmstK7MqxvewIw7swMl0c4esTbKD3kjvmd3QD6y7OALtxTqZsEioHyRT1/frAe5p
         J8OiwY9kCMMKrv3fKoGcEEL9+bCwFvz1UozBW7q+omSBsMf3TvXC0D57YcztktdsKm3/
         hYOYgqtFvEUnWYqofC27VLyOewCBPf5pDSX9zkMyDDhKKPQbbKHfIzkT9xevMFRpPeXw
         AYlWXwdQR2k3gkahcjO1wKoqeG/TQ2szl4mKaUgWJU6+lE7LDmAcgTjdWjzMl2bQl2Q8
         Wm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736386935; x=1736991735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4g1ykfPq95SnXVLikXosC+HM7OajCsrb3rQj4uRrmA=;
        b=YPpG9prDcGgYTphnl/nEbpFahqrnRL1KTKdJAy4RiXVXTTSyJDqCJL7RN/NXJ0Hi+l
         OGTgxoTB+qny+vDoRKs/D80Q6wd8PmQ10zeqlUSoujHfW0W3cIkDxN9loudTFh1VIabs
         koKugVcjBoHruNpUYyO70OPApZwclWd3U+sKk2gYexEh3TRziAj9c+GcMNNhD+SgsE8E
         ayTXKeQaKcdFrr0NHkgu/lCo/9cKm3AHrpzEofuz5ZjGBSBs9Svf2SN8btY7lW2P8KqG
         aR+8Kx7aAXJei2+J0+RtSkIgS/zOjRxlcMrCn9uR73tyxkaEYo/d4o5XON1J5vbLrGux
         Szzw==
X-Forwarded-Encrypted: i=1; AJvYcCVy6vaSg3Yw4F8v69LCoG2arLJlBWeJKAl/bGTrktZnevD5dsmOMFHNo3V8mNywVhCDakdEeqzjNGEi4mLwB0CtSc5kLJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIKqlsG+WR1JnozXr/JF9Rxe97KNYlF2eb+8o6F3qhA7GWggJ
	wAROBQEZKxk3IZFWqxbIzczbFM/VPhf6GFT3pNvd3wef/BpEQpLrBKjv53xqOHgPnHSn7hR2dWY
	KI2hK6Tq64OVmAKEYrrvGivgZawfjYvSksol8
X-Gm-Gg: ASbGncv2dmgKaUa8UW3t2lHugqdevNwm0VlQIvlrtHLCeYS048pGuS3MjvKnauVhqsh
	kgSmyvSq04U9cP+LolO8XLNFMxRTCXeOue40n
X-Google-Smtp-Source: AGHT+IFuNxO/vAJGBSQf0X0zue4DrqJfy2Im0U5mQK59KcyjDBi9LKq4XwIzzUc37VkLKwvDPtY4L5mlNnHdAYwyijE=
X-Received: by 2002:a05:690c:9c02:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-6f5311f86dcmr44197627b3.6.1736386934739; Wed, 08 Jan 2025
 17:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106235022.3859523-1-enlightened@chromium.org>
In-Reply-To: <20250106235022.3859523-1-enlightened@chromium.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jan 2025 20:42:04 -0500
X-Gm-Features: AbW1kvaVBfWYoRuRIg0anjLmixxvkSZIUhwZmuUivTaG5s8l0aMCoV_R-PjeFd8
Message-ID: <CAHC9VhSdDJrEvSi_8LXM7Uop3dymTOwPyNJJoR+33HymMwuZUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs: add loopback/bind mount specific security hook
To: Shervin Oloumi <enlightened@chromium.org>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, gnoack@google.com, shuah@kernel.org, 
	jorgelo@chromium.org, allenwebb@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 6:50=E2=80=AFPM Shervin Oloumi <enlightened@chromium=
.org> wrote:
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
>
> Changes since v1:
> - Indicate whether the mount is recursive in the hook. This can be a
>   factor when deciding if a mount should be allowed
> - Add default capabilities function for the new hook in security.h. This
>   is required for some tests to pass

I'm not seeing anything like that in the patch you sent?  Am I missing
something, did you send an incomplete/outdated patch, or simply word
the change above wrong?

> - Reword the hook description to be more future proof
> ---
>  fs/namespace.c                |  4 ++++
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 18 ++++++++++++++++++
>  4 files changed, 31 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..535a1841c200 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const ch=
ar *old_name,
>         if (err)
>                 return err;
>
> +       err =3D security_sb_bindmount(&old_path, path, recurse ? true : f=
alse);
> +       if (err)
> +               goto out;
> +
>         err =3D -EINVAL;
>         if (mnt_ns_loop(old_path.dentry))
>                 goto out;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index eb2937599cb0..94f5a3530b98 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -71,6 +71,8 @@ LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, s=
truct super_block *sb)
>  LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
>  LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path=
,
>          const char *type, unsigned long flags, void *data)
> +LSM_HOOK(int, 0, sb_bindmount, const struct path *old_path,
> +        const struct path *path, bool recurse)
>  LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
>  LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
>          const struct path *new_path)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cbdba435b798..d4a4c71865e3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -365,6 +365,7 @@ int security_sb_show_options(struct seq_file *m, stru=
ct super_block *sb);
>  int security_sb_statfs(struct dentry *dentry);
>  int security_sb_mount(const char *dev_name, const struct path *path,
>                       const char *type, unsigned long flags, void *data);
> +int security_sb_bindmount(const struct path *old_path, const struct path=
 *path, bool recurse);
>  int security_sb_umount(struct vfsmount *mnt, int flags);
>  int security_sb_pivotroot(const struct path *old_path, const struct path=
 *new_path);
>  int security_sb_set_mnt_opts(struct super_block *sb,
> @@ -801,6 +802,12 @@ static inline int security_sb_mount(const char *dev_=
name, const struct path *pat
>         return 0;
>  }
>
> +static inline int security_sb_bindmount(const struct path *old_path,
> +                                       const struct path *path, bool rec=
urse)
> +{
> +       return 0;
> +}
> +
>  static inline int security_sb_umount(struct vfsmount *mnt, int flags)
>  {
>         return 0;
> diff --git a/security/security.c b/security/security.c
> index 09664e09fec9..c115d8627e2d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1564,6 +1564,24 @@ int security_sb_mount(const char *dev_name, const =
struct path *path,
>         return call_int_hook(sb_mount, dev_name, path, type, flags, data)=
;
>  }
>
> +/**
> + * security_sb_bindmount() - Loopback/bind mount permission check
> + * @old_path: source of loopback/bind mount
> + * @path: mount point
> + * @recurse: true if recursive (MS_REC)
> + *
> + * Beyond any general mounting hooks, this check is performed on an init=
ial
> + * loopback/bind mount (MS_BIND) with the mount source presented as a pa=
th
> + * struct in @old_path.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_sb_bindmount(const struct path *old_path, const struct path=
 *path,
> +                         bool recurse)
> +{
> +       return call_int_hook(sb_bindmount, old_path, path, recurse);
> +}
> +
>  /**
>   * security_sb_umount() - Check permission for unmounting a filesystem
>   * @mnt: mounted filesystem
>
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> --
> 2.47.1.613.gc27f4b7a9f-goog
>


--=20
paul-moore.com
