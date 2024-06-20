Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A521B3736;
	Thu, 20 Jun 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903348; cv=none; b=A2jZLZcmRiwhPOTGa/iMxBAbbtx96C2UNJzdTusXvXFv/Na7Gzr2j5A71zMO0vKeS0+RDPeCWlOcq/m7ScBDKdg/dHjBdL1sQVBoug06LXICWUQVA97Xy3lYuVUHAyW3VjU84VDCr8mYjySQGwOKrTkMeXIDaaNvWtN4TaY2qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903348; c=relaxed/simple;
	bh=dMTJ8908E2JNrwW/lpHVRd+tVPSWWPLkCIEguNz8I0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHxWWkXW9aZkLBNiE/gr+YccUqF4ZJoLaibs9rJsFHfWBI8zoguEduLGYRfSH0exXzamq2eucjteQMJtcuRs4GGOuB55dHO9/bzhZgEvCpuCuQgFK6By6HU4OP6FDJPu1lhgBH2TGNG1TZHqY/gb0tMxlHVwYORSoRO+lzeez8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E/5/ThKI; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E/5/ThKI"
Received: from [10.0.0.100] (pool-99-255-30-7.cpe.net.cable.rogers.com [99.255.30.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EBC4A3F210;
	Thu, 20 Jun 2024 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718903341;
	bh=WUmq2Z+BZ+5Q2DHpiaBkQxOe37bDl4Qhdq2/NQMQuco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=E/5/ThKIUAuABAsJCcC6kMW81J3WwrxQq/XW0JKQjblFomtVI3c+vnhI0JI9j6R+i
	 bybkZ/XRsNk27Mpk0KeHaDcdsQi6phL1cPBQyIP+WKkf49HxE8AgFakPqG2yBxxCRt
	 AC8hF6lCbMnnSx+VHjw3+NWAejhDnwLdn4tPF39l5fVnYxt/dNSFxmIAvoUdAb+x/L
	 vl6lJR0NK+bEdbvas11hujemBPFuCi0/28hu6tRvmVwlhp1i45Qxwh905Tj508DgwQ
	 aJQjkgicrulhYg/Men9dopgWqvLbcU6h/lT9xEj48abe/vZjR4Xa6RhhNzlUY5sbgi
	 ddYdhEbXMja7A==
Message-ID: <c9f55357-029b-4799-8072-f5c96216d60c@canonical.com>
Date: Thu, 20 Jun 2024 10:08:58 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: try to avoid refing the label in
 apparmor_file_open
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, Neeraj.Upadhyay@amd.com
References: <20240620131524.156312-1-mjguzik@gmail.com>
 <71c0ea18-8b8b-402b-b03c-029aeedc2747@canonical.com>
 <3ijkwqkrynfxi6t5bj2jingkpebsnomdcwduhe4pgl6pu25sfs@smvxx7ewexkc>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <3ijkwqkrynfxi6t5bj2jingkpebsnomdcwduhe4pgl6pu25sfs@smvxx7ewexkc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 09:41, Mateusz Guzik wrote:
> On Thu, Jun 20, 2024 at 09:26:00AM -0700, John Johansen wrote:
>> On 6/20/24 06:15, Mateusz Guzik wrote:
>>> It can be done in the common case.
>>>> A 24-way open1_processes from will-it-scale (separate file open) shows:
>>>     29.37%  [kernel]           [k] apparmor_file_open
>>>     26.84%  [kernel]           [k] apparmor_file_alloc_security
>>>     26.62%  [kernel]           [k] apparmor_file_free_security
>>>      1.32%  [kernel]           [k] clear_bhb_loop
>>>
>>> apparmor_file_open is eliminated from the profile with the patch.
>>>
>>> Throughput (ops/s):
>>> before:	6092196
>>> after:	8309726 (+36%)
>>>
>>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>> can you cleanup the commit message and I will pull this in
>>
> 
> First of all thanks for a timely review.
> 
> I thought that's a decent commit message though. ;)
> 
> Would something like this work:
> <cm>
> apparmor: try to avoid refing the label in apparmor_file_open
> 
> In the common case it can be avoided, which in turn reduces the
> performance impact apparmor on parallel open() invocations.
> 
> When benchmarking on 24-core vm using will-it-scale's open1_process
> ("Separate file open"), the results are (ops/s):
> before: 6092196
> after:  8309726 (+36%)
> </cm>
> 
> If this is fine I'll send a v2.
> 
it will do, largely, I was just looking for something that explains
a little more than. "It can be done in the common case"


> If you are looking for something fundamentally different I would say it
> will be the fastest if you write your own commit message while borrowing
> the numbers and denoting all the wording is yours. I'm trying to reduce
> back and forth over email here.
> 
>>> Am I missing something which makes the approach below not work to begin
>>> with?
>>>
>> no this will work in the short term. Long term there is work that will
>> break this. Both replacing unconfined and the object delegation work
>> will cause a performance regression as I am not sure we will be able
>> to conditionally get the label but that is something for those patch
>> series to work out. My biggest concern being people objecting to necessary
>> changes that regress performance, if it can't be worked out, but
>> that really isn't a reason to stop this now.
>>
> 
> hrm. I was looking at going a step further, now I'm going to have to
> poke around.

