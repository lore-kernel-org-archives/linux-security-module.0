Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=azza1+03QkWOf6IOEGFk3jJ7IiPxHY+M47dcrY0y6nSEKV0pyC2siuq0Cd+06nPO29xv
	 5tI+/58B5SNVGKoJuFuv2hxrQ4mI2QfB+kezoKySjZ0OeMGmXhALp6ud1ZIABwjkAvxvW
	 bV0B3cfWu9wdL/25r0glthI0bN4aCx2D+Orc+4TalTjjo6l05DB+yR1/BOabA9w350C/2
	 gxcqgvXdRDscKijd38SuZhK6MIanPv+tiPYDzwuNwAV72oWijabB6ZJuGy31RwYvspsXN
	 vKim2w6HOUTYshrHKDF9a0QEkpEmGuFv3VNUSJEffJwe7bA24cH/h2lJ9cXJ5oVJfmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=ACveGX/eJ3YU/6Sao74f4OzGkfXBLiVbYO7iS+D7Qh0OFotzY5UuKzTYGoFZWtB7GbAx
	 W1L2UiMpJVhkZto7iIB8z2wXBW0jTSUF8KRFcXv7aO4ZoP9tM+gHSXFXte7UoPK2qHT/8
	 ln8ObjznfCrJ+DCSFgJfKuhmp/CRsMO5NYSgZiufrtuOnR3qwJqtDbkIbDw3JAEWmcyLf
	 s409ThKh2ieh4+alYSiaT9DcvKv1mgKpz4LFB3hUL8eTjJnsK9G2bwT1KxENBhexq8lp1
	 IsMrOIUcrGpj+qGw4ZVH1DHllaC4bg0Oxhz4TeG/4mgdAobGyPzYtrNpBgq7TtPNmwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F3608B1CD
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5F3608B1CD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1adbf62dd31so1554463c88.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=rljimjGnA43TUBOsC3zXm3XOoJ6fgsXR/mq8AYBTIJpppyCUksTzUZSF3K1UPReXYk
         JY2A539IkPQsPjleeN/f7LjZ+ng4uvE6ZFQ/vYWpCTFKzrcU2Q3+4AF5AF7Ss/Dq22DI
         afbK4u7/xYUW5GtmTQMc9P2QSMSgtqBGuSS0QiKq+l9x7Lm5T+7ATaz5OX8hw3GxhT21
         OAlBF8Oa5YMdRl8EgQSr3XZdhxsJfXPAQHRdMKzIOVdhRHJWBJ4lMVDdj9kKY7abNghU
         BMvFTbeZGHmvidw06kxprQyUI85KFm0jjGr5YNeGKpRxGkaZ7twGfpP7qh9qAtuzg6uS
         p0/A==
X-Forwarded-Encrypted: i=1; AKwUvBxkGyTzfbQydUtxGuVr59SnF3ke0IKUlnm1VKCDYbvK4wr9K3Buzsv4q/T1+058Qs/miCa2h7EFZADdapFksMJ6FWYSJss=@vger.kernel.org
X-Gm-Message-State: APuU4Z//T+r3F9EWDwq0tZ2TnAVa4A8H4ezjzgwVqwFVCH9XMvL+JeJn
	pLUFtisXd0apA4A+ngiHkjMAUyUxwbLxb6ZNRmgmMuVgi8yRjxtE2tg=
X-Gm-Gg: AYBFou3JCmkJmAmiuTUSbHLQ80ZK33jdIU2MKuOyiiM7f43q8GgkR3hque6B89116mr
	gkl6Z7EBbv5MJ6wIsAH+TZbkecIdEHQmmeHuFdyXcX2/+spf0T+9Pg3XerzJ9pkfZQ9WEfxBVte
	kiDdf6Y6I9gG1g6K49NJbS3eJ/CnFZLL8srQHy0wGMupIA4HE+96ehX8WLmoFRiin/z2pi5e/9i
	VnuZU9a9JqBmGKxG7qadjcAqWo/g3XlPE72GQ9mUTJVmGr34ZM4ZdrxVskmrGrttu8RpF5HNUix
	3VxcyO+olctwb31WJP++IY7MXD4gXHzJPmkmXSt4hRskE/JNsDxY4YWMt1S9niWlai8rNdUMJoA
	E014Qm9ippb+MlsBcAfbLbn2vX8GfSaUMsbrIUBiwC5LcpmSA7AvbCDB/hq5lH6hcoM2RT55cN0
	mKKZHB0u7IkdWBhobhHgv4PPZgGIoCQYMpZOaBJR/0j5b7CYDs1JjGVGsgV9l+kH5ivL2mcwNll
	Ndta7MUaB0/vRdxwAa5jNFcWSi8i2jUg7qN6xKO4wO3LqvCOgs1hYFJd+YwQMnzj7KyA44JFweM
	F6J8wCQ5dGzT3EqlXp6D80qoPZ434cSjO6lyMG9Dj2bcipKYMsz/xwcOJaaSODIe9g==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
