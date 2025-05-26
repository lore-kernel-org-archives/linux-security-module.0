Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCC1E834B;
	Mon, 26 May 2025 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284686; cv=none; b=R2vhB7+eFYpoc2k1yYBBOmiaisBoYdf1I0EQ7KRVEpiDKbVkSu5Za3MicgE7OTIvhKKSWJwBEUirQcraLPAWfErz9wwyfPZ2jY2FuRaKuGVwHL14JOVELWbOHGr7VJsZevhoF7zNMmhDxBTr+6IlfwyBJsSH7zr4pG8Cn/sM6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284686; c=relaxed/simple;
	bh=VNAq2FAXqBcgIybb1kc5PDOUXgZ77UwzdAhjfkqMHdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHkr07/72eZG9ambZA5Uc3Oo/uiFRdqRMTxOawYrcSKDuD+erbeG5VEu53OXaWXfuNXuTD9WY3AJGq12tNgiojMWUoeKhwQTLIhya61+nWc13TxxXqEVYuE6fh6zf8Y6DfmThw0J5oMWYvEaUPsGbohXOMJohyXRbvUT7PrGcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=MGGW4T2z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHnA1mSM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="MGGW4T2z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHnA1mSM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CE8825401BC;
	Mon, 26 May 2025 14:38:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 May 2025 14:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748284683;
	 x=1748371083; bh=zt4Z97l7Qj2wnxf4XdSULDTeX+4SUZGhGdJ4L7aO5SQ=; b=
	MGGW4T2z/FkOW4VY1a2f+1XF/StPX6SJ4NOf3/5xIBqZu1UTQkbOw8EY2eBGhgkY
	JU+vGia9SLrtov8SEdoyfU5QPnkQzD8wSJNwfeKLItC5Ah0j1AwF0Jc8taRYopw3
	iXtuia+DwlHpNZ1xOrNm1ZkJ1Of9i/KciumVo+NUgJUKeYxaFyRNl/uaui9tr/uN
	Rif6Kek8HKNoZ8yRHSZNcTSb40cQbJNdrtQKTIQDu2fJBNbzMWco1HJyTv+qvipH
	4sGtGqg/l7B1VKMB0pz9l0mnDwxDpimNwLT+3lKMVrbMjGQJAuR+7gT9dwHQYi39
	D12BTiuUHuC1sbe0V6LI/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748284683; x=
	1748371083; bh=zt4Z97l7Qj2wnxf4XdSULDTeX+4SUZGhGdJ4L7aO5SQ=; b=U
	HnA1mSMdmmfkVk5jwsy+zH2D+Qw7frsYqubvsGkv6KvHouRWJMMHDf9PUa3n4uZw
	68Ow1h9bo8V47IpvG8QpaKbDIdejGOzLDjyrscl5KPZHZcGPCzU57NhVaZT21mfy
	Qdzq10sUjLb5Net4ZT1R1cYK/bnu0+SzjJFyoebDIIXpdG1g7mYZQWJjzqXgI+91
	ZKdoXG0FudTyHSUFvO2icqGcJTmotodbMSzPMstLYo6vCLtJdjxNofyHstaXLW6s
	Zjt5Wg2gsqUVT4iqdBfRf/bm92Y6qvwRYgy7GQnVdw43SHpI4EBU+vMvwLvebbJC
	xc9PA4XRZHA5yavjPtOlg==
X-ME-Sender: <xms:CrU0aO2lest3cPsj4aBlCjv20ryhSStM8oJOCbuKIZdvnnyXxW_gEQ>
    <xme:CrU0aBGwvZiw_2reRIsid_iLrIdEXirVRvraiH99KdJRgon1kYlo7L9EOr20TAs_o
    VT3hi8Hb7rKQp--3RI>
X-ME-Received: <xmr:CrU0aG6V_3m2_ZYJ4eyLhJ_pZkOgyxhOADTdJwi6HsX9wfI0XSviOqCu0xQLzd5ThfhBSwjvE5aHDZooyXcCq1Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedv
    vdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguih
    hgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtoh
    hmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgv
    fhhfgihusehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprh
    gtphhtthhopehmrghtthhhihgvuhessghufhhfvghtrdhrvg
X-ME-Proxy: <xmx:CrU0aP3fXvw_ENpWSdE_msKd3NAQwJyyY7KeyZs1co93ydm-Y3GYrg>
    <xmx:CrU0aBFxItGdK01nTavtZb9P9DBvHWJANN31_cmw44wQJ6qrnqHTCw>
    <xmx:CrU0aI8G0nfTrKOZcOmZSw5fzlfVVtI4yMDKdkFc21VfGRS6TCZk5A>
    <xmx:CrU0aGnWwjaKpkoIUZLMslrtViX9Rh5TOiYfLhyaiQrm_wcbyHAYJw>
    <xmx:CrU0aEp8-htf1hFPtrDFVAfwsc19WQwIv3eHXZRkWeVgxGUIuUoExSO9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 14:38:00 -0400 (EDT)
Message-ID: <112ec51d-523b-444b-ad7e-7b1b3d56507c@maowtm.org>
Date: Mon, 26 May 2025 19:38:00 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/5] landlock: Rename landlock_id to
 landlock_rule_ref
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
 Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Ryan Sullivan <rysulliv@redhat.com>, Shervin Oloumi
 <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-2-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250523165741.693976-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/25 17:57, Mickaël Salaün wrote:
> [RFC PATCH v1 1/5] landlock: Rename landlock_id to landlock_rule_ref
> 
> This avoids confusion with the new Landlock IDs.

A very very minor suggestion, but I think to someone new, 
landlock_rule_ref would sound like a reference to a specific rule (like 
a *struct landlock_rule), but really it represents the "name", or in 
fact, target of a rule... Maybe we should call it "landlock_rule_target"?

(Or maybe the confusion is resolved quickly when they look at the 
definition so maybe it doesn't matter)

> 
> TODO: Split in several commits to ease potential backports according to
> stable branches
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
[...]
