Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711033EB1A;
	Wed, 26 Nov 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176351; cv=none; b=OZj0eBrA0UwUFE9gtLOVVWgdX1MzQDrsnzBJwtg0FlN20yK02tuOD7O0UW2WKBcfr3akCu/8Ca4kK52/IdFWbSsL6XsFtNkX8OkL971AhfxjsWTw6CiYK1g/cRm1e5txsI5HhbyAcM9de6Q9N0ZPT1HIJoAklNR6r9pTnyna9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176351; c=relaxed/simple;
	bh=6Ih+8pBFYSUgvrVYhFtkRPxBpaswv+43S1DFc39xtfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2XOPn5JDNdLbfhTsi5HDHjSLv7XvVBH6WGx0a31LV7GDIvmm0H7kvr730majVWxvKDBTwH38u3ftb4wHTjH2/6LzY7z8uFXY7wKOBbtXhXJdKXxPzfpr7LuqwlIRtpWhSO//0W+WE4MdbkqXfFhW0RHn9WmeG54rj/R5J6YfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=QE7SLW03; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QE7SLW03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764176336; x=1764781136; i=deller@gmx.de;
	bh=Q58gZBlCKtev0x1vex2b19fxkq/leb3vbOwDruTW/o0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QE7SLW032rGF/7ruoYpkw7CKtkEdKyU0m4A7qc1p2bEyA5A83Zn/M40w2e2QD27b
	 wyC11aJ4WHUciKdF05X69sA3pDmkS8ifYnTAu3PwW09uzVwjRV7a3og5FtiHjCK50
	 CdpFtphRvnkx37n8QRvgp8Ab8Pxn2eL2wnaWRfke+FOzx0k5H/M62YjwWegcJMMSE
	 1zdjIJJBQUfyBvAuBsKMQVE6+Q7jvLL6s3OJG7mD7icMcVgKo/7w2flqAgILdWgIk
	 hWUsEoMVHb/rwqn9pZwS/UHuAqdFJqYnCPtojlBwxyZv/sjoqwZ8wmegSC8Fyb1Ul
	 SFxhKyxxLbhdJFdEUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.10] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1vVDXD28M3-00On9D; Wed, 26
 Nov 2025 17:58:56 +0100
Message-ID: <0d03ddb9-d01f-435e-a57c-fbea32844b66@gmx.de>
Date: Wed, 26 Nov 2025 17:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@kernel.org>, John Johansen
 <john.johansen@canonical.com>, david laight <david.laight@runbox.com>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
References: <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
 <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de> <aSblGNyoSV4LfKji@carbonx1>
 <78f1ff26f06c0e61d71c1a7f05a7c03c4ec03bef.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <78f1ff26f06c0e61d71c1a7f05a7c03c4ec03bef.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AHrU3vlsyLnJa5pxcX0FvzDjFLgm8PRZBJqsa+0jc935jsXbR0t
 j7VRdPxg1cyLkzN841Nn06p3H5yIkggcgnkF+PqIfZY/TR4stMLTaPA+HY/kS2LlQ4GWfMx
 uJKTVTNu13N7alU6Ss0eZcA+QjvCfuETjxtnzc5rqJwXGhouD0ZTZ3UzQdPD9fMq35+VHkK
 u6mCZNDqLwU5yW/8xP9jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K+lzWe/5xpg=;kBlgGmnZ6BuWdnLszUU4fZo8zMv
 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
 AAfa+fVQRY+KBs5EeEhg9rXlPXj/uIOWYklXeL

On 11/26/25 17:16, John Paul Adrian Glaubitz wrote:
> Hi Helge,
>=20
> On Wed, 2025-11-26 at 12:31 +0100, Helge Deller wrote:
>> Like this (untested!) patch:
>>
>> [PATCH] apparmor: Optimize table creation from possibly unaligned memor=
y
>>
>> Source blob may come from userspace and might be unaligned.
>> Try to optize the copying process by avoiding unaligned memory accesses=
.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/security/apparmor/include/match.h b/security/apparmor/incl=
ude/match.h
>> index 1fbe82f5021b..225df6495c84 100644
>> --- a/security/apparmor/include/match.h
>> +++ b/security/apparmor/include/match.h
>> @@ -111,9 +111,14 @@ struct aa_dfa {
>>   		typeof(LEN) __i; \
>>   		TTYPE *__t =3D (TTYPE *) TABLE; \
>>   		BTYPE *__b =3D (BTYPE *) BLOB; \
>> -		for (__i =3D 0; __i < LEN; __i++) { \
>> -			__t[__i] =3D NTOHX(__b[__i]); \
>> -		} \
>> +		BUILD_BUG_ON(sizeof(TTYPE) !=3D sizeof(BTYPE)); \
>> +		/* copy to naturally aligned table address */ \
>> +		memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
>> +		/* convert from big-endian if necessary */ \
>> +		if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
>> +			for (__i =3D 0; __i < LEN; __i++, __t++) { \
>> +				*__t =3D NTOHX(*__t); \
>> +			} \
>>   	} while (0)
>>  =20
>>   static inline size_t table_size(size_t len, size_t el_size)
>=20
> So, is this patch supposed to replace all the other proposed patches?

It just replaces the patch from John.
But please test the v2 patch I sent instead...

Helge
