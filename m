Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6573A2E07
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697855; cv=none; b=pZJPsTnTJR6SitFpn2XWlc/Pu6hZjfSWzO7oxmQHQL5BlMJh89QLHQbH0v50yC5jdSZIKDMhb9Q5oabBaN7R6+aiBQxFDKzBjx0FUCSy3Sb1vG1XB+RDfXuEZCdvBP7yiDgnRLWYlQRhE7I9YsVls77kPJGbOjQjp/QmC+ZulKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697855; c=relaxed/simple;
	bh=gfaRbPbbHycDLO2twa2JXBasiA+0K+EK6LJvEW0CoUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqpq70PSJ3DI2nRbEGp1VYPn1k7/eRjlhSz8Euo0NO4Z0dOM2o5nQldRXNGMS72Xwv4RmTpLLrhfYm0IF/Qrpp5YeeYDQjNaCZU8RzjrVqhtLpsD4Tb3edMo/PfSu53Dv22nB+YihO4C2xZyEaQW9M5fGvWuUakKgYbNM+nkeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kRpvIUKN; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kRpvIUKN"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gG2Hg59d3znpy;
	Wed, 13 May 2026 20:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1778697423;
	bh=WinMqMQTlJYFNMJfZw69TW/aAR+KBvDSBFB7M2PlPBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRpvIUKNPGJbA62BPmLGOM9cro/OHpmiqjZuHylghJLHXY4bOzzhcvdqAb1Vn88ar
	 H1700JGyN/bn0j5wlluBvkTXwSLlQ4XXACv6ItbasiMuuqA/yGGY18kRvWN1GrUFNS
	 2Q0pRInHfEk/sbga3GScoNr4rm7BoarQ77QrJgsg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gG2Hf64qJz3tn;
	Wed, 13 May 2026 20:37:02 +0200 (CEST)
Date: Wed, 13 May 2026 20:36:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, linux-security-module@vger.kernel.org
Subject: Re: [linus:master] [landlock]  874c8f8382:
 kernel-selftests.landlock.audit_test.audit.thread.fail
Message-ID: <20260513.choh1Aiwee5D@digikod.net>
References: <202604300436.a07fae12-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202604300436.a07fae12-lkp@intel.com>
X-Infomaniak-Routing: alpha

Should be fixed with
https://lore.kernel.org/all/20260513105112.140137-2-mic@digikod.net/

On Thu, Apr 30, 2026 at 10:51:07AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.landlock.audit_test.audit.thread.fail" on:
> 
> commit: 874c8f83826c95c62c21d9edfe9ef43e5c346724 ("landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      dca922e019dd758b4c1b4bec8f1d509efddeaab4]
> [test failed on linux-next/master 9974969c14031a097d6b45bcb7a06bb4aa525c40]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
> with following parameters:
> 
> 	group: landlock
> 
> 
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202604300436.a07fae12-lkp@intel.com
> 
> 
> # timeout set to 300
> # selftests: landlock: audit_test
> # TAP version 13
> # 1..12
> # # Starting 12 tests from 10 test cases.
> # #  RUN           audit.log_subdomains_off_fork ...
> # #            OK  audit.log_subdomains_off_fork
> # ok 1 audit.log_subdomains_off_fork
> # #  RUN           audit.thread ...
> # # audit_test.c:252:thread:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, &denial_dom) (-11)
> # # audit_test.c:254:thread:Expected denial_dom (1) != 1 (1)
> # # audit_test.c:257:thread:Expected 0 (0) == matches_log_domain_allocated(self->audit_fd, getpid(), &allocated_dom) (-11)
> # # audit_test.c:259:thread:Expected denial_dom (1) == allocated_dom (2)
> # DATA: audit(1777390809.810:10): domain=1a323af0a status=allocated mode=enforcing pid=2437 uid=0 exe="/opt/rootfs/tmp/kselftests/landlock/landlock/audit_test" comm="audit_test"
> # ERROR: no match for pattern: ^audit([0-9.:]\+): domain=\([0-9a-f]\+\) status=deallocated denials=1$
> # # audit_test.c:275:thread:Expected 0 (0) == matches_log_domain_deallocated(self->audit_fd, 1, &deallocated_dom) (-2)
> # # audit_test.c:277:thread:Expected denial_dom (1) == deallocated_dom (0)
> # # thread: Test failed
> # #          FAIL  audit.thread
> # not ok 2 audit.thread
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260430/202604300436.a07fae12-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 
