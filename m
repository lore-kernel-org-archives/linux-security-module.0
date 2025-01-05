Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FF433D9
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736045535; cv=none; b=DKz8PzcD1EEIs9Ia/pHcLVHN2+CyH205g18Oi7LhN4B+II8sQyZcTwOhbx4JRY9a3IbXTmrP5Amcue5EoLzK82MiGr9XmG9lms4NVTqWOruQn9+Wsr1AbnhPIuEfYf732u4D8M/V5kyn2AWQZMxKxffex1lLDr0JDJz2ka3wHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736045535; c=relaxed/simple;
	bh=Ed/ZqvZRaVGHS9E8QAIyTsjOhw61iQHgVTsB3gr5hH0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=H40TQVT23BDVykK15WCTjyCvRC5keapMMWE6pY0huJrg7Yd0OCSWh6VXSijewqB1Unf/q/6RWdwdR1HqaZhQCZ0UlKEOYCMF0nU1Z8flnHGkvkpCp6P8ZDHv6BwQItvKFjYmROM4kYJdmGG6F08nD9wcOah5wiFQAIP490Hugq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HddofRKK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HddofRKK"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd43b08674so92014276d6.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 18:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736045533; x=1736650333; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYn3W1dDrfsPK7DEpP2DitIJR/82bjH5cihKblylHmE=;
        b=HddofRKKtaDxeQQaSnnX4TnpVjfbT7+q0gygw6e74FC2lQ0tGVZUBvW5rBEHbm+lAQ
         KNayRE61Rqw2+uC9IFGY/Pc0Tak92IC9x9gw+/t6nuZ7ioccBiltwbe7ehpZNf0LyZth
         lnUAbos016NcwqjryvM0wzJRfGMJC7O/KdvhXPb4K32nNNED2DlRYQMEzyiAuGA+hCYu
         A/zErWZTquX8oK5WnORGa8oniE9kimj7tvcjmMg/qUcwS6tyxBoPmfITMlJ2jMfMtSKm
         PkeCu9Slv9YXK83Yp47bxGod3DI6foG1WDZ4Qu5S51xq8R4RtKVJBSKwc6OCiTYdMTFw
         jI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736045533; x=1736650333;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYn3W1dDrfsPK7DEpP2DitIJR/82bjH5cihKblylHmE=;
        b=pBxRJkTZWcUIwxWZNgR89O07oJRjszeKo56w0FrlYJ1eRHdSFoCHQ118Os6zO9gUL1
         Dz5F0kd7K/qO/7lfZD/BcTG6jQtGmLp1VyP2DSCnG616VHVmWYmCe5JlPo3r4mYv3Qa/
         cx6TqL2pNqL9WpNB+MYx5FB7VV8JQPEZh26yk76j5zOVDwJISElcn5cUM3pVW0XDFkXk
         nonconbgTrtJPYG2m+H0CqqAYK+3nYeU8ATt5+IAxPdzrlLfJnQ1Dpo6HmDLCMAzWINh
         QF4G8MFZR4N44EJnpSfugacUOWMcEB/Opz5ymIjeTPCfZCuErlp/ehMqfun05QaNloSS
         kHcg==
X-Forwarded-Encrypted: i=1; AJvYcCXhpBiUKQappRr2l9n8X+V+8+pjc4QuAtnge/AfbqvlLFIwqC4Ka2O8D4E3IxVEADh/RbWgQVr7lSmEOuCvz6mAzoXxAK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmiM+6CLvn1nuhch5DkSObXpDWMZQFA37rzOgszR8nkqX8K1kU
	bl5mB9NZpLr9LvrsdHJomQVIvVm+kAvrOAa1A5VR4+rrruqUaDl3d85EoKjPbB5o+7kn3GbexTR
	OFQ==
X-Gm-Gg: ASbGncu+/847cppbz+8/LP+kARrNJ0T2WhqzxPIj2pGbk7qYafzVy7ZLKhOgr19ZKxr
	GCmIJ3RWkSi6+NnugpVOnUWOS3OXDmef4wzWazzLqhReYUR03D6r8D12pbNpxew527lH688W3Zd
	dJ/JpyDF6cOfIzpEVNzuTCz1M0KGMqDt/XEfzppBVSxd1VsV2//KyyY3CEy1W8tJVMr0B8JuzbE
	uvePbZs00TvjPDaqNiRANnA/blcNgLxEqPWEV4OQAmGXpWFp9A=
X-Google-Smtp-Source: AGHT+IFGYNQHPVzW6g3px+M9lSt+KEfxPCyKFIoAQxXMSJm7YBYmrIZwyfYjApa4l/M+SmZddJollw==
X-Received: by 2002:a05:6214:234f:b0:6d8:f611:3af0 with SMTP id 6a1803df08f44-6dd233af13fmr842647616d6.48.1736045533264;
        Sat, 04 Jan 2025 18:52:13 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810dca4sm157322946d6.47.2025.01.04.18.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 18:52:12 -0800 (PST)
Date: Sat, 04 Jan 2025 21:52:12 -0500
Message-ID: <1e9b49e3e80d71ab8a34f7d873614908@paul-moore.com>
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
To: Colin Ian King <colin.i.king@gmail.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: remove redundant assignment to variable rc
References: <20241112124532.468198-1-colin.i.king@gmail.com>
In-Reply-To: <20241112124532.468198-1-colin.i.king@gmail.com>

On Nov 12, 2024 Colin Ian King <colin.i.king@gmail.com> wrote:
> 
> In the case where rc is equal to EOPNOTSUPP it is being reassigned a
> new value of zero that is never read. The following continue statement
> loops back to the next iteration of the lsm_for_each_hook loop and
> rc is being re-assigned a new value from the call to getselfattr.
> The assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/security.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Merged to lsm/dev, thanks.

--
paul-moore.com
