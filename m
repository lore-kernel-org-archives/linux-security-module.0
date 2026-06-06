Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3C23505E
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jun 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765715; cv=none; b=iOXRJSsOMV67/Ki2Emi44XiYnWkazk17jTJYCdEC1iynlGVCyKXm/lTKYWh/bl4SpJ0IQT1/Wotp0YoPoXlNgpz4fHIsc6Vuwn6xiW336ha1q92YmurP25C864hz3tp1rrMA2pQ3WRHeCFNoUtRqgS6ts+YlOJ5SPdS6Oi2f3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765715; c=relaxed/simple;
	bh=0BGFgo6g03rQAvNYENOa43LF7fzZBnIwtU201XixPa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcspAor7dTlaVrtMPiI7K668fCjjS1uTCMtw73acxzxfXJZp+rUIIyyxgpnHClBwvvOWG6kJ/j7tf+MqpVg3labyBcMHTcXXQsygx/6CgT7uNmTBqQdrkevG9sNhecvIzl1UogVB9+N8JdCKu9z+0nqid4iFzdCuWTIVZos/eAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Wq8nfyX+; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Wq8nfyX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1780765284; bh=0BGFgo6g03rQAvNYENOa43LF7fzZBnIwtU201XixPa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wq8nfyX+nsj7U3W9XDd/RozAgXtw2uEBSGoKYn4sHGQRsU6GzXLMBrccPmY8xqhVy
	 ytHxpaaLqDHJgfxIgHoTy3dqv3xAyzi1Fatba9bcHrdwpVbXn0RKb1E2lpB2dN4Akn
	 3p+ghBbix2VsRFMFzPtmRPlbf3qzwDDc/gQYM1poD5q70nCY84dXlHDF9tIQyXZuTA
	 hj+4Zn9uJz6K0Mr6URCtwwZbOkGf6LvKpuB/8zyq+f8Mu/+D1N8WVlyv/0aUrXF3fJ
	 hansPeSlk5+s00/2/IAgSFZrr86cFqK1gjM+/yzTkJf7c16rT6X50UCf76tkRFsCJ3
	 hUDgTUXHGn6Iw==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 7B3F5125930;
	Sat,  6 Jun 2026 19:01:24 +0200 (CEST)
Message-ID: <ed2805ed-72cf-4277-993e-8a0ca73e65ee@buffet.re>
Date: Sat, 6 Jun 2026 19:01:24 +0200
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
 <20260522.saibiuZ5ailo@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260522.saibiuZ5ailo@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mickaël, Günther,

Thank you both for your reviews, I will follow up with these last fixes 
in a v5.

On 5/22/2026 11:08 PM, Mickaël Salaün wrote:
>> I'm just not super happy about the clarity of logs generated for denied
>> autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
>> addresses and ports are currently only logged if they are non-0. A later
>> (coordinated LSM-wide) patch could improve readability by replacing != 0
>> checks with new booleans in struct lsm_network_audit.
> 
> Do you plan to send such patch after this series?  I guess we could add
> has_{port,addr} fields to lsm_network_audit and handle AF_UNSPEC too?

I have not come up with anything better than adding boolean fields, so 
if you're in, I will draft a proposition along these lines (and cc: LSM 
subsystem maintainers to synchronize the change across LSMs, I guess)

>> I'm also not
>> exactly happy with the integration in existing TCP selftests, but
>> refactoring them has already been discussed earlier.
> 
> Can you remind us what was your concern and the potential fix?

Regarding TCP selftests, I was referencing that discussion about 
readability (length, and usage of conditionals in what are already test 
variants) :
https://lore.kernel.org/linux-security-module/22dcebae-dc5d-0bf1-c686-d2f444558106@huawei-partners.com/
Nothing blocking, refactoring can be done when things are less busy.

-- 
Matthieu
