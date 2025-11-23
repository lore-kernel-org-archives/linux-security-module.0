Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81F23D7E3
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931816; cv=none; b=DzFUW6Bwi11cde/emGojWic/Mke6xoCFlcUE/tQII645QXn/tmdOKByVJt6I3MZDblU2ijBekxOIiZiGjNMByC3Xe/sEaFRgZxVuZ/gigcusqWheEX9t7h4vJz5Zltk9MiwUPYux1kM2NOIwM54AfxTCncYXpl3FXzAHJCcjbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931816; c=relaxed/simple;
	bh=fjz83YnHLTkqHD33N94AYtW7lZyJWG9FzzI1Xly/RSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBdKlMEdTkkIPO7UwvtpFUu9rgYf3nrsROcnwMyGhwwpNnrjJVGDD4173rCLrHAawcl+Nw34NDUolTr1AN1Ki1DwlHKODVH6MS6nDPT49XbUF/uCXzdVkWndKg77LDvHdAZ3eX7uVVn3xrN3tvt63M83cY2V5jeF8Pjy/CfnhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=I4SMwrZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uVROYVki; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="I4SMwrZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uVROYVki"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA16714000CA;
	Sun, 23 Nov 2025 16:03:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Nov 2025 16:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763931813;
	 x=1764018213; bh=aFqfs0TMDQl9TuE+G+Rhp75aChQyWcRAFbnUOHdyIF8=; b=
	I4SMwrZ70baBf0Ga2AGQhBeE6ipRjefSiYvorHHvunN/UNXXiy4wkttuPJwLk50O
	6gZbwLWVWtcNcOmgIBQEKbfNFVQsICcDlrDycp+4Ozc6bAjE5/oD0PiYyNGvQvi9
	vMFXv1NQxWgRoHK9NnD/AF6OlSSDEVOR9V3V0a6U3e+nwTM9ADXS5rNR/4BRfZGS
	Q/lfK3KzpZdzSD9CUiYOhRjPoI7fmNBhtHa+0foykFVuiNFwf6lTiRifj0FY+ora
	Xku3N5zx7WfU589QLRAefBn4qsXvkIIiR/ridcCL/dRds7UgCPj5w2TonbgfrN6w
	RzaRAZ8ldefxuhgIcZvBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763931813; x=
	1764018213; bh=aFqfs0TMDQl9TuE+G+Rhp75aChQyWcRAFbnUOHdyIF8=; b=u
	VROYVki5ZHcQgZeCVlAnG4yjRdJ2k4j1KftBuc1seka9i/wu2FuwsADtGFUTPN7e
	EOJQLkB/Y17Bq/gmcDh4Fr9YUc/1XzqnvCk5jp8dFSpG8pkhfvM07NmzSRZlBh0b
	WpTlSk4m/FnppkNuK2SJBmzNnyr81DV4OeuyBveUgrdxUGtovKlTR4O+urYSDyqd
	aZkzZL0cX9JFKulibwy1vys8DqfixainHwZ2UZ7R2EW9aHiIqEXpe8WBfT2Kk3eP
	UcvMKQjBDukjPtBCatP5hwIshT81CUDIPy4K6u/c0Rebeqfel/AsFEfw84g3bRtQ
	X5SixMUHRxY/g7ttxB2pA==
X-ME-Sender: <xms:pXYjaZdhyLUBxDNwuaxBmUUVOcAbLWkhyIcMpPyx0u447NMyreXbOA>
    <xme:pXYjaa54pE59ntdZHBfVuOfJuxWqSQ2-Kld5KyU4yMe9Cb3nH1epqWALFZKWVgUuo
    XyJ_ttmw2mieRqcua9UDTiauSm3BVGYFJLU4mEyuwQwHoSFcudSssQ>
X-ME-Received: <xmr:pXYjacUQn62Iti69uPzb_VJDeouGEMSiU5LgGWhDJ6-nBKdSjc-jU4Yw22gFnd-dEEP2oMOQLw1pl7n0lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dvheeluedthfelgfevvdfgkeelgfelkeegtddvhedvgfdtfeeilefhudetgfdunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pXYjaZ6RVAWUJ724e6FeHqMNye9mSQ5PSmQauQ7erTGkKfl7JrH6WA>
    <xmx:pXYjaXrD8-dXIx6Ag6m_vgrFhywiQzxdwTTG1oJsPLMVEb7mftIAwg>
    <xmx:pXYjacn1EVS_WJkmc_vKFjXcnhYBR82EhaM-rRl9vIoNIbqaUlVjWg>
    <xmx:pXYjaTOzzN9BGvfnORWN9UMLVYi-1yb1S8yaInpA-TmCrPFFLK7ZeQ>
    <xmx:pXYjaah7pWJaE-KN7_H8etroyhGYSb4dkhAJ7JIe14Q2NKmAKo_ZyexJ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:03:32 -0500 (EST)
Message-ID: <59aa2857-46d0-4527-990f-03fd6bf13305@maowtm.org>
Date: Sun, 23 Nov 2025 21:03:31 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
 userspace api
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
 <20251120222346.1157004-3-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251120222346.1157004-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 22:23, Justin Suess wrote:
> Implements the syscall side flag handling and kernel api headers for the
> LANDLOCK_ADD_RULE_NO_INHERIT flag.

I guess you probably want to change the comment in add_rule_* as well:

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 200287a34895..650ffce6f92e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -352,7 +352,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it
-	 * is there to hold a quiet flag
+	 * is there to hold a quiet or no inherit flag.
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -393,7 +393,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored by network actions.  However, the rule is not useless
-	 * if it is there to hold a quiet flag
+	 * if it is there to hold a quiet or no inherit flag.
 	 */
 	if (!flags && !net_port_attr.allowed_access)
 		return -ENOMSG;
