Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B93A16AA;
	Tue, 12 May 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578072; cv=none; b=D9qUDNh0Lrx3YZ/JoTfcH5z/GkvrYhbboPg2rsMhkC6DXWiro2s8agf55fNNAtmuOfEHrNJm3kMRq7at38lDurB5GAJ19AFtWgJUkyzQ5OKIbele1NkVkcIS4m+3aUUArmUCVv5RmT3FCPQ6lDWj5W6JsSJTDY0E8Ft10GBGd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578072; c=relaxed/simple;
	bh=y4lzFPfIQ5EXXJU/Ics0Ph164aLFGtivkxRvVKsXBSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/0Dxd3ZJRzPZX4dPBzskZLAabFsdOK8xorI9PB4v8ABAbYlZvnnuZzXSf8Ba43kh41Behmaokpo+3tCiocLBlWUWV7z4ui0vON01Wn1E4lASWCr+bjTUE/InW4kR9q5+CtIwhpcXYmuuWXVWkcXFURtAWy/DTHUgXjYwOz8xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faDAsxfv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WNE8hyGX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faDAsxfv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WNE8hyGX"
Date: Tue, 12 May 2026 11:27:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778578068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxx69tCSE3cRbeXb+WlVhc3iPwTFRTNC2XNEWjF1AlQ=;
	b=faDAsxfvxqzlSCX4+8XWyeNPpd6fFxpPKnoV0sHi1lwfIjCivzTCO6t89u7z0ZZBz2VITS
	jHk2eugpQQ4P8cKtg7FJ4jPLaMAVMJjIQRz4iz37lQj6snlIjqw0wmlMjFUocGPitJCMpT
	8zpW3DyJ2Sgy86Tb+mgflcyrbSx/GM+dJsaoTUirdnQKbRbnt/cLlBP8zamyXkKD9kSIdB
	386q0mX9cbb5j5UZL29F7hxvjDyYcdYpGcLMQ83qaGqIigAIExuXjyEU4QKOnTa58W5JmG
	1LuFNib3/0huVV9NDEIBIZiC01tutalobmqblyNKVKea4wH/4FLLtv4a0bVmQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778578068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxx69tCSE3cRbeXb+WlVhc3iPwTFRTNC2XNEWjF1AlQ=;
	b=WNE8hyGXqhD/TMJfx0PSI06tF4IX8Zx/sr01jvjZXYhxBpv1MsxdAUch6tRxqtVWxDjYWn
	dLSzK8n35Na9GZAA==
From: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	linux-security-module@vger.kernel.org, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [linus:master] [selftests]  465b05bae5:
 kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail
Message-ID: <20260512112054-0a5c7cad-c8c6-4745-a765-0780a3bd2dab@linutronix.de>
References: <202605111649.a8b30a62-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202605111649.a8b30a62-lkp@intel.com>

Hi Mickaël and Günther,

I received the following report about a failing landlock selftest from
the 0day bot.

On Mon, May 11, 2026 at 10:15:00PM +0800, kernel test robot wrote:
> kernel test robot noticed "kernel-selftests.landlock.audit_test.audit.tsync_override_log_subdomains_off.fail" on:
> 
> commit: 465b05bae5ac553c13315681c1490dc565337771 ("selftests: harness: Restore order of test functions")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
> with following parameters:
> 
> 	group: landlock
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com

I was unable to run the landlock selftests myself, on my machines they are
failing at runtime with all kinds of colorful errors. Are the requirements
explained somewhere?

> # #  RUN           audit.tsync_override_log_subdomains_off ...
> # # audit_test.c:591:tsync_override_log_subdomains_off:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, NULL) (-11)

This error number means "EAGAIN 11 Resource temporarily unavailable",
so it could be a temporary error.

Can you reproduce this issue? Is it really dependent on my patch as
blamed above? If so, does the selftest rely on the previous, incorrect order?

> # # tsync_override_log_subdomains_off: Test failed
> # #          FAIL  audit.tsync_override_log_subdomains_off
> # not ok 5 audit.tsync_override_log_subdomains_off


Thomas
