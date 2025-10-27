Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1F1C84B9
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558059; cv=none; b=XB1Txmb3b1tqGzOrz3rKlTprgdS0rWdTGgrX6bUWFAAuLMxViYGWew1Neiq10kTRuWuo0DMsGFDAgYj2EZqFdMpVJ2nkSaK3LdkCGf3QVOBKcfr/mtaOw7ERYo2d0cAhjrjuGfC5D1kGuZEY612FuQr/LwWNDp0iwB/JoSQ80Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558059; c=relaxed/simple;
	bh=LJf2KlQpTI/J4Q2WN+sN/y3pJoAQ19a2PFHP5cQAUww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nif8TUSBeWTtXVh8FG4zTdHIatLX6KYB+7qh2R1Cu32uGnvbrZrurAf75r0OEbHtjFzjYUkhTWHULnsVFOH3xlJExcpZHdbr2CoKqZhVxvsbmkWczINiAnKISvH8amfTIVktfVV1AXZoxKmeZ+iYUpQjIXDDbNly1BcyL/erPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvlXdDyP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvlXdDyP"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso7858199a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761558056; x=1762162856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09qrJlPsayZCPVTpiVR4xUYmrnkMGkD243Y8R70R/2E=;
        b=GvlXdDyP7cLu2FemyS63alnCOggPpYN6/On9+AmLeq5DI/sea8hwfoGVr8i2FSAAlC
         TjhDV3QmwMxGwn6CSBvn5W8VTCWhP0xdhOBNgzhD3yj3vCzQwz74+GqF5qHoFAsVhh8a
         seFWbKTegfuJTPqXKJbwRP+SLP1KoNs2stalXZ0s3K1H3BzR272WWViM9Wz4JSyFnLWC
         0XXNAZ7qjfFHqWOQbhD9893ksDekOjXHxOkSzn3EV9xnoEJtLt1XrZrzR6vzyAZMKIud
         Xmxirbn/W/jFY1iM5K+9BGOmaUlyOFxTaG7AgrZeUfoEFf+ko1pQ5136GUaek/6fGstl
         Jj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558056; x=1762162856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09qrJlPsayZCPVTpiVR4xUYmrnkMGkD243Y8R70R/2E=;
        b=kQEd7r1+Rq9ryBWoMPuTOlgq76z61TRxON+jixThor2jaeSbPmSrZOExSe8bO51yAC
         nKTHmmHo+tGECN+KiLvGD5Ni8f2G0z6//ZYTqZrOQcWZnqhE3JBdCN2YewOS/bp1atOv
         PYcapINcFoen1pplez4VEMl2ZZaqqoPa5zDzrEo/osB9OhNgfirPhmMaJZSJZ3Fefkn+
         n9VsNXiiXk4TGRNW/efcRYvN2mAWJVVGQKq8nsZHsWSEJFz/YDTNJ/9dIFX269OqlqiE
         7niAkfkeEwwzfi3TsVPSDF6w/H8iNwnoqay2GMoLg8xZJO/sgpgZuBfpxmKBsfccFd8+
         OLIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFnIZb69YNtOC23jtCg6XX9ZLD6Xs5bH9gPFGcTri1f/NQzAajjYtzVp7iws/YMZMhSmWYdHICJt6bYbjArgN5gtUgCfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQcUdDkBVGLpYpl9KID764IJaSZnfzOY9m4w9N8dTxTnEPO46
	EsRj7U1ZrBfXg/BbjBFoyRtjF8F6COuEh2yAvLJP/7vpo1xfEzucmZpGBMIv5ypD3Q==
X-Gm-Gg: ASbGnct/m+W0bbbtdi3VY0Qz6besvfAGecpnJQZpk+gPk8P1HoD3nIIAo8Ur00pZFl0
	3zUFq2hI+g4uyppLpnDnGTAwvS9Wjph9NN1MrH51kLwHQ6X75Pn5KZisowzIpRwquE22lIt/me+
	vneLOvnQNQ/ldaI+AHA67qnDKPpRGTbiYFxFL0Um/aLsPPNVgugVlp0MB5mll6SzkT6qdX4ETvP
	M5xxPnc7XAV412Emo91GtP8+vq3k61hlKaxOHgshM/yvtHAbv/dcwK2D93vOdd3BILQ2uGkA0mV
	KW09OOWFxbwWzTN3ahFQmP1mCUTJ8OI5pfB0HmExxXrMjHZywx70njQUBNU4LYO7A3eldGrQHp1
	iYtUF8XIGLJNVkEzUp3qBsvAhIerj1oe/kr+vE03kcgMvJrW8sJ5r/Ay4j/QUmbTSPxdtkngypZ
	Xt5aVRul8b/zFS+kwZ/46tVLr6ieI1dBN8U4zgVzLw6X1yggBJ9whgmZnI
X-Google-Smtp-Source: AGHT+IGN1boHe/GFDg/GqZt15GA1jLaCNOuuTeRlKLZW/T+8td18Gf64Z7udwrA77jn62CAOrb+kNg==
X-Received: by 2002:a05:6402:1442:b0:637:e57d:c21 with SMTP id 4fb4d7f45d1cf-63c1f62ab3amr34451213a12.3.1761558055326;
        Mon, 27 Oct 2025 02:40:55 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9739sm5929263a12.29.2025.10.27.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:40:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:40:51 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	casey@schaufler-ca.com, kpsingh@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aP8-I5ZBMU0PNDJV@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025001022.1707437-1-song@kernel.org>

On Fri, Oct 24, 2025 at 05:10:22PM -0700, Song Liu wrote:
> lsm_prop_bpf is not used in any code. Remove it.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
> 
> Or did I miss any user of it?

No, it doesn't look like you have, and I don't see how struct lsm_prop
could be used from the context of the BPF LSM ATM anyway. Thanks for
cleaning this up.

> ---
>  include/linux/lsm/bpf.h  | 16 ----------------
>  include/linux/security.h |  2 --
>  2 files changed, 18 deletions(-)
>  delete mode 100644 include/linux/lsm/bpf.h
> 
> diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
> deleted file mode 100644
> index 8106e206fcef..000000000000
> --- a/include/linux/lsm/bpf.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Linux Security Module interface to other subsystems.
> - * BPF may present a single u32 value.
> - */
> -#ifndef __LINUX_LSM_BPF_H
> -#define __LINUX_LSM_BPF_H
> -#include <linux/types.h>
> -
> -struct lsm_prop_bpf {
> -#ifdef CONFIG_BPF_LSM
> -	u32 secid;
> -#endif
> -};
> -
> -#endif /* ! __LINUX_LSM_BPF_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 92ac3f27b973..b6ace332576f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -37,7 +37,6 @@
>  #include <linux/lsm/selinux.h>
>  #include <linux/lsm/smack.h>
>  #include <linux/lsm/apparmor.h>
> -#include <linux/lsm/bpf.h>
>  
>  struct linux_binprm;
>  struct cred;
> @@ -163,7 +162,6 @@ struct lsm_prop {
>  	struct lsm_prop_selinux selinux;
>  	struct lsm_prop_smack smack;
>  	struct lsm_prop_apparmor apparmor;
> -	struct lsm_prop_bpf bpf;
>  };
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> -- 
> 2.47.3
> 
