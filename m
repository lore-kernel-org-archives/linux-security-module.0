Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1A20F07A;
	Tue, 14 Jan 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896626; cv=none; b=b4q8VpIFpVH4aZapO1Z2vRDHrknZswKrZevFCv+nRky+ECSIOTxDSqwi9HLqwjNG/anUv9RuO6vtC8yYdRbNLU+raP/ogbSFnLabGbNnblNXlh261X3LjwyltBgAVjxIdTwdovm+4ZlffXgCwKlNlV8hAz9xCqu4Rz35K2i0qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896626; c=relaxed/simple;
	bh=LhiQiJBBDL4iZT8Ou25HPAo6qd7tXNeHRjWYX3juTOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlPo6NlbscECRTtkCtXBU7cmXIEfY9w0TS0dmHj9FBcqc/+xj2gzRQUTw6F+EbwC3b+pwMmE+QthUBt4fcpGPm68VdO5a8DxZHQwniDmrFlwTVC6J6BDS0wHDSUToeEzJJJPpse9ANdfbMy4zvubR4NCYTnoBvoBojZM9T8E7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CcZ/K0JZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CcZ/K0JZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=lEp2uRj+ZxbL1oJzYa0+EuwlfwNJW/TaR2/8CRcAMJ8=; b=CcZ/K0JZsGVCgXzsx9kGKkDLBy
	bETwleowLsIRbz+LlomvC11xXbwHrmMSRQ8gQAW+Lv8GK0AouzuozVudaDAb5AFc7OIy8lzdTjXg3
	CEnyFszN1eoPASvCbOccCWnTugbOBqnel2Smb5c8SHmid6Bb/lR4koDSSgKK194oxRQ0x7PoQ2fbl
	5hHWLoQ5X4oEUFdZeD9f8svV0UFm1xhUjvayY3pzNJazR/MsJJnCdCuo2Byz5Ihxf1UqbcTqH7odj
	LjSb5WiF7hSlhh2Kz2BwrVenqYO+M0oOBB/XXZUk8W0ZiMA3kUyjYZ0trqHY3ZlOVll1Hr0TiTskb
	ji+NRjHA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXq9b-00000004lYw-2aHV;
	Tue, 14 Jan 2025 23:16:59 +0000
Message-ID: <07909d9b-7ec1-4eae-a20e-38a8a15dbc31@infradead.org>
Date: Tue, 14 Jan 2025 15:16:52 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/security: update cmdline keyword usage
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-doc@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <sergeh@kernel.org>,
 linux-security-module@vger.kernel.org,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 John Johansen <john.johansen@canonical.com>,
 John Johansen <john@apparmor.net>, Jonathan Corbet <corbet@lwn.net>
References: <20250114225156.10458-1-rdunlap@infradead.org>
 <1b4275ad-a07b-4647-9d2b-48af08cdbebe@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1b4275ad-a07b-4647-9d2b-48af08cdbebe@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 2:59 PM, Tetsuo Handa wrote:
> On 2025/01/15 7:51, Randy Dunlap wrote:
>> Use "lsm=name,..." instead "security=name,..." since the latter is
>> deprecated.
> 
> Sorry, but security= is for specifying only one of exclusive LSM modules
> whereas lsm= is for specifying both one of exclusive LSM modules and
> all of non-exclusive LSM modules. That is, you can't deprecate
> security= using s/security=/lsm=/g .
> 

OK, thanks for the feedback.

I am still confused by this part though, in Documentation/doc-guide/kernel-parameters.txt:

	security=	[SECURITY] Choose a legacy "major" security module to
			enable at boot. This has been deprecated by the
			"lsm=" parameter.

-- 
~Randy

