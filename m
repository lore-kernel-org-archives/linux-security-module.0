Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92632EBDD9
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889380; cv=none; b=nvChMmsPhtXHJ2U5Is7peVJNzwN+1P/B6SfUA0T4nMaCauudZ9Hz7Al2CanrvlwxBo5ecDxh7jG+PT2nJc5mHiRfqtNCIunb3AIbqlNoQAo9SI3AyC3dEomkQg7BytILOBwDKKuS9vOF9mlyU0QT734Ef0h6sblO21rJaeROdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889380; c=relaxed/simple;
	bh=gnH3fp2wRxYJUQXuaIn6rCwe44XriHxBG5TJoIF4EQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uemyine0SiYYqiCzOs+3oe8NkBxa14G5YZJlO9a7a9wzPsdnko89bPF5HVK95UufJdMaSWuQ7wECIJS0KQvdKG2Nry4Rp3s+J3A0fxPB12i1L+/OsIARNExN5Rq8xaiGHUvBFizGGRzShIqILivT+T76UA4C9Civ/O9KWWNbWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ns7kX7VE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ns7kX7VE"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A2BB3F52A
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756889377;
	bh=GvF6W7qQl2KeCzW4pVON6GD0QXJ+Di6g1Uch/jB1tAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Ns7kX7VEdkWj5Yhu5TzUI3aXzfDKY7BKZdtORCN4jezqR6PHT/zy1CEuyFKgs0u8H
	 EXu52oadIlXo7VviWk+kyO3BIizg2LEjntqUAVbHvygxz3AuThaRHj93C7Tmhbq/Oa
	 vtx+44WTU3mAsyYwyYT7Fc0Jyk8hB20ZcDmgzbyUrU0eQTrVXVtz5Wac/FC1Zkd+SW
	 y2q1DG5xJGoElV00yn5mNXUFHHzatDRsipKMxzU45OoIR0iiRd1IOknfVKEiUAcUes
	 bPXaiouUUovC+ldBCJ8wkESmtpvv61NgTp0fgqRCmoNc6yhpnfJlr/pIAy+yILetoA
	 GufSl3gxAdaCg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32b51b26802so1053042a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889376; x=1757494176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvF6W7qQl2KeCzW4pVON6GD0QXJ+Di6g1Uch/jB1tAo=;
        b=IEw9AkESjzGBK74FKBB2X3mU7ffNpqM8Um4Pizfy8h8Bi5ApLTBiXd+rxzpmkSZxUV
         61tOWXrmvUi0ZBPKh7qjEOqB9p3er8CEO3zzzP7t9k0nCCURgCdoNxPs+v2W+NS8db3L
         hr+g1FNONnCyEwOsEMP2QDt1aAEB9U6Bybr/md8qkHYbtuhTcflmL5nxhdINld5df+37
         C3adzi+x8Xkm/DIwSgNbjY8I45CWuwskF1+fhSdNR4LQTWSKkoFKdMlNME8w6/tjS4S4
         Z/pwHMoX5zjWnUWQn5TKM8+bVxmGnTFEkEdb+yBdzqzGTD9EEobvHjFDMKKj56MnDzy9
         99Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9F44rqCrH3SAea249usO20/IV59DaxAcko40PkiN4RaPtQsX5f99ZMEC0702KkwXgeCSm2CaY3rsSYusAAL/WjjmyOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIyexM79pJ25UHRboYAo1FsC42XdRY310Hq5T/ZjaTLvl2BWz
	TbA130PqADQIRNWUx5C6jSde76dFGpFNPfXwIuheoT720LPcE2E+tn0DfZzfw3cvObRgwCWjL2x
	eyy1y61Cgd2wHircEgzvxwsd2FBpDi+nJ/i0SReJGzY2C9rO9rqTF1+FcTrNNjjODOVuIoEZYpt
	LteB9ubskflEKdv5h62g==
X-Gm-Gg: ASbGncugiFSSuuHErSm0YrAwJCONKajd1W4Ad3iMeV/yu6X/aWxDyhlmyciJa2/BvVy
	boj34a1ibPQKQiOoZTEMXfNqptJ0bRZ6og+AIZWoR0tpYxKOiqCjZlTqciyw/FdxjKptDwsNuY0
	92toy5yiynNFa3r8K0nnhSJAkZWEmc49+5qB9cinJzpmtAIxbAzjECeVUy7YXAM++0vzptPNvyF
	LM/KRGMQAviSmMW2Rfxr8jsiWEpvPnGXclXz/VF8dRNmkaPt2LGn6lKKaDrHRBw618ZG3AZf4qj
	53/BxbhnwVDQslXZXKridu+K3JoETjfSvGKrXPIq5TClbydhnsjoAw==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr17092858a91.25.1756889376226;
        Wed, 03 Sep 2025 01:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYj+FFd0wyzW1cRqd6nve5AQ/3cx07H8SkzipAJ7wMHb+/tWGv7dd7z6uG8ytH/+qNLV9HPg==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr17092832a91.25.1756889375842;
        Wed, 03 Sep 2025 01:49:35 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-329d08a36b3sm5701942a91.25.2025.09.03.01.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:49:35 -0700 (PDT)
Message-ID: <d099f11d-b34b-4491-bffe-f0e76b6b23a7@canonical.com>
Date: Wed, 3 Sep 2025 01:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/34] lsm: output available LSMs when debugging
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-57-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-57-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> This will display all of the LSMs built into the kernel, regardless
> of if they are enabled or not.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2f7ae26fca0f..c6aea57a01e6 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -363,6 +363,8 @@ int __init early_security_init(void)
>   {
>   	struct lsm_info *lsm;
>   
> +	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
> +
>   	lsm_early_for_each_raw(lsm) {
>   		lsm_enabled_set(lsm, true);
>   		lsm_order_append(lsm, "early");
> @@ -385,9 +387,24 @@ int __init security_init(void)
>   	struct lsm_info **lsm;
>   
>   	if (lsm_debug) {
> -		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
> +		struct lsm_info *i;
> +
> +		cnt = 0;
> +		lsm_pr("available LSMs: ");
> +		lsm_early_for_each_raw(i)
> +			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
> +		lsm_for_each_raw(i)
> +			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
> +		lsm_pr_cont("\n");
> +
> +		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
> +
>   		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
>   		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
> +
> +		/* see the note about lsm_pr_dbg() in early_security_init() */
> +		lsm_early_for_each_raw(i)
> +			lsm_pr("enabled LSM early:%s\n", i->id->name);
>   	}
>   
>   	if (lsm_order_cmdline) {

