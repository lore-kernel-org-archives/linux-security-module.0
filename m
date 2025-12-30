Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C986277
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767109979; cv=none; b=V810hcnhal5xc+BAbCh+BUl5mN6ZH98s9P5wKLnKzJ1vxQUuAfZAVk7hQmS2bM+g78Olf2VuOhXIHODfnD4CzjWH1o4ape6RTE6nVNmuz4qNCC4gKW65zdTb5b9G1EyFobqBRZRG8jX5Ew2c5mK98nT9B9WqYVameMPV2mhTIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767109979; c=relaxed/simple;
	bh=uiIt2qwqDayp9IgqCKfGN6zbLUJN1ZMTmT+nwiPkyGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+zyKPnsLjX4sjC5RC8nzsJ74tBQTcBOq6X73Mj8xJS3Ik1HcFSxJAIb8enYdWvdEQ4gj0oHQAIft9569gqdSzkUn7GQ2Nyi5wzVhzWKwlBOKtXL01EdN7u/yn+clvTj+5Iyj7B2s5Xjz542w1Z5DEZQ6nOuesUrDI3oAcOpT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=UUH684Wu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqhE3yTi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="UUH684Wu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqhE3yTi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 931AA7A00EC;
	Tue, 30 Dec 2025 10:52:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Dec 2025 10:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767109976;
	 x=1767196376; bh=+wfSDlwK31N83NLDiw5mZhifrG+43FE2/XqClPLN+Vs=; b=
	UUH684Wu+YOf2CobK9/nnI3YtYV7LkZ/oZQl7cERZh2Z8v9ZbOIyEDBEBWoBNJmS
	Fd7zJssmp3BidfsKodQMAl+1hAlJR+MWFdtSLuTgbcYKhQjVidGINOE5IF+y5PSi
	YKb9YDHCn7jvygQG4tcDDrCRlhSeDSbD6jS/ZfODB6jzAtc/EIcn4LyNTdmZ18Di
	e4zw2E5GGXKx17PuFgmF3xUxXg33+ZcVB6Z9PLqrNVGnovebvG+jKPbOiJOjqHEv
	ury0lMjeXmuoeqSHs4mffvbrShF4SlAxl4HQtPS2N8ExSNXbRdOGMN2MlEd6beMo
	Py/bO6xrbPIb+3djWeP3TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767109976; x=
	1767196376; bh=+wfSDlwK31N83NLDiw5mZhifrG+43FE2/XqClPLN+Vs=; b=m
	qhE3yTitOgsn8HJksqDZyt1cTfG7ucuTWigYKCxcnKgKLP3I4JpOC9atBYN9NxA8
	0jeJ4GjHl8XzV/v5NjA5OL3QSL9/6ncLM8/isUd2cmz/JTUgSb7AvzwewCbTrAIQ
	fz0t1L3kqpQzoCOZqgINky7FrAB+elLGuyZ61mpGyESfEKVPhawBwbC7095PEPQs
	HUzTkxpq6rQzpGT9FFrsg3bSraGEU00f6w9Iss8baZ76vHAA4yQMINk9PmWrhyep
	aNlbTUxZz9PKN9Iupqt1DefqX6gGgX5vaQhvzfBLuA0/SRU5+vXlpT50+E4+ertx
	HGB3cIFnfZGmU7pAyMetA==
X-ME-Sender: <xms:WPVTaTVKs8RTtKKxi4O_BzJodYQWHvfV1ARdFpRV67x_sNSHt_HrWQ>
    <xme:WPVTaaoxR8Klv6830P-w4BOiWQcXI8pP1oWw6wCkYvJVfFlSgHfsnVhXHmiwY38PB
    l4CYOg0ZxxtTeaR3QZdE37sraMp5rj2b9QGO8WnPocr34gW80A8sw>
X-ME-Received: <xmr:WPVTaVmfM3c2J692l29OyerxYl5FfvUjPO3b2H7YDefR749idxzkxl4pplX5IeIkGCcCSnImpOD_OGBISg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhr
    gheqnecuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhe
    dvgfdtfeeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtth
    hopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgrhhhi
    mhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehhihesrghlhihsshgrrdhishdprhgtphhtthho
    pehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WPVTaa3sGauxOA-Jx3dZfiOwFcid45sAaFAHg8TLfaw0MoXMfccmug>
    <xmx:WPVTaSTCZ4LkpJAeuxTmasC-KLjaWeMqt7qaAlb46fFd-33Lnv1RAw>
    <xmx:WPVTaTz_gdDPwXZBgtkrBEp9m54Es20turCVX8P9-qe_sULuFe9eDw>
    <xmx:WPVTaSDlvGgyl5sDnjDEQ_NKIaNr200wV1oRU3F1v4j3i2o9JTt36g>
    <xmx:WPVTaRSNTCVtI7BsaAry74g9egb7TikoDDq7zf4-gGYZneavBiHpPmxj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:52:54 -0500 (EST)
Message-ID: <09f721d0-2644-44ba-b2e8-93626a17fa55@maowtm.org>
Date: Tue, 30 Dec 2025 15:52:53 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] landlock: Implement
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: demiobenour@gmail.com, fahimitahera@gmail.com, gnoack@google.com,
 hi@alyssa.is, jannh@google.com, linux-security-module@vger.kernel.org
References: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
 <20251228163750.451028-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251228163750.451028-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/28/25 16:37, Justin Suess wrote:
> On 12/28/25 07:45, Tingmao Wang wrote:
>> [...]
>> diff --git a/security/landlock/task.c b/security/landlock/task.c
>> index 6dfcc1860d6e..9fbb0ada440b 100644
>> --- a/security/landlock/task.c
>> +++ b/security/landlock/task.c
>> @@ -233,57 +233,84 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
>>  	return false;
>>  }
>>  
>> +/**
>> + * sock_is_scoped - Check if socket connect or send should be restricted
>> + *    based on scope controls.
>> + *
>> + * @other: The server socket.
>> + * @domain: The client domain.
>> + * @scope: The relevant scope bit to check (i.e. pathname or abstract).
>> + *
>> + * Returns: True if connect should be restricted, false otherwise.
>> + */
>>  static bool sock_is_scoped(struct sock *const other,
>> -			   const struct landlock_ruleset *const domain)
>> +			   const struct landlock_ruleset *const domain,
>> +			   access_mask_t scope)
>>  {
>>  	const struct landlock_ruleset *dom_other;
>>  
>>  	/* The credentials will not change. */
>>  	lockdep_assert_held(&unix_sk(other)->lock);
>>  	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
>> -	return domain_is_scoped(domain, dom_other,
>> -				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
>> +	return domain_is_scoped(domain, dom_other, scope);
>>  }
>>  
>> -static bool is_abstract_socket(struct sock *const sock)
>> +static bool sock_addr_is_abstract(const struct unix_address *const addr)
> 
> Nit: From the name sock_addr_is_abstract, it's unclear without reading
> the parameter that this function only works with unix sockets, when
> socket is an overloaded term that can refer to other kinds of sockets
> (e.g tcp/udp/raw).
> 
> Maybe is_unix_sock_addr_abstract? or unix_sock_addr_is_abstract?

I guess sock_addr_is_abstract is indeed a bit of a weird name, but it
helps that this function is static to this file and also very short.
Maybe is_unix_addr_abstract?
