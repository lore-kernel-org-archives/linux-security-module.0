Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0C222597
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712003; cv=none; b=LvJx5EzNhOstdO/mnHDzL3VnTg/4VnRdiJoqNC4oQMUV3oAQhCsLpHFwsgKOv5V/142SAFfLhjwiosMFgXUalBOYfuzfmk5AWb3MGAHkZztYBNnG28oGOrsU8KE82ItG0CYk6OMyvNzGSYuPz7RFUBrvb9Eh8N6GYNmBZLPu6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712003; c=relaxed/simple;
	bh=+pQt1XKo6e4wGsWims5i75xxoFCpZG4g4b1nw08w8Ng=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lh2AMBW9R5UYJKBTo9+VSglJ9+wmQq2Trd+1F6su8Wm7XHv7vJFVYQMo13K4lYX8rmOwGgucT59n+AjpkDHBwl281Fo1ZHNWWHUhTXhAp9/GSYieprwPNJMoYiN11b5385Zmpo72chFebJMai8/ddUoaIXwGxB8BSBmQxglgba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=nREfNcq9; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="nREfNcq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1764711989; bh=+pQt1XKo6e4wGsWims5i75xxoFCpZG4g4b1nw08w8Ng=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=nREfNcq9vHSHsNO6c5melN4B/2QiJDL6qUOO2hHjAqDfNpt1lvPaqjebUH3omMSYJ
	 cXMzqL+kBalUSp6FLdAcOqJmO0mmVk9AF/BuqzMDL+DjmKsAUBGjrTTp+474XskA3q
	 3hzvvSp62LfizO2xmJMaAZJsy1BoivsOFufTVX1DXNK1++mKuK9tJfPCZZ8iMQoO02
	 4hC1IkBqzme+D+CNKZ5IDtHGJfKVkr3WhfgMn1q1rE55ulLQjAOfYdOupEIpuKa97N
	 DtagALloxVbjsiUwgODOYIyc5ErP4E4sJLRdVU67MCx2tmmvh18mjDf9pAYf2FRooP
	 3ud7PeCpVMChQ==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 8DDDF12546D;
	Tue,  2 Dec 2025 22:46:29 +0100 (CET)
Message-ID: <c2780073-9e74-4303-9e07-6b825963148e@buffet.re>
Date: Tue, 2 Dec 2025 22:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH] selftests/landlock: Remove invalid unix socket bind()
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org
References: <20251201003631.190817-1-matthieu@buffet.re>
 <aS6lMPTlUo9bWYEG@google.com>
Content-Language: en-US
In-Reply-To: <aS6lMPTlUo9bWYEG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Günther,

On 12/2/2025 9:37 AM, Günther Noack wrote:
> Optional: In hindsight, I think it would be nice to simplify the way
> that we calculate the address length here.  I probably mis-read
> unix(7) at the time, where a similar formula is used (but with a
> "+1").  Re-reading it, it seems that just passing sizeof(cli_un) as
> the address length would have been the simpler and less error prone
> solution:

You're right, the rest of the code uses non-NULL-terminated pathnames. 
Not a problem per se on Linux, but these computations make tests less 
readable. I will send a patch based on this fix. Thanks!

Matthieu
