Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA7384232
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161523; cv=none; b=DqcxQmTzU1TsrsBJaas9bz4179i3JTtj8QhODEUClj02Kmgw2zCc5+cerKUmS4C5s6wWvchMOlHsbTi72bVK4WIM4uB9Vfjzvvmku1c0AFRCctHGoL276lVNRpEsG2BICAR2hLkdP7LrCtMac5Mv/rEPaK8LCRl0jnq+BMHRLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161523; c=relaxed/simple;
	bh=M+ygnrvbd1t83GBCmH+solpxR3l4QjrCqXbvg1oenBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJG9b/DD6w2oS9+5fcMh6cPpSQBiufaEPMZtk8p77Hddg+BBhyBAHMinwY5LUk1R9ZDvmvDz470K85LYNmHRfBoYcHmP4esSymes9nCZKB2Khm+Iz4Nb88uQ1xwOUF/b+1SGP6nnjt8Ufs7Wr5zCEs82dufSrnYLQCe2ENpUhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+sfZfYR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+sfZfYR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso13121965e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161520; x=1775766320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jcc1hZOquhNmlP9pXmTrYcA0fCA/28vP38rmU1pTwc0=;
        b=Y+sfZfYRU/TjPxABK0xcx0Iv5Gfqas27zmnl9HFq5aCJPo0+ET7XuXxu/DWfESeqjp
         phoTe8SBFP4/8LBNRRwuCGjC57y4o/jRF8Moe7sQfZNkwpkEKeBdArmiGnj0dTkZDgf6
         Kl6ULtfefHtggY6/uNG6IARPp84qMN57l5aUDtLX0wcHAjNsNrmzffbhfsCKhQVIuW/h
         qrbn6M6UPWCkYMO/fuECnB4+9qahSqwLc5VAiPZA/76BtSUAoH0FftJB/d5vYjkFWPMB
         JkZp63aJu9oXLook6PzGQkcvzauIQYQA7uSudlNVXdI0yGtr+LQaBre+XQ0u+k9wnCqg
         7+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161520; x=1775766320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcc1hZOquhNmlP9pXmTrYcA0fCA/28vP38rmU1pTwc0=;
        b=spt3eKQ2wta3jEbLsP8rd2/U9rB5sg/8S0irJQznhsHVo+A41q+A+HtmQCp03p2Wke
         BbckeIs1hz7RP1lr+k+BiPRpbK/TmGyPBw+k8HRE/q7uB7IGiwvpaNx6IBd/RGtcGZSa
         mgqQb8Oq/MYtooU7LB9i6k/hf4Q/4QeLfHt4qjSQjlF8THkh8WMGpVn9sk7TxPtpx8uE
         0et+Nm6SQa23Une0mQeyS8oH+99EO6rQ2bZLn8o9xlgKGHdaKFUxbbpL0He6h2efMLMZ
         3raCpxfaOhtPGhljllCj6PMiFDmEAtP7wjTNYdkMAmhfL98xB0UfKKKbJ2M66shFiXYR
         2pqg==
X-Forwarded-Encrypted: i=1; AJvYcCXBts201YX9ibM8Q6thybySwnkXGv75434bL4ckE3tIWh5pzoEkhgpHK84H0Ugk0dV9rrlavgpwAe5Pew64hcdN/PZpnho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfSgnOFANQaQ/ZwLJMqYewHU5koZPSHSqJsbXRMvwDsvXoEFz
	sW6enPBcKg2TGXNAnpMBNDvoW81Y3AsVhb8RG553ZNaM8UvcjP+Btoh/
X-Gm-Gg: ATEYQzyytlmBNX3tu7JfWJWslstGwJ2h8u2GDyp7QdBXtz4SBRJZLAgpNnVUIDxmcn+
	HiHkZrzIR2KQSDcolCDanjxzf6tQhmC0RfMw2NmKOpWgwfmHP4JsXDkLrHsKnqRLUr79dw2f3Xy
	upwbO+UpcEsBlJniYfeHIN8engoVk3OAqN271WbYxR1PUWavDT7arWCeePkdw5KA18cQCEqAp35
	hadiCcvUe0iAkoAE/xm8McvYjt9XPuRHBQ3hMNE5XTgjg7TWSy9H0kF/TWaSgTigxJsX7EyOqju
	h7APXolbobajY3Lu3NL2aOQdxcYUfc7bkyPPs+BYwU9/67vP60NNLlBDArflwMPWEj0Vll26zfJ
	idaKzKVlQVogZLI/zuzN8cWw1dfSvRbgAXRRqSPWCTfOKgngKaeeNro4vWa0WbDgC4k0trxz91g
	CQOUeJJuGG5QxRrpkcx+efh5w7pgXa+ubOx0LVAQ1CZhrfn70q
X-Received: by 2002:a05:600c:8b32:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-488996afe1cmr6726265e9.3.1775161519863;
        Thu, 02 Apr 2026 13:25:19 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm10040513f8f.14.2026.04.02.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:25:19 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:25:18 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/landlock: Fix socket file descriptor
 leaks in audit helpers
Message-ID: <20260402.4ce8eba2f199@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-3-mic@digikod.net>

On Thu, Apr 02, 2026 at 09:26:03PM +0200, Mickaël Salaün wrote:
> audit_init() opens a netlink socket and configures it, but leaks the
> file descriptor if audit_set_status() or setsockopt() fails.  Fix this
> by jumping to an error path that closes the socket before returning.
> 
> Apply the same fix to audit_init_with_exe_filter(), which leaks the file
> descriptor from audit_init() if audit_init_filter_exe() or
> audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
> audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - New patch (split from the drain fix, extended to
>   audit_init_with_exe_filter() and audit_cleanup()).
> ---
>  tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 1049a0582af5..6422943fc69e 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -379,19 +379,25 @@ static int audit_init(void)
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	/* Sets a timeout for negative tests. */
>  	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
>  			 sizeof(audit_tv_default));
> -	if (err)
> -		return -errno;
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
>  
>  static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> @@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
>  
>  		filter = &new_filter;
>  		err = audit_init_filter_exe(filter, NULL);
> -		if (err)
> +		if (err) {
> +			close(audit_fd);
>  			return err;
> +		}
>  	}
>  
>  	/* Filters might not be in place. */
> @@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
>  
>  	err = audit_init_filter_exe(filter, NULL);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
