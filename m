Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF461FC3
	for <linux-security-module@vger.kernel.org>; Sun, 27 Jul 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753626716; cv=none; b=QIRCj+2wc0EeqAHMmGxdC2FraLXnbJ4mmEzeUuKn4VQu1Hshi5jCN+qRM4X8IGJiCNpGkNDDjKy1UEguxm+adecO0Wso0oEyUoJobX61355aGb5yBXlFNHKwD3g+GiqFwlKQ9CtBXlL/wjT3mUyRR7VAyttWpXVtSqiz7uzCpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753626716; c=relaxed/simple;
	bh=nAwBUKoPabDzM1CJqE51gB6UpenkpbuRHYXb7+DY6AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8BE+dFQQacOapuRlDnCz37LEpCSxS+DXnPmvABzs6wjvcV2v5EEZr/ns+kpuIfd58mTXZpSt8MkYQcWOuX7XgJjBzCMuwMkmjTjZ+1l3fy2A+llIt5tn4Gn9Zdx+v62ngxSQfXLe2yqTNxLGOv4N13i+Dl4e5aSuv6TMMeSKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=HWtyiocA; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="HWtyiocA"
Message-ID: <87192016-310a-4d7d-9583-af583afa33e2@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753626699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYeAj3ZeLV33v9Dn21N++Y1TKPE9xeqIjpEr38ZBV0Y=;
	b=HWtyiocA04hj1Y4YDAFyyJRoF+vjOhLD/VZCuSxZmOHqfMka2dSMUdehPEF/rE7zJ7IY9U
	UKA/uc3mPZ60PtMynQjBCG6HsV/GgCLcOWRE+eC8pzwzRtkpphE1/Q3tfiddXJZ+KNP4Iv
	fbVAcrXkeg5UlJvWFoNfE6Xg+aOgrHs=
Date: Sun, 27 Jul 2025 17:32:30 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[2]: [PATCH 00/19] smack: clean up xattr handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <cover.1753356770.git.andreev@swemel.ru>
 <f4b697c8-7851-4e46-ad33-bd0eed50af06@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <f4b697c8-7851-4e46-ad33-bd0eed50af06@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jul 2025 14:31:39.0224 (UTC) FILETIME=[2A00C580:01DBFF03]

Casey Schaufler, 26 Jul 2025:
> On 7/24/2025 6:09 AM, Konstantin Andreev wrote:
>> A set of minor bug fixes and optimizations in Smack xattr handling.
>> Logically independent, but with the code dependencies.
> 
> Please break this into two (or more) patch sets. The patches regarding
> restrictions on getting and setting the file type specific attributes
> should be presented independently of the xattr "fixes".

Hi, Casey.

Each patch in the set is finite by itself,
addresses an independend issue, and I ought
to send them separately. There are several reasons
why I ended up to collect them into the set:

   1) they are very small and have common subject
   2) they have code dependencies
   3) the feedback time for Smack patches may be high,
      and sending patches one-by-one may be long.
   4) to give you an overview of the offered changes


May it be suitable for you to consider this set
as independent patches, that require, however,
the specific order of applying?

With this approach you could stop considering the
sequence at the 1st unacceptable/wrong/failed patch.

Else, I can collect them into two (or more) patch sets.

> There appears to be a misunderstanding regarding "valid" Smack labels.
> A Smack label is a text string. The intention is that a label is "valid"
> if the system is exposed to it. For example,
> 
> 	# echo Oatmeal > /proc/self/attr/smack/current
> 
> should introduce "Oatmeal" as a Smack label if is has never been used
> before. After a reboot the system may find the label "Bacon" on a file,
> and if the label isn't known it is imported.

I think I understand this.

> Similarly, if a CIPSO packet
> includes a label that has not been seen in is added.

I have never seen this. The unseen CIPSO label is not added,
instead, the incoming packet is marked with `*' label.

Just rechecked, it's so. E.g., tcp/ipv4 connection,
listener side writes the audit record like:

| lsm=SMACK fn=smack_socket_sock_rcv_skb action=denied subject="*" object="foo" requested=w ...

when incoming CIPSO has [bar 250/2,3,7,10,11,16,18,19,20,23]
at the initiator, but unseen at the listener side.

The documentation does not define either way of processing
of the unseen Cipso labels, but current implementation looks
reasonable, as sheer import of network-provided labels
has no limits and opens the door for denial of service.

> This policy is necessary in part because there is a valid use case for
> a Smack label with no explicit access rules.
> 
> I tried out the combined set and encountered many unexpected failures.
> 
[... skip ...]
