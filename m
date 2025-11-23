Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9436D4F0
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931622; cv=none; b=XAydRGAVErfqeJE5i4cATXmGF/lKIwhJdjO2OZf5Qo+Z8j4o6D2U7eWSbMg2m/2V0yXq5u+edZ9qzhvR57VfGQHeuZbcNQ2i8NCv9GdwwI1/mrP6RlHE4m3yDUTWA+BaVPe3LM6yglAfDw5VAEF/i5WvNSnOotC6Imz9SZ0a/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931622; c=relaxed/simple;
	bh=9FyvjfkT7Qtnnufmm/AEmald98UNxiyDjvz+/RWMmBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NL5ycYlxV+3DWiMKexph5cJtdWR9+P1IgwxQs2UAcAPvKzBO9hND3k9G9k6q5PyP60L6PWkdZbN5onXpttndjOsmtJNseIlCPgKK2NAqFJcazRAUpzeIF8xLtHSt1yjl0cmREhcWkCCxQenU+DbufQAubw8csOrpbiGMKsCuc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LqMr/5+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSdDGvbf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LqMr/5+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSdDGvbf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AFA1400176;
	Sun, 23 Nov 2025 16:00:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 16:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763931618;
	 x=1764018018; bh=tgxstepQHm0Nnw5/mB+ZuN5dxA1UAFKMljjC1zj6I/k=; b=
	LqMr/5+A+OmcDcQZu8jnMvvWgiZCtiBF2aj91QnyV6w2lsC/YnnI4bUncoI08ix3
	HfyrEDo9eGzp2EBSWGrmBfakQEw8I6qs5cosg31b7tC9ln7GHJwxbuvLjCLfKnEQ
	zKZPjtYiML8uihbuE0dgTui8owZvHz/xkK7is8BOLrJ3128dk6EiXjZ3pwfCJgoN
	SjTDPhWsIsc81kZMHm8eNGYJMJO+wn8L7nWAjoM9Kxljsft0Oy1Uk/Ni+0w1pzDL
	+MAH6az5wSHYZuu7OvDz31jF/5duz+zpf6jJGWAB+++/td6nAh6H/Fw5HHgj2PBS
	c9f0D8g1EeyDwLWSrruwtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763931618; x=
	1764018018; bh=tgxstepQHm0Nnw5/mB+ZuN5dxA1UAFKMljjC1zj6I/k=; b=O
	SdDGvbfahkbzxVnXWVoJv5pgeoh0xIB6twqZRXtrUIoiGiafOBhT0pB2Lc3OmDFz
	j5+YilUEJ5fKGOYARFckNfsgICVy/D1L+q9JsgdwxIz+2AfkMWD5bzOk9BI9X4D2
	RBSQdOgpySlBLhd0xty71nGHfk9LAv9eTMwRstcb3ilKyRe6FdN+uVskHRt01pg/
	SSQPNOnDvetBqxFmVJ4W5AHmIDcOJIJt+hrbxvlDLAtZSUSPKTsF9O+MLLOa9TvN
	lBqGYtL6TjZMuaFw8MbjWbky7ps29hd3mAmsaKQqtlj4qxPEZgu1demdahbgUA29
	Gp6uTijccMKvYAI3hjiKw==
X-ME-Sender: <xms:4XUjaaCcVpGx84HpmYjtKtxGZasl6wDOEhHN6LAZgKP7O2qXeev3QA>
    <xme:4XUjaYOxic0hhwEhTuq6W02x9-X0nGPC_C-YHA_A1QT5lHayRPEUb6pXLpc37ifk0
    g0_aEi3rYUKWxCCAREDvngG0_FIeAMgNjFAnXFurSbsh4HFdpkplPI>
X-ME-Received: <xmr:4XUjaXaho8Dnh8VKIoCKotX5ChgJO46Jag2stKo-TlomdktC5eDrVBFByFSyGElVGIa-F101WS5GmUaVVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnh
    gufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4XUjafsycRnkAdNsAquPofUrz5U_vyVHauRPESfPuLotr4aYtFyqNg>
    <xmx:4XUjaRMG2pht3GuXaLxrlF3l_OHTQ-9xdfw1nxmaHfYA7vLKneBR5A>
    <xmx:4XUjae7G_Zj_cuQx57OfXCfdTsiCSpMlDHu_POdj3hKUdNSVyziv3g>
    <xmx:4XUjafT9N_r0dZL7JWIjtXw5Q7OLsHl_pRExdfZpIUaEXwH7tmNpOQ>
    <xmx:4nUjaTEgFEGwzRkmp_BxGNLljRPkj2zWpRWmix92BpYSO0KKXJg6Uxp9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:00:16 -0500 (EST)
Message-ID: <c79c1f19-7592-4533-95da-2299f99a697d@maowtm.org>
Date: Sun, 23 Nov 2025 21:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] landlock: Add API support and docs for the quiet
 flags
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1763330228.git.m@maowtm.org>
 <cd79fcf71e6d38ab4280c0de2500fa5f6b06cd9d.1763330228.git.m@maowtm.org>
 <20251120.Sae4geish0ei@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251120.Sae4geish0ei@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/25 15:27, Mickaël Salaün wrote:
> On Sun, Nov 16, 2025 at 09:59:32PM +0000, Tingmao Wang wrote:
>> [...]
>> @@ -69,6 +100,39 @@ struct landlock_ruleset_attr {
>>  #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
>>  /* clang-format on */
>>
>> +/**
>> + * DOC: landlock_add_rule_flags
>> + *
>> + * **Flags**
>> + *
>> + * %LANDLOCK_ADD_RULE_QUIET
>> + *     Together with the quiet_* fields in struct landlock_ruleset_attr,
>> + *     this flag controls whether Landlock will log audit messages when
>> + *     access to the objects covered by this rule is denied by this layer.
>> + *
>> + *     If audit logging is enabled, when Landlock denies an access, it will
>> + *     suppress the audit log if all of the following are true:
>> + *
>> + *     - This layer is the innermost layer that denied the access;
>
> Because these items follows ":" they should not start with a capital
> letter (e.g. "- this layer ...").
>
>> + *     - All requested accesses are part of the quiet_* fields in the
>> + *       related struct landlock_ruleset_attr;
>
> This should be updated to reflect my comment in the next patch about
> landlock_log_denial().

Not sure I completely understand what needs to be changed - are you
suggesting clarifying that only the accesses denied by this layer (which
naturally has to be handled by this layer) needs to be in quiet_*?  So
basically:

 *     - all accesses denied by this layer are part of the quiet_* fields
 *       in the related struct landlock_ruleset_attr;

or something else?

Note that quiet_* already has to be a subset of handled_access_*.

>
>> + *     - The object (or one of its parents, for filesystem rules) is
>> + *       marked as "quiet" via %LANDLOCK_ADD_RULE_QUIET.
>> + *
>> + *     Because logging is only suppressed by a layer if the layer denies
>> + *     access, a sandboxed program cannot use this flag to "hide" access
>> + *     denials, without denying itself the access in the first place.
>> + *
>> + *     The effect of this flag does not depend on the value of
>> + *     allowed_access in the passed in rule_attr.  When this flag is
>> + *     present, the caller is also allowed to pass in an empty
>> + *     allowed_access.
>> + */
>> +
>> +/* clang-format off */
>> +#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
>> +/* clang-format on */
>> +
>>  /**
>>   * DOC: landlock_restrict_self_flags
>>   *
>> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
>> index 7fb70b25f85a..aadbf53505c0 100644
>> --- a/security/landlock/domain.h
>> +++ b/security/landlock/domain.h
>> @@ -114,6 +114,11 @@ struct landlock_hierarchy {
>>  		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
>>  		 */
>>  		log_new_exec : 1;
>> +	/**
>> +	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
>> +	 * logged) if the related object is marked as quiet.
>> +	 */
>> +	struct access_masks quiet_masks;
>
> Please update the above @work_free doc.

I assume you meant the one in struct landlock_ruleset, not here.  Will update.

>
>>  #endif /* CONFIG_AUDIT */
>>  };
>>
