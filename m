Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6098372EEA
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161329; cv=none; b=HJqC8JcbtGaui4CXoXN14Y6szbLehKsGhXnB/hmGw8mJsluM3f0gCUg92qe9LHN2W7K43JMkEBupPJUc1DDStqfmzxZTOV5nB0M8DREZnFHkHlMWyY4/aEDo+MnTxdrARku7y80E4CkokVBF4EM2Oo3urWRfwf6RWijmeNHqHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161329; c=relaxed/simple;
	bh=2ALUTexkUDGQ0uM2WUOwABu2ysGRyfOZIT1Vy0Kc4D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAmU5NEAnc9egOhjhuuMi/O+3ZKLx2fLVt7VKABboYcBKBtDF1KUBqoRCbwjVuGgJor2cPEDeOBeo5dW6wJp1skVbqZtW3nM0vFtpmM2FvKo6Sa9eIOPgPIg9SBM5CzamfBxnLbmmBrY6/ncc3C/72WrwgOl05kTFcIj8QbXBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7dBeMYt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7dBeMYt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso4691345e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161326; x=1775766126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nPCeq4iQWlTeSpgeZgdE1HiF7Waw+BvqGsLGLfov9Sw=;
        b=N7dBeMYtjsXoTLKLedcm/K6TjBhxjsi8bUYKtY0+cuRQ+kGlQF7AegFsglERMoy3KY
         i+T2gkBhy9vp/x1J5sfBg0JGNCnFnfj3CIQwxNO2M7uNbBH1u/pbgDTqK8tG7v1u+RWP
         pNZSg1N8VTrismqVyfCnDygv4Str6BRW8wgx8tXKhWOkv1lWjfBItwytOKLb1CJs/1z1
         JfMU2gGUXQ/+ebUxz3+AQqhKz5xRiSXZIK0qz8XY20SDPWtOqL0DnbCKjpQPT8Y9Wf22
         Ws3fspq0vVqsOSGTBxGUM8Y3qbg/hsWupZUYKpGfyOjXLd94muAz/Nhcnm9bOY/evcIy
         Z98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161326; x=1775766126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPCeq4iQWlTeSpgeZgdE1HiF7Waw+BvqGsLGLfov9Sw=;
        b=hoVsXsfbZptS0Oe0qsAvOgiDQEMAvUB9GHayygXwW0sGsHLpyjZi0v8sn8JYRNx93U
         6pOYbBHW7KvATtfDEGzFPusa43upg6QM5Bsrkda8qoom59fdlBAf16v+e9957Gyx12Le
         hPhQYJTqfYKNhTHw3YvIBGlTmbbjEI+hB7ZXg4K8gl4vreMuFPyif65cMC+vegqFxOK9
         WBjjBqEMq9/WmdgGdusanCguvzcajfQ0qk2Ki2u2aDAdqjF6GBzyovrSMwDCSLvJAt91
         6NVe++9Ugbb7FM3ae9hgTHfLLA5BkX7sh85peiI+c4eA+wV52dXPorckQfOzh5YQlNVt
         35TA==
X-Forwarded-Encrypted: i=1; AJvYcCUjgBVmKY0YAKv6P1bBzbqlU7H4dwq60vRAWTKjYCWOVUhTt5/SdZA7onxLJnxhlgiJomFvuueHo6E9gN7ZlfPWYKceyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BiYOpJm4kZXLomI8sT3fPIUHdNL3PB4SVcoLw1jmTAJVaxFE
	tBkk2MKEVkP9lDdRg+vQb4QTNrGOve1F2LX1L8laLoM/fCCPXvaOyR1N
X-Gm-Gg: AeBDieukbMScfXp61i5W0WmRWbUiacOqmBIWDaIY0hINUwkEepTLhMixvthzuYzAfpG
	fuXb43374Wu4SwaANFlbk7L0tJZ1cZB0HNloR0ZR5dS9iH/fsjDc2bAVilQEhXHUMJhkXxm0Tuu
	iqV+8JlWpOXNBwu2Zi5dl0bJCWYvLI1xn/EONZ1UqC7Phc1I1n2XBoeD6wB0mvvzNN7RM19M5Pm
	bmo1WwHT9cVpA0f7QpnhiDLvihI2d+Q7T/xZXZVrv3sTyiV27In9ZsTrNd+vtRQJSBKKQ6jeTB5
	OlZxOm6bdhxzOxOEr+BDtdoeeLJ+rBvc/Bn2cSYOUJQC6m7hBzPZP8fXElz3oA/lBhEN4Dk7CwQ
	P7eGiwmW/guUvolbql/WP+Lpl8jj339ZNN3t2yHh9gkA8TtWjS5froGo/CsQNUHlGG2DEXt64LW
	RX+fFzFrbWt1MDjRgVpch1UmQBsANWSlK7rf/cs0c20dE8EZVuQE7OqSTpid0=
X-Received: by 2002:a05:6000:208a:b0:43d:184:8a9c with SMTP id ffacd0b85a97d-43d2927b833mr695855f8f.12.1775161325919;
        Thu, 02 Apr 2026 13:22:05 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm9808420f8f.31.2026.04.02.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:22:05 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:21:41 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 5/5] selftests/landlock: Fix format warning for __u64
 in net_test
Message-ID: <20260402.bdeb96fdcc2b@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-6-mic@digikod.net>

On Thu, Apr 02, 2026 at 09:26:06PM +0200, Mickaël Salaün wrote:
> On architectures where __u64 is unsigned long (e.g. powerpc64), using
> %llx to format a __u64 triggers a -Wformat warning because %llx expects
> unsigned long long.  Cast the argument to unsigned long long.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: a549d055a22e ("selftests/landlock: Add network tests")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202604020206.62zgOTeP-lkp@intel.com/
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v2:
> - New patch.
> ---
>  tools/testing/selftests/landlock/net_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index b34b139b3f89..4c528154ea92 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1356,7 +1356,7 @@ TEST_F(mini, network_access_rights)
>  					    &net_port, 0))
>  		{
>  			TH_LOG("Failed to add rule with access 0x%llx: %s",
> -			       access, strerror(errno));
> +			       (unsigned long long)access, strerror(errno));
>  		}
>  	}
>  	EXPECT_EQ(0, close(ruleset_fd));
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
