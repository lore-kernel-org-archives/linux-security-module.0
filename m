Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A3267714
	for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771658974; cv=none; b=ol9zSz2MXzdJTZkKRJGjhYeHyuQCPkK7X0RUhLhnrJ0O/4MuajJQ/c1qNvxHZ7HqxTzqMMrsFQQHLStDmUSvU0CyRUTeKSt9JtMxcSTkcB0JE2wW/P6lhKNouE63UNF6mt2N79rhzWdifSe6wCqD5jFwBIxoplp3Rm0YC/7DbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771658974; c=relaxed/simple;
	bh=oIXIyVTXgXqfsL1y13UAzfvdybeZ4vRPb7RuRAFNwGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=otWoVXuyLWbVGOR9qODE7W6g3yZ7rcomxcbOdZJxEnPyL772kKk0NX9CWKGC3TI2kfysSz1isRzjXA+zMpjhEs0UpqjEjDgkObFtJu4UBRC31ZmoBLiHezqkr48Y9yqE1SvMVjT/nQZntFlv7fuekZHORsf3ef6KJNSx4sHw0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m4SCE6UT; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m4SCE6UT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771658936;
	bh=fRzxBycTttgiJgGDLBWYb0f4/Eh48IkL758SwW79TAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=m4SCE6UTqiLvo0DR/or4LqjViplhX/kwcIJtTcRsxy0MtOIamPOoVz2Q7a0L3UJ4/
	 Qzas5JlKs5CUQo17M4fWb/hM7TryPNeJF6WahXaXe8u5alyV/IKzPxYZz34CPsd2BA
	 fCWIaOPfXU4ttLD3IjqFH4P1SSwthFFKLxHNWthk=
X-QQ-mid: zesmtpsz9t1771658929t1f66b8d9
X-QQ-Originating-IP: XCrJrTrv6doa6R3lpPfK9dlSiT09d5FYJbAQG6w43kA=
Received: from [10.10.74.107] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Feb 2026 15:28:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16224442729249208264
Message-ID: <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
Date: Sat, 21 Feb 2026 15:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
To: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
From: Ding Yihan <dingyihan@uniontech.com>
Cc: linux-security-module@vger.kernel.org, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>
In-Reply-To: <69995a88.050a0220.340abe.0d25.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M83iEva+1QDBrUmMP2jGgHxL0Jef/aENoYU273oMCHCnH88eyS9TbaLy
	l6kVIHIa+uxeV+R+/kkNa/7B0Vk4rR3bmiND++q114Ch+QGfr+nlV5T+qNvnLRYlqarEmvO
	pMsOoOOxucGzIpdsd69S0VPbLazP8YWMxXt+8NGTcRKaMduMH1rZWewDRzwa6UaBPl6Ggqd
	WnBz1IW1rYY8dOXH0E+WXqYxBbSv2Z+6HfepzLws8e6ITNwJb2ovzrbNh8CT8wOnJqGDpzK
	EKKRDCNSYj5/bAkkw55IyQycriRuSpXaKi3O9bP17IVAfoP/OZt8hsNrkiQ6BK9JT36Gubk
	nixTmpK0R72c4H3Tb1zO4GctwLZt909zfuBXxTlTyPwL4FlZQU5k1M0RtYKScpO0Q4mcR8u
	VH+mtx2UAmz139FcXu2tbViW/3/g83ampnn1yPZxePsUFKD1WPMcbXzANXlio8f61FZ0OP+
	6TGA86/JXdVywymQ1/9cPtnqDiKcPg4Ck+/drLi/QbsQaZjnYirTd8L9QUQr7IJC8xif7is
	4uKAPDq5cNvGfeUvj04V9AnJhcOe/rERH+b3PwnKrUcVTaro7FPXVP3NaEe6FxXbRtYjVqy
	o2R2TRrLmO/uCYdlZTjllWDknYvP4UB4KTy0fpoqTfcQ8DBdyuNVau1hhPPwX+L3+vsTjOe
	FWfomX1ISzpiO3zZVD7ODRXQbq5N+KH5E9xINFruJDhkAuHx5B4qC2HxQwnYGTyg5OVdLhO
	F75yrqym1/HsOQrKHfuUWh+vy+38qqGLVWYaDEFvtD95tySEx7ITkwgbxV7VNqwqxQ8hBNh
	t2seqHUjMRUypbTA9zlbcO4TLsFVc9l/JS5VPsurkd4ia+oguW7YM2ydEpr/eOpCpVhBKNB
	gBVtJR5wIzset0syaODf+pIu1LQ8a/7SxwJsVBwiU/ZQY+nxF3CStR05znZ8Fpl4uw8k3FT
	UUZlsLmg3JN4OWd6TrNji/clJpb1rKKynV0CnctDraQ9E5MVUSxUUFOuWHfsBlv7USMxJj9
	4nZgBAR9xOgpsF3Jyu6698HR8fxK2e4C2GQzY57Om67gObeK1u
X-QQ-XMRINFO: NI4Ajvh11aEjlSFjtspRr9Fmw7ZDpXIlqQ==
X-QQ-RECHKSPAM: 0

Hi all,

Thanks to syzbot for the testing and confirmation.

Since I am relatively new to the inner workings of this specific subsystem, 
I would like to take a few days to thoroughly study the root cause 
(the task_work and mutex interaction) and prepare a detailed and proper commit message. 

I will send out the formal patch (v1) to the mailing list later.

Best regards,
Yihan Ding

在 2026/2/21 15:11, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Tested-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         d4906ae1 Add linux-next specific files for 20260220
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ea89e6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=51f859f3211496bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f0595a580000
> 
> Note: testing is done by a robot and is best-effort only.
> 


