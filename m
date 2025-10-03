Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7B33E1
	for <linux-security-module@vger.kernel.org>; Fri,  3 Oct 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511751; cv=none; b=mFV9EJDT4OL0x/xLzDuLiEINGOx/wfO0C7Tyu7K1ODJY/9IkZ3QOT3fVFz7M978O6sJFcArSZlr3HL4pDnosAm8pqj6ob91Q3kCCuYaOz/LZWUFod9Nndqlu5Gutj91jLhhD/FKGCJToNIlQpYCdFiMQcGcS3PgeM54seNiWy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511751; c=relaxed/simple;
	bh=0NPoiZbcuTljKRE9IE9cfxsjid914W1BOeaB5B1MAWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbRrGNnQU0PP0Ktz7DtBM7e7bEt4Jo0YwRboOzJA1iIry3VD3coSV0RkZp2cxuOGrBfD1eeY+BA4uBwMbdS/QVX5WVcFfnzee5X6TjwqiZLhAQXBQTk5hvSJHbR+cqs6L2r0sQ3lyoVexnN/aZQQB/w4WQLEG7RlaT6pqM2JkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmHnmAH3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmHnmAH3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so767285a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 03 Oct 2025 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511750; x=1760116550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQrIlPYCeDMFS6g0Xw3ObCA9wB0GS/RdHfZWbwbQfmg=;
        b=JmHnmAH3+dJvXRjVAyKivmPwC40LrbU/62b4pnMI+im1Dst/p5ZGPyvhu3x+Q3LMvD
         kpDG1PKVlslwRAoo3OOOSmoI/Whho2FqSb9kI1rISCgt1NZf2YS/Je2E7/yiqu1jNRg1
         UDWUjq7OfxyaB0aMMKX6DwYs3eS3rgDkXAHyaUR4dTWeoqrvq3o8Z3TLKgtc+W2Iuny0
         A0pJYBZ/DZJGOe7dpX6Nb6Jc5JZMTIKQbiH2RBTbA26+S/do5zx4Pqkw8DGZdmygvqMN
         ZWzsYml3WSAWh3BC2wN6ijtoQEh4ISv5JzZ21g1Z7s45k4BVvN6q1Zq7XyLb+tS3aDJZ
         d1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511750; x=1760116550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQrIlPYCeDMFS6g0Xw3ObCA9wB0GS/RdHfZWbwbQfmg=;
        b=h8MUWtQg4sxs8OM1Cx33IXdZgNVxyqkiVkTGQJAS/+i+SuKbLWJdLDBn7jCxg577EH
         X1zfNCZxPl3jlMKD/ErH6tESKEEBPGwPAQJPcRx9fV5338i9Uleq7Kd4sJzWsoAN7iaV
         9mDpI7+CQ5xJJh0tC6EO3bu3zGfpgmlFI2D7OvFejPrR2i2hE1cv8zSi2y9wulx/SuHG
         +CCuoyafuYPDg7wHn0Aer6FxCDy0QGMBDdOW8O8QKVjK8648mT77wuMQOFDzn7w0iYdR
         5BTWMql1xArREeIrkAw2jimHsYNCeyYS6JrskdctmcI+VWHaURlGFRGLrIZeO+8oE21H
         pp2Q==
X-Gm-Message-State: AOJu0YzcSj0RP7iQAy1MVe7LBMBEbMWYBmXk4vMQMLZo5Fs2tCM5TNta
	zEzj2GTn/QfsXVy3xBn0d1esO3FSLP9sHszpP0hJVETemEMaXVlx+uUtc+Xv46wWiCeeB6uVO7S
	RwHn57s6P0nnlPSHCSEzv1keUhJGxbY70ew==
X-Gm-Gg: ASbGncv49fe2H8VROKVF9VmS1iI8cSCJNDRc7YJsMNC4EdrY7XZv/N6T4wrfdSndMxa
	gQ+oncSOibj5aX8iKeAs5lBKlreFe1YGOzxD5ZH4GjJEcCKuipS8kvx2Y9AcevaF9MsG0n0Fm6k
	eNFz1SOuAWyOXHd3qucHUmYkE2MF4u7MlFkQ93mAF33z8SgV1Elornxifyym4GWsFkfc/HlRCDG
	FmebJRhTDq77OEypg56cfmbVW54TG+4lRK6n6C0gw==
X-Google-Smtp-Source: AGHT+IFcEuKic+Tf8lUTRJaPEPEhT5Rl6gMjc2kZRCXF5TJDM1b458clM5LKQjmau6j6GSyui8n/y0pdq1kHCcaAE+w=
X-Received: by 2002:a17:90b:4d0b:b0:32e:43ae:e7e9 with SMTP id
 98e67ed59e1d1-339c27a50ffmr4890684a91.17.1759511749562; Fri, 03 Oct 2025
 10:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003131959.23057-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20251003131959.23057-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 3 Oct 2025 13:15:38 -0400
X-Gm-Features: AS18NWDnIjAoE56yw_HjZFFUH0XaIXMln7NGShezn1DAyMFjLswB1bLYS-dxnTg
Message-ID: <CAEjxPJ4bdDA4mcPcYv1wyfbvBOYjg0018Q8QwYcMUUZAbvoCRg@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/lsm.h,Documentation/userspace-api/lsm.rst:
 introduce LSM_ATTR_UNSHARE
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, casey@schaufler-ca.com, serge@hallyn.com, 
	corbet@lwn.net, jmorris@namei.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls. When
> passed to lsm_set_self_attr(2), the LSM-specific namespace for the
> specified LSM id is immediately unshared in a similar manner to the
> unshare(2) system call for other Linux namespaces. When passed to
> lsm_get_self_attr(2), the return value is a boolean (0 or 1) that
> indicates whether the LSM-specific namespace for the specified LSM id
> has been unshared and not yet fully initialized (e.g. no policy yet
> loaded).

Upon implementing the 2nd part for SELinux, it turns out that the
lsm_get_self_attr(2) call can't unambiguously return 0 or 1 due to the
current interface definition, so will be spinning a v2 that instead
sets the *size argument accordingly.

>
> Link: https://lore.kernel.org/selinux/20250918135904.9997-2-stephen.small=
ey.work@gmail.com/
> Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=3DUE=
BjqQZQ4UBy7yds3eVQ@mail.gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  Documentation/userspace-api/lsm.rst | 9 +++++++++
>  include/uapi/linux/lsm.h            | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspac=
e-api/lsm.rst
> index a76da373841b..93638c1e275a 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -48,6 +48,15 @@ creating socket objects.
>  The proc filesystem provides this value in ``/proc/self/attr/sockcreate`=
`.
>  This is supported by the SELinux security module.
>
> +``LSM_ATTR_UNSHARE`` is used to unshare the LSM-specific namespace for
> +the process. When passed to ``lsm_set_self_attr(2)``, the LSM-specific
> +namespace for the specified LSM id is immediately unshared
> +in a similar manner to the ``unshare(2)`` system call for other
> +Linux namespaces. When passed to ``lsm_get_self_attr(2)``,
> +the return value is a boolean (0 or 1) that indicates whether the
> +LSM-specific namespace for the specified LSM id has been unshared
> +and not yet fully initialized (e.g. no policy yet loaded).
> +
>  Kernel interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE     103
>  #define LSM_ATTR_PREV          104
>  #define LSM_ATTR_SOCKCREATE    105
> +#define LSM_ATTR_UNSHARE       106
>
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> --
> 2.51.0
>
