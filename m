Received: from mail.cs.umu.se (mail.cs.umu.se [130.239.40.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915337F725;
	Wed, 12 Aug 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.40.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522306; cv=none; b=L0eeEv1QqVVNCvoFeXLN/YJpW7RmpUIO3mcYmkDaf1jY4C/KoMoNa/TSrWWf7A8G93ZERYjTqE/WbP/RSm2fPU3+MJlVkFoqyXV1ULH6Pd6LkJLsPWmWiJFZ2Fe5wVvabkgaNKn2QubgHbNZXpmtHqMRCefmHuLiaV4F763x6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522306; c=relaxed/simple;
	bh=xW9ZMoYBeKafn0p84RZA5pYECw33ih6ciERBSSF4w3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bsk+cazv+p5jNyG9h7aLBZP0TVrM08P0euv4CVjlY+mRUExYFbXX5W8jDOvZ/AlSrFK/6vAMOFbkECABq4d1WTqXi3abGO2YNWfletoMjKqm8dE/0iQ2tDJCM8964gBdkit5ensA1Aj2C86Rya3Vbdp8mjR0WBFd0bD55FdHCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.umu.se; spf=pass smtp.mailfrom=cs.umu.se; dkim=pass (2048-bit key) header.d=cs.umu.se header.i=@cs.umu.se header.b=KmCW2S4h; dkim=pass (2048-bit key) header.d=cs.umu.se header.i=@cs.umu.se header.b=mW/+IxEt; arc=none smtp.client-ip=130.239.40.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.umu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.umu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.umu.se header.i=@cs.umu.se header.b="KmCW2S4h";
	dkim=pass (2048-bit key) header.d=cs.umu.se header.i=@cs.umu.se header.b="mW/+IxEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.umu.se; s=dkim;
	t=1786521783; bh=xRGQdgSKljfrW4uvKs52zlEfeenXY3xamy4HFZTkOiY=;
	h=Date:From:To:Cc:Subject:From;
	b=KmCW2S4hLvAIum0K/ZYTBR6L1snTXXHXZYlMcMfkA5eBqw+0+nvdlbq5OnF5PlayD
	 e8COC5UnUY9iQfDMAxNwkILRJA8OtCQLaN1GwhI2OwAFRDQPFdvFBRUB2+3Uy2U6HP
	 0MVyStU/GcstrM6rqqqtpGiwBg31w/0Yk8VZ8+IP2W/o9+4Qi5hl69PuwEyJrUOCEd
	 6CQCIRaEsT3TZ1QgZd02e2QpPxDEDk2z3oOJ4BFjZGcUyQF2ODqf5ZkVk3zeGgJNGE
	 6Tsey2g6BFWHDeqzgIqh7Ve6pFNfRFJXYRzFmNgrqWwGXU4PwXN9QXK9QWmycShdlY
	 ay90pQ34Hl+WA==
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 4hKgw75kBcz3D;
	Wed, 12 Aug 2026 10:03:03 +0200 (CEST)
X-Virus-Scanned: Debian amavis at cs.umu.se
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mail-vm2.cs.umu.se [127.0.0.1]) (amavis, port 10024) with LMTP
 id ovcg_ptwD5Ke; Wed, 12 Aug 2026 10:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.umu.se; s=dkim;
	t=1786521781; bh=xRGQdgSKljfrW4uvKs52zlEfeenXY3xamy4HFZTkOiY=;
	h=Date:From:To:Cc:Subject:From;
	b=mW/+IxEt229eYM3zXro57LrT/UPqM/tTtqkzsEoG9wiFgPp7BAeyUOJLCuehaqs0p
	 qBSKf9OSFZHqH46gCxxmDw8IfXyBMcOEmNzaFQHMC54CrKOkQHFDwjektYnBLd/K+8
	 QtU0Q7/VR2D2SBAuY9T0Phs77Cb1LoHTmek4h3tKVBxuAgvymU4TZ3fDFmCo5P2Izh
	 WCOyNTcvPLD5kou+pZgs3ejM6piXG8AamT/AjWI8jFM3dYxsZpkMedWnDbufgfOFlu
	 I4OOFHivkvU4MSoYBuI68UCnUXzwEARjOvNa4cMwJ5EMoY7osboDsMXb3XhGwPa0n4
	 KeNgc0N3qcPug==
Received: from cs.umu.se (luna.cs.umu.se [IPv6:2001:6b0:e:4036::88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattiasa)
	by mail.cs.umu.se (Postfix) with ESMTPSA id 4hKgw52Znhz2k;
	Wed, 12 Aug 2026 10:03:01 +0200 (CEST)
Date: Wed, 12 Aug 2026 10:03:00 +0200
From: Mattias =?iso-8859-1?Q?=C5sander?= <mattiasa@cs.umu.se>
To: Ryan Lee <ryan.lee@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Cc: regressions@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, stric@cs.umu.se
Subject: [REGRESSION] Apparmor deadlock in 6.12.101 in complain mode
Message-ID: <anwotItY2-0WMbfn@cs.umu.se>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello

With the 6.12.101 kernel on debian13 we suddenly got frequent deadlocks in apparmor for our Apache webservers.

It appears to be caused by the commit "apparmor: grab ns lock and refresh when looking up changehat child profiles"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32e92764d6f8d251c1bca62be33793287b453a81

As of that commit the function change_hat() now takes the ns->lock mutex, and later with the lock held it calls a function that also takes the same namespace lock, causing a deadlock.

So, security/apparmor/domain.c:change_hat() calls security/apparmor/domain.c:build_change_hat(), and in complain-mode that calls security/apparmor/policy.c:aa_new_learning_profile(),
which also tries to takes the profile->ns->lock mutex.

###########
INFO: task /usr/sbin/apach:125024 blocked for more than 120 seconds.
      Not tainted 6.12.101+deb13-amd64 #1 Debian 6.12.101-1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:/usr/sbin/apach state:D stack:0     pid:125024 tgid:125024 ppid:2366   flags:0x00004006
Call Trace:
 <TASK>
 __schedule+0x505/0xc00
 schedule+0x27/0xc0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x41b/0x720
 ? srso_alias_return_thunk+0x5/0xfbef5
 aa_new_learning_profile+0x149/0x1e0
 build_change_hat+0x28b/0x3a0
 change_hat.isra.0+0x60e/0xd90
 aa_change_hat+0x301/0x620
 aa_setprocattr_changehat+0xf8/0x230
 do_setattr+0x2d1/0x380
 proc_pid_attr_write+0xe0/0x150
 vfs_write+0xf5/0x440
 ? __pte_offset_map+0x1b/0x180
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? mutex_lock+0x12/0x30
 ? srso_alias_return_thunk+0x5/0xfbef5
 ksys_write+0x6d/0xf0
 do_syscall_64+0x87/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __count_memcg_events+0x53/0xf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? count_memcg_events.constprop.0+0x1a/0x30
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? handle_mm_fault+0x1bb/0x2c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_user_addr_fault+0x36c/0x620
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f4719c279ee
RSP: 002b:00007ffdb983ec48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4719b15c00 RCX: 00007f4719c279ee
RDX: 00000000000000d3 RSI: 00005610b4669ce0 RDI: 000000000000008c
RBP: 00005610b4669ce0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000000d3
R13: 00005610b4669ce0 R14: 00007f4719a8c660 R15: 00007f4719acd054
 </TASK>
###########


Some more background on how the issue gets triggered for us:
We run apache with MPM-prefork and apparmor has it in complain-mode, and a bunch of different vhosts configured with their own profiles in /etc/apparmor.d/apache2.d/,
everything is fine as long as you call a vhost with a matching apparmor profile, but calling it with a hostname that does not have a explicit profile (ex the ip-address) causes an immediate deadlock.
So with ex a vhost as "SiteName example.org":
curl http://example.org <- works, no issues
curl http://127.0.0.1 <- deadlock

A quick workaround for our issue in Apache is to define AADefaultHatName globally so that it avoids the aa_new_learning_profile code-path,
we have it set to "AADefaultHatName DEFAULT_URI" as that hat/profile was available by default in the shipped /etc/apparmor.d/usr.sbin.apache2 ruleset in debian13.

Best Regards
//Mattias
