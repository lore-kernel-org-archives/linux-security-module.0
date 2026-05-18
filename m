Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373E326923;
	Mon, 18 May 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098516; cv=none; b=s37XI5cvIlCr7BeCBy5toNBs7dQ1FjQUfU0r/4A0jGoCijUX0J0N5RcCLIkq0anrBcONNYYk7m0ZYL1Tu8SAQAczqH44qFErNUIKNYY4Uh1p/i91/4/dkPRPqlBbPpnK7OSP0F83QjX8csHZHaTKEWl1g2ia+PgVos3/wQz6FKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098516; c=relaxed/simple;
	bh=L3f1Vp/n/cdeEMDV5sI+sXWwZyj64HpcGqTJbxUOe/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIj66h3xkxXanHOAg+kyTy3ZVbYSiXbE9M7L3fHWZtdKlEpDnXGXoJaXTthA/3bwSGUqzJk0kCH0RC7LnpyRrTlyI6PSAa6ZJ5ewtpYbvTe6GEMAwSN5lyU3A425/DNCvO9EyWsS8fIZ599TVwB9bHwlbpzgu3I+59BSjEDTF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONuaZYUV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtYKiEHJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONuaZYUV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtYKiEHJ"
Date: Mon, 18 May 2026 12:01:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779098512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R7iXz/vKaTcboM4y0DO/8RfZsBrVr/cAx9OLOYE8Gc=;
	b=ONuaZYUVIkb276hiZPlFFmhvaLFa/bK+n7SlrA5ctGJPIA5YkCVGuYwzhz2ZW/SyAyv5oo
	aaUJqL12sz8f5Nwa91tIg2eX/9BhWYN3X0ksKJnyXz76C4pIHu1KM45RsMDgE5lMNhAiP8
	yz5PLSjdOOIbWnbRLxY7FNjpdYhyVmDwNgW/dTlmV0HjH4HL7QZ417qq2sXRKJ6pr0qdjR
	pHnUolSLoBGcRYo9b3mbBW4/8dAVL7ZqBdV9njAa/McuvhkKFDhTFZ4MzT1Mw/wjig4bzC
	aZXvYcaZBZc1xoYB2XES6X5L0nVL/vHsLAiPmXD5JMCdX5adCLodYpmBoNKJJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779098512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R7iXz/vKaTcboM4y0DO/8RfZsBrVr/cAx9OLOYE8Gc=;
	b=TtYKiEHJSRwK6P/AZOSUveWrHARGDTNzttlc+E8rKl+7jbMwXJb/u8f73ElG68742EWq4e
	pJnWpBb7w23P94Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	kernel test robot <oliver.sang@intel.com>, linux-security-module@vger.kernel.org, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [linus:master] [selftests]  465b05bae5:
 kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail
Message-ID: <20260518115330-2156280f-0a6e-4d82-bbf5-13ad7052bafc@linutronix.de>
References: <202605111649.a8b30a62-lkp@intel.com>
 <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
 <20260513.eeboh9zooQuu@digikod.net>
 <20260518100602-5b161e99-83fa-4170-bb7b-1642df6b5a3d@linutronix.de>
 <20260518.ohn9DahGhui6@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518.ohn9DahGhui6@digikod.net>

On Mon, May 18, 2026 at 11:30:42AM +0200, Mickaël Salaün wrote:
> On Mon, May 18, 2026 at 10:48:27AM +0200, Thomas Weißschuh wrote:
> > On Wed, May 13, 2026 at 12:52:35PM +0200, Mickaël Salaün wrote:
> > (...)
> > 
> > > > > config: x86_64-rhel-9.4-kselftests
> > > > > compiler: gcc-14
> > > > > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > > > > 
> > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
> > > > 
> > > > I was unable to run the landlock selftests myself, on my machines they are
> > > > failing at runtime with all kinds of colorful errors. Are the requirements
> > > > explained somewhere?
> > > 
> > > I'm curious about the errors you get.  They are standard kselftests that
> > > should work following this workflow:
> > > 
> > >   make TARGETS=landlock O=build kselftest-gen_tar
> > > 
> > > and then running ./build/kselftests/kselftest_install/run_kselftest.sh
> > > as root in a VM.  The required kernel configuration is listed in
> > > tools/testing/selftests/landlock/config
> > 
> > So there are two root issues I ran into:
> > 
> > 1) The tests can not be executed from virtiofs (as set up by virtme-ng):
> 
> Most filesystem tests initially set up tmpfs and then use it.
> 
> I'm using virtme-ng too, see the
> https://github.com/landlock-lsm/landlock-test-tools
> 
>  ARCH=x86_64 .../check-linux.sh build_light kselftest
> 
> > 
> >  #  RUN           audit.layers ...
> > # audit_test.c:52:layers:Expected 0 (0) <= self->audit_fd (-13)
> > # audit_test.c:61:layers:Failed to initialize audit: Permission denied
> > # layers: Test failed
> > #          FAIL  audit.layers
> > not ok 1 audit.layers
> > 
> > (The same for all other testcases)
> 
> It looks like the tests are not run with enough privileges.  Do you run
> them as root?  Does the kernel has the required config set?

Yes. The exact same setup works when executed from a tmpfs.

> > 2) $PWD needs to be the test binary directory for "./wait-pipe-sandbox" to work.
> 
> Yes.  run_kselftest.sh should handle that.

Fair enough. The selftests I used so far worked just fine when executed directly.
Maybe only I am using them this way. Some better diagnostics would have saved
me some time. Consider it a suggestion.

> > > To make it easier, we wrote a wrapper to test everything with UML:
> > > https://github.com/landlock-lsm/landlock-test-tools (see check-linux.sh)
> > > 
> > > > 
> > > > > # #  RUN           audit.tsync_override_log_subdomains_off ...
> > > > > # # audit_test.c:591:tsync_override_log_subdomains_off:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, NULL) (-11)
> > > > 
> > > > This error number means "EAGAIN 11 Resource temporarily unavailable",
> > > > so it could be a temporary error.
> > > 
> > > Yes, the test is flaky under pressure.
> > > 
> > > > 
> > > > Can you reproduce this issue? Is it really dependent on my patch as
> > > > blamed above? If so, does the selftest rely on the previous, incorrect order?
> > > 
> > > I don't think it directly depends on your patch but it might be a side
> > > effect.  Anyway, I've been working on fixing this kind of issue and just
> > > sent a fix:
> > > https://lore.kernel.org/r/20260513105112.140137-2-mic@digikod.net
> > 
> > Thanks, unfortunately I can't validate that it will fix the issue at hand.
> 
> I pushed it to -next, we'll see but I'm pretty sure this is the issue.

Nice. I justed wanted to make clear that I won't be able to provide a Tested-by.


Thanks again,
Thomas
