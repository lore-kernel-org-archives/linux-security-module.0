Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE73BE49
	for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992385; cv=none; b=hp8A7GO0KKB/ivS6Xd4CCBdOHNBIYejPKli6Uv4kO8rvFJ2tjhBW9w2QQjLn/5kfATWpFzHQWr7IuGSzAsleNQ9RJvUGGF3GTbNthNWhaWS2SGNpik6eP07o5RODHF1KIEnQgyekSN5yjzvCKm42SCHbzysoISna6gX4utP/EzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992385; c=relaxed/simple;
	bh=e/oB7EHyTS+qrUZJuOHpe7f0RTBTpNdPueEV7DX+ZNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJnlTSlCKAXlsp6n50swsBHBe5rCO4807jKdeL6gm8Mp4/vBfAcsyCltt5hkDejJ4Rg0Oz7Ti4fBrpz0ML6+VsD/VQBpOII+bYRbF3zydqLEOcWRC8BLuzsfnBMgEQJdZw5M9cWxS2JhDvb6cyebsu4tM/AtbkcwC5fsx5e4GHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=JLbY4nIz; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JLbY4nIz"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id myjdrmzOts4yTn9HFr5HW7; Thu, 21 Mar 2024 03:39:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id n9HDrltoqbhc1n9HErPYiE; Thu, 21 Mar 2024 03:39:36 +0000
X-Authority-Analysis: v=2.4 cv=Z7bqHmRA c=1 sm=1 tr=0 ts=65fbabf8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=pzMpKnHA-g9QxEOb-IoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xx+crt5ANis/Uvu0cR7hGXRkyaHIWmqFF50ZDHk5Svo=; b=JLbY4nIzWuQCLgb5ICw49FDMKR
	/gzQINzFzoX6F2pjGfaO9J9u2drVa6xUl1c6zzZXdkMIikDGwHM+aNybzI4h7mquctoZL0V6fpxFG
	UNS0VuXi5ReVD1ibKpHXBlaaaLHyQ1O3mqrVxaiV4GZIyKz5gEdWQE/9+mF+OYuqBYeEq6EDQaeow
	P4sFbE1/rYZdydtTB5L3q4LClbdRtLtr56zsxXiR9/amRYqtQqK0svhm0BNpcIqolP3e0mmcDnuIz
	4V30tSlXG5ydaBoBibFWe/ub4uOi4RfU7C/5CK/8Y9+IGqBkSSSGQHME3VWCISZcbH2WfcK4qq13d
	kfzvj7Xw==;
Received: from [201.172.174.229] (port=41350 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rn9HD-00172A-03;
	Wed, 20 Mar 2024 22:39:35 -0500
Message-ID: <fe36683b-ec78-4f83-b4ad-8dca35e4fa09@embeddedor.com>
Date: Wed, 20 Mar 2024 21:39:32 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeYKWrXvACBBrAP8@neat>
 <bbae0060d6ed7a0b033dc07e8d26c9d68585080b.camel@linux.ibm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <bbae0060d6ed7a0b033dc07e8d26c9d68585080b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rn9HD-00172A-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.229]:41350
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEQjzVOG2Of+n9955yo/JJQPfu3kRHLDMzN22CgOgf2WtoCdYDX8JvMkd6aFQcaJK2i/T6B1l2EVyOLqIiPr45PKOFTcP9ElMAw1JfQ/tQrF9l+Es1Ek
 iFFB11ACHZLa1WKzzgQEjR4zcKJN5cS9ybUQLodlSpgWj1/hzDi0pysD6xNaOXZQGp2du6vSi2OYZLFQQqnG1fp5h9Jlnv/PSfVNCQ15JY2RdBsVVjTwENGE



On 20/03/24 19:19, Mimi Zohar wrote:
> Hi Gustavo,
> 
> Sorry for the delay...

No worries. :)

> 
> On Mon, 2024-03-04 at 11:52 -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> There is currently an object (`hdr)` in `struct ima_max_digest_data`
>> that contains a flexible structure (`struct ima_digest_data`):
>>
>>   struct ima_max_digest_data {
>> 	struct ima_digest_data hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of another struct, we use the `struct_group_tagged()` helper to
>> separate the flexible array from the rest of the members in the flexible
>> structure:
>>
>> struct ima_digest_data {
>>          struct_group_tagged(ima_digest_data_hdr, hdr,
>>
>> 	... the rest of the members
>>
>>          );
>>          u8 digest[];
>> } __packed;
>>
>> With the change described above, we can now declare an object of the
>> type of the tagged struct, without embedding the flexible array in the
>> middle of another struct:
>>
>>   struct ima_max_digest_data {
>>          struct ima_digest_data_hdr hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure.
> 
> Nice!
> 
>>
>> So, with these changes, fix the following warnings:
>>
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
> 
> A similar change would need to be made to struct evm_digest:
> 
> struct evm_digest {
>          struct ima_digest_data hdr;
>          char digest[IMA_MAX_DIGEST_SIZE];
> } __packed;
> 
> Is there are another patch?

Oh, I missed that one. I'll include it and send v2, shortly.

Thanks!
--
Gustavo
