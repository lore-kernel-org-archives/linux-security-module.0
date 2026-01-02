Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E82DA779
	for <linux-security-module@vger.kernel.org>; Fri,  2 Jan 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351024; cv=none; b=e/39zVc6aZo+DE3lO70nkv9uzvw9eA/tyf1D/A2yc4ef3ctf4/zqIR92hb15JQ12J1SvnqNYJlaG2+Rw1MrNvdljJDln1xS+kUuO0ziTXXtbdHLV2Vii9VPgl6zepJ/IYg4Ql0MqKI7Rk4t459qZfdzzHTDojYKEC1eCWE7D298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351024; c=relaxed/simple;
	bh=O83GhkEVuYhgRPcxM0hdphX3Ss+7zyRD3ciLVWHwEKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeT1EDl1lEV1DDcXtV2Q9zTlAea9aIKhilCq5F329E1qOWUlFj35bhDncILWYQkMwvPO+sVOm7llxh3VMrYt7tAadomQg5H0vY0iJbE0sl7KZB2ZGCaP2zSjFZbsFFP87TrypWpR2dWVmzle5j3B2vAVUlV2ReJ6Bv1964rA5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZagQoC2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZagQoC2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so14435528a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jan 2026 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767351021; x=1767955821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p9mG/I4dInPTKBaMJoLFy2fWU8hZWji8GnwQZo3qF8c=;
        b=UZagQoC2AGYb31e8GtKz0p3X3+vp4TzVlIuVXqiKyb9DgwZjqDhu2V6o5JNNuliHX4
         uJpoWD/Dxlq5AkNWwt8S/+1MmCvZ16l/nbH1Nnkha59SCLlo8qFtddQD34LVN0JOyNZv
         QC2rJC5Q3I2LGi/2LIcOt7XeIE3KoSNAsY7nnAXXutJiF+Fnc8HCbm06A7up5MzT+ydx
         Vc6osbEQrbseEfBg7edE8weIHMikJ1gv3xXjvYKYg+toPSKFOZ+ekjp7LCFjLrUriJA4
         juLhAXV1zneCFb9Oz2NAfoTQBLbPIhpL0ZZDf1p9ycYcu8Hfm+83qT7wv7cromSgdEuW
         2S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767351021; x=1767955821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9mG/I4dInPTKBaMJoLFy2fWU8hZWji8GnwQZo3qF8c=;
        b=wKV7+VzjzRQFU5eCsPBlkiV6NUNCH4m+pQYyLSgm4X3BpThR6mcBebn2+R7F0+Xn9e
         QRTEhWg13eCNllQrO4zRYK7/xQ7qy1AXqKd1kgYy74aQRbuy2mDzdD7GRC5n1T6PoSQL
         J2zt+Wc81rzdnuNnVIj8KCpA7JAPUJWpepNrfXTNq5BfhtCH56vdkj0b1rC6I4E9yqxo
         k+xhah9pZMV+FXrmtI7YBYs/YSJdQdgD7dx4HtplV95mERJn+pkT22jpQuKBpO8xAnZ/
         /wt36ci+qsFZ2aWqOOCNiYNBCXGVNa0Y3NCeGUFrA1QRd6l15ZzhX7+dgHMWXnqF5IzV
         s/kg==
X-Forwarded-Encrypted: i=1; AJvYcCXjaCRuRHbB4ZfdIwPnVCpHzpSfExcQDCevim45dslUoTS8muGEe1gBkul3dhtXdpSsmcK84w0wtplI3XvWa7QJXy+Vr8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5ogZxH/o3AoZrOqjlr7KP4+WD53UvkDhVH59IDsKQffC8EWo
	00nNrljJVrZbXNla1jGZSiihedoMckhnt8FLaO9AR/JIUQK70d6sICxi
X-Gm-Gg: AY/fxX6lnd8H8CE6N0QuDnIrOCRy1XBVMoGQpsAjeS6Ud9RCaGgOBH+eMEm3blMqZ3T
	xvHiSigyUxI0fxOPcWDcxUGwMu6DZkv0uF/AKhpKdkSOjxR+t0XDWJvs1uAW29XmXm3RdFoS2/S
	AYBDJBob/gPNBbRGfjVKG0Ma7NYIdYenrrKsoBhgfNh0PZr8WAAy9nzS0z/nDbuAR0Z59LaDVJn
	MRCC1aif3mQIKHDQMX94pxFutosWpl55ZWzvQbJa9xh+/V09pmnEjMRulhW7lW68qvmYQlw8xnL
	RuglqZI38xjmANdLmr5IzDXREBOlhktD76XF4xHFNfRuyy7rF51edczm2djngW2aBLvIW6dEtVE
	U80QpEDpgStXbVLEz25JTSQRF8Mzu0e3QWgzDtl4r+9kdnDfnFeGNcrDfdAcVNDjci/Zi1zR5PV
	VuLRl4qbrnxCJxfwfR/8pa3x6GyV0o07PBsC0WUU5ibMjnltw=
X-Google-Smtp-Source: AGHT+IHQ6opzTeekkt2bb8Xql7kDUzRESEvYK4WeItlfghQPEEP0qjj5UqMB+Aofr133SAdlFk1ajQ==
X-Received: by 2002:a17:906:6a19:b0:b7a:1bdc:aab7 with SMTP id a640c23a62f3a-b803722f90amr4354290466b.64.1767351020928;
        Fri, 02 Jan 2026 02:50:20 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f512e3sm4522464866b.67.2026.01.02.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 02:50:20 -0800 (PST)
Date: Fri, 2 Jan 2026 11:50:15 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260102.17e1c2b9faa4@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
 <20260102.93e0d7b9c9b5@gnoack.org>
 <81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com>

On Fri, Jan 02, 2026 at 05:27:40AM -0500, Demi Marie Obenour wrote:
> On 1/2/26 05:16, Günther Noack wrote:
> > On Thu, Jan 01, 2026 at 05:44:51PM -0500, Demi Marie Obenour wrote:
> >> On 1/1/26 17:34, Tingmao Wang wrote:
> >>> On 1/1/26 22:14, Demi Marie Obenour wrote:
> >>>> [...]
> >>>> Does this leave directory traversal as the only missing Landlock
> >>>> filesystem access control?  Ideally Landlock could provide the same
> >>>> isolation from the filesystem that mount namespaces do.
> >>>
> >>> I think that level of isolation would require path walk control - see:
> >>> https://github.com/landlock-lsm/linux/issues/9
> >>>
> >>> (Landlock also doesn't currently control some metadata operations - see
> >>> the warning at the end of the "Filesystem flags" section in [1])
> >>>
> >>> [1]: https://docs.kernel.org/6.18/userspace-api/landlock.html#filesystem-flags
> >>
> >> Could this replace all of the existing hooks?
> > 
> > If you do not need to distinguish between the different operations
> > which Landlock offers access rights for, but you only want to limit
> > the visibility of directory hierarchies in the file system, then yes,
> > the path walk control described in issue 9 would be sufficient and a
> > more complete control.
> > 
> > The path walk control is probably among the more difficult Landlock
> > feature requests.  A simple implementation would be easy to implement
> > technically, but it also requires a new LSM hook which will have to
> > get called *during* path lookup, and we'd have to make sure that the
> > performance impact stays in check.  Path lookup is after all a very
> > central facility in a OS kernel.
> 
> What about instead using the inode-based hooks for directory searching?
> SELinux can already restrict that.

Oh, thanks, good pointer!  I was under the impression that this didn't
exist yet -- I assume you are referring to the
security_inode_follow_link() hook, which is already happening during
path resolution?

I take it back then. :) If there is prior art, implementing this might
be more feasible than I thought.

–Günther
