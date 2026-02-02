Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3310F1
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769990768; cv=none; b=uBpSyAQ2Vh4RnIFvG6slSmsCnx0UzsRaxa6/XZ2w3Iq7TaREFlUVLXG6fOv1eEMnRrs2Z41+NedWFWE/yr2Xp+OvKKm6/GSzjpgma07lsufPTVslpUz8U8UQG4GHaVorXJ/fvIXNzT8OZATvvkd54YqgB544zwGsWxTnSCNKp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769990768; c=relaxed/simple;
	bh=WS/5U9GiIGu0GtpYgmtvpbI7uZHTpEOuJPnwIbm6W9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxevGpMFo8ch3f6dAFwq9Y+QnPFh+BKdXMPbBflT8hSzRwuPRsxYDS/hhkQKIolS1frEE/8WWL+wwYDiI1vQuRvfkdlShJEtVfkA0vWlIIUGQ12v1PqzE2HyjDzx9AZS82k4ZjFN616aGoFCegtGCds+52KWOqUjRYr/LP4NPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=oi659Ywg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLYLu88F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="oi659Ywg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLYLu88F"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9742D1400059;
	Sun,  1 Feb 2026 19:06:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 01 Feb 2026 19:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769990765;
	 x=1770077165; bh=vd/XanPcyhmkP7tg7wFWPAEKH536R4fLiAOfLsMkWww=; b=
	oi659YwgTuQkzXqGVCCFR/Z0ezmEPo074S4TxkA+HqAbfjXVRnLgoKbjIfaTOLor
	cadY4NP+YW93YK0xZla2JnJ6ymgxpMMvi88U4eVPYCDbKP/Q5bIR6Dx21d6mHvHt
	J4da2WqbO3fG81EN7tML61zmDR29jc1hZiFUZf3qpsu48ZHdi8VBQE3Q2xGU3bX0
	dd7XEtyoi+HZf2VFOfCYVEzAXqibehu1QxdMyz3jT4vaMI96Wpdi8KBzhykghHIF
	1rbeOymbXNz6WY9hIycT6YfRghDD4W4neBY772G0txwZgjvZXOi+ggbOwWORlu+2
	YRKE1yn8IIRDFgMGDhn6bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769990765; x=
	1770077165; bh=vd/XanPcyhmkP7tg7wFWPAEKH536R4fLiAOfLsMkWww=; b=M
	LYLu88FTsD0YuJ2TIIFXRmJyy63KX70NjcGEva0QgT2xrzbCEZzDW85vsGFkK3Zi
	T6kBi0svju7HgyPW+xX59XNo+D+rcIIruVdsBEnglUeAm4ECdoA4sZs1+DLOituH
	DQrlRCbV0PD3OvQ6XbbUVSiUJID/UHt3StBWXMCG25ox/3hpGfAX+MJIjnx+QjCg
	hB4rJAIAabFDMx/6huHClDB6t/MrAB3jYw8fdacwTDkBACjUmLTXZkJCHd4wqnqH
	24HqGxPTkd6FfWkgiM+em+rPO90/thxb2RjfEJkTEafbi7ADL6IocaIFhmm09e3c
	Lxe8adusvoeoy96GfLwtw==
X-ME-Sender: <xms:bep_aYO15Z_ShJMff5pgcRldJAT-2Q3hYEET7ytux6gfku301udJoA>
    <xme:bep_aeD1DvNMll7WCeHDM6xMsUAAbLOParie43zElYf749RtiMBGv6_zSUy_d593-
    rtgE62Q5DQ9HdoGgSayszJOm83i3-3k0K1rE33dLo-6gsWW6l1AcJM>
X-ME-Received: <xmr:bep_aVeuUmxAG1zMkJBLcINaz_j_kW19PW-9K-wXHz36N5vwBYu6B3lU2iKUokFzeK9BbwnUqtrGRtBstg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohephhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bep_adOC8wad3uueel4wpPvslDs8zpCwTm5zlpCaKhSHtKq_sM1IjQ>
    <xmx:bep_aVLU-nnISxYxGgZg0Y9wZvcj_Sf9S1JZXx_cVEqTAK2sPSlKYw>
    <xmx:bep_adIQ3gJ5a4iIBOzPaX0MdzWqyvMQLd-P174ehWktuKeHmWO2GQ>
    <xmx:bep_af4lBdw9ongX1LRE3Fpq9N27F7xU9A3OgeV7x6rrP_R2jUMG7g>
    <xmx:bep_aRIhHmHICcZ9fXadX-oPelrtc7P0P1OfNB1TB4DnbqR5V-YoqoBD>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 19:06:03 -0500 (EST)
Message-ID: <fb80012e-a183-464e-a706-7d0f6c3b3132@maowtm.org>
Date: Mon, 2 Feb 2026 00:06:02 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] selftests/landlock: Repurpose
 scoped_abstract_unix_test.c for pathname sockets too.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>,
 Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <53b9883648225d5a08e82d2636ab0b4fda003bc9.1767115163.git.m@maowtm.org>
 <20260129.ePhaehieJoh4@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260129.ePhaehieJoh4@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/29/26 21:28, Mickaël Salaün wrote:
> [...]
> On Tue, Dec 30, 2025 at 05:20:23PM +0000, Tingmao Wang wrote:
>> [...]
>> @@ -308,6 +413,12 @@ TEST_F(scoped_audit, connect_to_child)
>>  	char buf;
>>  	int dgram_client;
>>  	struct audit_records records;
>> +	struct service_fixture *const dgram_address =
>> +		variant->abstract_socket ? &self->dgram_address_abstract :
>> +					   &self->dgram_address_pathname;
>> +	size_t log_match_remaining = 500;
> 
> const
> 
> Why this number?  Could you please follow the same logic as in
> matches_log_fs_extra()?

It's not a const since we decrement it below as we fill log_match with
stpncpy().

matches_log_fs_extra() uses 2*PATH_MAX + length of various fixed strings.
I guess since the path is a resolved absolute path which can vary based on
where this test is ran, it is safest to use a value based on PATH_MAX.  I
will update.

> 
>> +	char log_match[log_match_remaining];
>> +	char *log_match_cursor = log_match;
>>  
>>  	/* Makes sure there is no superfluous logged records. */
>>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>> @@ -330,8 +441,8 @@ TEST_F(scoped_audit, connect_to_child)
>>  
>>  		dgram_server = socket(AF_UNIX, SOCK_DGRAM, 0);
>>  		ASSERT_LE(0, dgram_server);
>> -		ASSERT_EQ(0, bind(dgram_server, &self->dgram_address.unix_addr,
>> -				  self->dgram_address.unix_addr_len));
>> +		ASSERT_EQ(0, bind(dgram_server, &dgram_address->unix_addr,
>> +				  dgram_address->unix_addr_len));
>>  
>>  		/* Signals to the parent that child is listening. */
>>  		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
>> @@ -345,7 +456,9 @@ TEST_F(scoped_audit, connect_to_child)
>>  	EXPECT_EQ(0, close(pipe_child[1]));
>>  	EXPECT_EQ(0, close(pipe_parent[0]));
>>  
>> -	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
>> +	create_scoped_domain(_metadata,
>> +			     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>> +				     LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET);
>>  
>>  	/* Signals that the parent is in a domain, if any. */
>>  	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
>> @@ -355,19 +468,62 @@ TEST_F(scoped_audit, connect_to_child)
>>  
>>  	/* Waits for the child to listen */
>>  	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
>> -	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
>> -			    self->dgram_address.unix_addr_len);
>> +	err_dgram = connect(dgram_client, &dgram_address->unix_addr,
>> +			    dgram_address->unix_addr_len);
>>  	EXPECT_EQ(-1, err_dgram);
>>  	EXPECT_EQ(EPERM, errno);
>>  
>> -	EXPECT_EQ(
>> -		0,
>> -		audit_match_record(
>> -			self->audit_fd, AUDIT_LANDLOCK_ACCESS,
>> +	if (variant->abstract_socket) {
>> +		log_match_cursor = stpncpy(
>> +			log_match,
>>  			REGEX_LANDLOCK_PREFIX
>>  			" blockers=scope\\.abstract_unix_socket path=" ABSTRACT_SOCKET_PATH_PREFIX
>>  			"[0-9A-F]\\+$",
>> -			NULL));
>> +			log_match_remaining);
>> +		log_match_remaining =
>> +			sizeof(log_match) - (log_match_cursor - log_match);
>> +		ASSERT_NE(0, log_match_remaining);
>> +	} else {
>> +		/*
>> +		 * It is assumed that absolute_path does not contain control
>> +		 * characters nor spaces, see audit_string_contains_control().
>> +		 */
>> +		char *absolute_path =
> 
> const char *absolute_path

Can't use const char * here since we free() it later:

scoped_unix_test.c:513:22: warning: passing argument 1 of ‘free’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  513 |                 free(absolute_path);
      |                      ^~~~~~~~~~~~~

But I guess we can char *const.  Will update to:

		char *const absolute_path =
			realpath(dgram_address->unix_addr.sun_path, NULL);

> 
>> +			realpath(dgram_address->unix_addr.sun_path, NULL);
>> +
>> +		EXPECT_NE(NULL, absolute_path)
>> +		{
>> +			TH_LOG("realpath() failed: %s", strerror(errno));
>> +			return;
>> +		}
>> +
>> +		log_match_cursor =
>> +			stpncpy(log_match,
>> +				REGEX_LANDLOCK_PREFIX
>> +				" blockers=scope\\.pathname_unix_socket path=\"",
>> +				log_match_remaining);
>> +		log_match_remaining =
>> +			sizeof(log_match) - (log_match_cursor - log_match);
>> +		ASSERT_NE(0, log_match_remaining);
>> +		log_match_cursor = regex_escape(absolute_path, log_match_cursor,
>> +						log_match_remaining);
>> +		free(absolute_path);
>> +		if (log_match_cursor < 0) {
>> +			TH_LOG("regex_escape() failed (buffer too small)");
>> +			return;
>> +		}
>> +		log_match_remaining =
>> +			sizeof(log_match) - (log_match_cursor - log_match);
>> +		ASSERT_NE(0, log_match_remaining);
>> +		log_match_cursor =
>> +			stpncpy(log_match_cursor, "\"$", log_match_remaining);
>> +		log_match_remaining =
>> +			sizeof(log_match) - (log_match_cursor - log_match);
>> +		ASSERT_NE(0, log_match_remaining);
>> +	}
>> +
>> +	EXPECT_EQ(0, audit_match_record(self->audit_fd, AUDIT_LANDLOCK_ACCESS,
>> +					log_match, NULL));
>>  
>>  	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
>>  	EXPECT_EQ(0, close(dgram_client));
>> -- 
>> 2.52.0
>>
>>
