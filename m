Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8D12BF24
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985191; cv=none; b=kzzrDkdN24jaVMATpxv4WlEujTUYd3vJn6BCPK/5y2QiBvQ662Louqc2tHQHpDZKnEw44/8wX6lHvesIDs7rklXQfHsrPwaAh0TyKdAAuOy845IeL1KItWwzkHHkPBs1HJYed5eISkbb1XHY4l4cNK4YWaRbFPb7UmuTEfFm2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985191; c=relaxed/simple;
	bh=w1jIE9hJSQLAasM7TNhoYeU19kfzxbDAm9Fb79w17Zc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=qYAt2mF8cU+j1d7CPba8OBmksgfLPZ98r2jn4pzZdXCSRIURV9vlOviVfEcTSZ6RensZ/ygOPZGttRB2CLQJ8fMdYCaXFtNqDyWMd6weM0bH5B+FuIrWBVYGBzhiCQY6IclzRtyF/FYAuBMZL02IHwdL6b2wdJh7/zK48vpOa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eWmB2uws; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eWmB2uws"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b702c3c021so30501285a.3
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736985189; x=1737589989; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJh+T7Hv8PTpEPApQXjKvV56GIOkdSD6Exn3cyfJMsI=;
        b=eWmB2uwscZSkqgcsmyAUiGk8MXYioHcwTTK8Z/FmMZ9zQWk1D3ZUj66GpT9p49yyIX
         JS2GBqfR3fwi+MlEmz8+HKQ2jdw4Z477SDyvExFCfbR62qlZJSIgCxz7HneNl1VG0/5u
         i12lNmdYkOaF4suZi6ohihiP69DmdIbNkyV5S/xF58Ye7xsWDHgjXNaK79vhwpa+jrr/
         fDq66xBFjVZKvIJ2sC6EXEQUdcEFAn1NCiMqIhvWSbIUxqa6XFYvOs0bZvFhWQ6F+wtO
         4oj9ie3zRIP1XFrgLYt/jeCsyPDvm4LFoRJ5a4azTbfEATxnVEUn85ocvKJkOca7crY1
         dMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985189; x=1737589989;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJh+T7Hv8PTpEPApQXjKvV56GIOkdSD6Exn3cyfJMsI=;
        b=GmWHgye0qkctqEK9zTgKhqczrj4RPcwKfFpassuXUkDmOJiNP2mLledrMIHwz3f3yE
         D5lkHuKNlHUig1guAVheXs1oHbFJoQFoy3rQ52EAB76mWFaGHBr8dxXvssinhL8l5dOR
         D3cNLYfhaFyGND2a7NXX7NiuiVVpbUEChLZsVHfcYtSNCvmLXAOlsjCK2BdlIDjEGBwG
         OLtJnpd1Us2xt1f+Hw0gVzghvuO0ASKQTWpoYUzvmTW+86oe6JN5ktQMXLXzw+hQDhzT
         YYrkwH99ccNEi13qoU3IYcNOy9wvT5otQhM7DiIT/63924jLnWoKg11ZRgFPSOsVcpf8
         sRoA==
X-Forwarded-Encrypted: i=1; AJvYcCXEkjGrbQWbhoL5IazyeLYFkr+5C1wx6olQI+nIs0ZoeX1TI2cmWKk511U31bOYo+FVE1jUXR0wygnz//gA49AQ/XXW/fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweauuqrxXjyTWil6EmRaa4BZAw5HtvVHxFFWPqxxrKvijUaG6S
	JcUnIW/ZrFIotCvjDDhvf9dGpiTbAlCa2L3sFoerWs2sHrDTPlr72jgtaV6zwA==
X-Gm-Gg: ASbGncuzorSMsDr6eYvw9PNatF4aCwlqX1y5MJWyjAVbbVeda1UsnJydmrUdNkas7BG
	VB7+MbpiukgimjJLrIbAyWUVjxRErIvyWRj5Aaa6VE5E+T25HYJ01OBv9z9uv2TLLUJqs2CkNUN
	O1l4CojYfKz+02lcU7OiKbekUipbc5qRvrnuE2BIS/75603ZJkAS/YG0vjkTrRJhyPwScWoLMxH
	DlrTcpZyrAuUTrChi3vTWOpxXxVOgIkhfyugfcX6ANAwIRve04=
X-Google-Smtp-Source: AGHT+IGlGPvAT10vh7zR6GchXN0fLnmopYZatnQZSEGB+wWm79pzK4V/AiofLks/o3AMcVKKkQY4vw==
X-Received: by 2002:a05:620a:1793:b0:7b6:c93a:7f2f with SMTP id af79cd13be357-7bcd9709142mr4501376085a.14.1736985189359;
        Wed, 15 Jan 2025 15:53:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7bce3515f40sm766857685a.99.2025.01.15.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:53:08 -0800 (PST)
Date: Wed, 15 Jan 2025 18:53:08 -0500
Message-ID: <1ac8548a7b42eaed3f4392690011eb8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250115_1512/pstg-lib:20250114_2216/pstg-pwork:20250115_1512
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule  type
References: <20250108154338.1129069-29-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-29-mic@digikod.net>

On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Landlock manages a set of standalone security policies, which can be
> loaded by any process.  Because a sandbox policy may contain errors and
> can lead to log spam, we need a way to exclude some of them.  It is
> simple and it makes sense to identify Landlock domains (i.e. security
> policies) per binary path that loaded such policy.
> 
> Add a new AUDIT_EXE_LANDLOCK_DENY rule type to enables system
> administrator to filter logs according to the origin or the security
> policy responsible for a denial.

For reasons similar to why I didn't want to expose the audit timestamp
to users outside of audit, I'm not very enthusiastic about expanding
the audit filtering code at this point in time.

I'm not saying "no" exactly, just "not right now".


--
paul-moore.com
