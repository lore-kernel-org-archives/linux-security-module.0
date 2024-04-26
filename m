Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD93C062
	for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173398; cv=none; b=BrFOZjROvwz7QHM5KFrvOwIFL++NkBuAqn58L+vsL+Y4KteSJGZE1gZBukG1aX0wyAjr8bRsBSCSDlfCXp7Qh2AVa4XDelklM2IIVuXUe/ucSuo5FWP+xEYnGTzkI/atXA+GXRmJvEATg96roXJM1dBtd0a1bcFZtnZzmx3PMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173398; c=relaxed/simple;
	bh=7AjVYx3bCX4Fww04LykaNFtcTPbI6xC5fT6cTYYHebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxp7NM62wTt0YhguFFAXzl1YnihI561viKQgQ5GAmSHpphDVkHXBZyRgAmUfQcUOij/hJEpieO4TYEBNrmjSC48MwE9/7PkKjfijiTjlx6qkwH9XgjfH15frgdbioKLMzljRxQ7/7aGKhL//9hx94B1ix1V9y2H6kocCQRUanHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z8E1dV9m; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8E1dV9m"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed32341906so2660849b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2024 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714173396; x=1714778196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opWos3IruaB/4qZIdM96XOJaiq9zI0XzG7sSYPn525M=;
        b=Z8E1dV9mb3tTWT4KgQ8DL2hwBRk2TNIKp9LkJT1hOTmjEC5zKyq87plkvcRt5CdQIK
         b1IerMfAci6GPtSJP1VARkdGceH+2i4KBjLWGHi7awh7SwvQo8cn+Rgh3pzfx4jh7AlM
         9jkyqXu4x/Py7bmXZvQ8dXO9B5HS7zYV9qUpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173396; x=1714778196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opWos3IruaB/4qZIdM96XOJaiq9zI0XzG7sSYPn525M=;
        b=Wby/LAmR2fmpX1F+arcVbVoU1FXdq2jnUWsR5M7lUF+IFhTvg9C192d6CiNYyViMR+
         ySkBtycFaTznnldTu2QNhSA1cpVSrEAv7lQJNYvQfR//SSyt8Ty0O2Zo13aWi2OxfkPC
         551tqAF2/ewmH0oWHfEjpcqyjL7iXmZhgp5I+toUPOSd7/H/CkgAvyJGOi9zwhZv+nAZ
         nfnYzaNjnpisI4/0kkzGNwDbgyjB6EoF3jqz/lPDcjpZwPa1pCbXQETgxPxa5VJMKhKc
         rtrNeZdktkZALTqZvwzYpXmpkcL2WqLEgIrAoTg7D0jOgJ7kbSleEt+KyNQEy48YkgRT
         TqKw==
X-Forwarded-Encrypted: i=1; AJvYcCVlioAt4EoKVpcgw0oOjU/nsTJW6MYRuCSSq9l+HWjJSSdhaJ49fRK51JNfdROBkwZ20gh3U1MkS3VmleblWIToFBbDJkDvErq46/KVPbsIJpi6UMZ1
X-Gm-Message-State: AOJu0YzxiuLeqeOa9rRe7BPcQvpTZawpHblpV55RRAkt2jtBxKQAXwhU
	EM6TUXJm3jmtXguGER7N5N/GpbafV/Xse+TsnjLcLSFVU4OiW6plKa8EzK08Vw==
X-Google-Smtp-Source: AGHT+IEUZubJL4QUSK6pyzCdpuqFqY/W/ty9RvrLZCDN36NO8wZyv7NW/a7U0iQN/0uUIh4tnO/xbw==
X-Received: by 2002:a05:6a20:d48c:b0:1ae:a5bf:341b with SMTP id im12-20020a056a20d48c00b001aea5bf341bmr2506303pzb.6.1714173396083;
        Fri, 26 Apr 2024 16:16:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b006e6ae26625asm15345740pfk.68.2024.04.26.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:16:35 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 2/2] proc: add Kconfigs to restrict /proc/pid/mem
 access
Message-ID: <202404261611.958FEB4@keescook>
References: <20240409175750.206445-1-adrian.ratiu@collabora.com>
 <20240409175750.206445-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409175750.206445-2-adrian.ratiu@collabora.com>

On Tue, Apr 09, 2024 at 08:57:50PM +0300, Adrian Ratiu wrote:
> Some systems might have difficulty changing their bootloaders
> to enable the newly added restrict_proc_mem* params, for e.g.
> remote embedded doing OTA updates, so this provides a set of
> Kconfigs to set /proc/pid/mem restrictions at build-time.
> 
> The boot params take precedence over the Kconfig values. This
> can be reversed, but doing it this way I think makes sense.
> 
> Another idea is to have a global bool Kconfig which can enable
> or disable this mechanism in its entirety, however it does not
> seem necessary since all three knobs default to off, the branch
> logic overhead is rather minimal and I assume most of systems
> will want to restrict at least the use of FOLL_FORCE.
> 
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  fs/proc/base.c   | 33 +++++++++++++++++++++++++++++++++
>  security/Kconfig | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c733836c42a65..e8ee848fc4a98 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -889,6 +889,17 @@ static int __mem_open_check_access_restriction(struct file *file)
>  		    !__mem_open_current_is_ptracer(file))
>  			return -EACCES;
>  
> +#ifdef CONFIG_SECURITY_PROC_MEM_WRITE_RESTRICT

No, please. :)

Just use use the _MAYBE/_maybe variants of the static branch DECLAREs and
branches, and make Kconfigs for:

CONFIG_PROC_MEM_RESTRICT_READ_DEFAULT
CONFIG_PROC_MEM_RESTRICT_WRITE_DEFAULT
CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT

Like:

DECLARE_STATIC_KEY_MAYBE(CONFIG_PROC_MEM_RESTRICT_READ_DEFAULT, proc_mem_restrict_read);

and then later:

	if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_READ_DEFAULT,
				&proc_mem_restrict_read))
		...


Then all builds of the kernel will have it available, but system
builders who want it enabled by default will get a slightly more
optimized "if".

-Kees

-- 
Kees Cook
