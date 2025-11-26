Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25A29E110
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185623; cv=none; b=cg2fsBANA64hoYnX58fOcKxwEed2MyFXqFt+MhaehClnQYb4cWlY2kHa40U8yZJljJm7QFji8hdHDgcirmKIDcB0v78eT/ZX8o6Io58J8WArer3mTRwJ2q6pi5mgDTOTfxQ65d1Dbif1b4qBFtjF0wMZYFISHhNHUOOTaG9o+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185623; c=relaxed/simple;
	bh=HYH6zAtKbzREJZ4g9W6jt5HmnHtr5oDmUi1h/tnXbXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O72/xKa06LZcoBLwqjfZCBtwaF+BRG0eoniF4YMYtS0KGgekXhfmUT1DBXaWnUdLrHSONCafSTVzipR7fOAHM+maK4YD5YFRHojoA542khARiIhZ9/acaKS9BA3o40eRea3RcVEVAz8kBc/f65E2yKFiQpmyuJFoYNdRWqkDEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HRaqHDOO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HRaqHDOO"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A01440F19
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764185616;
	bh=az79TvpSU4Bz3IJbxRZDLB6JDgHW9IpSjfiaFglD1Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=HRaqHDOOOtmzkOzcHJMWt5UtvS5R8VkoogqTxEJX+VEsx/qlKi17GW4BKobnJZ3y5
	 fqtSpoOeDR9e5WWpajMFer3EEj5Bon8/jpw0g0a3K03lOd91flfs2LISWOhDFOMTXw
	 z6bx1t0zrACRCjlU3PbP9mBsmJQ1RBUS+7kMxnQU2wXGF1D0jFYS02DOeGAcjKJio0
	 x00thW+haxROaKWzqGzyVmwO9OCmmVXm+mjA0q+dx4ciZJm/zyYyQ+yT8DQ7jHkQhD
	 oQyfH4iJtQX9O2HpYaLZFIvOd8i3quTACRp7lZqa0vksdHfHif6Sq5M4N/TkbvlgU6
	 Llkd+VZ7AFTH2NgO/8fnbuuJfK+tOkvWJ5mg8xCajPMwyzsBpwt5o8HOT7FGMrB3MS
	 NsoKEzPcemBYtdqAtCCvlQDAt/ykj2Xn3jsE8ZBZttKOC2lDW8IMC49VZuWNzn/L3B
	 /5HpVXivQAIedeQXPd7J9Pt7GsQ6eFN3ZKdFfjyyIzMMWJGo9cJQehscOEiumfuKqC
	 6KqU77dE/qw4mu9sp3QDHm5+kdwwBbltLTTWPG+3DgIpUA/sNgH8/QWl5inJP8qPg3
	 N9p0GmLt1w56oKrfpFhHK3B0N4Fhf/9VzQy8KUpqvH+WQyeLlsIh/IWDcyAmxIXMtg
	 oVFCsrEU3cgBvOkHV2TQUNdk=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343806688cbso132550a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 11:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185613; x=1764790413;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az79TvpSU4Bz3IJbxRZDLB6JDgHW9IpSjfiaFglD1Xc=;
        b=pOEktAevwLqrJ07bk+ddsbFai0yet1ZhTmrUnFq8VFpGUoQeWfq1hONWdz2ZqIlm35
         /tq/4kbd7J1m8xn4f4Gu/AdoRv9Jm7H650B95iTqdxFdZVbdZ0cRT85yL904dp25vhmS
         pZNYr20b0nyIqROmtvj7MIi/nJXx+lkfHzgxezpRDuD5v3nL6dSqc4XeymOByG8nFQ9T
         Ln91T9s+39SPxM4FuVqsMGuSb3GMKFWP5EaOxHD7i5KWGUp8OYueM276v30M28vWnAXG
         SFpED3kBR9BLBz05OHB/asu50TIABmEcywEnM0LSbedE6hLTPp59k6JYh6uD0bKODYdV
         uepA==
X-Forwarded-Encrypted: i=1; AJvYcCWaNPnyhtfkTKEgHZqn5UA+zSg2oWvJLWkd70XeJoRcg/+bqrSuGca5aZ8n6yepdJVt2mcRLhIanmpkRh/bUHl4cLoOdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzlp49JmzKiULn+9nc8Aj0xs4IugXcpMVAw0XzjkinJzs4SQUb
	Y4KCxf0bMvRumHQmuvKWb1VEaXT5k6GTMeIScPkEaxEWpaF8/dwbicDL4RSzyhWI/Tma/cwGjDH
	+DvVpzHa12C6vhJd1bG87UReBnFI7U8HwwCL3qtzZzM8yT5WPR/KZCK2t/SAcbg3zX/5RrGTy5q
	J5nKEx1MsTxy3sPb/4aYKYZAvI94Ey
X-Gm-Gg: ASbGncszvwMEFK/E2Vp6Mk+JxDJ9kot/mSTtHsINtIVuZ6nbkTV82r10JlL0N7hvnml
	lo4LC9pcwnbVWo1yvhA6amdwSKxxAUsvU7i4Y7W1zQZvhJQnGwIl3tA0ftsYASEbF5releisOwB
	IsrEd+S3/6skMub/j1gCqqRjumtNKicvv/ACW69SEwxybGL6S37AKbo+H4FAMPZidC+zQiy4sKj
	k0e3pNWLI33652LFOJNms36szD5QVDWC2jQt3Y84pAljgoA7xlyH7FjaoRFEM2nUk3BrX2pG1Np
	JdHWfWb0zEf+pwQasMb1jJuOwvMXPDDstQM69cAC4a8un+Zk/OcFiwoU2asyyA53UMBEVVXdOPK
	uBrRx63XTxg6AIWIGDlzLqCvj
X-Received: by 2002:a17:90b:38c7:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-34733e55021mr16182653a91.2.1764185613359;
        Wed, 26 Nov 2025 11:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG47tmkWhcWx7LLIvtKQsizLgK/XycnA3H/j9qIrssDiOnhoTF9BGJBcCZ0+sksNIxvtyVvrA==
X-Received: by 2002:a17:90b:38c7:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-34733e55021mr16182627a91.2.1764185612922;
        Wed, 26 Nov 2025 11:33:32 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3476a7bd7f3sm3338986a91.13.2025.11.26.11.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:33:32 -0800 (PST)
Message-ID: <f5637038-9661-47fe-ba69-e461760ac975@canonical.com>
Date: Wed, 26 Nov 2025 11:33:31 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: Helge Deller <deller@kernel.org>, david laight <david.laight@runbox.com>
Cc: Helge Deller <deller@gmx.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
References: <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
 <20251126142201.27e23076@pumpkin> <aScY13MEBATreotz@carbonx1>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <aScY13MEBATreotz@carbonx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 07:12, Helge Deller wrote:
> * david laight <david.laight@runbox.com>:
>> On Wed, 26 Nov 2025 12:03:03 +0100
>> Helge Deller <deller@gmx.de> wrote:
>>
>>> On 11/26/25 11:44, david laight wrote:
>> ...
>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>>>> index 26e82ba879d44..3dcc342337aca 100644
>>>>> --- a/security/apparmor/match.c
>>>>> +++ b/security/apparmor/match.c
>>>>> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
>>>>>     				     u8, u8, byte_to_byte);
>>>>
>>>> Is that that just memcpy() ?
>>>
>>> No, it's memcpy() only on big-endian machines.
>>
>> You've misread the quoting...
>> The 'data8' case that was only half there is a memcpy().
>>
>>> On little-endian machines it converts from big-endian
>>> 16/32-bit ints to little-endian 16/32-bit ints.
>>>
>>> But I see some potential for optimization here:
>>> a) on big-endian machines just use memcpy()
>>
>> true
>>
>>> b) on little-endian machines use memcpy() to copy from possibly-unaligned
>>>      memory to then known-to-be-aligned destination. Then use a loop with
>>>      be32_to_cpu() instead of get_unaligned_xx() as it's faster.
>>
>> There is a function that does a loop byteswap of a buffer - no reason
>> to re-invent it.
> 
> I assumed there must be something, but I did not see it. Which one?
> 
>> But I doubt it is always (if ever) faster to do a copy and then byteswap.
>> The loop control and extra memory accesses kill performance.
> 
> Yes, you are probably right.
> 
>> Not that I've seen a fast get_unaligned() - I don't think gcc or clang
>> generate optimal code - For LE I think it is something like:
>> 	low = *(addr & ~3);
>> 	high = *((addr + 3) & ~3);
>> 	shift = (addr & 3) * 8;
>> 	value = low << shift | high >> (32 - shift);
>> Note that it is only 2 aligned memory reads - even for 64bit.
> 
> Ok, then maybe we should keep it simple like this patch:
> 
> [PATCH v2] apparmor: Optimize table creation from possibly unaligned memory
> 
> Source blob may come from userspace and might be unaligned.
> Try to optize the copying process by avoiding unaligned memory accesses.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
> index 1fbe82f5021b..386da2023d50 100644
> --- a/security/apparmor/include/match.h
> +++ b/security/apparmor/include/match.h
> @@ -104,16 +104,20 @@ struct aa_dfa {
>   	struct table_header *tables[YYTD_ID_TSIZE];
>   };
>   
> -#define byte_to_byte(X) (X)
> +#define byte_to_byte(X) (*(X))
>   
>   #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>   	do { \
>   		typeof(LEN) __i; \
>   		TTYPE *__t = (TTYPE *) TABLE; \
>   		BTYPE *__b = (BTYPE *) BLOB; \
> -		for (__i = 0; __i < LEN; __i++) { \
> -			__t[__i] = NTOHX(__b[__i]); \
> -		} \
> +		BUILD_BUG_ON(sizeof(TTYPE) != sizeof(BTYPE)); \
> +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || sizeof(BTYPE) == 1) \
> +			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
> +		else /* copy & convert convert from big-endian */ \
> +			for (__i = 0; __i < LEN; __i++) { \
> +				__t[__i] = NTOHX(&__b[__i]); \
> +			} \
>   	} while (0)
>   
>   static inline size_t table_size(size_t len, size_t el_size)
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index c5a91600842a..13e2f6873329 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -15,6 +15,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/err.h>
>   #include <linux/kref.h>
> +#include <linux/unaligned.h>
>   
>   #include "include/lib.h"
>   #include "include/match.h"
> @@ -70,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
>   				     u8, u8, byte_to_byte);
>   		else if (th.td_flags == YYTD_DATA16)
>   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u16, __be16, be16_to_cpu);
> +				     u16, __be16, get_unaligned_be16);
>   		else if (th.td_flags == YYTD_DATA32)
>   			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
> -				     u32, __be32, be32_to_cpu);
> +				     u32, __be32, get_unaligned_be32);
>   		else
>   			goto fail;
>   		/* if table was vmalloced make sure the page tables are synced

I think we can make one more tweak, in just not using UNPACK_ARRAY at all for the byte case
ie.

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 26e82ba879d44..389202560675c 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -67,8 +67,7 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
  		table->td_flags = th.td_flags;
  		table->td_lolen = th.td_lolen;
  		if (th.td_flags == YYTD_DATA8)
-			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u8, u8, byte_to_byte);
+			memcp(table->td_data, blob, th.td_lolen);
  		else if (th.td_flags == YYTD_DATA16)
  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
  				     u16, __be16, be16_to_cpu);


