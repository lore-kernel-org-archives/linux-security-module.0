Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4D13C9CF
	for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238481; cv=none; b=EIPF1kYCeve5JDKOE+cLJ4DgBIknwNsg4bMLLkEcC2dKCse/kpiHvdhGDHXk9IN74O3Gl6GWwXcS8nvp6UphePR3+78RHE5W9Cpq2rfakxE3cFnm3CRaRO4cLjyfgozLMI3otqc8Al8uWZ9LtJfOvQa6LU7VOon+nzS7sNOGBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238481; c=relaxed/simple;
	bh=RDsR4ToFpRNThOky+HJxH98rH88NIDQxJa03Zgfpnqg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lGf8HL5fPHOD3yughNON0gdSRV3JvIjiSAphaAbhkzHTlY1jfFNwxvdHoLkimHd/UD5GHCkgRwCQKzpPiCRjl5d37B0RsFuCoNDDy5qok2XmgBEQgOXxcDKBk/+G0kD8BXw1AhoA7f3sfslvm7J9bMdI2IN2YhQLwZBvBpvOXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FSbX/ND1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FSbX/ND1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso205372466b.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Feb 2024 12:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709238478; x=1709843278; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DZcR+0yv09X8AgyLuxWH7iCyYgNb+H9Qm3haz1AXF1E=;
        b=FSbX/ND1RSFg1XD0nhVbxsljXSGAvGIj+7f0miEmMGL7zcWUNZQWQ70jHggSADRp8J
         dLMFtqHIQIQwNrMed9Q4DQyGgjsKFnwIDsS/fkD04llSzsm3vlkrgVmU8FBQWOrO4gA7
         1RndLdKKvOnDHhconknl3unPhTovQuE2x+AP6QS1EJLzXbllR8BvfCorwBWqlHleLXS9
         419Bhyw2NG6ziPblkL3tIa+8oJQgGq5OBuT5lzWZRYePQQ6ZxCSeMvZI61OFdK4lL38S
         qnjgbj9cStiA2tvT3fZUcHyv1lCk4Fp0m8iaANld0DcqM+oqCzv8tr3hFg7iMrWMmGQk
         jMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238478; x=1709843278;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZcR+0yv09X8AgyLuxWH7iCyYgNb+H9Qm3haz1AXF1E=;
        b=N/SMOMP5kin5IxJXiyMWdSMX48+X2m7dXIL6uJBfkes/6D9U/JMGEOCcWrM+wFlwlk
         gkQojkhLvHjFcwxWyYeu13cc5YqJxlvUZpWgNk9aOEqrYbwXueJXEwRbSZ1lU+BDZl6j
         zBrG3XIyangQhDtHbhzPJmkWIpYvlfUgps3zm93h9ogFmQQtXgHcNluI66AGT8wOdSmw
         TckdHy9QDCqmTb+PmFtOgXxJIBCmnjvDU9qkP+7B4POSo4qUszyoux35/Qy+EywZkMpQ
         lomUAM8B7q9g9zl+9SXpiDjWvrVjYM5Gh/l+EBlBADUy2gLlPomGlqWci+ABo1DyQ5ZU
         QtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Pf8SvSwUzDPocJsVodOQtQyw8KQ78s01USYTk6wKz1nTIwfXkcQQJ88f4zKXAMZxSdywG0K4DACAr1vrX6AUONTyKxEM4E+vuHntzJstb595T41Y
X-Gm-Message-State: AOJu0YwTAz7GqVI1P7MMHxyj6Yj8dxPjCZlfAeVPk85ePc3KEtv9IRSg
	XdXYiR1LP3BVTEAxRPG4n0E4w5Dy19yTO293U7mRv2h1uxihLvZ5uNQ+Ao7phDA=
X-Google-Smtp-Source: AGHT+IG1YXaMCPYFP4ybh7Rx5xqWqA1BhyLNOKCSuLhH0a9+11clFB7+JHSCwlsHnhgI7bgLYfpXPw==
X-Received: by 2002:a17:906:3c4e:b0:a44:7209:4c94 with SMTP id i14-20020a1709063c4e00b00a4472094c94mr46779ejg.14.1709238478243;
        Thu, 29 Feb 2024 12:27:58 -0800 (PST)
Received: from cloudflare.com (79.184.121.65.ipv4.supernova.orange.pl. [79.184.121.65])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a4439b7756bsm1005844ejc.6.2024.02.29.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:27:57 -0800 (PST)
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-13-kuba@kernel.org>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 mic@digikod.net, linux-security-module@vger.kernel.org,
 keescook@chromium.org, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v4 12/12] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
Date: Thu, 29 Feb 2024 21:19:09 +0100
In-reply-to: <20240229005920.2407409-13-kuba@kernel.org>
Message-ID: <871q8vm2wj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 28, 2024 at 04:59 PM -08, Jakub Kicinski wrote:
> SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
> so use XFAIL instead of SKIP.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
> index 6ebd58869a63..193b82745fd8 100644
> --- a/tools/testing/selftests/net/ip_local_port_range.c
> +++ b/tools/testing/selftests/net/ip_local_port_range.c
> @@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
>  	__u32 range;
>  	__u16 port;
>  
> -	if (variant->so_protocol == IPPROTO_SCTP)
> -		SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
> -
>  	fd = socket(variant->so_domain, variant->so_type, 0);
>  	ASSERT_GE(fd, 0) TH_LOG("socket failed");
>  
> @@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
>  	ASSERT_TRUE(!err) TH_LOG("close failed");
>  }
>  
> +XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
> +XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
> +
>  TEST_F(ip_local_port_range, get_port_range)
>  {
>  	__u16 lo, hi;

[wrt our earlier discussion off-list]

You were right, this test succeeds if I delete SKIP for SCTP.
Turns out IP_LOCAL_PORT_RANGE works for SCTP out of the box after all.

What I didn't notice earlier is that sctp_setsockopt() delegates to
ip_setsockopt() when level != SOL_SCTP.

CC'ing Marcelo & Xin, to confirm that this isn't a problem.
