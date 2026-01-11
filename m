Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89B13B58A
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768167655; cv=none; b=dKgG0OE/S0nFRn5tpLUaFlvzDJsidJwa3r2lfNRtylckwNgwtSenUM38yQxn/V/xiipNVd7Gct9FJx5+uxk5MieDkQlOWFDf5ByY//Mwkcz0xvfUV5Gfz3PWOvmChymMULGprAlVGeNYuQnxJE/ccx4l4GeF0KDUyX7bUyAd0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768167655; c=relaxed/simple;
	bh=GEGYWjnQbAMn9kptVVwoZwMmt1NT1fy76vMD0FxJH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rac1KzKLSpB8nFqq7BDp1DrBmR2D0+PFiaiAkaW/uGeHyZ9/gKhLjWJnCc81WQdFmvbpCN+pg1TeRCo5LvREV/6a/HRnevF4iJVuM0ubNUKL8tRBwJgj2m4G+B+Baq9i8prQR/kvt6KVUy4n6D9azese/IIIw+oaURKev53sPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkKHYSzm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkKHYSzm"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so9930463a12.3
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768167653; x=1768772453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+SJsvIsMUiZ0ObB3JV4V2N/2dbn+ZfM37bgC/bNAqI=;
        b=YkKHYSzmDvBx12VQbMWuDe+P2JViyC+Q9ZVMUwXdCkVMEhc9TfEfRSNsHKaXzR3kom
         DwJYF7Hq52apl+4OTnm5RRff7hr8a63GpZTkX7VCn+UFIbKRFMipadA2NSNCHC2B4T4p
         tUE50LRDqL8LgxL7leN5ng2uFLX+Ia/yXeiq5p1W2W/HQ/DxHlYjRr6sYxQpXmGWQXig
         DqWBRBrZmB0zXizTHkn6izg+hdXVvlNs77lq/sbTnRaFyCEcRXCdOshwX6swax9kZnSG
         ly6w1FZBDrh1rbnxEjHAepGTiEv7d2USUVhPOida+vTE2ZSad5f0eZIk485RYFlxHqzK
         To4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768167653; x=1768772453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+SJsvIsMUiZ0ObB3JV4V2N/2dbn+ZfM37bgC/bNAqI=;
        b=JY3L/8Y+XCJ0hAmf8KQ4hMORsWlMCWKT12mjZqLQN/az/AtZYC8wzTu9jBgRu660yf
         yGhGj6tvmvGvRPrQ1eyUYN1n9fSo22d7dkpsIyqUQJBuXqdO5TdgnsB/IgpwZzxdcI50
         3RmI+zQJazL2q9b1viOSdTcOxWvPrR84SNp1V4xyvn/UQkQZgq0SFOPGNbR5Qy525lin
         k+lr65L+gfiWeCXinWMS1R5RoCXQ9OC6W2ZwRPAJXh7AP0oVRywXd4JRqDib268wIGe4
         MmgQTRV9SDR2hhPsWv+Mvry2Uqw6OB4zAZ081qtXZngvkC1tBLmAykwtWDHr1OYdTxAA
         7Zmw==
X-Gm-Message-State: AOJu0Yz1saJ2plDZC5Bh/wrzbtCcJek4hJW8k4FJc+aj0mjZQJiu06qS
	7Wk+XRQF81fvINhfSR4LG5HVSsfbCYivS7TzAg93MVM3JqKeUO3+W4v3+8xkMybf
X-Gm-Gg: AY/fxX5ETf5QpWSg/yTocLW+lwy4iQzuxqFX4x8bF1CLz90HrZ0uK5bnl1yyM3YGWB6
	/gCshx0KqXfuEkJJAjV9LpxWRjGB8QQ27QQ+cskKIEc7VuJYyENQMYNiPUgf2EEYqFol/UDvQ1m
	MJfbePm7Pxw6cordATOhKqYVKsLqa6weDkzrFoflE/M57qgXMSuDWpVRRYOjEPZwHYJJccNsQxc
	jdzYShxVebexofsfawVyCEsPzz9cr8TSVaEOx9XNm+Nf5zGbanP3i/ZQMsjYeHhf2yr7TCfyfQj
	voBI4iCc/ZvYe/9AXc7OUHvOTCdQ7WxQ77p05BEi81KpeFU/7DczzucGJM91iEYlDAS3XGWTc3b
	Yxx3in0C1VUgYnejqFKRPX9qKW9JIG4bCL7flmK01z4yWC04ZFupwieA+IGc4U0CvghDu4lPuRV
	kEuSDRM+YA7qi8dyFk6joSJGE43jFfoOE+D38T
X-Google-Smtp-Source: AGHT+IEBVlwNSXYpaQd5Xzul2GC/Xw0h44/j28qD9UmUGcccl33sZKH5ONyqq5ZK0QJfnQbvWc2CpA==
X-Received: by 2002:a17:907:c06:b0:b87:2410:5961 with SMTP id a640c23a62f3a-b8724105b15mr20880766b.36.1768167652596;
        Sun, 11 Jan 2026 13:40:52 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86fc303d7esm480021966b.2.2026.01.11.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 13:40:52 -0800 (PST)
Date: Sun, 11 Jan 2026 22:40:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 0/2] landlock: Refactor layer masks
Message-ID: <20260111.77ede31adfa2@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230.d4bf391b98c5@gnoack.org>
 <20260109.au3vee9Eisei@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.au3vee9Eisei@digikod.net>

On Fri, Jan 09, 2026 at 04:59:19PM +0100, Mickaël Salaün wrote:
> On Tue, Dec 30, 2025 at 11:48:21AM +0100, Günther Noack wrote:
> > To compile it, use:
> > 
> >     cc -o benchmark_worsecase benchmark_worsecase.c
> 
> It would be useful to clean up a bit this benchmark and add it to the
> selftests' Landlock directory (see seccomp_benchmark.c).

Thanks for the pointer, I did not realize this existed.

I'll have a look for V2.

–Günther
