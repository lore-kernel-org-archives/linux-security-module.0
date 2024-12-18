Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E31FC102
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558704; cv=none; b=Odg0iF1PAz6VUnRGCyB3GUUKn/o9rRF3bF9e/H0Ww0KxcaEfdWWqQKpLS5W9Mh/CPDA7igWqF4ySI4i39T8BBXfuMrbQ0qk9XL/hJRZYpCKzbzaUmjTgDR3z5evDkRZjrI2D13lkaaZs4tFWRH5T0su863Wt3u7Y0HmCn1O1aeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558704; c=relaxed/simple;
	bh=UNCCDv5z8ixchwYOxk9Ij5M5Pl1xOqzKsRygRZSeBJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKtC3pp+7f/YNPnRFPQ01KG2suTjq6W2yFk5zOLGNiq4ArI3bhPYaujZr5rnwdJxgsc7/zKOKwibzbblV9dnjfc+5wumWKCKD8cByeopLONjoKAX75VsaWAlENWBVMdhfuwT3MRNBEEgxHzwlHA0mYHeI4UB1x0XVs358CyVRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mimq9mPv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mimq9mPv"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e399e904940so112819276.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 13:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734558701; x=1735163501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrXIPFqOBLul2VgugyJ23MO+CFdBjK5d/jspFx7DXnk=;
        b=Mimq9mPvd7t9yPcK5HwmthhXDUQta3A5fh4AYzj2CbxpEOm7mEkm3d9dx/1GwzKJLt
         6tD1ohBQqH74x/TIVOAz0mWMvVvwCXzk5lz/Dr+1BgPvXf8/rP579sZZh13/XyjEVTLc
         nTRY+fuFtOrNLeNfsU9WNXSRJaowIdDMfI2uYWdey5P+WABUpHdyxwg5KyVJm69ATGRK
         7F2uSHFjSON59mqjIaiAefAwNYgsI7hZ7zWQ+ug+kG1jVM9dw2MtdnBPV+r1YG43k90E
         pRYaXX+qQjbbl/MkngPDyLHHuBaXreZTlOn36Og67XyLwLUy9GAA2T86Vt+nDZx4pRax
         EPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558701; x=1735163501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrXIPFqOBLul2VgugyJ23MO+CFdBjK5d/jspFx7DXnk=;
        b=sTvgNlv0ZJZPpuKfpn5O5vGrm/xygDJSz/axdDCM7AsDcAZAHiIIkjTM63h6umv+GH
         +4kGInBZ9Eg6PKnygMu+OA8MVprKsZ+KlV7X9BEFFoQfwuaDvWTj/YnISirV7U2DScD8
         XfHx08xNN2FFOpay/7400FCNUPZoUPh7Yv/gWu1kIVISlCg6sNLqrYw7h4Abr1DlZMML
         Eq3g3mAeGf/rwqvb/j+4xpAwMShip6Gx9rt92PKb3zt2+5jNd9m7RafqKZKA+ALjZd/8
         N4QlRDichfFaKFKXJ3lW1zZX6ECAbIx2yZ/hOXm7Jwv71D0uLuLisEnqVSUZ06T2qpeQ
         kC6A==
X-Forwarded-Encrypted: i=1; AJvYcCXNRNxPGDZeMjO1Z7tZPNnQwMQokIvFy8q1vG5X/MVxsbis/SKIWF1PI8Oezfft1lsdn2RpP8DXLHwBXRpIWF9fzf8Q9J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCKzJV5Vs65z5hWsshI0zRKYkYgSGtXHVfzOzsUiguDkgRPpf
	LEHGPAzA9XdGxibOvUv7jb8xmT/Xy5TA+KiZINcgvpRDe9BdnYD889ylqaeDJLPf52V6EdUrX0x
	9PAeRykPPb6n9PUbpaOifjIcj3Sn1V8BcsbqkgLOv02mNUUg=
X-Gm-Gg: ASbGncsUPAoUxMmSY+o3T2p3i4XQCciq4RNVld0R4TyWcHtybOEmWLwFeY470j+re7e
	mgqkkxqSPTmsGngTGOghefNsBR1ZRuqiVfSAd
X-Google-Smtp-Source: AGHT+IGglgUre+DOHpXxcijtzxc1muMl0gK6CeHMSdJgN+FhAIVgXuK6sjmKQkwTVekbrfXp+twO9uPUSn96nFZmo8A=
X-Received: by 2002:a05:6902:2383:b0:e39:9eab:908e with SMTP id
 3f1490d57ef6-e5362231224mr4183284276.52.1734558701581; Wed, 18 Dec 2024
 13:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
In-Reply-To: <20241217182657.10080-2-leocstone@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Dec 2024 16:51:30 -0500
Message-ID: <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Leo Stone <leocstone@gmail.com>, mortonm@chromium.org
Cc: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.com> wro=
te:
>
> syzbot attempts to write a buffer with a large size to a sysfs entry
> with writes handled by handle_policy_update(), triggering a warning
> in kmalloc.
>
> Check the size specified for write buffers before allocating.
>
> Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043a
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
> v2: Make the check in handle_policy_update() to also cover
> safesetid_uid_file_write(). Thanks for your feedback.
> v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gmail.c=
om/
> ---
>  security/safesetid/securityfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks okay to me.  Micah, are you planning to merge this patch, or
would you like me to take it via the LSM tree?

Reviewed-by: Paul Moore <paul@paul-moore.com>

I'm going to tag this to come back to it in a week or so in case we
don't hear from Micah, but if you don't see any further replies Leo,
feel free to send a gentle nudge ;)

> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securit=
yfs.c
> index 25310468bcdd..8e1ffd70b18a 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -143,6 +143,9 @@ static ssize_t handle_policy_update(struct file *file=
,
>         char *buf, *p, *end;
>         int err;
>
> +       if (len >=3D KMALLOC_MAX_SIZE)
> +               return -EINVAL;
> +
>         pol =3D kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
>         if (!pol)
>                 return -ENOMEM;
> --
> 2.43.0

--
paul-moore.com
