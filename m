Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE782907;
	Mon, 23 Sep 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113252; cv=none; b=REuVxL1ViPMEt6pTpU3uL1vvV3G03aw29XcUZd9W5XgHcZScTvdU8I0wgOV9M/lv3LyV3wCKvxb7vkNPZ6O9hXCYkPS2fiY/0iuU7wd4dSSn9LFHBZBtyfulZ899eQnea6nbIeYhW/xbwLq2lQK2fjMH0qX4qG5t3QLUBl5iIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113252; c=relaxed/simple;
	bh=pi34iohdoaF/UgYjqbNePgoY5eJI/IB5qUXN/WAy1+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRsEBZGt22JFc4xJyLrgxouOI5NL6tv/2WXY+BeD5EkFrVkhDN+4snwyZN95gRdzam8+i03IJNtGz1ZhB45TL/B/S+a6opeW0gEQcjBmxdXEGO/vCcnQ8827rPir2Y8BEQ3t60KPs9euaz0nrCwzA4/saE0/k4mey4GIZ3XrIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G6/4pfx5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G6/4pfx5"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id A62B420C5D8F;
	Mon, 23 Sep 2024 10:40:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A62B420C5D8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727113245;
	bh=Gr2uFb3EZBrN1Pu/nsPBCk8f40iLSgy4wKQYWk5B0o0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G6/4pfx5PN3ECtNoXB7dwRE54GVwJBZ5FGkGi0WfRQlXthBXk9iypPYEMtd9VXfnJ
	 qicFgvqmH4TRCtH0Sk7l/JjDf72iFprFVvxHgKbV2pBwLOvMc2+CdJcGjlBTuaqjwV
	 CbYAXyQFMf3T6+QeDJ+f3AlyJTArmK+8WD7trRtU=
Message-ID: <e824b125-0ab0-4e1f-9411-abbc1984c124@linux.microsoft.com>
Date: Mon, 23 Sep 2024 10:40:45 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipe: Add missing terminator to list of unit tests
To: Paul Moore <paul@paul-moore.com>, Guenter Roeck <linux@roeck-us.net>
Cc: "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <20240922145226.491815-1-linux@roeck-us.net>
 <CAHC9VhRWhknpRkKv7-yZza-kr1Bq2nhch8bYm9BsfDpurFir9Q@mail.gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <CAHC9VhRWhknpRkKv7-yZza-kr1Bq2nhch8bYm9BsfDpurFir9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/2024 5:27 PM, Paul Moore wrote:
> On Sun, Sep 22, 2024 at 10:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Add missing terminator to list of unit tests to avoid random crashes seen
>> when running the test.
>>
>> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
>> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Fan Wu <wufan@linux.microsoft.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   security/ipe/policy_tests.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> I'm guessing Fan doesn't have his tree setup yet, but if I can get an
> ACK from Fan I can send this up via the LSM tree for the next
> v6.12-rcX release.
> 
>> diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
>> index 89521f6b9994..5f1654deeb04 100644
>> --- a/security/ipe/policy_tests.c
>> +++ b/security/ipe/policy_tests.c
>> @@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *test)
>>   static struct kunit_case ipe_parser_test_cases[] = {
>>          KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_params),
>>          KUNIT_CASE(ipe_parser_widestring_test),
>> +       { }
>>   };
>>
>>   static struct kunit_suite ipe_parser_test_suite = {
> 

Yes this looks good to me.

Acked-by: Fan Wu <wufan@linux.microsoft.com>
