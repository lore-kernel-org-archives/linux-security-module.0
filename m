Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1311BD039;
	Wed, 23 Oct 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709467; cv=none; b=fxRsYzUxnayILmZo50AGGI7VIv6STKXSXyz/25Xct/8DQyfkhik0TQ3LP2lHJt/W+N7JMMVRzwuGoCITzfei5W+M6XYtFxYo7gdUx23PcY9E8+UfJUozShoGRYy8rXcQedjokoA5mih7sMWVXptTMl5n6myDDB585RIWjA/3tT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709467; c=relaxed/simple;
	bh=7HCutu5V1tEMLLJuWH75WdYsZhx2Gy0e1Eyzse07MGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+A3INK5ZEWVIiKbcvVySwlSMPJ55izKvy9d7BaEMS1nMJ5KPLx0Nl6pN410uwrNItz6NHYGv8IpyaioqaBQ8AE2xTCF9r0TPbt8y3bQCS0/Ju3mnMTp8NXqENSJeYLOM5MO4MJqts+bRY3bExDqaYxASmVmXnb/ImoadJ92FlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFfnPw2R; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFfnPw2R"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eab7622b61so69945a12.1;
        Wed, 23 Oct 2024 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709465; x=1730314265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llzPsYMDio+juWcpy41b3leKvBSZVCTZl4jDaYEj0IQ=;
        b=FFfnPw2RX5SCbdyidbPVlsG23arOmUCXNL4e62JTpSv1zNPOHYAOFqg7iAz1r/U1eF
         rwWv2qK9Icqe2H/Qp6uHNLvJq00SZyYcr3bWJlqAfZf6NlYu802bD0DsdFXlfDqNFbwV
         1vONasUwv8KV/wYoX3DlJxaqrkdCcTOTvJKZDbmc/wZeViYCszo9K9c4vax7n82kIIL1
         ruaTpu5Xv6gXs9tOlGIx4wgtkdv1LcaF3q7AhPYVIkSsFkbwsgQM4WaW7GdbScHbJBjw
         2rHGq+Cz/6vZS/7+sccVmqA/a28CHkU2LBn1b6HWGwMPVhJhEn9URV/I/2rwJueAbWLU
         cEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709465; x=1730314265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llzPsYMDio+juWcpy41b3leKvBSZVCTZl4jDaYEj0IQ=;
        b=b25j3w10y2ZXp+RkOuQ+tx9W5ralCwwtJ2tpML7S9VUJcBiyxlQWl9rAZgfwQJoAep
         tuXMzRqTzt4Fsm8WPgRmmnnghgvZRD7rxHWC6S+8LlhlxUc9CV5MQ9Fbi32GqVQp9CSx
         3Hxsvoa5LghIvBDjUg+Mb8RT6ozYRJ6/37zhPij90WMFWXt5J0f3WmkYJfw5UfPpTAes
         R9/9jxmDASpm5oeFeELqWTCDxHfmTEXTxxalFiao/qNm2PLlPM+qFEKgICyQR+m1Vtt1
         xTF5dTRQ/UTPSS9kKmlQF9lhZ0CkVeqDR4vhHUuSfnH7bMXPBM4hHt5VcUatFBmwcYd5
         K9sg==
X-Forwarded-Encrypted: i=1; AJvYcCU6j72HNp62w2esniVdyDdm3sgT4JSa1iV2m92RabLSdaYQjeocUEmpBIU/NdsyF7Fodpcuuh2lWLEKT05RCXGHk6Ry3DT9@vger.kernel.org, AJvYcCWHkw+lHV2l8X3NrU6l99aUi43doyfwYJcvIL9BY7tjwkdzZEXLVkeMpRhuLDC5IGrDxi8fhw==@vger.kernel.org, AJvYcCWt2EVI/FWPWxqWKkKeowGfOiIZFkY8O20NHceI35O1Q3DvpIcTJn1IpYDVy1QP0fgW86wVgJ+TaxK/Jht8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwzj2LMqm8O/Hp/MXtp7mDD6TPsEftv2MVi9PvdXTT0MskA4Bw
	Tu2fKcaN4ZqnUdmfKFxGq0bjW203qNgdlJu2GC9UYgZBDI4ziY9E
X-Google-Smtp-Source: AGHT+IEU2f/2XhlFsKHFqx/c77/+YwpYaDuXVTFxIKVwYIDWVILQjYJG/S6HhGZ0bYpyvYQCeZDJhw==
X-Received: by 2002:a05:6a21:e85:b0:1d8:a7a8:8b71 with SMTP id adf61e73a8af0-1d978b10e4bmr4668363637.11.1729709465136;
        Wed, 23 Oct 2024 11:51:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffb8sm6718974b3a.50.2024.10.23.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:51:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 23 Oct 2024 11:51:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT
 is set
Message-ID: <7751320f-cad0-477a-bed0-923dadfcf1cd@roeck-us.net>
References: <20241022161009.982584-1-mic@digikod.net>
 <20241022161009.982584-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022161009.982584-2-mic@digikod.net>

On Tue, Oct 22, 2024 at 06:09:56PM +0200, Mickaël Salaün wrote:
> When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and the
> dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> are found by the linker.  dump_common_audit_data() should then failed to
> build when CONFIG_NET is not set. However, because the compiler is
> smart, it knows that audit_log_start() always return NULL when
> !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> a side effect, dump_common_audit_data() is not built and the linker
> doesn't error out because of missing symbols.
> 
> Let's only build lsm_audit.o when CONFIG_AUDIT is set.
> 

CONFIG_AUDIT and CONFIG_SECURITY are independent of each other.
With CONFIG_SECURITY=n and CONFIG_AUDIT=y, we now get:

Error log:
arm-linux-gnueabi-ld: security/lsm_audit.o: in function `audit_log_lsm_data':
security/lsm_audit.c:417:(.text+0x5e4): undefined reference to `lockdown_reasons'
arm-linux-gnueabi-ld: security/lsm_audit.c:417:(.text+0x5e8): undefined reference to `lockdown_reasons'
make[3]: *** [scripts/Makefile.vmlinux:78: vmlinux] Error 1
make[2]: *** [Makefile:1178: vmlinux] Error 2
make[1]: *** [Makefile:224: __sub-make] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Guenter
