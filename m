Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB401F1507
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317751; cv=none; b=H+Qib7tx1jsIv8rhKTvmkTw4StDBDwWVadk1qI7BTr2NpAB1NZmyZ/Zwt3hsOMNjF/6k7ZDD4OqHAcaGMYR7KkVQ5mM4Yhs5sSuTEXObAlXGMl497Nof5VVBHqdaDSiXFFdhCukkF8ud8/jpHBItGuw3ZVpJwL56KP9sAiePBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317751; c=relaxed/simple;
	bh=OtKUFMsCCXQuyXdiECTB3D04cRKpceApukek+qlG2Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0Cy2ukTBjk9dE8auNMqkx+gnYu9a0UCyy8OVug7dK/xWGCmjgujdzYE6Ir8JtFGPG4F5TwE2EmvntiMB9c87MuZUXRneF9WpuQ83IRtN4nHQ51iE87N6Le+DhxC4/0LOtWavzXHAgHZhVIjZb7TexKKq7Pv8l6dRv2OymGWvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com; spf=pass smtp.mailfrom=inventec.com; dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b=QKymG9BT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b="QKymG9BT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so5171306b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inventec.com; s=google; t=1745317746; x=1745922546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtwwt/qGVMfOAJ61/DZj57iTfzywR/wMkolYpyXZwMg=;
        b=QKymG9BTaQM/G9cl6fJZmX1DLUhOVviZlTuu7TEKn/JLEzF1C1oBOCeG7qYH7i9fmv
         CX1ciJbvdYkLqUj2qDmGnQjr/NjYTseiG3TQs9jDGD1q75jhbpXyx+IVe9hLIyKAJuPN
         2Wmrxxc+WlY4HnZnm3acXCvQpv+RaD8MA9EbNzCN0tDgwmdZa+b260/7OkQGncMoh8Jg
         diTGNiXX/w5uoOpGcerSSWr49haDExVjHl4FRYMKUc6ZXU8WMHjnuGMPxFEUJCJcTPq5
         N2tAJjHRQg1uuUoaPIapfIOu4YcmWjvHdyCZIFwGMwu68SfMqasogjvnZPE6J5s3Nh1E
         yjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317746; x=1745922546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtwwt/qGVMfOAJ61/DZj57iTfzywR/wMkolYpyXZwMg=;
        b=SZsUyDluitbS8FjBEzQYuccMMwNm/eVLk51mrCrLBHGrG+Res12VsXdXeCi2yPaP89
         K1OSRob5K7DN0+jobNNrM+IMZ26BdgQ5wMjK7aeVFiCm+/V0VvfuUS7U48UxsG6a6QeW
         La01OsiaOmSM2t4CDzPxuMSjFOisE0sLqIfXPnyLo+dKj6QXhunSPy1m1tXdSulXWVa1
         VoRoYjK+Zh+0KJzwP5UXwbMtqT6kHuPpMiBfbf5TNVMn8E4AAboqZ5biQDvP8V+KHO7k
         lBi98RKPHzI2Hoi+ro4LXJ06bbNrRtMbYok6qlV9d7cNb32CVYiMvavuWjCcT3piMdA2
         DcDw==
X-Forwarded-Encrypted: i=1; AJvYcCXMxi2zuRKstgzc4PkJ+fv5POBhIn/rLraYl/sAboTJxGf9XfzRMQ4hecTQpx7Pu6y6x6GscqH9Rk07bpQ4xzCgvdJ7m2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAhPFZlTVqf3q5a4fWlLjB7BjpMhKgb6jsm6fE/3aNCpy3lgq
	HV0WSftMTZV393hR1+7xGjG7PqorJuDBBhTH3ffZCBSdMTf6lfRpIzfH/7Urps8=
X-Gm-Gg: ASbGncvcj6UZxcToyOYYH5zfkKY+cIVJj/ku7rFacWk8Np41w+a4R3r4KRmKiBTGxiC
	G7tdzwFldaJsr7HKgayMb8+nxth2TRVs5wJ1iJVf2zP71dlsWMau/mM1dM095e4gAbK8c9e014J
	GgWbPgIbA02xQCoJOLh06RqF2BRNq3nzImkYWZ0Z6s2XcvtkYovI6NLDVXLqUU0dldRS9WOzqMq
	OhEpj43LPv7RyYP4yZ0mmeVh8Im57AAf1/PJVXxo0f/nZ0diRTP+7XMBOQ+zmDrRBJdLfJ5Y8JF
	aZatPQG82STvlaU4odt6nK9V4oS1+Ifl1hc4OJAYj/DBoU6i8taRfOA74ZQUyFZNvDjOWU9nxPC
	9ZNgzSy+7y2f/iivs+w81Ota1BWjW8MZC0qMF9HpnFBDDjYwNhlRLTVzRSH4=
X-Google-Smtp-Source: AGHT+IGWvQiFpLLb/JnK+vxMBI1uFfmAhPCio9warje9sSHRSfH/F8j7WFctbSygpqJcvFqmOTJrmg==
X-Received: by 2002:a05:6a21:3a83:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-203cc6e03e3mr20985847637.13.1745317745940;
        Tue, 22 Apr 2025 03:29:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-242-163.hinet-ip.hinet.net. [60.250.242.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13c1c40sm5541763a12.33.2025.04.22.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:29:05 -0700 (PDT)
From: Chiang Brian <chiang.brian@inventec.com>
X-Google-Original-From: Chiang Brian <chiang.brian@inventec.corp-partner.google.com>
To: linux@roeck-us.net
Cc: chiang.brian@inventec.com,
	gnoack@google.com,
	gpiccoli@igalia.com,
	jdelvare@suse.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	tony.luck@intel.com
Subject: Re: [PATCH v5] hwmon: (pmbus/tps53679) Add support for TPS53685
Date: Tue, 22 Apr 2025 18:20:57 +0800
Message-Id: <20250422102057.2846899-1-chiang.brian@inventec.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
References: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3/14/25 10:44, Guenter Roeck wrote:
> On 3/13/25 20:30, Chiang Brian wrote:
> > The TPS53685 is a fully AMD SVI3 compliant step down
> > controller with trans-inductor voltage regulator
> > (TLVR) topology support, dual channels, built-in
> > non-volatile memory (NVM), PMBus interface, and
> > full compatible with TI NexFET smart power
> > stages.
> > Add support for it to the tps53679 driver.
> > 
> > Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
> > ---
> > v4 -> V5:
> >      1. document the compatible of tps53685 into dt-bindings
> > 	2. add the buffer length as argument for %*ph
> > 	3. Add Changelog
> > v3 -> V4:
> >      1. Add length comparison into the comparison of "id",or it may be true when
> > 	   the substring of "id" matches device id.
> > 	2. Restore `return 0;` in `tps53679_identify_chip()`
> > V2 -> V3:
> >      1. Remove the length comparsion in the comparison of "id".
> > V1 -> V2:
> > 	1. Modify subject and description to meet requirements
> > 	2. Add "tps53685" into enum chips with numeric order
> > 	3. Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81"
> > 	   Add marco "TPS53685_DEVICE_ID" with content "TIShP"
> > 	4. Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
> > 	5. Modify the comparison of "id". It will be true if the string "id" matches
> > 	   device ID and compare with type char*,
> > 	6. Add the length comparsion into the comparison of "id".
> > 	7. Modify "len" as return code in `tps53679_identify_chip()`
> > 	8. Output device error log with %*ph, instead of 0x%x\n"
> >      9. Use existing tps53679_identify_multiphase() with argument
> > 	   "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one
> > 	   tps53685_identify_multiphase()
> > 
> > boot-log:
> 
> This is completely useless noise.

Sorry for the delay, I've got the approval for posting the boot-log from our 
customer. I was afraid that there's any confidential information in the boot-log
of our project. So, I decided to post a boot-log with my laptop then, and I'll 
append a new one once new patch has been finished and uploaded. 

And thanks for the suggestion of adding a buffer length for %*ph.
The kernel crashes and keeps rebooting without adding that.

In addition, should I in-reply-to the existing thread or create a new one 
since the dt-bindings should be included in the same thread as well?

Thank you.

Best Regards,
Brian Chiang
