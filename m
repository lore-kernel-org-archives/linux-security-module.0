Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E235F619;
	Mon, 28 Sep 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565043; cv=none; b=AKBa3kN1Y6qQ6+qkVO54ppYVCOOBFXH6e9KZES4Sbwnshkv0CHtX7i0+SvyPTyXCcOrAbN9UWHhnGTu7/V0fJ5jLFrCy12LMtquvTBD5He2e1ZDZa2sa9u93t7/hPTaPk+iaVvkGcHb7FCOUjKPDY9/lj0/j4OaYmfDLE+A9hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565043; c=relaxed/simple;
	bh=7kiacjfJm9eg0o4SwtbMZmSLln96ATsdFYtP7J5a5/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NlBqU3zZ2IbKrMCCj3xGkn1CpW0/5wryzJ8wuIgwTP9IHTPvjd4Wbkiq1q0kb+yVcXtH6+H6E+RCJeMh+wpR/riic9MbHRFAyJmjucQi/h/5B3Vw8naha8E1et9SY0r5lPh+Jf28+MnImV8a0VT7Crj7EDW6HcGMIjto+J/I7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lvj+CEDU; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lvj+CEDU; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lvj+CEDU";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lvj+CEDU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=laF9olr803hHgYq5bUVHMyGweB+jScW/Hym2Kh92OJw=;
	b=lvj+CEDUh0+zZRvZIJCYL+GYuWO/qzhhd5Q7qgYnt2I+nDVdUz/aiYc/IZ01phJcD5inE58kW
	6HqI7Hn0o/Is6qqUzyFLZO4ASADWAzz1au0mPPp9VhiTBboW/DVWXLTqOvqdilDQg3pdQSN5L2y
	l6w3cxJj40MNw5nmCxtvjHE=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4htR9z1VXJz126LtP;
	Mon, 28 Sep 2026 11:09:43 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=laF9olr803hHgYq5bUVHMyGweB+jScW/Hym2Kh92OJw=;
	b=lvj+CEDUh0+zZRvZIJCYL+GYuWO/qzhhd5Q7qgYnt2I+nDVdUz/aiYc/IZ01phJcD5inE58kW
	6HqI7Hn0o/Is6qqUzyFLZO4ASADWAzz1au0mPPp9VhiTBboW/DVWXLTqOvqdilDQg3pdQSN5L2y
	l6w3cxJj40MNw5nmCxtvjHE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4htQwb4hXWz1K99t;
	Mon, 28 Sep 2026 10:58:07 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F8634057A;
	Mon, 28 Sep 2026 11:10:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 28 Sep 2026 11:10:15 +0800
Message-ID: <26ec4edf-8eb4-4153-8e17-7f67376f13a8@huawei.com>
Date: Mon, 28 Sep 2026 11:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
To: "Serge E. Hallyn" <serge@hallyn.com>, "Andrew G. Morgan"
	<morgan@kernel.org>
CC: <paul@paul-moore.com>, <jmorris@namei.org>, <pjw@kernel.org>,
	<tglx@kernel.org>, <peterz@infradead.org>, <debug@rivosinc.com>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com>
 <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
 <araGY/FhiKu61l5v@hallyn.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <araGY/FhiKu61l5v@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/25 22:34, Serge E. Hallyn 写道:
> Jinjie, could you reproduce your timing experiments against the
> SetProc code?

Hi Serge, the test result is as below:

|   method      |   Description                                       |
| ------------- | --------------------------------------------------- |
| baseline	| Per-cap syscall.AllThreadsSyscall6(PR_CAPBSET_DROP),|
|               |   the original gVisor implementation                |
| dropbound	| libcap cap.DropBound() (library API, per-thread)    |
| SetProc	| cap.IABGetProc() + SetVector(Bound) + SetProc()     |
| SetProc-min	| Minimal IAB with the read overhead removed: NewIAB()|
|               |  + SetVector(Bound) + SetProc()                     |
| mask	        | prctl(PR_CAPBSET_DROP_MASK, lo, hi)                 |

All variants uniformly drop all 41 caps (cap_last_cap = 40), and both
the success rate and dropped are verified.

Sampling scale:
- Patched guest, 8 vCPU: 2 boots × 21 runs = 42 runs/point, 1050 samples
total;
- Patched guest, 32 vCPU: 21 runs per point, 525 samples total.

Mean in µs bucketed by actual thread count (sample count in parentheses)

## 8 vCPU (42 samples per point)

method	     8–15	16–31	      32–63	   64–95
baseline    3258.9(41)	6955.9(43)   10303.9(84)   14394.3(42)
dropbound   3356.3(41)	5048.1(43)   9914.3(84)	   16837.1(42)
SetProc	    3365.4(41)	6255.4(43)   10179.4(84)   16799.8(42)
SetProc-min 3485.0(41)	5603.9(43)   10533.2(84)   15146.8(42)
mask	    68.2(42)	92.3(42)     224.2(84)	   433.7(42)

## 32 vCPU (21 samples per point)

method	      8–15	 16–31	       32–63	      64–95
baseline     8422.4(20)	 8491.8(22)   17814.2(42)    21612.6(21)
dropbound    5235.5(21)	 7568.9(21)   17350.8(42)    21205.5(21)
SetProc	     5540.8(21)	 8159.2(21)   17920.5(42)    22168.3(21)
SetProc-min  5582.8(20)	 7907.7(22)   15136.0(42)    22334.5(21)
mask	     114.6(21)	 181.8(21)    428.5(42)      684.7(21)

So IAB.SetProc is not an optimization. Like the gVisor baseline, it
issues one PR_CAPBSET_DROP per capability on every thread
(syscall.AllThreadsSyscall); averaged over multiple repeated groups, it
is on the same order of magnitude as the baseline, or even slower.

> 
> On Tue, Sep 22, 2026 at 07:10:11PM -0700, Andrew G. Morgan wrote:
>> The https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/cap#IAB.SetProc
>> already handles this for the whole process. It can be run from main()
>> if you need it to happen early, and it will track down all of the
>> threads in the runtime.
>>
>> To Serge's point, I am also curious what benefit there is from doing
>> it more quickly. After all, this is pretty much a one-time function
>> request for any executable.
>>
>> FYI The "sendmail capabilities bug" reference is written up here:
>> https://sites.google.com/site/fullycapable/thesendmailcapabilitiesissue
>>
>> Cheers
>>
>> Andrew
>>

[...]
>>>>       /*
>>>>        * The next four prctl's remain to assist with transitioning a
>>>>        * system from legacy UID=0 based privilege (when filesystem
>>>> --
>>>> 2.34.1

-- 
Best regards,
Jinjie

