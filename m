Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=TROf9jebmM49z1do8d1NYnwPsiar+AG030uCksFMPH45GnqrgNm/WeSYwq4PTfhPlUsN
	 Kdjke+0fr8+/XkXsPoJ9At8UTQk+wxjvT92N0MwHy387P3bpvZrRADIi+4GdXNi+jUpf5
	 KhRhSvV9/LglcDyysjMyZiwRgS5q3tlXxKuF1RsNQo9o6BQma02LsScmtr2PV1sGTAZ5d
	 ZkKadBKJ+AlqPKZP7K0QAqBJY3/PcTlz99WrO250EhJW8SI408/uorvwBTOJ+PTnB5ZUV
	 XTQFLE4GmJQOZ4bnqQgaXD5mKZ3OlqvoBzus8WNnzWVpYCzT88wb/I2RbcZNmvK3Bpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=oSh4igaFFxBgmqCzOSBQJb6pN4102gX3CJ3jZLWmI/1Rh+ZdOOURT58T27aiSdJvvSD7
	 +Flt8lBv/VT3O5YLGY3hcLyxpqRbttoFsfbSsOxDZSq7FfgpnA/om8OgCConBxJoBtfH3
	 Hi0aHUhWNMmK9Tf04CHMlgPO+zQTCYae7Oh7BcPcbad8NpqwDWK/SgrsZuHViXgAAy/N+
	 rpbIxafksJeVpPNF8rtDqM7XKlUlTZxB2NI5X8yrJvV5WeX23der2TN9F+9ytPgGw8xdJ
	 imAHQnbXCbE5wj4C/RHiaGwBwoJucCvgUbbB6g5eLbrKuoP+FzyuFtj2lktNBuoBtPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A7609765E
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C84A7609765E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-19305bcb72cso1062201c88.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=MBmy46k9mIV+yorkexD/OyuT0xC2V5m8wIIGGGrpw4zWo83gU5p7ZzM/6sAFlJ9w48
         dRiQIz2GFVFAuwWfpJwDxIIiv/Yrq4goo7YLOOGmaBIrtp7TE8SRbPKGtmCZ0yHkJBOb
         LJj6oq+683ybRXO0wz11Tkx9DgS6PeErkWmcfzvsEaiwLM/2edpNuB9ndIjI1NUkINnd
         OF8lMIVH7OjhO1YS1cW8JzylCaz4l6COGnEIvuTkZUFOQOETjxZ8o+JJgqueTbvS3F8V
         enCHSzTB9Js06DioEE/mYoh+jE73QrPHK35bY45k9Z2+yVL3DaL9GCXIaPbMwMdOCgMU
         mqeQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+zTv2GiA3Jz9iJo0sk49KjUQ73hOuHCBlkmu8mI2XsWRBz0d5PeNgY6jCcUJSKZri5a1I49NI7gGxJaXL+xpF9FKiV3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nd9YvbmYD/aMaQnozRgmUWpCikDA7Yf5iLfWRgyuKJqEvBW2Y
	alqhYLEl/4hY/vTDoQo8Ok+/cb9XN1SrdnAfn2WIVrnaFd3vWyEPwI8=
X-Gm-Gg: AYBFou3D4L+nrdVJKf/ynr3NOERkqxY3v5yLNm7MNFnec+YDk2WWQ0JTpg2zKHQikMi
	f2MGJG+fAZIqICLemI8SYks58VHw/hVYqvJT168UIfw2pAzQEJHaM1Yxh9CnXhQsHkH4Rce6lqd
	NH+tahXKicfQJjjQ9dFWQgl+XvOJXRufOg7b9ccD5a5c4nK6I9f5EI9llcAOGtnKfj2+PxvrMn7
	n5hdkS+RmlAMfrt1+hI4QBxTFiWsiOcgmMv6fVW1b0uy3bNKwZ52u0I0TkG1+sjZTmhNDRLHVYz
	MKkyopi+RjuALB1X/hp2yg8vrsln3TMu0q4oB2343HQaMXrwK4/mqQ47gGCllhj1NJLVj29LBw4
	b8dduBdFESJtOsi8J+JPKKZktObOuGdnye21NZc2COlny8BpxxGzi6m1D7TKhl3zSwMv/mxZxbn
	EONZFpNPz9fg9cMCcd9ObGsdtCXaqVbmjVj0kUdmqeddIVDe6pvHWEeKi8JviAHsEfiaZcgqy7y
	NPemxUhjTHisJAJZ6uebHx3TNkV7NaTNGbuk/YKGjOb2kzIwm2REp8kW2kNU2p5l+IS3CKEFDLs
	VBWLUgYFiYrcaRBs3ijQBL+qf/wWvfy4Pm5UH5aysIrSlXCIt6xbx0VRJ9B8wl3n
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
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
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
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

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
