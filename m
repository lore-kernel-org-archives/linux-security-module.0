Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC74472071;
	Thu, 17 Sep 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645006; cv=none; b=jTzHT9O0sMRtIojBaPP1iAVR0ZlqqRXb1CF7AnL01xbMtHbkdnBTXZxu5d6Vq+IppI8H3rU5lnFmQpQYo/3vKPgYdb1aTZ06PiXtXQdoK34+ptdc0GF93xrZkSJcBvZi70nmg/jfhfgfVe9vXNzBoL2hXGVoAihjE2Wuqbgj8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645006; c=relaxed/simple;
	bh=wnVF4EDSgyK6ufClPx8Vkw5CO0NpbiMXFip/7WIQvMQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Sf/szQWNbWCePnIU2oZjFhck3a5dsmLKG3Tqn/gzX6s3AroRPuaJVHjMXebSfXmfk5pDw+6c7Eu4W8c7TxVk+neig+ZwC72/DqUI5VXbX7MlF0OmWbaGHYKPwXsxjkw9d6IuCv1jCRFUlJdiIkwk80lhf+sK6dQUD5C7Fh5Ioto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iza2NPC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAJHFcp2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iza2NPC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAJHFcp2"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B357EC00A5;
	Thu, 17 Sep 2026 07:36:42 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 17 Sep 2026 07:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789645001;
	 x=1789731401; bh=ziPVSX4/3cQB748F1o2ZX4kZiZbJlTcRzcCjsKowjHY=; b=
	iza2NPC4mZ3pvoRung8Ay5RDxQowHHRGJ8FMjy9RjiFmznc2qSOqK3X5x8hjvIQC
	08lk3DplldfaPvbcPXpdlbj9NBx1S7GHdFG6E8IUG8VePjTxFaNVWP0ZvUCMSWaT
	9LlF9d8/i1yzuA3L6bls5tCazF+8udhbjjny37NMiMvF5UZjKJtvPJBhbGTXRDGn
	NtYUmtfXhYbaWfKv1NrJmP5iUiK6PP1uO5rBlHELetRzQsXYKaVhJXaVa3CpOOR8
	gDTb0oyxgVtJixzQ4h/d5jAIBTxS7dWy2mY03Gn1wdcffNwybNxSFsjdU3HUv/6h
	a/IY/dVrKmfN5xF9CQt8oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789645001; x=
	1789731401; bh=ziPVSX4/3cQB748F1o2ZX4kZiZbJlTcRzcCjsKowjHY=; b=i
	AJHFcp2bT1RdX2RsTr3Em/95nrBinrE/zUotZ+m56zIU3EoCoKKaF2YfW4bbaZ5b
	rn+hsMkKPsm+PilLGpqoHaxLWSIdiOcI8kwWHdnBTr6tm70mAgBRM6oDyp5AqVhi
	hrQJP/hZxR6RrVwkblVG9/z1awQLOr+wYLhdtrWulk80/klpDO1GMotG5/43lHYy
	tzgwSe6x3JaUXWhD4KeuuDQw/8kHwu40fihk15EVtM9MHxJ7nppLt2ahWphNMvlk
	FbjWTpx91Ap4QTw4c9RhSO6Tc2+3ClXyHTXSEhE85kzBHKJgEbCLdjgx1RFpDlQB
	ol1J/ZU9NpGVE0y8xYZQw==
X-ME-Sender: <xms:xNCrasfu5B7Hea255n73ua47tOhvrlxRN_cpz4_CURxepqSmJ83iTA>
    <xme:xNCrapBIA2NefeSyRahTczoDNojHDVd1RLIouRGb9bHqC6eyRBfcak2UiFUCm8Pt4
    DAysVdriXfi_D-a-ZUd55ldw9f_qS4A0MWLW3JlupK3Etbwkj_hno47>
X-ME-Proxy-Cause: dmFkZTEP9uUHDX9dZsqDF5MTd3hSYSGi/ykCJR/t5N/emZ29OdpuQijn00YYtcHqSDQ7/9
    0xONnZPrHgy9cWTWveWtEeIkn5qf+Yagi1y1biJxGuyA32dNpBud8+vXZNzahA7iExbqG1
    zSb7dBmgVbJQM9bo2JLtu989R6Y0th4217limY/Y10DHACHhlwL9cZdNKDEyhqvc7eO8XW
    EFnyytYjFjQozY2uX/+OP6xfPWWQmORtuTMNbMsimmdmFDAM11D0qL+fyFP/5j/xEFTK7C
    ladkSLzqO+YdIxYY7NPCiOEFYRtA4XuVjvHJMV5gQxgtb1iwgdezHMlKM3fKXWBPfRnZAm
    t7BXZFzNmLoOOmcJkJL6Q1L0nGYyvzjbUo4Mkw1Wb5c9PczuLvwt8ZmTTl/fvRzMMJA9oH
    HFTdEet+UOzXurbXKQ/94rGlt3P7Vx+2eVKSgEhqGtNYH3SItq7VqHVZUXvpwf2VZs8OGp
    CsebyQxXqjFQ6H3zMVYkRmD0s3zFnKuKnYN+fAJJPWiROzc9PCx0ITAujnOwCjCNqoXjA0
    j6Y4lVgxOC//w5K/vjRPPkAIs8zQ3kLWKtJn8V09bKHcoYmK2eO/krufwcy1WjWDY5bvay
    96whB0gpO2AvBsUaPscxr5TYbpNUCz43Tc+jF0H+I3Hs25Xua8ZHVXfOn65Q
X-ME-Proxy: <xmx:xtCraoCcf914H0Mia0HozzhJT1qdn0Uv65BhEulf8S9arBXx90Q9fg>
    <xmx:xtCramZ11TIPFX7voeD2VMPInRyvr0GGRpIPQmjA1DMoqnGCJNu-JQ>
    <xmx:xtCraom7L-o0kFca2nPOVUxP9nlxeqOBjwj0WAykh3_-vERmMdZpMA>
    <xmx:xtCrajpaTQbzYFM-7NfTqUqCv7nS6t6tZQZxekH-SDgIhcWP8k6Lpg>
    <xmx:ydCrag0iNIUSh52yf0SFfzjOxFkiRQe7WOROVCMNVSDmQ5fHGp327eQU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2F3F132A0084; Thu, 17 Sep 2026 07:36:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMQlh5H7f1Z-
Date: Thu, 17 Sep 2026 13:36:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Arnd Bergmann" <arnd@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Tingmao Wang" <m@maowtm.org>, "Justin Suess" <utilityemal77@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <95e794f6-6ec4-4b3e-bfa8-7edae0ac898e@app.fastmail.com>
In-Reply-To: <20260917104544.3trW9Jq1@linutronix.de>
References: <20260915201036.3527935-1-arnd@kernel.org>
 <20260916084947.6QDy8KZQ@linutronix.de> <20260916.shai0tha3IPa@digikod.net>
 <57b5869d-7411-46e8-ade6-6d2a7fea02ac@app.fastmail.com>
 <20260917070915.Ix8TOn5Y@linutronix.de>
 <1192c2df-d39a-4d43-ad57-68b0167759f5@app.fastmail.com>
 <20260917104544.3trW9Jq1@linutronix.de>
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2026, at 12:45, Sebastian Andrzej Siewior wrote:
> On 2026-09-17 12:26:17 [+0200], Arnd Bergmann wrote:
>> I checked again and found that this is a config that did produce
>> the issue a few weeks ago, but doesn't today for me.
>> I found a different config from this week and managed to reproduce
>> the problem on today's linux-next using both gcc-16.2 and gcc-17.0
>> from yesterday, so there is still a related issue that is not
>> fixed in gcc, even though one at least one of them was fixed.
>
> Confirmed. I see the warning on arm64 while x86-64 is quiet. The patch
> fixes the issue.
>
> You might need to update gcc bug tracker.

Correction: I noticed the failing gcc-17 binary was an old one,
the current snapshot does not produce the warning any more.
It does seem like the fix was not yet backported to older compilers,
and seeing that the final gcc-13.x was released, we will
continue to need the kernel workaround. I assume the compiler
fix will eventually make its way into the other stable branches.

      Arnd
