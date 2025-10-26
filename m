Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1864CB5B
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511730; cv=none; b=X3ztjYOp9uCMfHiAaOFUAg2oacVAa7wbWwgHE4LlZzvDX+XooEsndtR6CWJsGX2skPDzwL7zYUSiRaYJHTTFq4AZI/VYZhcIvT6j6Vr93IM3xUEVQ4/kx9SesCShtJeu/LLQ1UxhSNjywAMCho/v3EAFJMprkx0nlLgmozbDrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511730; c=relaxed/simple;
	bh=gCUl4mb/8FqDIBRK1qNLxH1BHP2vEcoYwoi9IMDnZBE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lNgzNu3TIDfLyjtEzFC1izo/ZlYWelMeDfiFYjNh0+hMCBA0psT1mADKiSwvO5fsOyylWkASgiBC4UAznzhHLlfZYbNIjx9MQosnb6QLWIWeca2Rjz/kZkOj2Wom1VlNwtKrZ2DLla1023zfZJPrjiEQef2qhumNJU9m8Kjokmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DhA2vdAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQXUtwAO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DhA2vdAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQXUtwAO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EB5A7EC027F;
	Sun, 26 Oct 2025 16:48:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 16:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761511727;
	 x=1761598127; bh=hNbpaVtYNZ9/cj7LN4KgFXBh9aTIXWiifSkYK9R05Wo=; b=
	DhA2vdAVEi3aBD7dBFHz3nHtWGW5oSzgzNNRuZq5aea8tE11A/Qehh7hccAM3zUm
	JO1U38mFuiwjR891XOp+WkaV3IOHSHV1AHc4UCAk6DvGU38HXFDkcX3yuHD8xaMG
	yrohkZ/aQph4DE1sa6E+6KOC8cgYlJHSrMGDJTpKlPN1LJFv/J0DslquTWbo/3gr
	9htvKo9bwHzMa/aeY448fiTSRtGMgq58KCZVaciblkX/MPw0ES5boYQMTWkvUBma
	yToju68Kur8+f4wyqly8AY1r68BkjZ9dADQP6GbHGsadkdstz9qKkr2FForJES7U
	wSS6/tfAiOPE6tBf+vQqWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761511727; x=
	1761598127; bh=hNbpaVtYNZ9/cj7LN4KgFXBh9aTIXWiifSkYK9R05Wo=; b=P
	QXUtwAOoYbe9rx0C5xSlmpV6+260EgtV9TIXNegSVXdanTVv373uNJiVuA3XrkXc
	i+itXd7NSZl1p062gL9dF4eytbqj0tfspnFLDIRaIbwn7gZuHb0mBryZ4j0cfsE5
	HlzlMp/grhVKKz85Am9hqjhBKbG1I7jtNmdA064vUvLzLlIxopOJ4PePbBKVdVe7
	kHsB1d1JlhyhLyWCtQRk2iPtl3JRQO+RLq4VWn02b94S6U8MEAI+1w2E7gCruscX
	KxljE512g//h4v0h0Sm6cmD5teBngN5xhcLLOVliC1hpbEXBHQXtQSAtLJ24WF+F
	dH5qv68yqXraP+mJOZthA==
X-ME-Sender: <xms:L4n-aCiEJlFVwM2YegEAqzWsz1D0WQeN1cwA0sYKvNkOtWVp0ncz2w>
    <xme:L4n-aKD1MBD3xR1xtov-Php455UjfoGJj5y0EM11SMErWfpdvZDkDjL0PUXs1j9rI
    8srPPUuDTl0JxQNEt97cLieKZILU0cJkkc2DHYS4Jj4B75j9B8XBQ0B>
X-ME-Received: <xmr:L4n-aPFi8H4MXFd-zEYJwxEcGHiKwSNh7pnJfO0cMLzbnQs-umDDFQy8GqmR33fOgQvGGCJKCWdUWbfBTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepvd
    egudeugfdujefgtdetffdujeejleeliedukeeujeduheetgffhgedvteevffeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:L4n-aKK0ihKB4MmUWqiy10VYvi_jBFLzR2EIaOBRz1pn-qFSoejL9g>
    <xmx:L4n-aLmq8TG-3zGHqtwRJkHEp0aAFpj63v_SaZ5kmYjJhfq5lcI8Ng>
    <xmx:L4n-aKQ0aoJZmE8p-2IsS5cCaZ9CsrAam7N3v-Ak3-ikcPlJ_lTfEA>
    <xmx:L4n-aFLVnjnY_zviYWC799IaxJjCCW5q1ZfP6oagPuanxcxrZYyfGQ>
    <xmx:L4n-aBZP71nmP1FImIvxtqYa7mdEwGUbcjda9aJzPPUrPT8-UfBcV8G9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:48:46 -0400 (EDT)
Message-ID: <50a1dc6c-fbd1-4167-929f-7a65fb1e5a83@maowtm.org>
Date: Sun, 26 Oct 2025 20:48:45 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 3/6] landlock/audit: Check for quiet flag in
 landlock_log_denial
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1759686613.git.m@maowtm.org>
 <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
 <20251015.Iengoh1eeT0c@digikod.net>
Content-Language: en-US
In-Reply-To: <20251015.Iengoh1eeT0c@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 20:09, Mickaël Salaün wrote:
> Just use "landlock: " as subject prefix.
> 
> On Sun, Oct 05, 2025 at 06:55:26PM +0100, Tingmao Wang wrote:
>> [...]
>> @@ -436,6 +456,52 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>>  	if (!audit_enabled)
>>  		return;
>>  
>> +	/*
>> +	 * Checks if the object is marked quiet by the layer that denied the
>> +	 * request.  If it's a different layer that marked it as quiet, but
>> +	 * that layer is not the one that denied the request, we should still
>> +	 * audit log the denial.
>> +	 */
>> +	quiet_flag_on_rule = !!(rule_flags.quiet_masks & BIT(youngest_layer));
>> +
>> +	if (quiet_flag_on_rule) {
>> +		/*
>> +		 * This is not a scope request, since rule_flags is not zero.  We
>> +		 * now check if the denied requests are all covered by the layer's
>> +		 * quiet access bits.
>> +		 */
>> +		quiet_mask = pick_access_mask_for_req_type(
>> +			request->type, youngest_denied->quiet_masks);
>> +		quiet_applicable_to_access = (quiet_mask & missing) == missing;
>> +
>> +		if (quiet_applicable_to_access)
>> +			return;
>> +	} else {
>> +		quiet_mask = youngest_denied->quiet_masks.scope;
>> +		switch (request->type) {
>> +		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
>> +			quiet_applicable_to_access =
>> +				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
>> +			break;
>> +		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
>> +			quiet_applicable_to_access =
>> +				!!(quiet_mask &
>> +				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
>> +			break;
>> +		/*
>> +		 * Leave LANDLOCK_REQUEST_PTRACE and
>> +		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they are
>> +		 * never quiet
>> +		 */
> 
> This also covers the case where the object is not quiet.
> 
>> +		default:
>> +			break;
>> +		}

I went with adding a comment above the line
    quiet_mask = youngest_denied->quiet_masks.scope;
