Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477541A285
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jun 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765455; cv=none; b=G0kXzea2nQiK2L5l09yW+C4uKYSMCFfu5mBLCOhJdgRemv2OzyJb2LdvCvWZG0xVJ/RGwN0EFTn/Y70NfQIacurE8ttucBhrTGTKFln2d+u6mklwZ/AWmU+vwyQLwvsMoVcALdwdrUw2w/PZk6V59dJNwExLk9hb6CVaw8VQE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765455; c=relaxed/simple;
	bh=zk4xPYUZT8QOJP1DZAiwTdr6yoxgtEpH3gU5DZkZKW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcS9f0cAC5nDGO4FgQuzQtpRQ2GdaTucvel0LSwdd3CNhgcfYb/BcoILox5WHTgDpkNELV1RhACWF5vtpF5MRguH2vpob12cDN2ZIQKsSOdStJ7SbJmuwjQxm5aP5MOjXJELXHv3q4jzf2arelDriUG/XCtMbCGH+paJ0jmAhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=HYyU+JuI; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="HYyU+JuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1780765449; bh=zk4xPYUZT8QOJP1DZAiwTdr6yoxgtEpH3gU5DZkZKW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYyU+JuIfq+gle/NLSnQCTblvjhpuD87Y2Od+sbA/iAtZa/b8Jt1XaI4vBwXW64Dt
	 wqBih+eAHwqdbKwGhXC8+a8oYTBWS/yDpCrCiM3xO2R5F6xDObLuzvysAFQlkXV7Gt
	 ARozueFmx+GxXk6yAQNNpaXJMq743zNRMm/bLvg29/Gc49TrbJzaJh8ONG1OLhxU8A
	 3lwc3uWemrykB3Q9sHzqF6IcZgnbGIq3bd+2bi/pg0Dq4oL/jb0V6z1KFTNJC7A+UR
	 CP2nF9yDzNNkiD6pl6D2lFTocvLHvsaXDVTWrLQAbFN/1yS6J0+uKVksHz9NmIQ+z/
	 hiSFYekj0CH5g==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 9123C125965;
	Sat,  6 Jun 2026 19:04:09 +0200 (CEST)
Message-ID: <39ca2f6b-56fa-4a37-86cc-928a599340f3@buffet.re>
Date: Sat, 6 Jun 2026 19:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] landlock: Add UDP connect() access control
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-3-matthieu@buffet.re>
 <20260522.AhMei2meelee@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260522.AhMei2meelee@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/2026 11:18 PM, Mickaël Salaün wrote:
>> +	/*
>> +	 * Construct a struct sockaddr* with port 0 to pretend the
>> +	 * process tried to bind() on that address.
>> +	 */
>> +	port0.ss_family = sock->sk->__sk_common.skc_family;
>> +	switch (port0.ss_family) {
>> +	case AF_INET: {
>> +		((struct sockaddr_in *)&port0)->sin_port = 0;
> 
> Why is this useful? The struct is already initialized to 0.

Indeed, I will only leave a proper initialization of the necessary 
fields instead.

-- 
Matthieu
