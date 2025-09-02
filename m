Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C431B131
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832146; cv=none; b=MqymilImwAaRosgDQtsokXUoCBa5Ptx99Lnduqhm0h8vHEr91dVesmrmtQkAYwdXI8CfcGTXEClYHziCP84DH2qoyo1bFT7ouROfPTKj4nlL5Yy4iBZcHvVkoabLcJkDylRUptSJ3n7QxDL2/H/OeyJDAdtn7t1q2q4ZZv3Loqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832146; c=relaxed/simple;
	bh=/xxeE059uo86Lbu9QoxapeearuJKgwvVQglnaDL81RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOoKVeKG0hmJxlLxxFGHATqUkLjpplK42pHV7hNvKrJGbNUkbOIHBhTDHDHWttyAGEqZqGIj/WJdKPNXStvZBxhp/Vrxx2DcGHkhex3EvseNM5Gti1MiFrj1kQll/cWe2qtBvebTfFZMu960PjXKRoEtRGGQ/6yhz93ShxEaUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vtQAQRvN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vtQAQRvN"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E7AD3F4A6
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756832143;
	bh=EY90WhhIV0VerTGq9O80b9w7uZTFSHb4YSkwpYsnu8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vtQAQRvNHVqDewRI3CSk81AjVQTP+Jx2V+svcq8cqqw7CUVWKl1L7JJe63ZbA17nI
	 QfxCDmncfz5rvxPC3oVpd00UYmTAVmU/BM3M0We1CA0vhXlnKKX4bm0I5CNmO/m+FP
	 r1KHHiw/xIhyetbCbUInmq8HS6Um+jgmr8PXFzHdMzF9qXuON92CAwRth9fEyK7HZW
	 9vw7IzvFuTqYwmODcayAZGGS/Q5dvlvcMFqNPlOjq7/c5o4GUIj1KCeJKz6pHgPuzl
	 7xeGLrGRPS/i0/g9iQEKCkY9wwjqy4ehDXFe6Fmqhs/dZ0io5+VScabFoBtRNX+oXF
	 Ld12Unb9/POCw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724046c346so2843884b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 Sep 2025 09:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832141; x=1757436941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY90WhhIV0VerTGq9O80b9w7uZTFSHb4YSkwpYsnu8o=;
        b=h+G39DICXLtxn4uJ59STbZt1lPzKTELK8F008ut1LOCcBX6ozMph1e7AItbqFrESDL
         uOpVDwgDZ4w3FAKm3v2ecv1l08OChZNUWU3V2j60Q4ZTYgRDyShFTW61a5xoY0mZvvaC
         xXVAxfeQPJ6JBfq+Xo2Euaqzd37jTlJwFWEvVJUtyimi6n9LsAjhGT+yNQpkj7AGfSTe
         8DL5n9dST9QBdRRJdtUFjjUNLvj+HgDEKzeHmLdPB8K5VEnuFfMwsUp4ls/6HW398S7/
         zVxugQ+VHRrikUeyoHRuwa9gbJFYM/4sUSWnEKQQgTgRxBaxnNdIRdzMwiZ0CethqoPB
         UBeg==
X-Forwarded-Encrypted: i=1; AJvYcCXYU22rPMRmYP1Qk1718H/UuCfrhrkSpRnAhmAK5sMcdoK8WNyq9muoXqU8dX90j3G3HkBuH8LnDOq2zTwqTa4vB8W3WsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHl085csv/vq06wB/6VYF3R4cLKsO/aKr7eW0Kj+cVisn5TLew
	/cs7aFDB4MYLPvfvUXTBE1OG/HTRO3Y9TUpDPOIxYm7p8EfLUa+BH2fti7kbCSD4DzfZyYyXMU/
	ga3kIik3uclvXrb6Iw1Kn8sJ+3lpOmGDsZkwS67vNSOFLxTkdIxaB9MwVqHbBLRZTM4TQYXVj5J
	b9n8p1IKBh+J6ZKLZRBw==
X-Gm-Gg: ASbGncsVeQbsgZBs2uWgbCtyCSIbc/oVQhpRbki3kxB9H+048czabY23Q1uDURsOpBN
	fWTtkgHWqqZE+8Mopjq/8KVggzPdYa0gZtM+gl7sRXoHdbId7ClREIoPgbvjstZYMaLqpOZ4/Oe
	l4RbKOkWnOZwsQUEqoRncN6COWR1bys8JHxMUHMC9Qo/vY7HxcsIugB/6MsCloTbbE13YRnzhEg
	f4YBBlrj7KRSDwCttKlau/swc4oCoM2QI6ZCVlir85/mcGLUIFons9Hilw19yb1d9OHBPPhWFHb
	DlaeSxBPAkcTFFMLvGlikQunVkrCDDWugRqGjbLu1APeO/WtPrXlDw==
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr11870463b3a.2.1756832140967;
        Tue, 02 Sep 2025 09:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX4U9bm5QhGjURu7Y/R0akv7pamUW72N3oR6X4atcRH2LP/ZzjHY6NVilK3eQ35cZTc/RHaw==
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr11870427b3a.2.1756832140545;
        Tue, 02 Sep 2025 09:55:40 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7725f9f7b50sm5803411b3a.68.2025.09.02.09.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:55:40 -0700 (PDT)
Message-ID: <95872870-17fd-48ed-be0e-25dd768e2eb0@canonical.com>
Date: Tue, 2 Sep 2025 09:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/34] lsm: integrate lsm_early_cred() and
 lsm_early_task() into caller
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
 <20250814225159.275901-42-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-42-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> With only one caller of lsm_early_cred() and lsm_early_task(), insert
> the functions' code directly into the caller and ger rid of the two
> functions.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 35 +++++------------------------------
>   1 file changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 09afa7ad719e..a8b82329c76a 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,34 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	kfree(sep);
>   }
>   
> -/**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> - */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc = lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
>   static void __init ordered_lsm_init(void)
>   {
>   	unsigned int first = 0;
> @@ -382,8 +354,11 @@ static void __init ordered_lsm_init(void)
>   						    blob_sizes.lbs_inode, 0,
>   						    SLAB_PANIC, NULL);
>   
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> +	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> +		panic("%s: early cred alloc failed.\n", __func__);
> +	if (lsm_task_alloc(current))
> +		panic("%s: early task alloc failed.\n", __func__);
> +
>   	lsm_order_for_each(lsm) {
>   		initialize_lsm(*lsm);
>   	}

