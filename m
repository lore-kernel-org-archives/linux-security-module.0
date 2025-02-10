Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F191BEF91
	for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199413; cv=none; b=L0KQYAP3N6mfeRPdu/MMmmIro7ntxxJdArUn5k5XCYJnb7lLBJHW9FQSwF6cbri7k9/ikJwMLqFN5d6qCZ6K+unLDl7AUyGuIsG0z0Kwb/0MU0IjqMfVtB41TA2rRzkfalUik6lNdS/0SN01djpyWW9J7xbkDk9ZdBGOie7Ft6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199413; c=relaxed/simple;
	bh=sFhCPdUNAw5iw44504+Ovi0gxtAx+rM+ifalu1G9FiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOt6H23kT5OGRgZdlm2EbksdzeOZ5FeCk3juaFIx7eyn3pZn2GpRcAmFkju6zrtv4Vuplubyr2xp/xl4AkSogYpgCmfGbZeEMW+EpX111d6WIMdwWH1ud0xfNUETGPI0uZXiMMnwUcAFgZPwqr2P9FAzx6nW8zjgOz4tfq6eB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yy3WvLMa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yy3WvLMa"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f679788fd1so30519417b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2025 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739199410; x=1739804210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKzEUyykFwouVSNMgbx9VHRlGiI6/+ni72GVpTcZkJs=;
        b=Yy3WvLMaWrGpEQ8TTc4O2FGWEfLVPn1SgAtS74x4SwYvc6T8YYn0iktg9DCGOvToSY
         NGv7f4MpVKXxOnWjL2k+tgfhkFBONOZ3C9qK86WyeNG6vj9w11YVmqVL6w9rTNQ5I9OM
         xQLCRXSmPx7JRQtAo6AlEL5iYU4uv7rIf2SoN46U0AoYg41seolT6Yfhw2nFMIgYH/kx
         qrQCgPTc3LQpC0zacq2qQphol39FhoyXQ8uCdgcSJOfpAVS3IcZZyaKpuCzCulALO30u
         v+ka31AXRBi1zdYpRBbVcGISk1VdsGnpV0zbeIeTsfIw2UOb4StwVOjPq5tR8Tp7tSe9
         9tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199410; x=1739804210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKzEUyykFwouVSNMgbx9VHRlGiI6/+ni72GVpTcZkJs=;
        b=Lat7Z8jruevDNF819pr0cOL2V7JmUT4rSm8Ww3P3QyTKt6jqAW7Ovakk6z0dBjFyka
         zzkPf6BAPiOUh0xnM5kpqTeQ3CktiFys+dNRs1Z3z+ClbknkBjcWx+V6v7vXcjBndBEW
         RUo2m44QpD9FJMEYoyPUEVhpcjyzlg1KGUGEBcdjgrZLOnNSxqn8SGB0nM+gjBXVegdl
         WOY5vAs94dzXW/JA7vGh6vZfegjOJ7zfUD7KsCLGiIMWdQVQm6vuN1kxsbT7s2m9bTaf
         IjcgWukA6TpNzKte+yDetz3XJSSt4fZJxSjwydh8X+z9VpBYD1U9bg10JwIRcRGQZZoA
         iLpg==
X-Gm-Message-State: AOJu0YwQmcTYPL8MQ9G18LsimsGx4nYbOSqSU99UsxrauiV53OBC3Ipu
	15xunVWBCFtaZdBglNlZlVZXDbH72UK/+i66rqCLFDq+FPQifDsW3W7gOTcAYbyWarc7ovhezHM
	vydX53rJkoeWFXtXjjmKEuBvcYDJ7NxB2nHbqIJQuKq7V5J8=
X-Gm-Gg: ASbGncszGJR4r2cuRajaT2ilsvrO5rk/8aTYdZ+daUBujYX2Tx3yw0jaF2WboB1DRPX
	tqC5pyB6Y3MmOMM053j3H56hBmc/U/T2TZEJXVVRGZ8yhlVV8HPiRKQNCKHLm97Da2LoUL0I=
X-Google-Smtp-Source: AGHT+IFX3Fkp25VzweHfvgEsrx+xC8PuKNFykmTjhscCRMIA+yQ8nq4hk7Ivp9FeonkpLJhReXlBBAxTPaWZi8G4lC4=
X-Received: by 2002:a05:690c:6f8c:b0:6f5:3bb1:7b7f with SMTP id
 00721157ae682-6f9b29d8062mr118695267b3.26.1739199409102; Mon, 10 Feb 2025
 06:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210034132.8448-2-paul@paul-moore.com>
In-Reply-To: <20250210034132.8448-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Feb 2025 09:56:36 -0500
X-Gm-Features: AWEUYZm-GxL2Ov0Xi9Cza8-oaPxHSWN2MC_VBhPJXsMmQeIYb7a2snP2R7tj93c
Message-ID: <CAHC9VhQfiABZQagVsZV81NyW2Gm8htwHjG7EHiUTt_LSebDUTA@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix a missing security_uring_allowed() prototype
To: linux-security-module@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The !CONFIG_SECURITY dummy function was missing an inline attribute which
> caused the compiler to complain about a missing prototype.  This patch
> adds the missing inline attribute.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502081912.TeokpAAe-lkp@i=
ntel.com/
> Fixes: c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for io_uring_se=
tup()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3e68f8468a22..fab843d5e621 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2376,7 +2376,7 @@ static inline int security_uring_cmd(struct io_urin=
g_cmd *ioucmd)
>  {
>         return 0;
>  }
> -extern int security_uring_allowed(void)
> +extern inline int security_uring_allowed(void)

The extern also needed to be changed out, essentially doing s/extern
int/static inline/.  Regardless, this is now merged into lsm/dev.

>  {
>         return 0;
>  }
> --
> 2.48.1

--=20
paul-moore.com
