Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D68A79C4
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736046684; cv=none; b=Ku4XOn4l/NuLu28wmZHAcHjyRV+PTY3J5jWv2FQ0aMTDBn3yY8867s+b86SMnhxQrDg39L8by26lSExlKvF5KxhQB+CEHh9F2dbp0VZJGLBDRHOPyY4DBSyxQMiunvA7F9zeaVv0wXq4uxJD3qNmf8jjflwbjeNL/8OkWmbTH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736046684; c=relaxed/simple;
	bh=LjzVv5pLxvqrc1ynToshNVK4xohlWsJbzs7wMSKW3i4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IQQZ18FID31vIF1qMsMA/0rxYBmZoW5bLeCtqj9hFlKxK4hP9rknvF2YIVn/Jb4QLPd3xsS2niLgR7IxUgzOz+JB0mGwWseLRSM4VN/2+CxVXj8PEeZvlaHVRN1nsd8RLcYGpBKOLR1CBJIfwoEVYY8PVWHrKcw1Clk1Oeso04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fF/Emey4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fF/Emey4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b70e78351aso1078650785a.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 19:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736046682; x=1736651482; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=713K/Xxci2+ii1pa7s1nbThzLbzo8/wputlWA7AidGA=;
        b=fF/Emey4F8Ra8jzpzTvbHLld1x4U04koNDXwJU+ZF9Xxlaca/aVunxE+pjzr+v3gnO
         alpaVsPgULWCHx6wANOTklCwVOY8q/pbSrdlYE5k2OKWqJBJDOyKgUdM187R311YBz1d
         S76VZ1BZ4BKU0914o1DCq3J7NKIFonR46YvgQ96jNcV3Kbb7uZwpu/k7+m9at3d1fmxc
         huvJYqmDUkADe7CYcGhFv2OKL97+LPma5nvsfT6fSiZrItlCe99Xollvwrq+x4ijzaJu
         /rshpJ418uvcFLyNOTly7dGcS8vXQIk+NysZrwm3t9si4kBcxu+5hplutmCPsHVbetav
         0Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736046682; x=1736651482;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=713K/Xxci2+ii1pa7s1nbThzLbzo8/wputlWA7AidGA=;
        b=Q3JQ9fkc+Tz/ZZWAr9NRkVmgVpKLOsjzu8wvonlZHmgXGi2lUa4X01G6ulNYhzSVFH
         s7OJbMkvmHwumcisB6IJtBgyYFLAr67vHPwooXwtaOGpNSGLI6HtPIXnQkC375mGNEml
         PSSJYT0hxnOCMwPc1d4A3l1tZLi1VCGpWYadkGAo7TGZ+n0cg5zu7vfLpGPtwnxbRwll
         4Nopt8vzJvaeML0CALiFIzFk4KiNs8s1cJdvXQ4bCTmFd24kice6hpV4eeOisnW25Edh
         qWX6m06EVg9UrS/DuRQYyD/FWzHIsa78zdaB1SQfZDF0Izui4lhNs+mUAoYQZsme4k1c
         YlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYmEb+YskB+whQuMfYFrFQ7xPwIZJa6/Qv6CWMFUaAdRg5D765dCDWF1NH3nh1sb0vupb63SWO6t3beOGxWM6750q7NRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1oHAXYXxnfqWFCdqyPlglZq+Dnh+fj7M+6Ftqegl0avB/Z4C
	xt48WzHGwjV3PbN9fE4IjDaAKGYggD8+A1yyej1yGlBjjNPSVLhmnd5NiwRvLA==
X-Gm-Gg: ASbGncuYMSjK4qSc9G/pQC3aJOfH/GMGr18eay6BVCdTjJZyuzcPL+OehYbis0JhmOF
	sa/zybQ2gs+WXmKuBwSUud17RFflnRNECdQrxk8/wdV/yWPp5BpRMzxEmbZR8wy9n4Jws+Skmd/
	ssWb/2G77sR8frrYch/yWNpUoLw351EWF3SQOuFBh09oo+mpPwQFX3qloJug4fwABtxOpvWI6//
	uui/FOHa4Ez0zdPgVeGq7XSQ8qop0m1uSTpOi02zEEmGxzsD4k=
X-Google-Smtp-Source: AGHT+IFYBQEhVjHgNrj6df3L3PvVYd3aTn8gApq+cjhuE7r06vSWA6/s7EWPEL3m0kgHTJ9r058cMA==
X-Received: by 2002:a05:620a:2807:b0:7b6:d631:2669 with SMTP id af79cd13be357-7b9ba79aa8amr10662502685a.21.1736046682034;
        Sat, 04 Jan 2025 19:11:22 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbfbasm1399728585a.17.2025.01.04.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 19:11:21 -0800 (PST)
Date: Sat, 04 Jan 2025 22:11:21 -0500
Message-ID: <3a60ad96a636f4fe02bcf10019017d58@paul-moore.com>
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
To: Casey Schaufler <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Karol Przybylski <karprzy7@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v2] net: corrections for security_secid_to_secctx returns
References: <2ac1afc7-8549-48eb-ac63-daea64c3d80a@schaufler-ca.com>
In-Reply-To: <2ac1afc7-8549-48eb-ac63-daea64c3d80a@schaufler-ca.com>

On Dec 20, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> security_secid_to_secctx() returns the size of the new context,
> whereas previous versions provided that via a pointer parameter.
> Correct the type of the value returned in nfqnl_get_sk_secctx()
> and the check for error in netlbl_unlhsh_add(). Add an error
> check.
> 
> Fixes: 2d470c778120 ("lsm: replace context+len with lsm_context")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  net/netfilter/nfnetlink_queue.c   | 12 +++++++-----
>  net/netlabel/netlabel_unlabeled.c |  6 +++---
>  2 files changed, 10 insertions(+), 8 deletions(-)

Looks good to me, thanks Casey.  Merged into lsm/dev.

--
paul-moore.com
