Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85628B4E2
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630481; cv=none; b=qcVkI1kt8uQDbuY6esN93Z13yomcK6ro9f1KJVb8HbdtV3wjSAv2vSwqCIPMUqdik0E8N2J17OoxMEG39JeAFeakvnJVfinb3oOk+uP3dr6COKmC782ZJZ4P5Dm4KyUu9l9yFW/1xxEtjq07MPCXjaO2SVlIQEOeupPZjbX4dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630481; c=relaxed/simple;
	bh=fpPZz7nXNtaA4yT1Wp1apXuthf8RXpr5RMHJiJT5B0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTwDY0xsultAbXwtbTclVpWztO3JMW/PTUQA1ZqVPQn+wIBcne2RPckR/0KQ6NK3U5+E9uv9Ps/3j2XqiCgNyE0HvBbRiZlEOpiQeSjAk6fyX6R4/w+gfISbXCAFgLp33hE0zTGlHKm//JQHtxlsIvQSiEMB7VKYcPssenDH5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NIsXqT9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NIsXqT9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso10547155e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770630479; x=1771235279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVb3ihhQrL0ye7IASHBk+YcT/LYft5g2Zpw+ktRPLGI=;
        b=0NIsXqT9tDoTLOKHxdO6j8oYu8RGFu8GxmrLMdxxaqUZdQLkp179ZHNMqTqUMbz1b4
         R/xG76T2Ef3BCF48zn2BPDwqnU8TWzL30Ov78RvyKI2DEFRKwdVVtfYoq1snfTakrJ7I
         aUeqXpLqbf6dwnPM/SOAmkk8Vnm4t6htB8Aex65U6fYy8GxgGKzbfbHI1J2+YZ2qsQUw
         wNL8gWxbaPfir2IOtTt9IarYKyrF4gJjVMI61dre4Wk/511PpaZVUa17kEQ6XM6JlxiJ
         lkciYrKJMjonk41zEuCjl6clweUDDSDJZm8jO2Ft+6VDFdLFomJ51D4Ok1ID/VD2vB/i
         H3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630479; x=1771235279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVb3ihhQrL0ye7IASHBk+YcT/LYft5g2Zpw+ktRPLGI=;
        b=GTmyPe29onY6bd9QhSeQ3P8BdU/8gKu8w2dGgdVQI66bhIbEeWH5VEdM5Zim8Kq//c
         +P9zShMlZqtl4N3bcKWFI66PXCUSYXORTWaACiMdkBKNWIErJ0Xv6150ikL8tBvmTHMo
         Q58DjbfrYw1mjpCedBrvkM17d6Kc3Dxd3ZiJ5vfJ1fmlN0QfB2s6PVGdfKFxpDUUW56j
         Bx4gvdE9nQYiQNwxqgQ7xxlV+drD/0SRUSv/t09oBFpds57e2UJkE2LbyyM0aDWIY2ZQ
         F1mqErEBsDnn2DidftI+7dV1mJ7BeJ4s1WQPvAQAYstYy+6IW3qhH75Xd1HFdy4pFdxK
         BOEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhfe5Wo2mVDP/ipbAysJsRX7TLRSMTXFnGUTa7iVrkjTq5r7Wa674eGhDjv2z63V0pPHUrzlgNJ+XCcUmPCCv8vW+XDkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cCKrPkF7ib0Tvgk+SXnM9a461vTa7PDhf5iurhWrHqfG+L4p
	dgsFRxuHWDkOpDm3ZjVIGNW6THiSlBNhnbEZoY6uvSRomyF3Sl04MB9t4+p5WUX8tS0WkxGzKsY
	9V5Z9QBMi
X-Gm-Gg: AZuq6aLdLWSM+rz4cKhpy/Qeh3Tem/kflhTWdktHs9CUwNmRb/sanh3fiwxUEA+4OR7
	5lyo5bee6kW3KWUsG0OHGLtPkhtLZITHcb9fBVHoCluqzKv1p7+kXOWGA1ldMRdsf2C47jVGqhg
	9eXAbb83wPzbfJ4eR4Ovc2tfc+D+YN8mMk3/GNs7xiBe80ud04FNjwOIRPlWaQzeQ78gMOHAdrN
	uLZoTpn9mt/6JbOe9ZQnvpc58qgQmWYaqTTv2TyklEkSIBbPmOtwXmtjBVgV5iw0cZvuC4+phn4
	2H9tnfam6k4lbmWSnCLy7PmAXyT1HqxbA5akLQCslA7sCYZRTL6+U84qBdsoKj5X1A6KXH06jkt
	P0bRgpkS6xUbBEcMuJH4eox14y/XfkW1umzfEZ6x3aOLzSko5jyMPRvx1D0mJmbqbZ4Gl1fLr3t
	qKkuqXzvsMHFsb/za1hIIUtBU6yV1pvt14c+iM+OfF
X-Received: by 2002:a05:600c:3e18:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-483381e473dmr61917825e9.2.1770630478937;
        Mon, 09 Feb 2026 01:47:58 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:4691:a1a:ffd3:5695])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25d5sm26361145f8f.2.2026.02.09.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:47:58 -0800 (PST)
Date: Mon, 9 Feb 2026 10:47:52 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Add counted_by and fix comment in
 landlock_ruleset
Message-ID: <aYmtSHwoCdcek4Ev@google.com>
References: <20260208235449.1124354-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208235449.1124354-1-m@maowtm.org>

On Sun, Feb 08, 2026 at 11:54:48PM +0000, Tingmao Wang wrote:
> For a domain, this array stores the access masks for each layer (of
> which there are num_layers of them).  For an unmerged ruleset, we have
> one "layer", and one element in this array.  This annotation serves as
> useful documentation.
> 
> This also removes a comment saying that num_layers = 0 for unmerged
> rulesets, which is incorrect (it is 1).
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Reviewed-by: Günther Noack <gnoack@google.com>

Thank you for fixing this! We should use these bounds check macros
wherever we can, IMHO.  Removing the remark about num_layers=0 is also
correct.

—Günther
