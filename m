Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B273596D;
	Sun,  5 Jan 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736073737; cv=none; b=MCsOkjev8+zWwWuDJvT1HAcWTrRP1O1dHBBxzN5UrDxTPzUMfbCE4BEFcG0nTOr2bZq1fmndBbf5zpw+4yBn8D2GhvbKSbyK9uP67GUjavBNJXPG82BbH58Lgo2bGCfu/5MKBNyoP1QEl3SZE7Ax4FLf+Av0YEPUyecBFAMmZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736073737; c=relaxed/simple;
	bh=y2y07+62ycXnmqOSfRvwMDunECBtasQsyacudufPEyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxZO2oXCxy1f/0optYggkTJsp3HXGSuQCtttnKeJzjogNd8waJqB3mO5PgAIj/eeVPaViF2TTIQcgocxOQRq+BdxgT56P1mwGalF8I0odctdSA4ShR/IM8anrA67sYHG1wte+3j2wS7hpIt5mgwdWucZNeSUkXkLkQS2RDOwUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbcSzib9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbcSzib9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21661be2c2dso173575915ad.1;
        Sun, 05 Jan 2025 02:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736073735; x=1736678535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RW8qOj6aL3VEI5FY4qDrXCPjFiUKk26602zZ7X611Aw=;
        b=kbcSzib96OGjfvQ2qfVphLnzb8xloEWrXtZ4tcOXe0vwx+ETOckqOgnCV/6EHtpPOY
         XA9B5NsxFa6gov/oRdyNqCmpKGnPw9+61xLCkJDqkkwyqFu7xZcXrkM0AzdhF+yPO1F6
         jOyTKsNTCfBP3PuybH9yKP3CsZEWE45fNvKDw5f9qNfkRvxLHQFeI2/CtCijDYUywE9k
         n+S3I1dbJ2+7GQ2jZFwMAULZKw66rnnzYSEGjz7idgXtkk2/3ZIf+DqgP39KZWnmVgUQ
         holo+osZa3Kr/4Fk2AHz4PDqXRjQXeCjVr3BknA8eRTneLYxCoTLCCeDLOmRBtOlYSsw
         AYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736073735; x=1736678535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW8qOj6aL3VEI5FY4qDrXCPjFiUKk26602zZ7X611Aw=;
        b=gvSB4Zo+mbDZ4xQfZIMKu8Wflso40vvGnyJF0ZlByltMz0zm+5RgqiGDS5WAXQeKY+
         QJn6DFpqn7pax7jUC8TAwg24U7+kfGGlLuZ+ifjQWfDGqp+J2mqGx1nZYvxgqT449pZS
         D9szGDhLABc286scWiqPYYtbQOzsCdSVaLYW6PfKRWFYLSfqx5rpYBBtOTOp7J13ibP6
         chaW5N1e3yW2B7GW3hylby/i9sioOnWUNSt7Nu4og6UhiVnMv1EeJE7UPYzqx8N3zsK4
         qvmUtd6PdRvB2l7vun9/F0BaxNFlgsa3ja/KDKJZqH/oO34Qg4B6RxEm0YEAYSVroflP
         GmXA==
X-Forwarded-Encrypted: i=1; AJvYcCU70TKZD2h+nqAWUxAq+JUKviNXX6F+Y4AErv9zrHJ8DQkmJlOUumUql3te1QQiDzhbdq07a5XjxDMWhN1+lXU/URgs/ZGg@vger.kernel.org, AJvYcCW179eATtomyRLA9xMpoooQfiJpR/8bschVLLs2jayRZtkTubBopt3zpo0r0AlLeYSdGSHvuaNwZZpzkJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr5lQqazjEm494YTlGd4SRZmLGhbaQrOqqFGL362/Q9kfMDpp
	DUqlN0GTZvxQJphC6GgQEqPno5b5Wc2xXBr7byngB1+iBBnhrT9a
X-Gm-Gg: ASbGnctBhq2QtsoExe/C4dh91UN6sJtJ6DtWOHLfBDY+kNSg9kM32zkpNWE66DRD++P
	WXtn+S4QaPHtf5e7sHz/ets7nERNXI6DrgbUxZrm0y1r6SdbdOxlZsb/E67d5T36yW1Qd3bJpcC
	eO3GjfK+KpsR/o2P9QNgrdyDcH8Rg225WWE0G+nyTab7iLsCKXTv8I5tIR6UCRlLLO7KWKXcVAx
	TW6w2Qe2OsC7pbR9qjSOB8f40a5Cpmaj0S4+VbpDksN3JC8mR6teYk+70DldyVDhIvUOw8ehm/+
	HVY6iHkC
X-Google-Smtp-Source: AGHT+IGFp/OUYBxcthZ+8DsOBebCChZIz8SV80eT4AapiHKyjPipUA4XzSaSbkl4F9hhgod3YSSZgg==
X-Received: by 2002:a17:902:f612:b0:216:526a:53df with SMTP id d9443c01a7336-219e6f25cb2mr841763915ad.54.1736073735538;
        Sun, 05 Jan 2025 02:42:15 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdda6sm274918125ad.164.2025.01.05.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 02:42:15 -0800 (PST)
Date: Sun, 5 Jan 2025 18:42:10 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	kees@kernel.org, yuehaibing@huawei.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	matthewgarrett@google.com, skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: Re: [PATCH V3] lockdown: Initialize array before use
Message-ID: <Z3piAiLGWgsegpy6@visitorckw-System-Product-Name>
References: <20250105070537.58334-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105070537.58334-1-tanyaagarwal25699@gmail.com>

Hi Tanya,

On Sun, Jan 05, 2025 at 12:35:38PM +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> The static code analysis tool "Coverity Scan" pointed the following
> details out for further development considerations:
> CID 1486102: Uninitialized scalar variable (UNINIT)
> uninit_use_in_call: Using uninitialized value *temp when calling
> strlen.
> 
> Conclusion:
> Initialize array before use in lockdown_read() to satisfy the static
> analyzer.
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>

I don't believe this is a real bug. The lockdown_reasons array is a
non-empty constant, so temp is guaranteed to be written to by sprintf
before being passed to strlen.

When submitting patches in the future, could you also include an
analysis of the conditions that might lead to the bug, along with the
coverity scan report?

Regards,
Kuan-Wei
