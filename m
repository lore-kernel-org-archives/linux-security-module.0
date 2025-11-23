Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380841E1E1C
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763933828; cv=none; b=sqBFIaXajuf/ErsYQPz9d4gxbI1megpotcNPNeMksXbk6xzmusqAzG1yw9T5FuSD0m/At/Nxo0TqQbDCOAgNfEW9PKa+GaIHFlt+xXdUZVzKuFtt6Y6QfZm2ufuGlnQ94DEaUsSYwb6dGTuI9/gLvZoGJypWBw31YGYAdBl3YLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763933828; c=relaxed/simple;
	bh=ZQ22wxuQUX5hMETZm7Mx/CtoeYhL8jHJXYmAcBItRBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgEojrErhuNZWjSFAiCucVBqZXcQz77yN/i6NHEL5Z+23Fn9v8s3k52BIGITx9fqLsuGOV7nRu7EcKj12TIWYkmctoGD91jTaCdr+WO6cd6+aBympn4i2k2768BwAQ1l7aAHEfCcG2haKYPaamuzgiIl+vnESGdHxvlSdsM1sCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RlxIY/SE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aa9eeEiN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RlxIY/SE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aa9eeEiN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E4571400157;
	Sun, 23 Nov 2025 16:37:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 16:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763933824;
	 x=1764020224; bh=0rAVP+7Sla28XDxtQnIYatLxkrYCu/jYLXmxy2s5bSc=; b=
	RlxIY/SE05eXiAPviQAy22djC38qCVW11PjtOejd23JzF1W2DLmHW3uofoWRO5Gb
	iHbjmy2KL2ggFRtqFV0mj3ZF0LpskoEHQiJdUM+5pxO6oK+Db+zDVJRBF2o5BX9n
	l+R/FysK6GGsIcbYQAqWQo2JCOLlWwb3tDF0/CZ5yAvLtPW4vFsDfpBnJkkZIeAc
	ooMIdtZ+1eJoCU9gdQ/iLKbugCg97S1VPxQBBHiyJ1JgMlsOGUzF3iDxGgW8kF9p
	tdJ8p/4gZEUmJIeKGGiu3J1TElW5Zr+vdunwgrH6En43cgIdUw7LQYvEgIGkiliZ
	tFoKYhlmS4EsSa1LXHoKtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763933824; x=
	1764020224; bh=0rAVP+7Sla28XDxtQnIYatLxkrYCu/jYLXmxy2s5bSc=; b=A
	a9eeEiNqzLuAQum9EHPHOPVn3iSWqmufSNrGUryrUhVq8eBjKKpU0saMEBXxHcSV
	ctOUYXZb3c0JZZ0Gr2n61X2TcT+fd53UO3qMawK5XCeQ7pJ09u69DV24K8TEw/bz
	6UVYr8mnV/nEDMTsQHhIYdWrGhC53FcFBaM8nPgtwUlftgK3gCWl9QFveYvg6KA+
	B4ZZFuZM4o1P0Yt5Xzs6+MgmbbQYaq4B0O9g1ZTG35xAPEv7tPeZznYA/QYv+7HF
	lLLvqjio8yxQmgURPkHTTXYQQeuZROM2tDK3zvQuY0drt6TlY2uKgB4WClnKz1sp
	ha3kbzMaFE7gjWE9OIpsQ==
X-ME-Sender: <xms:f34jaXsR4yJ73Nsadq-DxEo12l75pCHu8Sa7GHSu-nS2W39j_yZakw>
    <xme:f34jacI0OJt5aDnq2o0X5-8zCKPGFBZkyIBBDdYLBDxOv3hemJdLCDvQC6oOnaOyI
    RU7wD_GcubpA-qp46sf3AY5ucpPYwetkvpPMyjDapU4um9u6mklR1U>
X-ME-Received: <xmr:f34jaUkd8L1OXKFmsrKxOhendYdFpKN1hWZWsEC07YsO3SHyItzuInN_RgCSre4v75YwxzXXrPgfoAApeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnh
    gufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f34jadJ9xcp6UB9qUzLskaq_rAeIFUNSmQDraizOPrnwAOlo1CBZZA>
    <xmx:f34jaZ4NL0U6aL_rl2iNZmHY8IvPXin-khGgNoneK8m_BPgtPHTRtQ>
    <xmx:f34jaR3fHNwd3aQR7ygvBtwWsWyQ7aFCC67cTfIGG7fWhbI6CNW-ng>
    <xmx:f34jafeDg4vwkxsvOzb7ZJLpR6L7bLucmNMa7i-ILPJypMlbvCR5Qg>
    <xmx:gH4jaYxx2AEZYfqTA4gQ7u9pizL4EOTlJixeVYGwdCO3k1ZQYucB2cBe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:37:02 -0500 (EST)
Message-ID: <24b9b2bf-f84c-454d-9aa8-95ec19916914@maowtm.org>
Date: Sun, 23 Nov 2025 21:37:00 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] landlock: Add API support and docs for the quiet
 flags
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1763931318.git.m@maowtm.org>
 <f78d2189e01229cc3b3f6138c19617b653ab9a19.1763931318.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <f78d2189e01229cc3b3f6138c19617b653ab9a19.1763931318.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/25 20:57, Tingmao Wang wrote:
> @@ -185,6 +188,8 @@ const int landlock_abi_version = 7;
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>   * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
> + * - %EINVAL: quiet_access_fs or quiet_fs_net is not a subset of the
> + *   corresponding handled_access_fs or handled_access_net;

Oops, not sure how I ended up with quiet_fs_net
Feel free to squash (or I will in v6)
(Thanks github)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 93396bfc1500..5cf1183bb596 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -188,7 +188,7 @@ const int landlock_abi_version = 8;
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
- * - %EINVAL: quiet_access_fs or quiet_fs_net is not a subset of the
+ * - %EINVAL: quiet_access_fs or quiet_access_net is not a subset of the
  *   corresponding handled_access_fs or handled_access_net;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
