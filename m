Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318426B973;
	Mon, 18 May 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094117; cv=none; b=hSkL7Jd0BPzJB+PEn5Ty/cNUJqADHmJady9JIzOTSJbUcj+1i3RgkIxmOd4zupmHHAht9JbxF0CN4wAeuLLbNIY67DFqqwdeqzVD/adZKzgqX237RnbVO7pn42lhs3zH7MbUJK1FGkr+f0xrACPk2+B1lP2tg6twdpzTyGDBPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094117; c=relaxed/simple;
	bh=9t5KxgZSvMy4+PrO7AcN8zNi278O5hkk/AIOuTQgGLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJgFRxZDAkevPoPLKBRFgohT3VXWAOswBA60Mit0ebSOe/gajVtEoE7nIwaWUMUjBaS5AUihi+EKHJMHV+XRCvcoBzn0nlew31st3kHJ1B/yFjoARbgpfQVSjhy/gd8Xx+PPMH7dtqPBXo11XQNKrHtpbZ9yn5pwl7ghWzs/91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QixhRBsf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCb8Hd6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QixhRBsf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCb8Hd6j"
Date: Mon, 18 May 2026 10:48:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779094113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NmoyZjWMcQlJ+wu8nb9k9PXQ/vBAKzFMTW/kF6RHyw=;
	b=QixhRBsfT4Zq9oBQC1PdPmHgj5oPrfyE0MAuOUnGr5C7Q/D/a4WLXRuZGfVo7yRPxZbu5P
	Lt0X2/x52cBqxISi6FmcGAe4FwIcImR7vjhdiIApPYOItJYfZ3l35llnJoxFJhENpBAte6
	Xz/GhEyfUZkex/WfpQJCGg3B4PsQ0BTiOXfCye2/ojX5mZo4nYUevJIw+VoTaLN2B0/gaG
	MBTbIGimRsFOJDLBst9n3zGH1aIdl8+SfS7gqd7yN9zEfxILPDPTFPWw5oetTEqqPgL1mL
	713K9cGfkycxklwrKpPwhHFsd+KdmNEyT1tdmWZfaMWq/ZUdTU4EWL+A/sOKig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779094113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NmoyZjWMcQlJ+wu8nb9k9PXQ/vBAKzFMTW/kF6RHyw=;
	b=rCb8Hd6jfN5h+IrZLnNTt6Q80Vty9DBmxOpBnIG+y15r3587Y2WVmdFD4r/9BZPhAdDA5z
	kmUvLUuASGkzLZCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	kernel test robot <oliver.sang@intel.com>, linux-security-module@vger.kernel.org, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [linus:master] [selftests]  465b05bae5:
 kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail
Message-ID: <20260518100602-5b161e99-83fa-4170-bb7b-1642df6b5a3d@linutronix.de>
References: <202605111649.a8b30a62-lkp@intel.com>
 <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
 <20260513.eeboh9zooQuu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513.eeboh9zooQuu@digikod.net>

On Wed, May 13, 2026 at 12:52:35PM +0200, Mickaël Salaün wrote:
(...)

> > > config: x86_64-rhel-9.4-kselftests
> > > compiler: gcc-14
> > > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
> > 
> > I was unable to run the landlock selftests myself, on my machines they are
> > failing at runtime with all kinds of colorful errors. Are the requirements
> > explained somewhere?
> 
> I'm curious about the errors you get.  They are standard kselftests that
> should work following this workflow:
> 
>   make TARGETS=landlock O=build kselftest-gen_tar
> 
> and then running ./build/kselftests/kselftest_install/run_kselftest.sh
> as root in a VM.  The required kernel configuration is listed in
> tools/testing/selftests/landlock/config

So there are two root issues I ran into:

1) The tests can not be executed from virtiofs (as set up by virtme-ng):

 #  RUN           audit.layers ...
# audit_test.c:52:layers:Expected 0 (0) <= self->audit_fd (-13)
# audit_test.c:61:layers:Failed to initialize audit: Permission denied
# layers: Test failed
#          FAIL  audit.layers
not ok 1 audit.layers

(The same for all other testcases)

2) $PWD needs to be the test binary directory for "./wait-pipe-sandbox" to work.

> To make it easier, we wrote a wrapper to test everything with UML:
> https://github.com/landlock-lsm/landlock-test-tools (see check-linux.sh)
> 
> > 
> > > # #  RUN           audit.tsync_override_log_subdomains_off ...
> > > # # audit_test.c:591:tsync_override_log_subdomains_off:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, NULL) (-11)
> > 
> > This error number means "EAGAIN 11 Resource temporarily unavailable",
> > so it could be a temporary error.
> 
> Yes, the test is flaky under pressure.
> 
> > 
> > Can you reproduce this issue? Is it really dependent on my patch as
> > blamed above? If so, does the selftest rely on the previous, incorrect order?
> 
> I don't think it directly depends on your patch but it might be a side
> effect.  Anyway, I've been working on fixing this kind of issue and just
> sent a fix:
> https://lore.kernel.org/r/20260513105112.140137-2-mic@digikod.net

Thanks, unfortunately I can't validate that it will fix the issue at hand.


Thomas
