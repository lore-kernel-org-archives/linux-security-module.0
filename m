Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5136826B
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003846; cv=none; b=VptBUxE4q98TbcDR03wel27fodfBMP4XQKLiPLsuVb62SFLxLQ1eOHmwH+tYzI2QrMrlN7YTvQIPDR8E8IusSVNsrmHzX5wXaY5/QZUKVZoJfzPolcXMu2B0L/XxW6o72S23I6WUqOMh6EoJ7UmNSbjmA/mMS1YJQFXWHKmXf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003846; c=relaxed/simple;
	bh=1IzeW1rxSmYCxrFo2Da7k3pGAVhezJz892VmGJFw3aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXh/3u6WT2nhJFrriTEJK6DnNP/33uMJ9yG/9pOVP0wVE5W6oquiZXqw9biKh5BQiLeuBeltdXHXXkvFd1NmD5tMlMT+MXNrODpQUXMJ2YMN0lvcFuTLrtWIAWQ9UA7kmOO5YWXO5NDIkeedv6Y6B1VgK7+TSavpaHiJ5s9o05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji5fbQbI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji5fbQbI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so13510365e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774003844; x=1774608644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1IzeW1rxSmYCxrFo2Da7k3pGAVhezJz892VmGJFw3aI=;
        b=ji5fbQbIF7TY7NMEB1Q/4EWVOSYXHAtQE8yryshs5pWeCt4gcgLeUPJOwQtjL/B+zs
         gqNPe9yEAi0Y/kc885xH18huFi4O/SLyhkcUdTCnvDUK9SWfSxk+aq61McYe1BWXupXV
         a0xe6Rt8Ptzg9gHhYJ+YujcrMzIWJOTE4RwEcbaxOeqoTzu6pbSlv2PD9Ak2FpPyKMub
         V3oQdL/Tehg0bZ76msNXt9cbTfUCdgT9cDW1qOrfw3PoNTclP6xfvBZjTd2neLglrJyA
         6gWvTxKkKGv4+DoPzO2Jhc7mix387lvjG5KeK7BfqT0hg3dqR6+Y+A6GhgRWOzKM8NrL
         sefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774003844; x=1774608644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IzeW1rxSmYCxrFo2Da7k3pGAVhezJz892VmGJFw3aI=;
        b=B6MvxLu8CnHAxBBjfoytypax3XPoX2TlKZd343UREPIpqSAyAG8smp0VWNEjGx4O9g
         SH6nunJdobmWFqOJ0uq9Qs8CpI8lbuvZR9Ex9Rrj8yNp56xeiHD4hzONnHIXnGx1WSuz
         N/3usoUQWrSZnD2HELjUlO8n2afB0r2SpERrSf0NKJifGlyy/npCxIxnWoqw23C4P7T+
         AlPebM2fITLl+TEjc0KNLeyCkQEvn2SL9kLW3TYvVjCMjCGPM29pjJ7oFsIi0ZUIH+rn
         P91f/Hfcaw1+Vuig6sLTi9RC1uh4Wzk8kY8/Vo9CQjLE8KK8F9XwJad+U3tTX37zvPAn
         o+og==
X-Forwarded-Encrypted: i=1; AJvYcCV6HID63LLGOa3XesR09XB4pQ8oa+F4NFwbaE0zqPHMtxAobHjcvIgHRxxPgZMHy84GvP8mIhwlvicdePVo0OtQTQhoM4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6i17+SoVjg9Sr8OApZ6XWD8wfQQ3eODvshbWJGDWGnJ/NKXx
	g0n2rk5NQrM3aMyuR1cFRV+pyk8lRFzi5QQsaimaA40HUE2epYjuzG2B
X-Gm-Gg: ATEYQzwgKoaEaRdpAdtY1e2/yQLdTAsbQ91cX+ck7NS7Pxvt1Zot30/PhNo2R5WO5BY
	TswN2egVGSpmADeBdBZMdYBP2j2d2Wbo/qSzS5OZnSH3Il/Ten+9p6pb/gZ3cc2QTN4RpXke4OP
	HClwFiYCODGVuCW9cdp/El8lzLSM9kRbYXq7Fw4Ykoq4uQEHknJXXLuLNxXSsYcPO7d579fjRHu
	IxEXQUrRk2KUOTnd5DUplCKWhLVESGsEqdykdkyhAZUMdT6q8hI6e8HyP9uCCrwv9wx3HW0FkDb
	OUhuic4HVCD906EWcDcqT/YqBRbT2Q/SR4UVUj+buHpUfgdn75uA8Kiad7OkaedEM7Ih4mHX4MS
	y8PaRs41lZfugqLjzvWSdmbUp3sl+8FXp3FZykbqXPP4wO+XPghm2t4+vplpkEQIR8HheCCk3H2
	8/mqeHmi8Fzus+mnxqUBjMp1zj5f2dax05xF17CT6m9eSuu/Se
X-Received: by 2002:a05:600c:c111:b0:485:3a03:cee1 with SMTP id 5b1f17b1804b1-486ff02119bmr25514525e9.33.1774003843583;
        Fri, 20 Mar 2026 03:50:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm90804185e9.0.2026.03.20.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:50:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:50:41 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 2/9] landlock: use mem_is_zero() in
 is_layer_masks_allowed()
Message-ID: <20260320.eee8131c5ba1@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-3-gnoack3000@gmail.com>
 <20260318.ePee0acaeng8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.ePee0acaeng8@digikod.net>

On Wed, Mar 18, 2026 at 05:52:10PM +0100, Mickaël Salaün wrote:
> Subject should be "landlock: Use..."

Thanks, done.

–Günther
