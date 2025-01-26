Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA4155743
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900910; cv=none; b=h/E654yoqFdPrPiTf+l3W6tkdR8VALzQ02MZAS7S8Tek4Te9nH4JfCJuLr7vD4s0XRQeRKxS/VmFZhJ2XE77Mq4xXsit2ZtsTMGfdUxw3yX0BSxavRkGT1vCUUz9qxmkPYhsJ81vqK8cKjOuy/v4HBidH81pwgy4+9mTcXQghUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900910; c=relaxed/simple;
	bh=5T5KU9AeFx9gpFYlUYIWNv1ehk6tbL87hinsBYrjPKU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eEQ7IQQ/0z3k11FBjUzaynGXKcx8rlruMPnOke1x6Hmm5ciCHEsqmDs6TTzTANeV/mjK4QK2bIdrmsr6SV9/ASSkzJuaWA0sNlJWt1LSXR3Qvrah/JmMJfpTxTBMZyvPNM5BOfAzuQjR6uKJ5WGqIl6P4KXWccNsiriZs6JrUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=e2zzqmsW; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="e2zzqmsW"
Message-ID: <72077b25-4f5f-4a64-ae35-ee2fe72f49c7@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737900904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awI40/D+svAcMO79CeOlzsrhudt3JSIO5pj4XhKUn3Y=;
	b=e2zzqmsW46ZI3vnwc87Vw8GIZU4LG5Z/QqzQq/9IJ5kPOLFVXuqQPSSyQkH/VOHFn2cvjt
	5ZT4FwBmly6Z+jj3MOaSLTJdogSP1QWK0gUDmFy7LEaCqYAKy9+k+bL2uKU+I7w3lrA27P
	ZlgDfUhKpmbUxNch8Os4b/ueletbXIw=
Date: Sun, 26 Jan 2025 17:15:50 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Konstantin Andreev <andreev@swemel.ru>
Subject: Re[2]: [PATCH] smack: dont compile ipv6 code unless ipv6 is
 configured
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250117163645.3069927-1-andreev@swemel.ru>
 <40046ce8-1117-47a7-80a3-650f7adb1ecc@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <40046ce8-1117-47a7-80a3-650f7adb1ecc@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2025 14:15:04.0353 (UTC) FILETIME=[B1D50110:01DB6FFC]

Casey Schaufler, 21 Jan 2025:
> On 1/17/2025 8:36 AM, Konstantin Andreev wrote:
>> I want to be sure that ipv6-specific code
>> is not compiled in kernel binaries
>> if ipv6 is not configured.
> 
> The IPv6 Smack support really ought to be replaced with an
> implementation of CALIPSO, now that it is available. The
> conditional compilations that already exist have drawn no
> small amount of well founded criticism. I will most likely
> take this patch, but if you want to be extremely helpful
> you could have a shot at CALIPSO for Smack.

Actually, I am sharing the changes
I have made to SMACK along the way,
during development of other feature.

IPv6 in Smack is in my waiting list,
but not in a focus right now.
--
Regards, Konstantin Andreev
