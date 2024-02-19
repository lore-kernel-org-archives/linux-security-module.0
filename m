Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09F3D38C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Feb 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708376871; cv=none; b=PQ57rymL6EpkAzbyhb6D5LfD2V/QuSxzUHZw+rHZ3jUHhZ+VJJPtBLsn4BFM10npKDtaoi+jGOOGDF4Ucl6IGUREge8+yinEdjDovsYv5v9mCcGf7mzUXdvxl5C9ZIdkBzyJ0IcRJqpZ8IfNnwM1VXTnIzJ2D4QpD4+3BxhsB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708376871; c=relaxed/simple;
	bh=Wb1EsAOdRQ+TypSlFyHwyJrlgDHcSksuMbbbXKbQxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOyGfnDzLaiY5+DdnHOaF0wu0ET6WPfhCu86Yu1VtXFuQOOgyczr0jc7cFP01foe+VSEQ4Sh/ERaZTm6RK12QmHbdoaitemn2iuQ0urrdsJusTmL97JiFJI5fStDouYlN2ky5MICdXB34CHRdVDvix/DCP2osWtzn4na6yLbJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqGzwUhi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqGzwUhi"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e09a890341so2383905b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Feb 2024 13:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708376869; x=1708981669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0v4aGJ9LU9dBSomS+ec3dUGjJlpnKfj3hq8T5zymb8w=;
        b=FqGzwUhij7LMdv6aCDTBzNyV/FOCGQFfjP95A8FhobdSv6sKeSPPDCLt0EpOP+5A7v
         he2QN+7Cja4kaqwis/BvHSrH1rogQMeJiqOTF2obTVHYwvSjT36FYNYczo9B6v5jW9u6
         mUiXAUqczrccMdjUkpIa2XerW3AWNebPy4dEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708376869; x=1708981669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v4aGJ9LU9dBSomS+ec3dUGjJlpnKfj3hq8T5zymb8w=;
        b=a67QElMk540fJl1V7KO8TdkbXgJX9VOdXanIGMZR+FT3KQ00yafK/ER6jJTAmS7JJi
         CBLggJjMV/WOlDUv5n55izdZjHcVe8ECjsKL2rd0jIsp0xjAPpWZIOhCWE0h8ZGKhBJ+
         hOzBmzGiGlpakPlOlmgy2AHVFtBS6RSEulpasUhdZcwi2eDvrTSqsR7EPkms6VBrM9m+
         P/+colbyzAoH+MxlVEbnjPGl6JKr2kiiyYdjk3Zx4+SIvgrdn6ibowZuOGMyS6DUc/d1
         s1/W3KA3kUbB+xmuz4XqE3qGraxDcBZC073p0/QD62vEYqp4ieCG54zFcFfUhwarkL/z
         6ALw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrDFKwra3yXySwb23FtMe5PvbCFQKrzgxw/t7H04FqULzV+VNzxZx0c/MkZfGkPd2e23VY/Xy0l7Sx64wV7IEaqMR99EfIf7Ng9uDWyoDQoH1/I6D
X-Gm-Message-State: AOJu0YyU4rZ4RSfbpzMzApDlhezjCrTkiXKlT83NX04lYQlsiSkot/Sf
	L+VLLG3+KuMrhd3njlFMtJd0onFwUaJut7CmuClNYa9+KUF3UD7sMMXrf0JjbA==
X-Google-Smtp-Source: AGHT+IHbLBW3EDVvJdonxYBkFDS1KzBBkz2Oq6mObdvWo4OQ4squ6PL/TXRDYA61vIonSEErhJiQtw==
X-Received: by 2002:a05:6a00:812:b0:6e4:6047:fdf3 with SMTP id m18-20020a056a00081200b006e46047fdf3mr4974895pfk.14.1708376869048;
        Mon, 19 Feb 2024 13:07:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h9-20020a62b409000000b006e448fa3d93sm3401025pfn.174.2024.02.19.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:07:48 -0800 (PST)
Date: Mon, 19 Feb 2024 13:07:48 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Warn once if a Landlock action is requested
 while disabled
Message-ID: <202402191304.ED03339B@keescook>
References: <20240219191804.2978911-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219191804.2978911-1-mic@digikod.net>

On Mon, Feb 19, 2024 at 08:18:04PM +0100, Mickaël Salaün wrote:
> Because sandboxing can be used as an opportunistic security measure,
> user space may not log unsupported features.  Let the system
> administrator know if an application tries to use Landlock but failed
> because it isn't enabled at boot time.  This may be caused by bootloader
> configurations with outdated "lsm" kernel's command-line parameter.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 265885daf3e5 ("landlock: Add syscall implementations")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/syscalls.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index f0bc50003b46..b5b424819dee 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -33,6 +33,18 @@
>  #include "ruleset.h"
>  #include "setup.h"
>  
> +static bool is_not_initialized(void)
> +{
> +	if (likely(landlock_initialized))
> +		return false;
> +
> +	pr_warn_once(
> +		"Disabled but requested by user space. "
> +		"You should enable Landlock at boot time: "
> +		"https://docs.kernel.org/userspace-api/landlock.html#kernel-support\n");

Perhaps update this docs to be really explicit with a example, maybe...

If `landlock` is not present in `CONFIG_LSM`, you can add it. For
example, if this was the current config::

  $ zgrep -h ^CONFIG_LSM= /boot/config-$(uname -r) /proc/config.gz 2>/dev/null
  CONFIG_LSM="lockdown,yama,integrity,apparmor"

You can boot with::

  lsm=landlock,lockdown,yama,integrity,apparmor


I *still* wish we had the "+" operator for lsm=. It would be SO much
easier to say "boot with lsm=+landlock". *shrug*


Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
