Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDC315793
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697876; cv=none; b=UjE8nPxPjILXOLkjGBeb+JUxLvrWHFicZjI5tbmS/zy+OkOMeePE1UF8UoIA+vNVqkGuWpDa2SovUQUzPpjVVMkruKabI9cJ5hB/3S4zAe+r8UkV0hkj5HVXAflT/3IGLU0l4giOd5hOXStFfk+gsVGNmY0EBcqOIdUskbDYljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697876; c=relaxed/simple;
	bh=0cfpgEZxAtHlg92XqcFn2b1AgT2Rux9sr9odOOPM6rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omc941qAI1NAVEy7qwScYrjwlrTomtN85CAD4qT4wtwg7v3yNoD6HUO7kkEpx61ZfxgsdAjBPi6oqcnYd93/+6fS2LFAhQ89E4RaxB2/cM6HPx+1/RjA3kigbCSPHeFN3zMjbCs2YKapGd4YarRDu7rG5jUUJQfkAGA+6LGGUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/IlH4hS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/IlH4hS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so8924085e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697873; x=1770302673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=b/IlH4hSx+B+6rP5XO+ZCDrdqIqZNwRvFmk3IzNbmVeUc+S3/VL/Q5SYN5ja/Dqh6j
         COyyMc4qNfR93w8mVZzfHB7aPkwrvmsmYNZuatgAFU7PZ2Syv7MPZbndco7ydj7+30D2
         vz0NOGBbj8GqWuNQ2UvQHk5mPn2LY46vylYlbMpdeXXyplDvYLNjggXVxcnfYaanAvTr
         H/yw+UBIWwHlvJKPzSyIWnhBaaXYm7/MQznVaP1yJsh7ut1ecphrx6aHukIyBbKQW1ix
         2ppFJr3Rk2uWM22v+p/ag9GslNOlj7dExRrweweudR+1g0BnHFHKuA30BEcjkLT1ZrSu
         YSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697873; x=1770302673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=HimdypnIHUOSFEei2DQZtM3HcMqWxUMBV1sTqhIvY/XYUXBkpqiF/Qhw/NISOyD7I/
         VQq63zc2oZJaPMZPcMMXouRbDVEQKpeU+6CJ65h1UiLK0lZJJ/ktvvrjozAWfXIPBQ9D
         7W1arHw5V+sZbMqo6e2l4wpwc/6Un/9whZkAo6YhnOsXglB+D6a8+7M9cvDMkgVu7RXx
         qrfF7rGg+hNcbrI6BzuQib6C6aFYbIKCtYEX4/lA+guIq2F334agxmeZgxAchZzrvqmC
         5D4Q3GJtj4qqh5639D6q/w2ZWJEBtNBOLjyGS3vaHOJg1oLQhxeNqooajdfXtNV+oZc7
         AbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXea/PrxTdpJW/TcvQp47TLvqyKemVB42q6yc2a5B59wWelur+eb8/7Pn/cIqrp5JyYDfn7NNuHBoTzLfBx6O1YGIPc5Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5/kEB6kfTA7qyq5as1OuEWsVV1s3gun91UZb0c0hUZTkDJbj
	JTK3wxPPR1LDsE0U7CrfpJeXixlL1SCe4I74DTWcVDCY+0TYCL4fY19MH8lzybjHCxM=
X-Gm-Gg: AZuq6aJrJ/xezEFJdaqKqu/VxRuct2Eg/j4OVAIjhdSIfpn8qlOmw6Xfqd1MQnnu2ub
	DC89rATTRT5wffL3nQlcAzcInsVZo5WFV82ivitKx4Wqrbl6wG9Aoq5ALF41CKtn54mcra5sIzJ
	pmtKEwlv665aC16tVYgbpY6W2cF0F58gfTLYRvR6lqYgkJAZ24oE4BejR9fWT9odXe6OtTbFU3V
	T4zXs+GkzBmrQYim7emUJeBDjty+KLlmrucCtW87rQ4Rk1xZLJ+CXun+096eudlaOs3RZydnuhJ
	p0EnWapf3ntSqrpQkIKeDVMPpVpwDjvHzy7J72qLMbdO1UeH1ymJGwgPUPsBHtMBri9lFLep+LU
	yDp9/FlX7LD272F1jNTgzzVMXCwZjcDT4r5XXiDgC56C3iMTkOwODLGIZH7CPJuIpZIbkVJK6Im
	zGu1M5kWTRsSXlJTjnGuN7Ocr/3+F8BA==
X-Received: by 2002:a05:600c:c8d:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-480828ad89emr46795915e9.11.1769697873050;
        Thu, 29 Jan 2026 06:44:33 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm166871115e9.5.2026.01.29.06.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:44:32 -0800 (PST)
Message-ID: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
Date: Thu, 29 Jan 2026 15:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
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
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> This needs to be handled by callers differently than PKCS7 signatures.
> 
> Report the signature type to the caller and let them verify it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d65bc300a78c..2a28a0ece809 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
>  {
>  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>  				       MODULE_INIT_IGNORE_VERMAGIC);
> +	enum pkey_id_type sig_type;
>  	size_t sig_len;
>  	const u8 *sig;
>  	int err = 0;
>  
>  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
>  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> -				    &sig_len, &sig, "module");
> +				    &sig_type, &sig_len, &sig, "module");
>  		if (err)
>  			return err;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
>  		err = module_sig_check(info, sig, sig_len);
> +	} else {
> +		pr_err("module: not signed with expected PKCS#7 message\n");
> +		err = -ENOPKG;
> +	}

The new else branch means that if the user chooses not to configure any
module integrity policy, they will no longer be able to load any
modules. I think this entire if-else part should be moved under the
IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
patch #12.

-- 
Thanks,
Petr
