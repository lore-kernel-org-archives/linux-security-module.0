Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8723FA5E7
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969296; cv=none; b=Id+lWqZm8ODSD8ZdYMnbz1sNnrhnEKgKG5bXdMJQ5m3Tl6KIvuUvGVonGedt+IvI6ye8JCNNE7hG5re4XOoD1s/aqDhhPciorQiRLeBWIBNBrSLlxMSFp1DRIWP1p+NknW7kUCxSxPrm3VGSYAXx5TB13FdTEVKa0rzPMYYTfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969296; c=relaxed/simple;
	bh=tow3pyIoIEn8SfWm8iGmxS1KjjEqUhTNr7iReCWznoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JveBtTRsYpFs3uJv8ERJTQvT+7CcEdIC944kmHPUS3bH6JXSGBWdQR2rzDNwNcXP85Hvni35SKCAiIziR3H3hKZJSRwpiKOoNu9qq33g8Z4m5ukB4jt+YgpXJqH3fPBSHLmRXsqdYDWK1qw9LeWaaIyyzt3jfnAN/3IuQevfSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=eA39eJue; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="eA39eJue"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C77263F584
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786969285;
	bh=aDQtcVUQh67+ohJJVzNmRTqJdMYbbVhNeLfRhdWahWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=eA39eJueC/vWJx3bZzUwbIwJNpEGYMfkLhBcAbSYoCRHhR6FIprijCLn3/1P+EEWH
	 PlJ6+E9HhRTaw787rR+pyO9umErnUGD3Q9e6KopNqCNgihP4203rT7iJO4TF1cX9Pq
	 fER/tK5Z+ZRK2juegz/zH9B0NU+4ISX4pBKoxqIfCtELn3wwSlMOcH9Wq8rcprz635
	 AVTynTo3xV9KDojI6Ud6jI9NddhxNuHotfADSjSEYwT9DaWOWf/+m/p0kIcinK1Hzi
	 QY8T+RWWE1gDSrPDi+qcq2AKQE0GmhavRw0nnycIPd9pb05HQUP50n12gyzRrVkmI2
	 TbdJf/i/eh2PsDE2jWOvlDSPvRTNHOF7WQAbr+ISJtmLjwrATfK4YSWX4xRshAbQtD
	 CEcj0T3pUdoFNMYkJXHqBUQJU1SzCZpQN9KWtZhqn2aeXjknAwEpg4Zy1RMMeSa5Pp
	 wVCAaI+NwqzRsb2IuBkRZOZ6aW+qrc/kHVn8E28eKT9h0j2LmtdaB8YDbWIkWMJ0HL
	 31EB8+A8qhYt0Cw2VFPd9UtFeCLhfExleWppLd7RPXZWXHWEA3186HgpbbeB50I2SY
	 W+H6UJBrl1RLJkfOdYvv+sk4J156jhYOi3LyoMVSC9TpiVyThC6LAukVFIr+KKtOQh
	 EX9ISZBQERH7uW+Gk5LuNvkI=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb687f82eso53907555ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 05:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969284; x=1787574084;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aDQtcVUQh67+ohJJVzNmRTqJdMYbbVhNeLfRhdWahWk=;
        b=dz4oku1swUYOBtqLAewJvHflc4y21JmunOQgEWN8WXYULWpw+KyUM7SuvV6aQmAb/H
         I3L7ASx12QSei+dxOPBdvH7iTloziTjAYagO7Vs1GE+2kJY0gOnNJ/u4tbi1/tXeJJ/8
         dfMZU6HAb6JjEwYdp1li2Un3sfYj6xWTafUcymsKAufA1LhMlyO4tPU+hxHQC2IX2pgm
         aCqK0p+0vkVcSfG4QC2Vync1GtWj/PJZ+2/3ITrapYk5PbrFEKGYjL7bsgUKmxei/V5R
         QgbdvWtf2DUSfSJDbw5TxlwRTY5dJOuE63Kxy7Fp8FRhgAWNbjzls9w5TRgWpHQ4DPHc
         Qe1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrhJgBtXsQryAtOLj7/y5Axx8/5G69EfsyjcHStnkA03sitYH8BGqfdr8eQ8K/J20g6kuxNpJ725jOW5ZaMEvjq5PnTDWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF6O5oPGLiPaEwL6+IkFZ8KszvbUq5OcRs2gcTPH7XWIgpYRB
	nRrOS6Oy9yhFNsqeIWSYXovTjCwFhH95KXYeI4o9iTgnoQYAXBiN7NU61B1hDqiwYmu+pOpEy0C
	b4hmgU/X5QhtwFaQVyRCGnwStuGS5EwFfambnr0vCDLk8pGWOywrbpkr5KqTR4L3MekXdaB2vMg
	yrQn0Q//H1sVvT8BhU4w==
X-Gm-Gg: AR+sD10xsNDzJmiOXaJDIF+PTGyfDcb9pZV8DDpdBL63iS+zLeRFf1LcloKivujnNgW
	ADUe/7pcXV8z4Yw7kjZv8IbXjUrbzO+qQ1lBPWCtc8zMTroGmnaz4xRr4GJaeWBaJ72c6peQBIp
	aPUIrgkGrdx/KvMGHRpClIO2jEvulLZ+9raKXMQpoW22CtHSO2jX6KZnwa6Qc3IRf8RBHUPeDF7
	BBaOFyvKPpaOebS7lDY29OhvCzHeXFCmVKk98RQ5l7oYHSetkOp+KMHzeMA51o8AVd3XKdMeE86
	2td6Y8M1YzDpSqGkZcZWC72HJLdMGD3u4KMQpb4givy3uZH3CiE9IQiuKx4CZPk+RCM2TP18Ry1
	J7/f2aqpRj6Z3yIA=
X-Received: by 2002:a17:903:37cd:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2d3b0d17a57mr265712365ad.8.1786969284079;
        Mon, 17 Aug 2026 05:21:24 -0700 (PDT)
X-Received: by 2002:a17:903:37cd:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2d3b0d17a57mr265711725ad.8.1786969283609;
        Mon, 17 Aug 2026 05:21:23 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d5bb4e9174sm4822115ad.23.2026.08.17.05.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:21:22 -0700 (PDT)
Message-ID: <96c804df-80c5-4b8c-a9db-67fcf161bc48@canonical.com>
Date: Mon, 17 Aug 2026 05:21:21 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Apparmor deadlock in 6.12.101 in complain mode
To: =?UTF-8?Q?Mattias_=C3=85sander?= <mattiasa@cs.umu.se>,
 Ryan Lee <ryan.lee@canonical.com>
Cc: regressions@lists.linux.dev, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, stric@cs.umu.se
References: <anwotItY2-0WMbfn@cs.umu.se>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <anwotItY2-0WMbfn@cs.umu.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

thanks for the report

This should be fixed by
   commit 4ec11f14d1d6f apparmor: fix deadlock in complain-mode change_hat

in apparmor-next, linux-next. It went into testing early last week, and got a small revision a couple of days last, and got pushed into linux-next late last week



On 8/12/26 01:03, Mattias Åsander wrote:
> Hello
> 
> With the 6.12.101 kernel on debian13 we suddenly got frequent deadlocks in apparmor for our Apache webservers.
> 
> It appears to be caused by the commit "apparmor: grab ns lock and refresh when looking up changehat child profiles"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32e92764d6f8d251c1bca62be33793287b453a81
> 
> As of that commit the function change_hat() now takes the ns->lock mutex, and later with the lock held it calls a function that also takes the same namespace lock, causing a deadlock.
> 
> So, security/apparmor/domain.c:change_hat() calls security/apparmor/domain.c:build_change_hat(), and in complain-mode that calls security/apparmor/policy.c:aa_new_learning_profile(),
> which also tries to takes the profile->ns->lock mutex.
> 
> ###########
> INFO: task /usr/sbin/apach:125024 blocked for more than 120 seconds.
>        Not tainted 6.12.101+deb13-amd64 #1 Debian 6.12.101-1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:/usr/sbin/apach state:D stack:0     pid:125024 tgid:125024 ppid:2366   flags:0x00004006
> Call Trace:
>   <TASK>
>   __schedule+0x505/0xc00
>   schedule+0x27/0xc0
>   schedule_preempt_disabled+0x15/0x30
>   __mutex_lock.constprop.0+0x41b/0x720
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   aa_new_learning_profile+0x149/0x1e0
>   build_change_hat+0x28b/0x3a0
>   change_hat.isra.0+0x60e/0xd90
>   aa_change_hat+0x301/0x620
>   aa_setprocattr_changehat+0xf8/0x230
>   do_setattr+0x2d1/0x380
>   proc_pid_attr_write+0xe0/0x150
>   vfs_write+0xf5/0x440
>   ? __pte_offset_map+0x1b/0x180
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? mutex_lock+0x12/0x30
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ksys_write+0x6d/0xf0
>   do_syscall_64+0x87/0x1b0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __count_memcg_events+0x53/0xf0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? count_memcg_events.constprop.0+0x1a/0x30
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? handle_mm_fault+0x1bb/0x2c0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_user_addr_fault+0x36c/0x620
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f4719c279ee
> RSP: 002b:00007ffdb983ec48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f4719b15c00 RCX: 00007f4719c279ee
> RDX: 00000000000000d3 RSI: 00005610b4669ce0 RDI: 000000000000008c
> RBP: 00005610b4669ce0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000000d3
> R13: 00005610b4669ce0 R14: 00007f4719a8c660 R15: 00007f4719acd054
>   </TASK>
> ###########
> 
> 
> Some more background on how the issue gets triggered for us:
> We run apache with MPM-prefork and apparmor has it in complain-mode, and a bunch of different vhosts configured with their own profiles in /etc/apparmor.d/apache2.d/,
> everything is fine as long as you call a vhost with a matching apparmor profile, but calling it with a hostname that does not have a explicit profile (ex the ip-address) causes an immediate deadlock.
> So with ex a vhost as "SiteName example.org":
> curl http://example.org <- works, no issues
> curl http://127.0.0.1 <- deadlock
> 
> A quick workaround for our issue in Apache is to define AADefaultHatName globally so that it avoids the aa_new_learning_profile code-path,
> we have it set to "AADefaultHatName DEFAULT_URI" as that hat/profile was available by default in the shipped /etc/apparmor.d/usr.sbin.apache2 ruleset in debian13.
> 
> Best Regards
> //Mattias

