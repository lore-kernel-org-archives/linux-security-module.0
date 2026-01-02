Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715A2D94A3
	for <linux-security-module@vger.kernel.org>; Fri,  2 Jan 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349000; cv=none; b=uwN0R0vz1QYqVtxVpRuthpu0UD760CxWj3aw+/cRwFdi7IzKPwbx3eALC1CZp770qDaG9ukPPr9oLQxvVC5NO8phP3gHBuGcJX3izOJS2Xxa7dv3ShrXzz4ghGLZCA0RuMoO0jeqw2q3xDN/9Ss8+HgKosj5B94E5BetZ+6XTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349000; c=relaxed/simple;
	bh=P/hgVsqz40m4e3AGATUtgVIP22TBOiVhLhxr89IKnQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtjGTCBHAMBt8sFl0odyGrrVSaytgyDm2o59qpDeyZnVXhTwiwt1i73UWH3PIl4+gENH+psEk13c5IwvVhAE7iiyM2/0bAvPhv6pxH3kP23yBBA3h46KovLN64t0Bm+P3AaurHbYTkn1DxLVbKdW5mBf2At6t6Y/iQ+3jf3QyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0ajpwAU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0ajpwAU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so1856539666b.2
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jan 2026 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767348996; x=1767953796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ccugoyLVHZhP80SRdOhjFMBmv1AEWrWcM23ZyuMBruE=;
        b=g0ajpwAUPIvjANVLgwNIqazCYuCq4TdYFgI89hYpZbvLArOqlnYRknXIDGhk6/6RGb
         TaV9UOTc9S0SSxVqV6DTLHDtXc4MF3+I93qbctV3KsQeM1DCAy01Mm9gE+o9vtKMwptw
         h4kVoxUQ7wDz4Pq+T2ID4PNz4XrBowCIH5PgjTlYBgZliFuo4/Zkmap1ZLSzLZr/2UUY
         Pko+uXAgkHEUw39a2V3pQ0MoGFhA9GNyHZRO3tzPfBDQ4D6jGyPF7xme6UzcuH6eBuR/
         RpRnGzOEaM2zn6gihSM6r5V0Mday8yh3o/LxG9B+uLRUuJIClJtt2HiV/8T9sEMWGKb/
         Zdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767348996; x=1767953796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccugoyLVHZhP80SRdOhjFMBmv1AEWrWcM23ZyuMBruE=;
        b=A+GC5hflUXMA5HOlIQ7iTzeYq+7anZNqCl6QUaw1r3YiKZxv2tU1dvk6jGGQoQBNWz
         Zhx4g33fp6AZMhS8R0IzkBqpvF6tapoZl9U8uwU5ND+ChFWQDplhtNcBgH14xYvd8aQO
         eouHbEohtdPSL/A79mqkTk5JjTqjyXdGHtly1wSawLSQU+E2MY3ljaWYx5oPIms+25+r
         iwMMDVCo5y+KB8HoUvx3pyObsWSSI9XQl72POj27zu52Y9I8a1qocdOb26Zp86EvHulH
         slxI1hgl5/W0kZvzQRr8csKMLzxE0l94/mjeJu8KrSXHXH/qKyjutnt5rmIrqnyIHps5
         wGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm09BdW0QVS0Ukqrq8Q4ZY91vmwo6Fcflh+OB9sZHFYchF/vaGzlLAJ+KtKvNdyI6vVX2s+ETEbPsR9f7VgAuEcb+qbL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUTmx7Pp09lgSeIcDKmOyW8Ipd4ODfMY41oiSlFmFBy12zj5I
	Ub1jTRsXe3hnp+xcJ48zsg7NMVmBhxsE8/NY5QyxwjyJlEGoAwzdPwEQyHIe/A==
X-Gm-Gg: AY/fxX7cxJWyx+tBSpmY7g5IcY30PD6k7hP+T1yDIydyL6+3E6YR37t+BYfNrt6fJl6
	XTVhZwwZRMa6BA8wwpsp/clyJ8i/86rUrdsbl9ItTEafJUMC5jGNOt2A1mRFDvRLqY/k5PrO0UU
	1FFxOAB6t1D9lnY/gCsxekhiVcH6ejHCRUVGZ8/3MnFt+9TfYRWSDl8XV75oHVFm3NIXc+AxM07
	BSaMaw/qNCIsdTyHroEBDG3zE8IwTd9Z7cifBaDK7vAUrjKaWbFQfDcVK52M2NyvZr8GfPr+FEJ
	LxXNHE526IrmG8LiN1XSiVZVGrqO6rF9OQv273TQKf7we5diEKfCoE8b7Sqls5JYYlv84iaMDCL
	56uP2OSLPsomT1qbcfhR7Di/IxLB5Axe+49ETOMamGzF4gFBYQc1ziLQ3Kw8PxeO15CSS3Y+kQw
	IBFoEsOcJ9rQZ6pg/tBjkve7S+l5pGzATOMsBu
X-Google-Smtp-Source: AGHT+IGq2heI7TijsW2yfavdvKa+RzpuPZnukegz6SiXGzzocS2JZVsQ0F2osb7Fps3F137g0nIxqA==
X-Received: by 2002:a17:907:6d1e:b0:b83:8f35:773b with SMTP id a640c23a62f3a-b838f35775dmr1089547966b.54.1767348995677;
        Fri, 02 Jan 2026 02:16:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de004fsm4613001566b.45.2026.01.02.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 02:16:35 -0800 (PST)
Date: Fri, 2 Jan 2026 11:16:33 +0100
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
Message-ID: <20260102.93e0d7b9c9b5@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>

On Thu, Jan 01, 2026 at 05:44:51PM -0500, Demi Marie Obenour wrote:
> On 1/1/26 17:34, Tingmao Wang wrote:
> > On 1/1/26 22:14, Demi Marie Obenour wrote:
> >> [...]
> >> Does this leave directory traversal as the only missing Landlock
> >> filesystem access control?  Ideally Landlock could provide the same
> >> isolation from the filesystem that mount namespaces do.
> > 
> > I think that level of isolation would require path walk control - see:
> > https://github.com/landlock-lsm/linux/issues/9
> > 
> > (Landlock also doesn't currently control some metadata operations - see
> > the warning at the end of the "Filesystem flags" section in [1])
> > 
> > [1]: https://docs.kernel.org/6.18/userspace-api/landlock.html#filesystem-flags
> 
> Could this replace all of the existing hooks?

If you do not need to distinguish between the different operations
which Landlock offers access rights for, but you only want to limit
the visibility of directory hierarchies in the file system, then yes,
the path walk control described in issue 9 would be sufficient and a
more complete control.

The path walk control is probably among the more difficult Landlock
feature requests.  A simple implementation would be easy to implement
technically, but it also requires a new LSM hook which will have to
get called *during* path lookup, and we'd have to make sure that the
performance impact stays in check.  Path lookup is after all a very
central facility in a OS kernel.

Regarding the un-restrictable operations, Tingmao's pointers are
correct.  In the warning box in the documentation, the missing
operations that I am aware of are (a) the Unix socket connect()
operation, and (b) the symlink lookup which happens implicitly during
path traversal and which Landlock and other LSMs can not control
through LSM hooks at the moment.  (A symlink always gets implicitly
resolved during path lookup even when you do not have directory read
permissions on the directory where the symlink is.)

–Günther
