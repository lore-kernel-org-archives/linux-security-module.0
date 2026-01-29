Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67311315793
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697710; cv=none; b=sSuStM1gONiXD6W4XBAMmuykTKXCMLBhVekX1pxinBu2ZdqPzSwipebWY1MMByRfE5agRb6l3v783mULNKm6+a539yXnk0AY0ssbR5MeQX6tNOM7L/7IAbMtNYQXlggEfSQU3/gNZ5tIgqK20GsWRu1OpKWDkg1aDp8iG+7jDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697710; c=relaxed/simple;
	bh=F0b8hnfWHbsOvhccuNKow2wnsDEWWek2mfssz8GMxsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrRVLHxCxOtaD0c38bZoxGd7NHqT5bpeoeo69BvqqkxoKJ+a9aLt0WnkjvkqFgj4iPKP/b14GdJgSLiOkz6UA+J2vT1LRE7HLzf7DxeBKevLJNx/waPXjJlXkOe3h2Z50zEKe2wmKUpHoDe7W0vBr16Rzb76Zc5pJQjAEYT0J+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DCdmfDvY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DCdmfDvY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so8428205e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697706; x=1770302506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=DCdmfDvYjNE7C1O2jiZtSAx5VFyXp7kD/Q7BI5euaOR+Aece3eGzUKs2VWuSK81cFV
         1GFRfcCRI5Gukv0bp9TizXNuyZfwsTpyqy5P+VkNyNxkRnws1AEIYl2hhEUd8UPa0/PW
         y+3TgGZgtrKtkyDwNhatNcP1EY9CAYjT70lD1b7Fs8UyFAO/WOJh+HnBMwFvQxOZlZBz
         QuNuFBwZImsqcYQ1MDZ/A8alCPRdprBiX4rjuvwJ24bIc5V0PHY1wJV1+QrbSDS7TFwP
         0REI1tXsfsQnH7ryQMfgAhS9va5/2Ax1ONsbMHGzdnpe132FZc+P1kz/N4aylIk7XgMh
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697706; x=1770302506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiXqWFBbTqasdWh8G25vCefiMtu7P/aKonwdz1Q+QEk=;
        b=OADbWAQuDWtOpw8vHy0GkAJ3Kof3YZ8fLfcUe4BP3Xp5JwdcnBU2eOLeL//L8ARIOk
         OA3XA8y1RuqyC17QKmJdJBmhHPvwT85Uf9QHgMNjqZ7HJAreLx5cGBrVEoG+zJduheT7
         WLovk1/G/7vd/wf3wt0tjhe1GxB0uz71qRrOPYkXNGepC4DPNLF5XWDZIHJydYwh6COJ
         tRlUwXiAJAt4M9lhc2L1UzViSJVnwUxpa6VyOU21fCdg2frZ7rpjeHn7Fj+HFzJOoiMx
         odMSJtEMirRNOiAZ1hzgqzlqwVGeMpSaRY+aOYn4UkBOjPVNLza3tKuCxhiX0P/bHHSx
         s/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK1IcDFasD7gzd6zi95K3Xl8CiAQid30fgkJS586IvpvDlZ1hGQn12tRqWoZNv83whzUEbsuPk16jJLNzbreQNUocNDeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxum7NWlvlu9ccHa1GOlhF0Vq3lX+Z7M6sWnsGp69A0O7/jCbXK
	jExMjT7UJd6V4yXoxkFMTs2yMfSqVc9Ra+wtf+d4bCXbmuffB3xrjL5NnJQebTEcGT0=
X-Gm-Gg: AZuq6aIifBAIoW8ZON9UZSm+ayOxm2bFurdgKvr6JbPzJsLwogJT3AZjY8wuXo6UoFv
	jSy5u1iwP8WNm8oL3EKwTbX7GJlLhSd/C7Qg9/nMKQw3y8Bpb3LszXj1KJuJfweeZKi129Mrocy
	yb6DaBozueNFa+YCfEANW56yBYaXJaWXUaW/gWSlabfWTt5UMCe1+QrG4Q+QSpKboSKNEACljJI
	6VYvVEoCVxGU20UPrDdOcY8fvP4WZy1bZl3OywFdMBLeEKRGLzy9YRAUALTJWUbCrdDIyUfQoYS
	mmBPc/tGN/7oOaZo+JUgJVpz0LRwW+GuLJhI4odtcnjrGwd0E8a+beVDNuJLLm5UVjfq3NMQREt
	TnTVdf/004iHBXseR89bzI3y20CoepGIwi0raXud5frRR9q6XGvmJarMtuerl1aBf79f024ASYY
	v7Bo9DbksXJLjLwWDzPGgwQsigh0Rt7g==
X-Received: by 2002:a05:600c:8b76:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48069c49d54mr120114805e9.24.1769697705735;
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm182396725e9.10.2026.01.29.06.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:41:45 -0800 (PST)
Message-ID: <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
Date: Thu, 29 Jan 2026 15:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] module: Move signature splitting up
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The signature splitting will also be used by CONFIG_MODULE_HASHES.
> 
> Move it up the callchain, so the result can be reused.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c09b25c0166a..d65bc300a78c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
>  
>  static int module_integrity_check(struct load_info *info, int flags)
>  {
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	size_t sig_len;
> +	const u8 *sig;
>  	int err = 0;
>  
> +	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> +		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> +				    &sig_len, &sig, "module");
> +		if (err)
> +			return err;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_MODULE_SIG))
> -		err = module_sig_check(info, flags);
> +		err = module_sig_check(info, sig, sig_len);
>  
>  	if (err)
>  		return err;

I suggest moving the IS_ENABLED(CONFIG_MODULE_SIG) block under the
new IS_ENABLED(CONFIG_MODULE_SIG_POLICY) section. I realize that
CONFIG_MODULE_SIG implies CONFIG_MODULE_SIG_POLICY, but I believe this
change makes it more apparent that this it the case. Otherwise, one
might for example wonder if sig_len in the module_sig_check() call can
be undefined.

	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
		err = mod_split_sig(info->hdr, &info->len, mangled_module,
				    &sig_len, &sig, "module");
		if (err)
			return err;

		if (IS_ENABLED(CONFIG_MODULE_SIG))
			err = module_sig_check(info, sig, sig_len);
	}

-- 
Thanks,
Petr
