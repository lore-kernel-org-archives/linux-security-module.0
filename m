Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79683112DA;
	Mon, 18 May 2026 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096666; cv=none; b=pUlCBQmxZh7xVKPCUriji4JOlPJ54AtiI4tRjVxRV258TEyxfbCgnISlsG4Bk1GZ7MkCi4LUub6cPTbNpBu1R+c/cFWX0o+ESl5IT7bpQ1ZmXDlNGIiY+6y3jYyXb7zGkmQOIMlbyAsuVh6D2fI6vpxpmi7Ep81SdnKtJCV4C+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096666; c=relaxed/simple;
	bh=/dYR/di/P91MBWleOcQbzeLk9BRn7Di7RPmN3cGMuGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKsMa/xHFL937EvxhrSN5PEREdiw0ljFXnOuN7atgYQjcsZvfn0zOrHMDKtmfLWu6v9B+KS4xYF6EcTgQoeqkZgCXi4kKYK+FwuaL+B4E9wdCFX1RvSpu/7BbI4A3UbI8hoYoqCGX5AgDo7mFSbIbiU8l2HE9SZ0GMzkMNFl+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SZn0qOoP; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SZn0qOoP"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gJsxB6fq5zbDF;
	Mon, 18 May 2026 11:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779096654;
	bh=Tq4nWFRD2pesMJMgNQoyW5cYEITckzriAVmKWJfRgHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZn0qOoPOdzYJ22SGoQKd/pL9xU1E4r9IW/x4D1naLrEOL5cxHEjiBSNtC33yggMv
	 NusN9MhvK8JM24DpmVA/Q4OeQo3L+wLSuzCsh3LTCtG2ICBdwteRR3ZIaP3NceziI9
	 jSG8eHz7JxhlRG6L7D5eEoPz0ELMMcHIOEg9OfIk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gJsx95w9KzLNw;
	Mon, 18 May 2026 11:30:53 +0200 (CEST)
Date: Mon, 18 May 2026 11:30:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	kernel test robot <oliver.sang@intel.com>, linux-security-module@vger.kernel.org, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [linus:master] [selftests]  465b05bae5:
 kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail
Message-ID: <20260518.ohn9DahGhui6@digikod.net>
References: <202605111649.a8b30a62-lkp@intel.com>
 <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
 <20260513.eeboh9zooQuu@digikod.net>
 <20260518100602-5b161e99-83fa-4170-bb7b-1642df6b5a3d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518100602-5b161e99-83fa-4170-bb7b-1642df6b5a3d@linutronix.de>
X-Infomaniak-Routing: alpha

On Mon, May 18, 2026 at 10:48:27AM +0200, Thomas Weißschuh wrote:
> On Wed, May 13, 2026 at 12:52:35PM +0200, Mickaël Salaün wrote:
> (...)
> 
> > > > config: x86_64-rhel-9.4-kselftests
> > > > compiler: gcc-14
> > > > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > > > 
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
> > > 
> > > I was unable to run the landlock selftests myself, on my machines they are
> > > failing at runtime with all kinds of colorful errors. Are the requirements
> > > explained somewhere?
> > 
> > I'm curious about the errors you get.  They are standard kselftests that
> > should work following this workflow:
> > 
> >   make TARGETS=landlock O=build kselftest-gen_tar
> > 
> > and then running ./build/kselftests/kselftest_install/run_kselftest.sh
> > as root in a VM.  The required kernel configuration is listed in
> > tools/testing/selftests/landlock/config
> 
> So there are two root issues I ran into:
> 
> 1) The tests can not be executed from virtiofs (as set up by virtme-ng):

Most filesystem tests initially set up tmpfs and then use it.

I'm using virtme-ng too, see the
https://github.com/landlock-lsm/landlock-test-tools

 ARCH=x86_64 .../check-linux.sh build_light kselftest

> 
>  #  RUN           audit.layers ...
> # audit_test.c:52:layers:Expected 0 (0) <= self->audit_fd (-13)
> # audit_test.c:61:layers:Failed to initialize audit: Permission denied
> # layers: Test failed
> #          FAIL  audit.layers
> not ok 1 audit.layers
> 
> (The same for all other testcases)

It looks like the tests are not run with enough privileges.  Do you run
them as root?  Does the kernel has the required config set?

> 
> 2) $PWD needs to be the test binary directory for "./wait-pipe-sandbox" to work.

Yes.  run_kselftest.sh should handle that.

> 
> > To make it easier, we wrote a wrapper to test everything with UML:
> > https://github.com/landlock-lsm/landlock-test-tools (see check-linux.sh)
> > 
> > > 
> > > > # #  RUN           audit.tsync_override_log_subdomains_off ...
> > > > # # audit_test.c:591:tsync_override_log_subdomains_off:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, NULL) (-11)
> > > 
> > > This error number means "EAGAIN 11 Resource temporarily unavailable",
> > > so it could be a temporary error.
> > 
> > Yes, the test is flaky under pressure.
> > 
> > > 
> > > Can you reproduce this issue? Is it really dependent on my patch as
> > > blamed above? If so, does the selftest rely on the previous, incorrect order?
> > 
> > I don't think it directly depends on your patch but it might be a side
> > effect.  Anyway, I've been working on fixing this kind of issue and just
> > sent a fix:
> > https://lore.kernel.org/r/20260513105112.140137-2-mic@digikod.net
> 
> Thanks, unfortunately I can't validate that it will fix the issue at hand.

I pushed it to -next, we'll see but I'm pretty sure this is the issue.
