Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8C15855E;
	Mon, 30 Dec 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583798; cv=none; b=KSmGC0JFIR05oaiwFutkz1SaN/eMbey8fE8c1S5KhRWWZ2mjG6yOCdtVx6zyfAiagzs61/vMVECcbCWykCVloWVmq+uvbaVj19nSQbryz6Ibny4ixSHF1gaCO/Nh8tX6nboOVcGZR1uFq5bps8ZBedu8wIMk/4x/nNyqyY3jlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583798; c=relaxed/simple;
	bh=7nv6t6D9vJCjPEk0qq+1R21b6fkOA2Bsx8ApE/3ZLCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dz46rcFfgIdZiWNSixSYcu9ujeRzOS3lZVk5hNaO+5f7oaQZ8vW4mrGycxGfPNGg8jzK2drR1l0vB2WgU5SjpkPlvZF+HWsHbQpPdG2Cp+bEJFeaSm58oxPzOE5DwmXkqT8KSD729N56srMHmNFfriQoQAyLoTx0vwTgwHY2Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=n+9VAewT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="n+9VAewT"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ADBCF403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1735583795; bh=lTiFUAVNeTO2xzNvLru9lNbS3VL794yG8iBFtprjiDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n+9VAewTA8ypRDMrnh6V3YWR0sBuhu3tSpvhKvdZtPBxsFu71qh23xKSjX540efnM
	 ceGzPb/FPoF/24tbwonkSWAP+oF32cB/QPaRNIO5SolwxnoybXo3FdTKU3SEzM4RSP
	 GoJEP53Mi/fJFxeq4G54DIyDrv1ohvkCE3G5rPggh478LdJNSUXEPlmRynzD5g7V7n
	 DKv60mJ/Dc9ROILDsAxBzoahVfpGyM3qhDJNuGL6DdAGBnjc5lNT+93ug9eX4cu+P/
	 zHaeRurgYvR457dOfaGcLuF3ilRd+DgKZGKqWjfr+Flj/nLcDfZuScO9UmDUz8TgQ1
	 xLw1/YO3cMOCQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ADBCF403FA;
	Mon, 30 Dec 2024 18:36:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>, alexs@kernel.org,
 si.yanteng@linux.dev
Cc: dzm91@hust.edu.cn, mic@digikod.net, gnoack@google.com,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, Yuehui
 Zhao <zhaoyuehui@cqsoftware.com.cn>
Subject: Re: [PATCH v2 0/2] Add security index Chinese translation and add
 security lsm Chinese translation
In-Reply-To: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
References: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
Date: Mon, 30 Dec 2024 11:36:34 -0700
Message-ID: <87zfkd10i5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn> writes:

> Add some blank lines and modify some translations in security 
> lsm Chinese translation.
>
> Yuehui Zhao (2):
>   docs/zh_CN: Add security index Chinese translation
>   docs/zh_CN: Add security lsm Chinese translation
>
>  .../translations/zh_CN/security/index.rst     | 34 +++++++
>  .../translations/zh_CN/security/lsm.rst       | 95 +++++++++++++++++++
>  .../translations/zh_CN/subsystem-apis.rst     |  2 +-
>  3 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/security/index.rst
>  create mode 100644 Documentation/translations/zh_CN/security/lsm.rst

Applied, thanks.

jon
