Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AF28689
	for <linux-security-module@vger.kernel.org>; Thu,  4 Apr 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236701; cv=none; b=R1R5Q3C//hr88shtb4MzFsa/aSrn3O3ANA8L1ut6+csHo+9eeiK988Cjv8ONjzoFeowuJ4ooQ9+WHueLzjZkyWi+O/8WVVUhyD5gmeGrdzkb1Nyf5IBo5ymwpurWYaBbng03YNSd9iksYp8Zs5dDP6wzd/Lx2wCeWmXVUdFskAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236701; c=relaxed/simple;
	bh=TNa/BNEOuYD5hp6QjAdEPCaM+Cp1hRL0BDPW82LVBoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+h9NJazYb+hNCg8+B1K7GmhpaSIrTCEZtQKMarM1VXB+mk/FJ6X79zUtNS2WnB6h7PUH8RHXNRmVl3JwXG3DKscKUTjWhTgFvKbtVUMhytXnlHCFwGIQGrzuN656QKCjgJDVcz7eJenC2gD0N1q/UeUQlt40fIz3hznSI8axaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fgs5eawN; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fgs5eawN"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V9MPq3V48zYqg;
	Thu,  4 Apr 2024 15:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712236127;
	bh=TNa/BNEOuYD5hp6QjAdEPCaM+Cp1hRL0BDPW82LVBoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgs5eawNezgekiN6MJ6Znsb5GoCOL2Q4EpWkTH/QQR3qKNOrm7EJ7zLqfBqE2U2XK
	 4zRiTg/gsVyEjwXqwXxIHJe7aHXh/0ZuiMD+oFnNIwz2BDaBXfh819RYVGo+vFOcUM
	 54AFS1HfwpzUXbh8f99R6GOEn9hJe7+i7AdUtL70=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V9MPp3mL4zG3N;
	Thu,  4 Apr 2024 15:08:46 +0200 (CEST)
Date: Thu, 4 Apr 2024 15:08:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: Linux-kernel-mentees-request@lists.linuxfoundation.org, 
	fabio.maria.de.francesco@linux.intel.com, skhan@linuxfoundation.org, outreachy@lists.linux.dev, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v3] selftests/landlock: Add tests for io_uring openat
 access control with Landlock rules
Message-ID: <20240404.Aejufoh8gier@digikod.net>
References: <20240402.MooNaiJoo2cu@digikod.net>
 <20240404121621.9162-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404121621.9162-1-dorine.a.tipo@gmail.com>
X-Infomaniak-Routing: alpha

> Subject: Re: your mail

There is an issue with the subject.

On Thu, Apr 04, 2024 at 12:16:21PM +0000, Dorine Tipo wrote:
> 
> > What is tested exactly?
> 
> The test_ioring_op_openat() function is testing the enforcement of
> Landlock rules for read-only access.
> It's specifically checking whether the Landlock rules correctly allow or
> deny read-only access to the specified file when using the openat system
> call with io_uring. The test does this by preparing a submission queue
> entry for the openat operation with io_uring_prep_openat(), submitting
> this operation to the kernel via io_uring, and then checking the result.
> If the operation is successful, it means that Landlock allowed the read-only
> access as expected. If the operation fails, it means that Landlock correctly
> denied the access.

That doesn't reflect the content of this patch.

> 
> > +static int test_ioring_op_openat(struct __test_metadata *const _metadata, const __u64 access, const char **paths)
> > +{
> > +     int ruleset_fd;
> > +     int ret;
> > +     struct io_uring ring;
> > +     struct io_uring_sqe *sqe;
> > +
> > +     /* Test Allowed Access */
> > +     const struct rule allowed_rule[] = {
> > +             {
> > +                     .path = paths[0],
> > +                     .access = access,
> > +             },
> > +             {
> > +                     .path = NULL,
> > +             },
> > +     };
> > +
> > +     ruleset_fd = create_ruleset(_metadata, allowed_rule[0].access, allowed_rule);
> > +
> > +     ASSERT_LE(0, ruleset_fd);
> > +
> > +     ret = io_uring_queue_init(32, &ring, 0);
> > +
> > +     ASSERT_EQ(0, ret);
> > +
> > +     /* Test allowed path */
> > +     sqe = io_uring_get_sqe(&ring);
> > +
> > +     /* Prepare SQE  for the openat operation */
> > +     io_uring_prep_openat(sqe, AT_FDCWD, paths[0], O_RDONLY, ruleset_fd);
> 
> > Can you please explain what this call to io_uring_prep_openat() do?
> 
> io_uring_prep_openat() prepares the submission queue entry for the openat
> system call. In my tests the call to io_uring_prep_openat() is preparing
> an openat operation to open a file at a certain path with read-only access.
> This operation is then submitted to the kernel via io_uring, and the test
> checks whether the operation is allowed or denied based on the define
> Landlock rules.

This is not what is tested by this patch.

What is the last argument of io_uring_prep_openat()?  Did you write this
code?
