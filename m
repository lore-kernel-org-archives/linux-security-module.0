Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A532B104
	for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741065; cv=none; b=ZC/te91VKzu+oV+SaKXbEXFe8lxWhsllrw26Ar/GyXVq/m4LGRi2jpEp3XjWjSKPsmNMN+prjkUoEk2Zm31HVI4e6PI0ypPPHUNmEva3m+vr/ygyOaj6LkrMUG5PJl9fUmCZrDAS+MPtK+CoO46SGAk5mdHjlK2KhmFVC4Zd6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741065; c=relaxed/simple;
	bh=SdMHSRPFPOdRrXYnOJuBx+37r+WD5EJCOrrI0x3V67k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUeGX7kHuYLjcfNyDWLV6tXtbZkQixKJ5sfM2mePcRQLqo6uWGexx994ki+rronkVc0Vd4VUCqYNY/B+hCeDBxFuA07ABjZ766tardHlLLt81CagEgiZDT0D9xMBuTUkoRPHbv0IFTjnpzd0udit8qm2vjj+N+2QWu0etUyt/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOyH1rPo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOyH1rPo"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c252cd2b3c1so42380666b.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787741062; x=1788345862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSxv4pYntTUwSidf4pllRCYgkIQxBJh+160AfjnZ5ns=;
        b=FOyH1rPoM2nAJahQPn56FnFwExKPO1/U0Ka95arPzKRDWfTuOtyhF9rsw6GX8rpTBM
         MxyTxE/SjRASR6/3E0ea6mpG8+F/B2ybqjPG8kwgGC/70efEHGmdJ/xCpvipfvYfsBY6
         aXNGxWqdHOT5wdKfYttNcKHwpUdeC58eZtinUoGOtwgEzC7OjYOlu68vjwN782CodE7q
         5WBvLnC22yPSYmpgmqyX2Vv8gGldbRHbMSyiNygfg1GYfSxutfWYK5UhLumpm5OFDGmq
         eP7AyOy/g/bHREWqqO9alnKe2H/PJNeE8M5pQeMGMQwnTE98ZiC+1VBhwFXaOFXLWn4B
         MgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741062; x=1788345862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pSxv4pYntTUwSidf4pllRCYgkIQxBJh+160AfjnZ5ns=;
        b=CkbjAZaa1eJu6A/L5GklEO6AIXKYMWOz/yBFRx5jGpQOf1oExNThUU/HZ7Jhkh2388
         cSGWdj7MubPOBZuTW+SUuRHYrUmLMu3ULqkMickArBeba3R/tuYd9Lh8r9jXQp2dPJ+l
         iefhgkEdQnCUGUBkqlrN/fwE6bO4UKIfIEj//O3uXsOSx46v3FF9R1391jQMkIz0tzk6
         ypOlPoVz0HfDbGdCwGoHQ1RZvWXSrNApNef39Lm8tnwRKW47W36Msrt3Tie3UitfLHBc
         cSkSs5CwVJIteoaJ627741505Er7JYy+ja8VzFBqLpN+1M6y8a6D2tyt5FLRSb8ur4cd
         +IKA==
X-Forwarded-Encrypted: i=1; AHgh+RpYqgsIPlCHMSmFfw5DNy0Tt4c2uTHJTqfV2n4ssRZHO4Tvl7sl7sXRX1Fu+vqtCpLK0dGvXkznkmewxLVkEpS+pnTCXhM=@vger.kernel.org
X-Gm-Message-State: AFuF++nwR46WxBjBfCYO1eRBLlcT6p1Rg471vqIKO6Df6sZ6ExUZcZq4
	9MaOQrzIabvElxDpH+DSJMRBUAIkqiee+ehW9JBa4wj+PJehXfzzFAjsaTn9Qd2qZw==
X-Gm-Gg: AR+sD12CZJg+UejWNepDDL7lRFzNKkM2xeg9nGgkmb1wBRYKw0J64OjXAvGOvVdhVHV
	h6zPxBUUAoxA6GI0VAUhj/wpIs3NY6SMlhHDoYUbA5XlmZRREr9pVsVFeJp1P5CmCsnoGBz/6o1
	GAecugCrzTcPiieDzhTst0ltf0T7tsGcVsZZmfxmkKCo+VH5dnJBsK75YFOSafFR/xlfDQEWnmh
	t3R6kbyiIq/wUykmGk2vvERxhixhNJg9b8EXs6pg29fxhdP/5eBijwW88MzoT25AqXyIWgulzJw
	Z21yJaTd/C2bQi1njGHx+U5gtKxobsZXXCR3f2xdaG+rNx6gyl4FVCB15D2dlAH35TaxkRXcWMh
	FemgIQX/ozrvG7aCwHk7iqOE8Hltmn7iQSPLiu1TVxqBpFU/kWVMYyTHpsuC1AD14awlP3y7QrY
	eNHM580uLsDmrf7n2mgGEqO1WGDetyVhTJfC/WcDapboe1/8fQXmnPbBldYA1LSnqvxzMRI6fov
	KoUyk8d29cjTC8ubq3HmXF01PHDaQ==
X-Received: by 2002:a17:906:ee88:b0:c12:83da:7eeb with SMTP id a640c23a62f3a-c250c3add0dmr673831966b.19.1787741061401;
        Wed, 26 Aug 2026 03:44:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:7967:21e1:13c1:d2ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d69a7sm642416766b.8.2026.08.26.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:44:20 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:44:14 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: mic@digikod.net, shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] selftests/landlock: Fix snprintf truncation checks in
 test files
Message-ID: <ao7DflLdx7-lFyvk@google.com>
References: <20260626070016.61049-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626070016.61049-1-wangyan01@kylinos.cn>

On Fri, Jun 26, 2026 at 03:00:16PM +0800, Wang Yan wrote:
> Commit b566f7a4f0e4 ("selftests/landlock: Fix snprintf truncation checks
> in audit helpers") fixed the truncation detection in audit.h by changing
> the comparison from ">" to ">=" to correctly handle the edge case where
> snprintf returns a value equal to the buffer size.
> 
> However, the same pattern exists in ptrace_test.c, audit_test.c, and
> net_test.c and was not fixed.  snprintf() returns the number of characters
> that would have been written, excluding the terminating NUL byte.  When
> the output is truncated, this return value equals or exceeds the buffer
> size. The existing ">" check therefore fails to detect truncation when
> the return value equals the buffer size.
> 
> Fix these remaining instances to use ">=" for truncation detection,
> matching the fix in audit.h.
> 
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> ---
>  tools/testing/selftests/landlock/audit_test.c  | 2 +-
>  tools/testing/selftests/landlock/net_test.c    | 4 ++--
>  tools/testing/selftests/landlock/ptrace_test.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 72b5612375dd..4bea8c880a4d 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -31,7 +31,7 @@ static int matches_log_signal(struct __test_metadata *const _metadata,
>  
>  	log_match_len =
>  		snprintf(log_match, sizeof(log_match), log_template, opid);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 2ed1f76b7a8b..aebeafd80466 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -2777,7 +2777,7 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
>  		log_match_len = snprintf(log_match, sizeof(log_match),
>  					 log_with_addrport_tmpl, blockers,
>  					 dir_addr, addr, dir_port, port);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> @@ -3072,7 +3072,7 @@ static int matches_log_connect_bound(int audit_fd, const char *const blockers,
>  
>  	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
>  				 blockers, addr, lport, addr, dport);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index 4f64c90583cd..65cf2d82f721 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -302,7 +302,7 @@ static int matches_log_ptrace(struct __test_metadata *const _metadata,
>  
>  	log_match_len =
>  		snprintf(log_match, sizeof(log_match), log_template, opid);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> -- 
> 2.25.1
> 

Thanks for the fix and the reminder!  The fix is correct, because snprintf()
returns the number of bytes that would have been written *excluding* the
trailing NUL byte, whereas the buffer size passed to it *includes* the
space for the trailing NUL byte.

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
