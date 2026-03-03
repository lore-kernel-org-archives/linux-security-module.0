Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AEB351C05;
	Tue,  3 Mar 2026 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570301; cv=none; b=YRXIeYWjukjppp6q6w/Q0/HYyO1QvDCjqvnOjE+b4K6enATShs4g4XDMv7XlpBG41NNAJCL+Qc2kpnVI7SwbXLUq7eXLnx3j3Rr+hr6De5cEHRWOnGvhGWgEVJQhNgok963UbgaGJQBeVvwkqNNlY63pDdKf+yoVSiuJhFTlPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570301; c=relaxed/simple;
	bh=1T/YxWL2v8R9lVD7UiLsks6StnPWID+aPvX5mjcmXPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJMyCHXVkUmFgkgDKFlFAs17fIoZky48tqerX9OZoSGK0MCVQJM4Fb2yqEDqgc+xYGw6cDDpPLc0PS0nR135FGHmm0o2nVJUNghLa9xeM+QyzoE9vAX3yiCEjjpV2w2OkeFZnVW0SzDrAqxvDhtfNtkqH97uigYmfcgu/XPkQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=M8vj8caC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTmpobIk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="M8vj8caC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTmpobIk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3609C1400152;
	Tue,  3 Mar 2026 15:38:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 15:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772570297;
	 x=1772656697; bh=QnYiFHlC2aMu/x58Iy0NZBM6jbHPpzGafPNnm5smENw=; b=
	M8vj8caCYOkOWe9M7i3QlebbsRontV4AKgiVAygc4qL7n5kYAY/QtChU1dwNzHs8
	4zAi6g05P0xKQfxGHBFY1NLLf0HqiKSfA3DDQucJaAEhJRAkSOc7u8M7qF0+EW2z
	s00fN8k7UJGbh7tOHQvL9wxHneaPGxOoUikzQRBokoiT2Qv4C/n1ntVr+Q+jnzeh
	IVm1dZGYOQF/Flr/Ksc2o9FMAzBAJeYL4SBFGvESgfacmUiun3HY9mxYumFNLfRa
	qO/AA76wbSZMNlBIEJvgneTWSBJ1N3YKwJnVodYdy7IsXr8a79kztn915axbWEa9
	tRi2cPc8Ta8JUSMLW3oR+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772570297; x=
	1772656697; bh=QnYiFHlC2aMu/x58Iy0NZBM6jbHPpzGafPNnm5smENw=; b=h
	TmpobIkW4zM734sdWiy37a02LEttYxwrIm9QR/FDN/NI3P3VjZUriNX1kQAeOj2W
	M+Iiyf0pWr9uaw6EF9Zik5RwmcQWHCI7eByuEZbo1NmVDvuSX8o6bmUALXD3Kl1b
	hK4kNDASeraO3rpNVUXKSo2SdTSttMb0FJZfI8HWkE4pHL9eBaOLlvZVGFiABNQ9
	V6WyQDZoDkQ7LvZSHVVc/dS6HEtpl59doGe0tm10FEAbaw4zCFVoLnqb+2kcK43H
	1q6IVXFj5b4JwOJ8A8Q7Lral02VNq0DiRjcCNieTLGXFKRD4nYsFjWdrnVp82C7D
	CFpF/ei4BBBi2iQnoIzjg==
X-ME-Sender: <xms:uEanaYS_V_S_qNWDkBt7grlSNXt9bGH7GNRQEQeEaVg9D6lZilG2hw>
    <xme:uEanaWPZvvYHi8HNoOl0wZQDkdqx0IdAIbB5dbuY65IIiFYMemAHHSSkOiMgOalCv
    QOqLvy03PsJgKwzivnIJVfazay2fp47_Sug7w7QakpV6GshcRGZYdk>
X-ME-Received: <xmr:uEanaWh93JDXsXbtfLk3GaIWSAFJlsXtyYmS9UzfCTakXjYi0qBHvejZ61Glr-WR9QMZdgNXoKN7zdgmoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeguihhnghihihhhrghnsehunhhiohhnthgvtghhrdgtohhmpdhrtghpthhtohepgh
    hnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtihhlihhthigv
    mhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehmihgtseguihhgihhkohgurd
    hnvghtpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphht
    thhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvg
    gtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshihiigsohhtodejvggrvdhfhegvlegufhgugeeikedvtddukedujeesshihiihk
    rghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:uEanaTm8OAop-dRWW76wbb0nWRV1Tv8J8pu8SoXVHShaHCNmW_aRKg>
    <xmx:uEanaSiTdbl4JAAThcNbBwDA9brwwrK6A3b-n7c49QOQFURPRY1JCA>
    <xmx:uEanaWGZmiJrXiy8hcztRpIJ7IZKU9Mmip4zsaax9hfjCGtwO6IC_w>
    <xmx:uEanaUtMKoGeD5xNLF1yY41TYbrPCtxcOreghYIh1ASYnW78J1pM9Q>
    <xmx:uUanaWeCdqaxL26y0ee-b2MbdyXDIcZDX-M7N6pY4yuElsHaY5-u7Un5>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 15:38:15 -0500 (EST)
Message-ID: <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>
Date: Tue, 3 Mar 2026 20:38:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
To: Yihan Ding <dingyihan@uniontech.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack3000@gmail.com>, Justin Suess <utilityemal77@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo> <20260303.2e4c89f9fdfe@gnoack.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260303.2e4c89f9fdfe@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/3/26 19:50, Günther Noack wrote:
> [...]
> On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
>> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
>>> [...]
>>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
>>> index de01aa899751..xxxxxxxxxxxx 100644
>>> --- a/security/landlock/tsync.c
>>> +++ b/security/landlock/tsync.c
>>> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>>>  	shared_ctx.new_cred = new_cred;
>>>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>>>  
>>> +	/*
>>> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
>>> +	 * when multiple threads call landlock_restrict_self() simultaneously.
>>> +	 */
>>> +	if (!down_write_trylock(&current->signal->exec_update_lock))
>>> +		return -ERESTARTNOINTR;
>> These two lines above introduced a test failure in tsync_test
>> completing_enablement.
>>
>> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
>> (this patch) and is currently in the mic/next branch.
>>
>> I noticed the test failure while testing an unrelated patch.
>>
>> The bug is because this code never actually yields or restarts the syscall.
>>
>> This is the test output I observed:
>>
>>   [+] Running tsync_test:
>>   TAP version 13
>>   1..4
>>   # Starting 4 tests from 1 test cases.
>>   #  RUN           global.single_threaded_success ...
>>   #            OK  global.single_threaded_success
>>   ok 1 global.single_threaded_success
>>   #  RUN           global.multi_threaded_success ...
>>   #            OK  global.multi_threaded_success
>>   ok 2 global.multi_threaded_success
>>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
>>   #            OK  global.multi_threaded_success_despite_diverging_domains
>>   ok 3 global.multi_threaded_success_despite_diverging_domains
>>   #  RUN           global.competing_enablement ...
>>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
> 
> The interesting part here is when you print out the errno that is
> returned from the syscall -- it is 513, the value of ERESTARTNOINTR!
> 
> My understanding so far: Poking around in kernel/entry/common.c, it
> seems that __exit_to_user_mode_loop() calls
> arch_do_signal_or_restart() only when there is a pending signal
> (_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
> system call returns with the (normally internal) error code
> ERESTARTNOINTR, in the case where the trylock fails, but where current
> has not received a signal from the other competing TSYNC thread yet.
> 
> So with that in mind, would it work to do this?
> 
>   while (try-to-acquire-the-lock) {
>     if (current-has-task-works-pending)
>       return -ERESTARTNOINTR;
> 
>     cond_resched();
>   }
> 
> Then we could avoid calling task_work_run() directly; (I find it
> difficult to reason about the implications of calling taks_work_run()
> directly, because these task works may make assumptions about the
> context in which they are running.)

I've not caught up with the full discussion so might be missing some context on why RESTARTNOINTR was used here,
but wouldn't

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 950b63d23729..f695fe44e2f1 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -490,7 +490,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	 * when multiple threads call landlock_restrict_self() simultaneously.
 	 */
 	if (!down_write_trylock(&current->signal->exec_update_lock))
-		return -ERESTARTNOINTR;
+		return restart_syscall();
 
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's

achieve what the original patch intended?

Kind regards,
Tingmao
