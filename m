Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2629D26E;
	Mon,  1 Jun 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295682; cv=none; b=XH9CxsFDVk2E9j2eBrhExo5v1jJWEjL9WrjbRIslxUaqBSrde5WE5bZ2EivcO1l0eHiqLdt7NMmQZsKnNuKiWcKKPVifgDZTbFbe53zQrRzh+Jl4a22BltnY1gclo5zyv+A0NDbrdTrqPOBSUPNallKKXy2zjYjnQPxXg/9Qimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295682; c=relaxed/simple;
	bh=mSrf/R2wyHFDHEO472ySgeqp9iRKsHdlQgrj43CETto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLQrKg+Moapr0lk+bWP8ceTMircG51sbDEivk0nLZ10Nkfmm40Y+bu/gv6ZJIupglJIvGkbSHz6kqDWUQmAkIFYNhsTDF4NvUJWsu6EfL7XfaURCOk6IKyBPpIhzURzs5Syci2LP5OyQDfqT6TQ49BdEkQAf4+PcMWceu+7C4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=T6KbjBKM; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="T6KbjBKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780295660;
	bh=Pa6uM69zAhT8Ksi94xXsM/bpX6DRtWUW4iiySLcqwrQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T6KbjBKMV0/j2zLh+Jp189o+0QFhwY6MWZo+lIxCvplk9QcM8hOB1Iu0TMBrHUJgs
	 mjokCJ6vZUVEU09qwRnRFIb0iqHehp84HqPPLqtXkJevGysniMKqV22lUQYv3Ck4pu
	 xArfuII/08qwuAIRTBE8Gz5LxSSBZhKbuBwMUX9A=
X-QQ-mid: esmtpsz17t1780295650tb6ae4d84
X-QQ-Originating-IP: /Er2uKdRF2ClQCcCIflW8DJzaoIWDrcea6D7ndD6tHM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 14:33:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5380624521232554661
EX-QQ-RecipientCnt: 17
From: Shijia Hu <hushijia1@uniontech.com>
To: alexei.starovoitov@gmail.com
Cc: 2022090917019@std.uestc.edu.cn,
	M202472210@hust.edu.cn,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	dddddd@hust.edu.cn,
	hushijia1@uniontech.com,
	kees@kernel.org,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH] fork: Ensure copy_process() returns a valid error pointer on failure
Date: Mon,  1 Jun 2026 14:33:49 +0800
Message-Id: <20260601063349.2524658-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
References: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N5TO0aYJJX6YQmwDo6Tu5DLQ3GUrNZfek1SULcnvvojfRN4Q7+wbES7Y
	b1AU22OOgqF7pGhZYv9NQotrTzw6CdQMZdmclkSoMgvm71Di4mPPUc58HZ1DGZyu/Rqr+zp
	eJDeNkiSrJXjWQt7Fmf3VM8Al7ti0ZX0pWQ/06AGXhJBv+goAwQVLWdVe3Ppgmsds9yZNt/
	Z1idfrnPNi5AT1Y7MmDYITnSKKP5GDLjkUhCxwtZHkF/zBKyJOHBSsV1GJOVl2hWEBnfFWn
	iabHkOudTZeKgpx0MeyOcJ01ggW2+TVvu6fYmBomFyXjGKBTAK+tHlctodJhXV53wPS6gnn
	oHokPN4unQLAa8bgb0L2ftvcxVHfGjYh8HWU/iUKYLMKTdUjbsbf0meLl7V48nbGp1RumV1
	wp3FEB7uvNIeAgg9giyvBVzUkqh6GM2HbY3lxfy/24rUDg5BLcRmVOmnhY5dyhqrWc4OrlJ
	xzLwkWk44Rb1Cipipz3g1uo/STBAI8MpNEAby2a5VGJDwbrwIYzXEQB8OEPx2Cnc+F5OryC
	XWqJJPt1Vvv1p909zzfyX1pMlCOSbkqf4gL7uv5P3zPL7oVwqLdnA5kaxM+ae6W+JwCpMXu
	Pr+CnXHFXG43mJe62Pi+mi82P+ZyzvvrzdWyq02AbP494jaTsUUkKKiGSQZfJN/ROWdTqJG
	fXOBqFrZII/hodTbmirh8Aw9GO1cDmLcoOesAx8qQzCom1ORpac98Ye1NJs/ZuxF5GNgxnA
	ERXcQvxLZ719z6bZKwN0eGzv7RoZrDiq78dnrnCGb355im6dfb8/3aTW1G9oSOlEftiqFHX
	qhTm62AbVMO9Q6D2m9Oz9y6F8RXD7UbeaAyS4GB7oYiUNWFDTSW3asi8IerUWS6ou3r1Rid
	VfQJkKIHwXCpgs+EWROKzlp1gSm/BInskr/NtYD0BanzsWluxAlETLam+oY2mi31yHtYpQI
	OT+SFjHeFI+9PLy/aqYNynKXQggRiCDrxLRD57lY/9h/cmBOjhnvx9Wrgk8s/iGiUYHc5XU
	uJtKN482V7YcwVdDVkTLXGEFFuelElEK9XMq7nuuvVyEyw9LA10LPmavVkvGolw886BihIm
	TAO6Fv91ED4iLfLFACz1pVn80cIf7WhGA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Sun, 31 May 2026 20:58:49 -0700, Alexei Starovoitov wrote:
> This was reported earlier and there is a fix in the works.
> This approach is incorrect.
> You have to fix the root cause, not the symptom.
>
> pw-bot: cr

Thanks for taking a look.

I'll drop this copy_process() approach for upstream.
 
Is the follow-up fix still being tracked in this thread?

  https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163.com/

If so, I can follow the progress there and help test the fix with the
security_* fmod_ret reproducer once it is available.

Thanks,
Shijia
