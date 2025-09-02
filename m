Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67E313553
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834945; cv=none; b=kcOCpgxoAdCtau96Kha4KSXvzSe2300RZ3aimdmiCljDQz1ls3QDLpJ0Sy/Wnm68ysu3b0Hf1nnbETapocd0qSJeIqiNYLdVZN8LRhU3in1LvGttpyPWDVn2b7PBaIMZ4DzsDxmBe+MAZkU8hb7UGXNq5RQi/rJHRWIK1ioWen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834945; c=relaxed/simple;
	bh=KOGBX3OjF43QzjSeHsTt7YXEzPgmCR6KFEFJf07pGoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgqDHUoauJGD1kEgr4/OkPjl25LpiIwJy0SGlXdkfjPhmotZkkL1z7yx4nOCr+dcl2ETCWqkpm6hPRVnN96XhsWYgCyzxzC+DdHOwUzWF7B42FnqXFE/5hWVMxjRZKSi3YGgcER3KCdfW2/+nRH75ytIHlS7h3UI/2cbzTEScJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H5cXqrza; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H5cXqrza"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 242753F52A
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756834942;
	bh=gh3hOv1yCTHyZzXMIsqBOWC7kzvUNQqAjqBxPsFIuD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=H5cXqrzaS+WuOrWD3/UmJhAyOw+4+uSZKTnQVdxZMcNRKHEzPEN4TOwdejdkmhCkv
	 zqUw7uUOi5cBdx8rWDXqzIpYy+icsc0Yh0o2UgKKPqaWqW0GUUQtOkltxFBUCk09EH
	 Ylk+Cr4VGGbIP4SWvJNiVVLWiazV7rX9pUwpXw6D6XCzQHFWYzAF6tNut73aoLUHdN
	 PXA4bAT7lWwp6FRYvQn40awEYiy76JPr/kC1NGflxWP7cT0gyXYOgVnOCmswEBdUhp
	 oGkGpnMf9v/H4jbH4zPX7IfTLa5I24wH/wfTQZLgT7P9pMGn9ahs/wZvCyjaKSk6LW
	 goUlzcoajrjyw==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248eec89618so59427575ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Sep 2025 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834940; x=1757439740;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh3hOv1yCTHyZzXMIsqBOWC7kzvUNQqAjqBxPsFIuD8=;
        b=nE8t2mEiVbh4wm0bqw0kkAuDotwspW6Mv093zTRhlcIiP8p9Sn3UHycWCe4INNo7eC
         HsMP0fEDlv5Oij8ukhP5oZcIbCBD8f3pK+jJPQJ1OxYiqvwznFCBLgfwAhSTDHg9jInH
         ChmK33wJDbuUeITu9e9uVLgbbktAPlLToowGMdzK//jZWCGC2DHNwROK5ExJWydalvCU
         IBRepiJI8ZZtg6oxFF2mwKQcDu8sv/1pG+jH20pus/9aN7M3Urpt9uZgNDlu64VbX6qI
         E9hUir4MOzky93BkTNhzWxAiKnhzHsrgE1MfHfUD0wL2YuhgC0HVGfydVikjLzN0rqLP
         /z1g==
X-Forwarded-Encrypted: i=1; AJvYcCUWI4lS0B8bDv4PcBOCHGXHiqozlYPPWAHosRt3CXNozZIfkt8MQWsmjbQno7JYhfUupfk+muNN2EIh94AAL4GRbagpX3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zMjIdEeLTIcRDMCp8fA/QFj9DqOPvNFK2747nVmCXYlet30n
	P9Ugt5tpL6eT0QMut1JIz2CJ8vI10JpWmww90TJBdmFWBLbL75Sjdur2cO5FNAUcdBsTCp92+Cw
	tgi/oDfWtGnccQBq/hGeVQSqSkMP6NN0TOOz1mqB5thYYWTXDoyPL4fQIYTRqaSy+Qss3QsTpJc
	wCBJgL6zYwSFOEIic1Rg==
X-Gm-Gg: ASbGncvJDQ4sEm2K+dqk4I+9gYfgSamRvvNTu1ya/ltaP89CgMANDOozptl7M42FXY8
	fO6PvuatqXqzJ6L3YjiEI5AWbu1R+zIW08FYQtjvUP9JpnsIFMaGylJ+3nucq7dRGDuZ4WTy7OZ
	yaqnvxrP1Y/fWFPhnrczt/A1selqMxugW4kFO8qg3P0mzEZIJxplLfhwBpCQaV5apwRbXAD6CIQ
	kVfMu91b2OhSvZjA/2XSPQaleXHAzhe3rART0iiguaU48+DYrmLArE9N8e2xKFnJtdi7oimshVq
	sKGQpLQyy7+kyZua6wXrFgpg8oy0nHJEpoDlDqQgEVSaznKKbaHvlA==
X-Received: by 2002:a17:902:ea09:b0:248:e0a2:aa31 with SMTP id d9443c01a7336-24944a99188mr139257415ad.32.1756834940615;
        Tue, 02 Sep 2025 10:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH9O2MGGD36YTtYgbIL9Lp8qqpdIau5uMd5kUIES2cdeaB0Lc3os++mtNsOR3Vbj8xX2sZ5w==
X-Received: by 2002:a17:902:ea09:b0:248:e0a2:aa31 with SMTP id d9443c01a7336-24944a99188mr139257185ad.32.1756834940246;
        Tue, 02 Sep 2025 10:42:20 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm12594375a12.31.2025.09.02.10.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:42:19 -0700 (PDT)
Message-ID: <0e5505ed-aa38-4217-bec5-77279987d5f9@canonical.com>
Date: Tue, 2 Sep 2025 10:42:18 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/34] lsm: rename exists_ordered_lsm() to
 lsm_order_exists()
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
 <20250814225159.275901-49-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-49-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Also add a header comment block to the function.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2cfd72ade6fb..ec46ddb18e1e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
>   	return (lsm->enabled ? *lsm->enabled : false);
>   }
>   
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +/**
> + * lsm_order_exists - Determine if a LSM exists in the ordered list
> + * @lsm: LSM definition
> + */
> +static bool __init lsm_order_exists(struct lsm_info *lsm)
>   {
>   	struct lsm_info **check;
>   
> @@ -126,7 +129,7 @@ static int last_lsm __initdata;
>   static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>   {
>   	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> +	if (lsm_order_exists(lsm))
>   		return;
>   
>   	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
> @@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	/* Process "security=", if given. */
>   	if (lsm_order_legacy) {
>   		lsm_for_each_raw(lsm) {
> -			if (exists_ordered_lsm(lsm))
> +			if (lsm_order_exists(lsm))
>   				continue;
>   			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
>   				append_ordered_lsm(lsm, "security=");
> @@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   
>   	/* Disable all LSMs not in the ordered list. */
>   	lsm_for_each_raw(lsm) {
> -		if (exists_ordered_lsm(lsm))
> +		if (lsm_order_exists(lsm))
>   			continue;
>   		lsm_enabled_set(lsm, false);
>   		init_debug("%s skipped: %s (not in requested order)\n",

