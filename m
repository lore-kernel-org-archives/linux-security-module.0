Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F33231C91
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110211; cv=none; b=pCL6PzDSkgtj1GfCwK6yPTuCN0jlA3JoMnPK0TJHdaK3ohXx1gw6ZxuDGqgEFoHgAwnsO5zvKTLlX0iBKZEwmdbehtZd+apJS0dzPUwTu49Ypdddk0X/5/DMFAeBxGlzD6rKYsqZLSNk4Ld7Y+8i/fq7n4AeY7mplRhH+vqWVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110211; c=relaxed/simple;
	bh=uF4YrUp1zR/UTDqFeA7bXTOse9KxuGyYFlBvrsD+K30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f4A3ofWCqoFWBsebUJN7XFSF1Z+OaxhlSGAgBvS8tjswrLzBIoc9jI73RBNZGP/SCGfEscEurIQlSbHbFCw9mDlTOYQcdSGqs2KCAr1fa7QwJowK/2dvvz1fmb5YGyA/4kYknoFvfLHhbV9BCz4rlTRhHgjpBOkTUu4Zns5nDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=QMWYwkdV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+LeayJV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="QMWYwkdV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+LeayJV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 962737A0096;
	Tue, 30 Dec 2025 10:56:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Dec 2025 10:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767110208;
	 x=1767196608; bh=Xey8Uflq3+xj1i7k18drk6OPrseNu6sGDoz7k4be7OA=; b=
	QMWYwkdVObl0Tv8Skh6++r2nV6oT+z98XZdwDWTMRz3Q+43CwTejP3vsYbsT2JuT
	SjL2lEn2wLAkUlhOytNG4q99RrirMgHokiHGamxNqfYBjVqqkkr7SicVAoDC2Ncl
	hCaLE/9GUOebMroknwI4rV3CYHom3pU5WQknNp32iinGNe3DbbSosyK+msuqBWru
	AmzVBdm1zPSoMfqR6zqhaBuc24YEWDiBitYIdqsRRnCiFTNz573O6Ehpxg3oTECJ
	PuC5cNyuUvIX5cnjF+035K8xRC14RgEvatuLCs1MfOLgn8mexiL3DItfUY85vwNm
	0RZCyPj2mK6H6zCvkNrDsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767110208; x=
	1767196608; bh=Xey8Uflq3+xj1i7k18drk6OPrseNu6sGDoz7k4be7OA=; b=P
	+LeayJVg0mS7havn14OjgEH1sz+EKlIZZ+ylhIMnzD9h9E1CJyDx9K1vk+pJt9j9
	PVmxGwkboNMrPw2ehtgn56C2a+M6u+gi587jI/E5HPr9eU8eyekVpMk82oyg9796
	x+e53xnPhaOYAv2lHcG14NkYYUjNZ3mUkBCwR7cCUAZYGpXzlbU8ZdJlUzBgeSIV
	GFla0p7WrRP11VDIA0ySg2elEiJZ1R5S/6MAhnuRkbObYVP7HAYgUhMuPpWjZhR1
	prlltbTKrarWK1XGMcx5iPk+oRvoZQ8Gj3hjnbVGBBq1+SvpBcAt3Y5UiBkj5vKw
	8RUSLWyPoG8x05afc2DeA==
X-ME-Sender: <xms:QPZTaWKR7Rm5z6XWwuOJmTsJGvYeCQK9zm0yHbhj8G2VxkiBYcDVLQ>
    <xme:QPZTabGwqRCVlARuumOBKbjRinkvKUXtIysROyu5navDMrc9hBaC40S6UX0SPVhGB
    nnJ_pCVLklNNuyBlYHkn7NoUNJROOCGFEtFQiDRcPi7Hozt75Gec-c>
X-ME-Received: <xmr:QPZTaSVfFGPYmGQDY5nM5i9NlORPBib29luEkOuOck4Km6GvBtS97jYc_4SPsghXkSDnIN-2j9smjQcNZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertd
    dtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhr
    gheqnecuggftrfgrthhtvghrnhepvefhteeuheevudduvdefgfevjeeiudfhvddvhfefke
    elhfeuffdtueelvdfhhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtth
    hopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgrhhhi
    mhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehhihesrghlhihsshgrrdhishdprhgtphhtthho
    pehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QPZTaTxPgnH2Mgp8Nt4bEZY_1Q7Awb0pqvCnYkFcsA2pQmmyg2fh6w>
    <xmx:QPZTaXSis1tnD6e_6u5NHsAQKOEyhlEJsjE9vODxeZzG-LgoV9F7dQ>
    <xmx:QPZTafizI03mXd6cxyrAEIQoKW7JaGiFzh2vP7OOFsBvSD8i2KMeow>
    <xmx:QPZTaelQOBcrH6gVRSuQL0j-zEylvjn0K7TpyaLfXb9EVsrVjHbbag>
    <xmx:QPZTaXJDVcrpMmeFJRuZ4g64FICC0_o3HT2OJ_P1Z0QrlfxmATKgMByq>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:56:47 -0500 (EST)
Message-ID: <a7812afa-3178-431f-8788-b115bb4997ac@maowtm.org>
Date: Tue, 30 Dec 2025 15:56:46 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] landlock: Implement
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
From: Tingmao Wang <m@maowtm.org>
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: demiobenour@gmail.com, fahimitahera@gmail.com, gnoack@google.com,
 hi@alyssa.is, jannh@google.com, linux-security-module@vger.kernel.org
References: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
 <20251228163750.451028-1-utilityemal77@gmail.com>
 <09f721d0-2644-44ba-b2e8-93626a17fa55@maowtm.org>
Content-Language: en-US
In-Reply-To: <09f721d0-2644-44ba-b2e8-93626a17fa55@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/30/25 15:52, Tingmao Wang wrote:
> On 12/28/25 16:37, Justin Suess wrote:
>> On 12/28/25 07:45, Tingmao Wang wrote:
>>> [...]
>>> diff --git a/security/landlock/task.c b/security/landlock/task.c
>>> index 6dfcc1860d6e..9fbb0ada440b 100644
>>> --- a/security/landlock/task.c
>>> +++ b/security/landlock/task.c
>>> @@ -233,57 +233,84 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
>>>  	return false;
>>>  }
>>>  
>>> +/**
>>> + * sock_is_scoped - Check if socket connect or send should be restricted
>>> + *    based on scope controls.
>>> + *
>>> + * @other: The server socket.
>>> + * @domain: The client domain.
>>> + * @scope: The relevant scope bit to check (i.e. pathname or abstract).
>>> + *
>>> + * Returns: True if connect should be restricted, false otherwise.
>>> + */
>>>  static bool sock_is_scoped(struct sock *const other,
>>> -			   const struct landlock_ruleset *const domain)
>>> +			   const struct landlock_ruleset *const domain,
>>> +			   access_mask_t scope)
>>>  {
>>>  	const struct landlock_ruleset *dom_other;
>>>  
>>>  	/* The credentials will not change. */
>>>  	lockdep_assert_held(&unix_sk(other)->lock);
>>>  	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
>>> -	return domain_is_scoped(domain, dom_other,
>>> -				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
>>> +	return domain_is_scoped(domain, dom_other, scope);
>>>  }
>>>  
>>> -static bool is_abstract_socket(struct sock *const sock)
>>> +static bool sock_addr_is_abstract(const struct unix_address *const addr)
>>
>> Nit: From the name sock_addr_is_abstract, it's unclear without reading
>> the parameter that this function only works with unix sockets, when
>> socket is an overloaded term that can refer to other kinds of sockets
>> (e.g tcp/udp/raw).
>>
>> Maybe is_unix_sock_addr_abstract? or unix_sock_addr_is_abstract?
> 
> I guess sock_addr_is_abstract is indeed a bit of a weird name, but it
> helps that this function is static to this file and also very short.
> Maybe is_unix_addr_abstract?
> 

(nevermind I didn't read Mickaël's reply before sending this, if we can
get rid of this extra function then the name doesn't matter)
