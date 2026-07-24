Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4393EDE68
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930357; cv=none; b=Bdmtn0pWhgOsFJIa//6g8V0PlGuuzWxHY5x+umDnzi1Nxhokj5PNexgxu8glmilsZFdqsjWMh56nKwYY/ykOZfaG3Seh03fjMQWBlw4F+dRNq4D0rMCfuZJiFFbkFipJ8UmBymUpXk+ni3vhE29xY5zE+ASSnYfXCPc7VWeOifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930357; c=relaxed/simple;
	bh=MUIgpz4nKc1Ifj681lvMpsc1P9TZSam1taTTKIN85is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW1tXnV0Z/zrYBnWHCCPUD6bSqfpW8rF/sUYpLTjzHmaM2VdnRmM9hMsV+8JdRDcV6fYOgugpyUwqoKu357Lshy3u9hFpilJuqn5y4fWJ7ZPyjJAlFnb20kcUwKjnTDNTcukrzlXcB8icAY7KemmhgeOkr7wmywX43KQNf6qDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WLXSrAX3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WLXSrAX3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e6f0b4610so7364287b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784930351; x=1785535151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WQ3cIAte29peloA7ilqteMd0LDA6wT2JHU11VjgfUo=;
        b=WLXSrAX31vIYde8AhuG+OTI1rqdKLnGJMMfYEVG5pmc+4UQ/pZoLokWQom0tebv69G
         zkapK0dvQOjrYDUzXCx6viwQjpuYizc3r1fsHWWbTcNOYpIxAsEC2LVEAEXxfI3T+t9F
         XyjVk5OkCIDBBav5XqqFkDNXprt06xHXdp5y6X8yR4KgjBBXkbi6/lBYmFYQTCwtyk9w
         qsHmGDNBLMVRGNrnXfp7D/qTPcLFYGf2BFZSJFgWvSg6hcHefCs8Li3U9TDoZKTkEkK9
         1XG7SjOI3m12ltS1updZyEqhDkU6MAVJ8sknQWsoHNJM2/4kvqOWEkgIqjGSyv7M3akh
         P9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930351; x=1785535151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WQ3cIAte29peloA7ilqteMd0LDA6wT2JHU11VjgfUo=;
        b=JKLpfvhvOzzok8S9JPEkF1DBcoXIiw/K6r3Qv2ksCWCBHtrEidakJjZeYmTfsEgwuD
         dzIXEG4TDA4uPBQ6mGRXY/Sic+svY1JM3EggGxFtsXGoZQyljZs3jwBNomhgBDhDuheL
         OfUw4jLHf19Hrl9Ft5SDE/skD7r/bRjFImXbGoGxEL8Dld9on4+pTOkHkqxMXirYqt4c
         8kG9bdlwg9JykEJHxzQY55QatOQv6Og2DpNol7iimSenzIy2Yt8gFn6j+IJqYu8VQOTQ
         o70CSzIKVxHE1SXFag22dvhS1H06DPPZCdHUUJ60V1lkzOw/drE73gdE6GpBWKFQj0KR
         +lxg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/uwdYnaBtcva+7Lu7jVVdu8kjzSlxVj7CcZD6hEUR97JV5R0INSyD2J9FFTqWStbogHnpP1NPMBKENoHNiWly+cHz0+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBvrxoY8OCJewqpwwQHLoHtB6Yj+EXgJeLrYG/vTNXhsJGPjd
	vED8Izuakdh70Qu40UgUnZ22RdQkw3HKMzLkfNeXS8w6rzvbse4RwZUNU0fdnICnvws=
X-Gm-Gg: AR+sD13V8IRSEib6JlURJweUOMPOEfJNofBiKD2mgVJZut/YjZZAjb90jHMkVOvQ/Bl
	lQrduAg2JmsuKUMNyyJAMIhOoTESCyWBTXugmAGITUdrwcwBNVckk65zXEhBpoguTUMkTw0Y0La
	V4RAMcH6ltDRlu+jYCjl84CeF7/XokzBgbNKB6ycvgh/1UwaLQphUSDEId5h7N8P2rSDaS1dukF
	ok/G+K22amPFwB5ORcrGgG1bowLBLcop5w+sWRGCqNANizbpXAVVYyC5vmTrDe6kaKWPBMnQtwQ
	95NRcys6QCFK+3VbUC3dBiGX82wM8TBe+xz92m8pYHd3uxsQ2xeIEfEqlVWXTo3oIWFWKp0OM+4
	852LXkR0H7PYHdhFTszqqd7OoxGYUVQku7qHRWxhCc2j7Ci8PJezbNNNk
X-Received: by 2002:a05:690c:6d8b:b0:81e:d032:f3c8 with SMTP id 00721157ae682-81f69e2f265mr799977b3.37.1784930351217;
        Fri, 24 Jul 2026 14:59:11 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:5f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6592eb29sm5818427b3.43.2026.07.24.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:59:10 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:59:08 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] ima: Report errno for failed hash collection to audit
Message-ID: <lkr72ii6ids4d4izyh6ruqhuxigrvlxsimz4tjwcdhmvz2enhv@3dsebnfscrm4>
References: <20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com>
 <6e6642c14477e409ea34a6090a61cde7f00934fd.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6642c14477e409ea34a6090a61cde7f00934fd.camel@linux.ibm.com>

Hi Mimi,

On Fri, Jul 24, 2026 at 04:34:07PM -0400, Mimi Zohar wrote:
> Hi Frederick,
> 
> On Thu, 2026-07-16 at 14:10 -0500, Frederick Lawler wrote:
> > integrity_audit_msg() wraps integrity_audit_message() such that errno is
> > always set to zero. When debugging for failed hashes, it'd be nice to
> > understand the corresponding error code with the cause.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> This patch looks fine.  Any chance you have time to look at the remaining IMA
> calls to integrity_audit_msg() and fix them as well?

Not a problem.

Best,
Fred
