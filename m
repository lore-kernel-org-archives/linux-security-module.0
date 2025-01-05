Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EE44C6F
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736050512; cv=none; b=Lc+L/nFe9zdg4If8PHXqrqwGh3nYP06Z7vBjRITOlZeDLoEISpI2Ob3zGss2hnmwnF1GW1reIhinM7VwPMgGkp6AjXm7QuJT7Zt/xwFTjWpOIyCRJFUaYEfplLmILbhwcqLvC9pgpSZuZJys3rZIxiKAkAAFiNzp0sbqPRug8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736050512; c=relaxed/simple;
	bh=P9eOjaOI2LC9LhZ6Px+trgodUECZTt6C+WiTYfGakzQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=a2J4VpWgeCU6P01GOdt/irsevJOuZgELlnf092BLiRW7FMqr299oQ4MA9lAFmLuoUwVFBHgxuPkHDrJZYu/IhPvh72tTnRV5tjX4kJ9VUgNalMGKWbG8D643qFSkgh2onkmcuStJWNbROc/CqNT7/jrEmXVEgYOIRVOq607dJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PAR9kRix; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PAR9kRix"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b98a2e3b3eso658800485a.2
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 20:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736050509; x=1736655309; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnkW2Ito+yFWYvNl8ukUMqSS1ZhIA/mI5uOYZFH7SfM=;
        b=PAR9kRixZaYZj37wnkhPaFT8gfFzdpTMjkZQiNscrLdUH/zLP8Q+VRGMt5am8nvj8b
         hZIPd3AnI8F6rbVSjWqklTr7quVAgsYsXu+a2hIbM7fYBuu+phz3lGBoXZHqmhVIwZNw
         wM+4mxxbK1eNbMzylEup+YVOhGQ0L++ajzYg8rLShcHJK3ZXVFTVie2VtjK94OyINyY3
         ofeZpthOpQEO5TeVKMgZUpFmcvoio9cWwJCMz3tRZAHleBI7cm9sz0KNEWKHeEk/T0WV
         8f8dtHYSnMv2WqBLShvszW7a/gUaB1J4uNM2STSaTDpOmNEru6uZl/3s4OaHdyxe9gCU
         gliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736050509; x=1736655309;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mnkW2Ito+yFWYvNl8ukUMqSS1ZhIA/mI5uOYZFH7SfM=;
        b=tv92BWUk4QXtMyj49WeApr0kBjyncgxMmdkN7QBuuZTcR6JximmUZ7qJjtf1HUp++/
         7WKad7k7OvVIx5hfZO78cMrHGnO+l7FCwybqjebrlGnn1uLKfe3nixLrkbAyHUKzea02
         myJzkDCjs9rjGiWttj94QiTVfb27MxAQg241pgMnMJgS/Xqi5CoKD62iJ6w13TSiZ9VB
         U9/RJkZCYm7o3IAOhZOvAXE3gQ8NK9Z1uoZM6zPAt3LyNRzGZXIOfvQI5YgsQNvM7Kfi
         9wXGe1yHiNfPhXDme8IYrdNSkq6Cf0UfV9kw9QPsJbSjWIFpIQHu24uN8NWd6wuMjfvb
         Pelg==
X-Forwarded-Encrypted: i=1; AJvYcCUqSEf8aLNDVIpHULz+UCuhAWQJQJtLn/3Lirg9+1qUFAkfuNEtfQowq37505PAcxv+4S0a/Z0b98PVmTlfG+WQcCQVuWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuXuG/UkO78dVU7vKVctJQJTK2TGVUz2Qj8MZ0CLvTL0AOtQl
	r+RFF1tPkXuXOw6QU8GNPEPf8TgNdQ8twHLpNZDB0Q1HCwI3VQx4PI8+Pn5E4Q==
X-Gm-Gg: ASbGnctC2wxy+kimoJuUf06O95ofDorl91OMmujthY90e04eRrhZbQAey4eoazdHZ+4
	xLZazRT20rsnjMyoAIBpCmqcM06FhvaskqVlzduURKnvK5vFotmqC85DxjAP96Vwf4JAHPbKW5g
	CqUHgtMx7mdHgiUo6SLDgQ+5/61CzJoeh4ln+0P3eDqL/kXkt9OySX08b6VoeTRX3kg2u+yEtzk
	HlhAVcsD60lxIWIaRBztAIK3hdQ9VZeE7H2tsHgKQD+d1ciyNs=
X-Google-Smtp-Source: AGHT+IH1yr+84FG4k22YoYqBX+gg+RpxcYNPFOy6IvkpIUQv6J8BwbJD0+YUBjKVZ/nXreKrgSCzJg==
X-Received: by 2002:a05:6214:2689:b0:6d8:8f14:2f5f with SMTP id 6a1803df08f44-6dd23349b0dmr1002590736d6.23.1736050508849;
        Sat, 04 Jan 2025 20:15:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c13b6sm156918956d6.96.2025.01.04.20.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 20:15:08 -0800 (PST)
Date: Sat, 04 Jan 2025 23:15:07 -0500
Message-ID: <018b4316dc1089799101308931a47fdc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, jmorris@namei.org, serge@hallyn.com
Cc: kees@kernel.org, yuehaibing@huawei.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, matthewgarrett@google.com, skhan@linuxfoundation.org, anupnewsmail@gmail.com, tanyaagarwal25699@gmail.com
Subject: Re: [PATCH v2] lockdown: Initialize array before use
References: <20250104191006.3807-1-tanyaagarwal25699@gmail.com>
In-Reply-To: <20250104191006.3807-1-tanyaagarwal25699@gmail.com>

On Jan  4, 2025 Tanya Agarwal <tanyaagarwal25699@gmail.com> wrote:
> 
> The static code analysis tool "Coverity Scan" pointed the following
> details out for further development considerations:
> CID 1486102: Uninitialized scalar variable (UNINIT)
> uninit_use_in_call: Using uninitialized value *temp when calling
> strlen.
> 
> Conclusion:
> Initialize array before use in lockdown_read().
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
> V2: add Fixes tag and reword commit description
> 
> Coverity Link:
> https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1486102
> 
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index f2bdbd55aa2b..df2c8435a7a9 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -96,7 +96,7 @@ static int __init lockdown_lsm_init(void)
>  static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>  			     loff_t *ppos)
>  {
> -	char temp[80];
> +	char temp[80] = {0};
>  	int i, offset = 0;

Since @temp is a string, it reads a bit better if we initialize it with
double quotes, e.g. 'char temp[80] = ""'.

This is also a case where the static analysis is a bit misleading.  The
@temp variable is uninitialized only if the @lockdown_levels array is
empty and seeing as the @lockdown_levels array is a constant array
defined in the source, this isn't a real issue we need to worry about.
However, if you wanted to fix this simply to quiet Coverity, I think
that would be okay, especially since this isn't a hot code path.

>  	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> -- 
> 2.39.5

--
paul-moore.com
