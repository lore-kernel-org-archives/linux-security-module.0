Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEC125B2
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775751; cv=none; b=HvmWmxom6WI2UpwAInia7GCV008eN6qveFOmUWCoII67tjFA0POE1BtkzyQtD6A4+dk+pec221vjF+EshxBJseZUW0URZgI3Wn4YDSoeQXGVCgvpBA+qThN7Fx4bsyD4XhHnQKDlAOOoaDLI6oErzvNmyEd6fwAKR2PfXjfBAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775751; c=relaxed/simple;
	bh=3QJHsmMTM6dH0YGCptmQLoKTJZOe4cB2lFQfVgJQnjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNAoyk1s0lY0EciVdRumVntkLIvp86exZToolS3aern0gykPYGgdDaW/KdbvZ69U2nzwr9xxmmjJY4EA1Pj5GN2GR0lPK3vao5qDAuEQBQEnYXjHY7YDB1/9M4rlU8FEr1DMqwIaaavb8BH1WwEAkz9dRhLYmTQqQAOpj+vOAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SceRTCQI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SceRTCQI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so44730715e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 05:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736775747; x=1737380547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X97wGoya4UQq1kA6RNcK33LUWiHL/CoWKGoyQkqMvkk=;
        b=SceRTCQIXjz2NY6DCDr2VSwznHXMPSEW0duUH5cisc8AsDBTbPkp3Kw1m5nVghZQea
         DvdGVkVyhNFdkpFvHGEDPNwvVbnHeHw/5FBrmhJDHVYUT7ZBFsPcoeFZhoTiPiEP8jDc
         CDdAMcytpN0Z3VrW1nA94Zocb6evceX1DnxoRXEIf0jYlB95o0Da5UFrAhY9/x94vOIo
         Xgpz/QSHpyqEWeDeVrUeDtbHtf1BUyX+GNuNnXOVjY4hNH1ZGj9ijDBcVaJiTXvdy/s4
         4+qe17EA9NvNq7yxNdbX+dZPAbBe7GQ6OJ9viubfF3koabanESTva02omATG/ft/FsLp
         jEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775747; x=1737380547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X97wGoya4UQq1kA6RNcK33LUWiHL/CoWKGoyQkqMvkk=;
        b=W017CF1OkeKud66Yh2VTZ7m0HSNvk0jvN1LkNYn3qo0WdxKub9PztE64l11BDyR9A8
         tBCrjsKDGO6/ONIULmNl6Vax8pf5bDfo+8ahXqdrrFtABxLKpo3wLDDCa68bq2qtxXG8
         wpR6VOuUxsrro1Glhs2IJP5t38M6SHyfZysSql76Lcx2OVBWs1/RRbhf/C9u/vTcQQTn
         WyjuhCnV+Yhpw5revncMm5RdFRvDA9fjOfXX/4wZnGsddBj33kNb6sKKp2bHMoz740ro
         jWkZ9/Ru3Tuq5hwumPKYAS8eUeTfm8ka2xXWRVKPuIk4pK6WrXPbnuFL+jCNcHzDP+z6
         AaLA==
X-Gm-Message-State: AOJu0YzFG8dhLdYye2HLvZtsYoCbpK79urGHWt7VYkIxT9sNue6zbUa8
	ZVMJwLKhxEFzxAJrjnl2WOi3fTSaaLT/faEk2yyLo+gFZxCl4rRjCxueWPOZmwE=
X-Gm-Gg: ASbGncsbYbrgx7pHmnC4spB9tkpY+bOBfv0ou7lzgibDfeVdIA3kurlNFKhVqiwACWF
	uh0gq2zHRrMTIw6yYoxTN2TK0JuSVW6LAkQZ+x5mSv+YzprQ93M73qUCHeoJiFiGYhbzlCSQM/3
	gQB0DyzI6aSjwrLokKiJ0x77pdZgK9QEhSemFS+vJKyrNUp6t2PhjmczcELTNUrdNIOieDyuFiZ
	Bg6SfggyWyRyqNTTi/HbnyOTVgz45O65F5o5U4vY9Gn7ToNSl5nzs7+T1R1
X-Google-Smtp-Source: AGHT+IGapJ+VZSro2x8LJDMDSAh3VRB+eJpi9PBbS1ECgvlLeDPwXL4yp/4ArB4ipngaE2Loe1Qmbg==
X-Received: by 2002:a05:600c:450d:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-436e26a8927mr234858635e9.16.1736775747037;
        Mon, 13 Jan 2025 05:42:27 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm178970895e9.35.2025.01.13.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 05:42:26 -0800 (PST)
Message-ID: <d76bfa59-8515-43ff-967d-fa7f779bf6c2@suse.com>
Date: Mon, 13 Jan 2025 14:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer
 supported
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Cc: linux-security-module@vger.kernel.org, linux-modules@vger.kernel.org,
 stable@vger.kernel.org, cedric.hombourger@siemens.com,
 srikanth.krishnakar@siemens.com
References: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 10:31, Arulpandiyan Vadivel wrote:
> Commit c7ff693fa2094ba0a9d0a20feb4ab1658eff9c33 ("module: Split
> modules_install compression and in-kernel decompression") removed the
> MODULE_COMPRESS_NONE, but left it loadpin's Kconfig, and removing it
> 
> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>

Please use a Fixes tag to record the problematic commit:

Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")

> ---
>  security/loadpin/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 848f8b4a60190..94348e2831db9 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
>  	depends on SECURITY_LOADPIN
>  	# Module compression breaks LoadPin unless modules are decompressed in
>  	# the kernel.
> -	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
> +	depends on !MODULES || MODULE_DECOMPRESS
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter

I think this should be updated to:

	depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)

-- 
Thanks,
Petr
