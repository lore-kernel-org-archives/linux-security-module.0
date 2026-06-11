Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADFBE56A
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137651; cv=none; b=gL82l6VmAoPcz0KCnhdIoS3OJNzRqIdcgBh6LsLQN/M2sp36x3wu7QMibKe/a90iN5asLpsekYmYKHycTKUJRuM/w+qX7F9Tw7h6eQSRgbB+nC3LWc0kwb0ABMIjKOBJa3lV3Lc05W9rN1kakakMJJSZufTV/5POpivns6SjO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137651; c=relaxed/simple;
	bh=/9pGd6JV78OrnjivPvJM9gnNvYWXclnXGuqfTI3bPjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ9pa26Vvo25iZTJtdP5XWFTO+yR34NdSQHrJ29qsSiYUZ5XlaGite+ZuFaMLxH39pdzdH3uOX9D4ftO+cBoPli98eoF+zJnkes8MTzDajaMZX1XDDf4m+2+prWXuGHqh8l2mQHZo4we/kR0nFPv0vz05FqwLwLbLOzWd3XXF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=lTcslGFS; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="lTcslGFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781137640; bh=/9pGd6JV78OrnjivPvJM9gnNvYWXclnXGuqfTI3bPjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lTcslGFSP4aGvPa5hquLdwaxUWgGV/WaEneI3Vq0zcvo67tqoJ/rO81Ye0MTsj7PR
	 zOeVFZe3qSCO2FLCQEj4j3oLfsg743HpkL/GTflhI9UvEloL5MT8UGzjJCbGatNMJv
	 FDCncDKeTtOTT5pc0Dxi1xID8KPkLug00lD6GLKZFvb/r/NI85rR2jFA3rsPo1bVKr
	 fpWDFMLNIXNjhi1MUwT2bQooNINk5P/5svubNnr6mzPEug/ZmA4WZkmuTg9sEM8Hug
	 vZYm8N1TOKGljDqXFeQItOHUUPG38kpqV7Kug8fimbuoT59zt13Uk/AM7Nd48JnBsW
	 5Cykcg7SCWdKQ==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id A053B125972;
	Thu, 11 Jun 2026 02:27:20 +0200 (CEST)
Message-ID: <da858a1b-c483-47e4-868d-f731c14caaa0@buffet.re>
Date: Thu, 11 Jun 2026 02:27:35 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260525.aeng6Xeula5o@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260525.aeng6Xeula5o@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/25/2026 10:28 PM, Mickaël Salaün wrote:
> Also, some interesting (and some other not relevant) findings here:
> https://sashiko.dev/#/patchset/20260502124306.3975990-1-matthieu%40buffet.re

No false positive in there afaict (e.g. connect(AF_UNSPEC) does not 
trigger an autobind but was indeed incorrectly subjected to a bind(0) 
access check).
I have just finished merging small fixes. Thanks!

-- 
Matthieu
