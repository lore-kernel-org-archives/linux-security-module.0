Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82043990D
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419247; cv=none; b=m6KHsSur0rxdjp7/wAIUPYznuBZoNwdE3uNsYkXzd3hwr42tbfveHKXYReXT77nsuttXvHq8fzKcwP2jbrdr/eP0+K5X4T12xZsV6N/lFe9pOenJFP9UHwy5dJ406wncLF46KOsJVXP177Vm0xH2BpxetEztHgUSSxwBR1DNHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419247; c=relaxed/simple;
	bh=ZAA2qmuoreyfSE9j1lmAvrtEXVzNEKkozSQcMHJ2ECg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCJpSWBSU8xZPc7yIY6Tw+PYiStf226M3FYdg8YNeAfDvG5eGPXwQUPy01qJ6LazcR116KcepkOhZZ67ufjCwXQDeBQR/YwV1jYsLLHPscAbXFk6J/HlS+rPLIVzVYeoKxN5KhiMkRZhxKFN63HeFiV4X0Vfeq2LeWWBIwIrqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net; spf=none smtp.mailfrom=jjmx.net; dkim=pass (2048-bit key) header.d=jjmx-net.20251104.gappssmtp.com header.i=@jjmx-net.20251104.gappssmtp.com header.b=MDwViDN6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjmx-net.20251104.gappssmtp.com header.i=@jjmx-net.20251104.gappssmtp.com header.b="MDwViDN6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso23947295ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjmx-net.20251104.gappssmtp.com; s=20251104; t=1785419245; x=1786024045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAA2qmuoreyfSE9j1lmAvrtEXVzNEKkozSQcMHJ2ECg=;
        b=MDwViDN6kFLDM3+GI1PFkcj9C01nCM49eMflH4SAnizOsQvbPV/UjCeZDBAHWk+Lfp
         nCGBv3jGYQWgdyYqobvCGdd6ZdLcVbfH11CNOrUiADEo/V1xTazgAuVwHsQarBpzRogu
         gqMW8E7/LrN4vf64diBHY/sC/zxOF8r20lafVFBFYXCqWq+q/t6WxHS27qB50ww3CQht
         an1wMKgBqGvodGrVE72HvmN9/bDU3uQoPrReuo5N1ijU3+WrT4fR5AvPT7s1pdLayozs
         r2yhULuT3cVfAuGQhpTi3kwjYdX8onvv3Zo3s5E7MS2ZN2xfy9GjgWGYpZ6U3Xsc5Ul/
         QP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419245; x=1786024045;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAA2qmuoreyfSE9j1lmAvrtEXVzNEKkozSQcMHJ2ECg=;
        b=S/CIKGJ+JqDAa1h24mBdMQVKBaiRbE9lqA77PQihdunUORo3+jiKgNoN0Xdg77sgj/
         qJZvpKbWi9Y1TVsWIWRXM1pLGf/EEHYUc//9OHTQJsiLJeRGRs7jv8iEqvkmfEpEje9C
         f7r61eu3tB9r28uE7AENUua6GKGT5AXyUMmxTZxFOntKTnJ4mlgu6LW+ZukNMgi7jASO
         AP8WL8Bgz5NdesokBHzJ8r+jTHXsmbHEqXK18fnKvvI8CIIRHmzDY9VK+Qeuy4MvTKPM
         /YquELTw9hfJyRRl3MEfONzkHjWG/+G85jaoeVQxWN9ccrz3FTXzlhdVMCFmtKBEV+PU
         REeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhaqpd9Es+UNicNHQT1S88KGhC7qr4kzWaOSTBVCPzYbWT+CBPNdMVWGImfbvBYrozi6/MB4ZffqSTMP5iNqRRbov71oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1tnWi9AETI21mX0FhNqDV/BdtbqS6x0csnmE3nKiO7rzpGYy
	ezP27JZav+OsC+zU1J6qphujug7fkGYcHNOim8hGiAZOOQceuAPvtGfsRsU0C0pAYL0=
X-Gm-Gg: AR+sD12YOZim7CVApTTFVwa6PusM65ly5MF13kdPehZyJdoVNjVGHim7qAFBltGIxwv
	2T/RfETDJqB/Ny+mehGxaKH9Np4NXYKSjCnfGoVqZSR2mth5Hf2QEQQ9hR9akpW7AWxNrjVxaJS
	nqaQq9ZpsdKgyTF0cpUUBuxIBJnfXrdQ/m3c/AvMT8ttBQejrPA+Z6pfqndsnzNhqRs7SL9ZbgS
	BIjaH3fsLcsRsxKMZdgu0wwIeN7xyrvpdBRM/adQaZz0Du5iMPlKQzabXi/fnjmFkqyFnoGRh8z
	F4ha9nq9OWNeZs93bqquA2rSlJaT5sY0azSvgDMLOAy4lCLplu28phCItc1ArZksUxWMlDDT50f
	Zg8YtfTCs0Iss3n2zZRuczel15RiAJMWCvuhE8RbRQoiOYjKmOxIj7Ie5+RSu3SMVHvDNeVdvsY
	15PrZ/lqCTLztL33K61Asa9/iAj4rbvLaatsvKW/MNjGL/z9iRatMvarml
X-Received: by 2002:a17:903:904:b0:2cb:2b84:f431 with SMTP id d9443c01a7336-2d035d2f310mr23977435ad.47.1785419244881;
        Thu, 30 Jul 2026 06:47:24 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d022a45979sm27495635ad.18.2026.07.30.06.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:47:24 -0700 (PDT)
Message-ID: <f056d7f3-f464-4bf3-abb1-6179803dea33@jjmx.net>
Date: Thu, 30 Jul 2026 06:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 29 (apparmor)
To: Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 John Johansen <john.johansen@canonical.com>,
 John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>
References: <amoeme309Gay4S5M@sirena.org.uk>
 <ecdde049-968d-4a89-a0e1-4f00a099fe04@infradead.org>
Content-Language: en-US
From: John Johansen <john@jjmx.net>
Autocrypt: addr=john@jjmx.net; keydata=
 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
In-Reply-To: <ecdde049-968d-4a89-a0e1-4f00a099fe04@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

fix is  now be in the apparmor tree


On 7/29/26 20:52, Randy Dunlap wrote:
>
> On 7/29/26 8:39 AM, Mark Brown wrote:
>> Hi all,
>>
>> Changes since 20260728:
>>
>
> apparmorfs.c makes calls into zstd_*() even when
> CONFIG_SECURITY_APPARMOR_EXPORT_BINARY is not set, causing
> build errors:
>
> /usr/bin/ld.bfd: security/apparmor/apparmorfs.o: in function `policy_update':
> apparmorfs.c:(.text+0x1307): undefined reference to `zstd_get_frame_header'
> /usr/bin/ld.bfd: apparmorfs.c:(.text+0x1359): undefined reference to `zstd_dctx_workspace_bound'
> /usr/bin/ld.bfd: apparmorfs.c:(.text+0x13f7): undefined reference to `zstd_init_dctx'
> /usr/bin/ld.bfd: apparmorfs.c:(.text+0x140c): undefined reference to `zstd_decompress_dctx'
> /usr/bin/ld.bfd: apparmorfs.c:(.text+0x1411): undefined reference to `zstd_is_error'
>
>
> Full randconfig file is attached.
>

