Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A93F660F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851370; cv=pass; b=H/7CwiIN/2/djrq3yfn5jGW2h4NHR8XyBPXocnil7GND5GqO5zImHWZgcKAicRVVh2qU0D4bD5mmDHZ6YCeSoS1X1gnhNuX+xbA/d+onINFOAv7HtdhdsxDzaIGJbZh6EoI09gyMdUqj9c6n/dHCMopVLEw2YUP70qauttrk9xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851370; c=relaxed/simple;
	bh=dwOqiO4po+wqev10gSaz7p5zryfByfkTgGACoMm21c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJTPVczfM5MBdH98TnEncnQoh/id9U8XlahX4zlqky8r0/iztR262rejGdQitDyz2zU76NlJveO9CTayJP8GbLdX5vpFT7wJoxnURR/hFh9nutIxAjF9f1a1Y5aAY9Rdvry1qjFTIf226PFr11YAsCcddqKi5pXrsg9gEsY+cb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J4Xr7d0C; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J4Xr7d0C"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829a27414a3so79968b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 09:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851364; cv=none;
        d=google.com; s=arc-20240605;
        b=lBsgljrg5dqvdzYgGLxUZSX48UXrkblAhLx5kBjAE+5m0mWVX+bhQ4gGGrUWPSDUGz
         V92w04l7F26hu/YSvJdSqByGiRnGAp/rMFVxTTrdJ5vU3VTCdq+oFlTpHaPuPQO6PwkX
         B6J7FC4o9XeXJ5f0aR/4IqvcCDddwmUfd8MzwH8UB7CWP2yscS1T+gw+aTuoR+biZNvr
         tOkoyomLM+RRrr0UaOJiqNWFguvj+lKeefctyk9pbbdG0Onz3Ec23yC64/5ltl0cY7Oq
         GkjA+n0SGe8UVjyp+Qx4bbzEcScsDYW+l7rgz4hdiAXmg3a6oT5YH5SbAk/ux6XnCnFI
         iFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNoB8uIuGPZVbfIhZFXhGKKHmOXtBWuNvH4MFazXXZY=;
        fh=+7zAja6ymHM+h06+iltw5LJdqFtp95bawL+GVlXzrp0=;
        b=DLqGoCygQBmKiDIn3UnvCjbOZIHVkX6NqR/ictXeEtesV045ZPhkMN8XVAfzmakIL3
         CCvPrQ3ftgXfCDqtcK5IIQrJ+PrhUqTSRLlbNLHxqIgIls8rUEDJqZenMkSsmvL+NMYZ
         mkjSF15icr0HHnsBPySel93aS26qT5rsFKqo3EZEoPSH2q9oaXdG26xkklYs8Kc6EMP8
         gbpG/zSYWJUQKSBigg6a4OkuSOUI3NwcA9FB0Urde0EkPX2Qiets35qmAut8i9rfJE28
         8aJy4l2JHuEbm+XWt86tk3C+mjITVyKLmO21FDrY4LQSgVhQjAz/1QvG32F2p+Fqqw7C
         qUEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773851364; x=1774456164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNoB8uIuGPZVbfIhZFXhGKKHmOXtBWuNvH4MFazXXZY=;
        b=J4Xr7d0Cqv3yuvUDuITyqQz3yH8gyyFPDKayVRMLKZ0Tz6F7wL7kEb1Rrh7GDolxzT
         gfVnOKRd8s4T8b1VqURVOVsgtTKLDH+XorF72zdMqrDvPqNKwGc4qHHn4d0h9Lxvc4Ad
         Yld0W8ddBl4EIwsPzm6RKNc3mMDdb2nb9orbF1h3oqQNCTRbzKS0lfxRVpEYxoqiFHeA
         6MxUd1fHHHjxEnD7HW9zvT6LH58tDFSMysJ4o28j8Ah4//WyqZj56U0hoIfTM79kbL91
         qzEzGoDAHCG9hnDOw/+GWNIz1pI1R6736FFACcKkj+40pGkEPWorbOwdUXuzCUziQL0l
         6l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851364; x=1774456164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNoB8uIuGPZVbfIhZFXhGKKHmOXtBWuNvH4MFazXXZY=;
        b=DZGXWvBIeCtM4R5IgGogXx28vr2nAywYdndni0Q9vcO5lsowY6ffHjfjFYJLECb3P/
         SYAnhAfxNkxjZgEPAP91p6TlCo16q4CaxicCbNi/Xf1wJXKwy8yCmeVm9Po28h8tEGTL
         6HQlHiB2DPhlVdarDR6UBU+5uowayFALjXfBn51ScoF3hJ45YmKWCqG6RFoxteiAjN32
         EuAPSRkw2l/Nn5RPrWL/QKnt0Nqr8MlUVBuF71vr4+7TBPWu6dlvVa1uCCs/WUQa6Q4S
         Xxrvqg+zvJysrmG3Xt6FV8ogvywGR6vlZmPEdUgd68Lq/voGy6jtabU/XBaF89C+n+5u
         q11g==
X-Forwarded-Encrypted: i=1; AJvYcCUcLVTunYiYLlpZTgukhDbzxbMsvPn7DO+2zPjAVMTWa+Ori7tQ/N5CYzZ8aYcDThnkFPWKS3phUtEwrmw6uAXmRZo2nEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qYBlqEHaSpylsDvlxuo/HZzsFLhmWgv4DngdwZP3NPqGWU75
	mhJf/oUGGDwVhF3nZZYXaQuIMqtfq1wnxXLSWkTQ4qsW5AtTy15WNEQ/hLfvUrV+CjmvwMY6JRo
	0ANYqAMbSNtOI1zjIcakOJhh03VrWCvVhKMLD4nh+
X-Gm-Gg: ATEYQzxGdvJZ5KTTd5Wxl2i0ABkux9U6MuUV7URPLyoxYdOUKHPjsiH1HeOl6efzOP0
	/7W6IaSUYrEmrNO9dBy6C/TTcQvmtOPTjibcGvof5Sqc91TeZwoskEnBl2Z0N8+RkUoIKnzB+py
	I6pJ43KLYPwNDOTV1ZyXckw5fJREKugS7lwyukKcKkXQuuSDHCZDDIFV+8ht719PmzuAOjRJyEv
	DMJL0ROm8j++/OqvjXOkaj8q64kHb9GFavbeYJ4rF+Cbup2DgeYRdlFKROhxrlCbvP4eiNJPSK2
	mWG1kHA=
X-Received: by 2002:a05:6a20:144d:b0:398:dde7:2dc6 with SMTP id
 adf61e73a8af0-39b99d4ca34mr4120420637.18.1773851364162; Wed, 18 Mar 2026
 09:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318104322.1643085-1-arnd@kernel.org>
In-Reply-To: <20260318104322.1643085-1-arnd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 12:29:12 -0400
X-Gm-Features: AaiRm50uXDAoJZ95ZzhDG8h8rlycIHy37pDpkjE-c_AXxf1S01biQAAKW51rWf0
Message-ID: <CAHC9VhQoawCxVSFGY1whF_pwfH0FHrT7QFC6cgWeFV2XApC6hg@mail.gmail.com>
Subject: Re: [PATCH] lsm: export security_mmap_backing_file
To: Arnd Bergmann <arnd@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johhansen@canonical.com>, 
	Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:43=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This symbol can now be used from a loadable erofs module, which causes
> a build failure when it is not exported:
>
> ERROR: modpost: "security_mmap_backing_file" [fs/erofs/erofs.ko] undefine=
d!
>
> Fixes: 0e2baaf8fed0 ("lsm: add the security_mmap_backing_file() hook")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/security.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks Arnd.  It looks like I'm going to need to respin this patchset
due to other changes, do you mind if I fold this patch into the
associated LSM patch when I do that, or would you prefer this as a
standalone fix?  No worries either way, fixes are always appreciated
:)

> diff --git a/security/security.c b/security/security.c
> index 8d10b184ce25..3e426a762864 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2529,6 +2529,7 @@ int security_mmap_backing_file(struct vm_area_struc=
t *vma,
>
>         return call_int_hook(mmap_backing_file, vma, backing_file, user_f=
ile);
>  }
> +EXPORT_SYMBOL_GPL(security_mmap_backing_file);
>
>  /**
>   * security_mmap_addr() - Check if mmap'ing an address is allowed
> --
> 2.39.5

--=20
paul-moore.com
