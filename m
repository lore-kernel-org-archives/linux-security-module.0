Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82CDDBE
	for <linux-security-module@vger.kernel.org>; Thu,  7 Nov 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000280; cv=none; b=APoLddXhAE3tuV1iB3TyeOhz601H8GOuuKJeFnASD0C0YdLIzPe7kH6fnPV2Pz3mcKsXPA9Vt4n2Ybnwb7Rz4+I0d4xitDHFAo1HTI1j/cHUUcr3cH/m62663RGCnFE4tOlUNoi2CdMM6P+h1cgRkhF4xQ8o6K2mZgKeHNj0XwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000280; c=relaxed/simple;
	bh=RaXyy+VKSiJiEiElRhCWWL1NRxuH7NeFLLzgJZE6PR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K5tMImGuj14sSpUelN9joCe9MBPromLUm5UYqsr6Hvvv3FCpHrQx10QIWUX7iimCjvv10HzV7NT2J56XqiKKgOlxXOJdaTu3p7LdgMBteHnD4mM01Ip5D8qzZoPl/e++RSPmd+6HH7cb4z8ZyZPXURmrS/abyqDrzRUUui7VeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=saIVaiiH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="saIVaiiH"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M46UDkODwazofnm32OHZTIwC2It9O9ffYs8hTvn4ncg=;
	b=saIVaiiHCnzwY0QUndR/YKmiOg91g7WSKQGVuRUy3g7buLB1SUbHcrb4sRSbOOO8oocD4p
	Yfoc66eby+zRWTCM1sPEEbsETLzSdTS9T72f/1N674QcwF+mcLT9a5ZRz5CCMcGj+yiqVf
	yoXtwZzyDhmW+D69jJiANS2ICoGWGzY=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] apparmor: Remove unnecessary NULL check before
 kvfree()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <75ea2e8a-fc2e-487a-8f20-c0664b1eaf05@canonical.com>
Date: Thu, 7 Nov 2024 18:24:22 +0100
Cc: Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8EE9A6D7-A3F1-4A77-9345-9E1C5B3C0DA3@linux.dev>
References: <20241107112526.2312-2-thorsten.blum@linux.dev>
 <75ea2e8a-fc2e-487a-8f20-c0664b1eaf05@canonical.com>
To: John Johansen <john.johansen@canonical.com>
X-Migadu-Flow: FLOW_OUT

On 7. Nov 2024, at 18:09, John Johansen wrote:
> On 11/7/24 03:25, Thorsten Blum wrote:
>> Since kvfree() already checks if its argument is NULL, an additional
>> check before calling kvfree() is unnecessary and can be removed.
>> Remove it and the following Coccinelle/coccicheck warning reported by
>> ifnullfree.cocci:
>>   WARNING: NULL check before some freeing functions is not needed
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> sorry I am way way behind on this. I am going to work through the backlog
> on this list today.
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this in to my local tree, and will push it up in a few
> hours once I been through the other patches and testing.

No worries and thanks for the update.

Thorsten
