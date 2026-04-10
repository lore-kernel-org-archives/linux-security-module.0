Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CF3191CE
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786192; cv=none; b=gdHpAHIAP2DIt1hgAqI03PHaOHuyCd1F9AisjxvWwafAHCUNXwqXZF4In6YoqQQ5oE/bSjSjPIVfZabU9nhmGbscpmPBA0BwVMdUEyKHSoDE/QDHAs3767ytAekYMAGgCtnI4Y0YVA4f8593xunJ6DazRKgdDgLmsKnj/0RMZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786192; c=relaxed/simple;
	bh=hNLsk9GgOBTzKWIb+Iv8TpoJgP67Ii4NwnZcW6bI3/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Li+3QrQSkz+aqEeM8Y4d7+UwVBLPRNzcp1Cg88nOzVncgIt5Ie72MmX00HSZ5HrDOF75E4rEYlyqrIPR5nS582J0zzu4ITH3bUSquKEqx/taGxf1YqDqvEQEBncZyr/Wt5y/SDXMeiE6JjIKOh7DZJ64py1vLH+u2eFUm8LtICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqMzmU2Q; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqMzmU2Q"
Message-ID: <a17199c6-fb52-493b-b76a-505faf27cfa0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775786189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSdoLdBeXwPC/LtqKWbZ4UUmsJ5DfrXJa+5w+Zt4nwc=;
	b=SqMzmU2QPrkDe5CQBh7AeWJ+uLdimKK6+gLqD9R4A8ELd4JTFf1NMtH/Zf4V8E6kFo6CiD
	UDU0TtiWBJDtxFPBUY+BmNxJl55BK/HfLBRkrZBHKP57nOG5EtPKsrJD5KHehpUO/8SERN
	pQ0AyB+TQmdx59vWHwqcZlGrA7b5t7A=
Date: Fri, 10 Apr 2026 09:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] security: remove BUG_ON in security_skb_classify_flow
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com,
 jmorris@namei.org, linux-kernel@vger.kernel.org,
 Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>
References: <20260408114257.298500-1-jiayuan.chen@linux.dev>
 <adhLQDIILT/sHpzL@mail.hallyn.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <adhLQDIILT/sHpzL@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/10/26 8:58 AM, Serge E. Hallyn wrote:
> On Wed, Apr 08, 2026 at 07:42:57PM +0800, Jiayuan Chen wrote:
>> A BPF program attached to the xfrm_decode_session hook can return a
>> non-zero value, which causes BUG_ON(rc) in security_skb_classify_flow()
>> to trigger a kernel panic.
> It would seem worth it to have pointed at the previous discussion at
>
> https://lore.kernel.org/all/CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com/
>
> Based on that, I guess this is probably ok, but still,
>
>> Remove the BUG_ON and change the return type from void to int, so that
>> callers can optionally handle the error.
> but you don't have the existing callers handling the error.  It's
> conceivable they won't care, but it's also possible that they were
> counting on a BUG_ON in that case.
>
> What *should* callers (icmp_reply, etc) do if an error code is
> returned?  Should they ignore it?  In that case, would it be
> better to change security_skb_classify_flow() to return void?
>
Thanks for your pointer.

So I think Feng's patch is sufficient and can by applied ?

