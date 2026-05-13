Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44683FB05B
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670155; cv=none; b=pa5JDgL8082//TjsKo64NO28V6C6dU5FHjV7VXLKBTT9Ud1AXSvr5ttwrsaak/AgG0Hbs57SSF5puNGzFO9cNGhYzYuCpU/jt2qmoJ9izupoHSdl4sD8RQV82fPYcYwnEVPd3deFxUcS1GH/qCxX21SHMSjfWNbZEYeuVdiR+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670155; c=relaxed/simple;
	bh=0MYAnE8ltPGjcQoQ6tYxrN2xPXGdXnSbRlYHQJYnz6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG+3hePzeimLXUHPIvHr80mcYExsj2wT5tQ+DDRgQiiZwa0hYByOXgyoP2EF1jSp6kyQowPCEOMc6JzZgfziZKKB0AlL0y5CVOflCxbPZWz/1mvGwKr6jZQmesL8gE6DuqHqWnPc5X9EM1XHgim+abWNG/LDX+FnKJhU7nLFQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=z4gq/Bri; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="z4gq/Bri"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gFqzn70zrzd69;
	Wed, 13 May 2026 12:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1778669557;
	bh=hT3FL8hNRoTv2wd/TyaHSDPl2qpHaafarg8T+VkCxCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z4gq/Bri5PY20oWAl5CPpmsrY0g7ZAicr9kWtoFC5zjwqxwVNIwKwFKPI/nre43PR
	 1W64XVWc/SFkdB6dqGu+5y8DJpkCj7Yr4gN6HairAVmBmwQiVaAV3zeOZiG0f8bl5i
	 OGGmFky8I9y1NuyuyCrecWCFjb+qSgmElV5MPKg0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gFqzn0x4pzjY2;
	Wed, 13 May 2026 12:52:37 +0200 (CEST)
Date: Wed, 13 May 2026 12:52:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	kernel test robot <oliver.sang@intel.com>, linux-security-module@vger.kernel.org, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [linus:master] [selftests]  465b05bae5:
 kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail
Message-ID: <20260513.eeboh9zooQuu@digikod.net>
References: <202605111649.a8b30a62-lkp@intel.com>
 <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
X-Infomaniak-Routing: alpha

Hi Thomas,

Thanks for the report.

On Tue, May 12, 2026 at 11:27:42AM +0200, Thomas Weißschuh wrote:
> Hi Mickaël and Günther,
> 
> I received the following report about a failing landlock selftest from
> the 0day bot.
> 
> On Mon, May 11, 2026 at 10:15:00PM +0800, kernel test robot wrote:
> > kernel test robot noticed "kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail" on:
> > 
> > commit: 465b05bae5ac553c13315681c1490dc565337771 ("selftests: harness: Restore order of test functions")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
> > with following parameters:
> > 
> > 	group: landlock

This group is correct but I'm wondering why the maintainer (me) and the
reviewer (Günther) weren't in Cc.

What do we need to do to subscribe to such report?  Why isn't
automatically inferred from the MAINTAINER file?

> > 
> > config: x86_64-rhel-9.4-kselftests
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
> 
> I was unable to run the landlock selftests myself, on my machines they are
> failing at runtime with all kinds of colorful errors. Are the requirements
> explained somewhere?

I'm curious about the errors you get.  They are standard kselftests that
should work following this workflow:

  make TARGETS=landlock O=build kselftest-gen_tar

and then running ./build/kselftests/kselftest_install/run_kselftest.sh
as root in a VM.  The required kernel configuration is listed in
tools/testing/selftests/landlock/config

To make it easier, we wrote a wrapper to test everything with UML:
https://github.com/landlock-lsm/landlock-test-tools (see check-linux.sh)

> 
> > # #  RUN           audit.tsync_override_log_subdomains_off ...
> > # # audit_test.c:591:tsync_override_log_subdomains_off:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, NULL) (-11)
> 
> This error number means "EAGAIN 11 Resource temporarily unavailable",
> so it could be a temporary error.

Yes, the test is flaky under pressure.

> 
> Can you reproduce this issue? Is it really dependent on my patch as
> blamed above? If so, does the selftest rely on the previous, incorrect order?

I don't think it directly depends on your patch but it might be a side
effect.  Anyway, I've been working on fixing this kind of issue and just
sent a fix:
https://lore.kernel.org/r/20260513105112.140137-2-mic@digikod.net

> 
> > # # tsync_override_log_subdomains_off: Test failed
> > # #          FAIL  audit.tsync_override_log_subdomains_off
> > # not ok 5 audit.tsync_override_log_subdomains_off
> 
> 
> Thomas
