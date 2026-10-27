Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119236;
	b=DaV2d7WbVHVBsfY/ARF0MwlFlpoe7Xd/oJ8nLmPXfwDUb2ti6hs+c/Zvigo/xCQWGaHK
	 p6I8pXC9rBNxEilf6I+XdFyxKUoHaTq6mTRd30/vTJyk4r/LMlu9Lj+XSRPa0F9U9Od2V
	 owo3MtgxbXPaW1LXf12bQ/N5PYrHzUF4JHNJSwfAKH22mVLQ2Jq2TzE2DlQar8KM7XoFd
	 NDigrX5ajXV6GgxiJteGtSIkcRH0XNwVahhm3/lul9O/xSVagF2a3YJM1C/hJsHOaQbKo
	 bBrkmcgDZoh8KXf1rNTHRpP1hmavoz1ZoKF6iLzjK1cWh7jajB4Z6tTKuwlEPPm+Ceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
	b=f91hKmBc46wG9vcC3Obt/+AS4sb3edz+pQWFn9o/timisnZZYNTXY5eLrufijw9Wy+0h
	 qIkBUjGfPza+XZRXma3lQGs6CpifUQNsInrWvKXXaoBBlDWz4F32+P3gkaXA7mPZNzUN9
	 T9QkMWMFO2gYGajKZnQf6epg8+GmIRJscqEyLqDqYoYXz/TstYGOE/ViKl8LZaT2BRuJG
	 3vCMFRP7XkRid29KKEmQQ6t8Q3Q8PxzTuILA6zJEB3r2LDGdU0X4SBoTjkbkzWgZb740w
	 bvcKDXNbDkq3SsQVs5D89vopnZ4RrkyIhX2dRlWHPnMN0IfVf8oNwSc9+f8qOG1hqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=B9pgIkEN;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AB606A31F
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10AB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=B9pgIkEN
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso62220a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793119235; x=1793724035; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
        b=B9pgIkENP1nZt32P35HL6R0QxS18tatDUdKB8+Mex6frfRryvJ9HnZJ7yNzfYATxhk
         mTrYNth1sJ7pCfjLGBXbFdbG3yuaxupUx6NbUaEWi/y1Uy1q26SBQQf/tSjOD1IJGvsz
         l/pr3UYOepZQugq4IDXYNoHxly1ZnTRA2eYRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119235; x=1793724035;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vGOrY3CisGPc8VMRVO//aXg6OQh93vx7xg6bEqOVs4=;
        b=1ZZHW/7AQvuIvjIaTNS3ypHnxQ7zV02+91z3IQkB1veCIxrv5TosnOuqXTXVUPI4Px
         JDGG0/IFW+j+T1qfSueGT0ckAqoU8vPvkN/+vK0unaXXcVYy/8lGDTSGPx1dL3fj1uFk
         csItfPYuqLz0Sm8AFz7HJoJuaAu7hC6a7EkIQm8ySrvCyJ8GCmvTdtFvslzIwyv/yQSb
         7gKtdeMdE7liJIwdzYRUessy+TTVivl50RTJKMbPZQiySxts+I2KWSM3CaaL7Nn9LExM
         hk7hFqpb4LSw+v8wmWRKbrioHnZIo3hcN5eU6g/Mo/5w9fT/yMVC11r6WhEs/1I/Win5
         2b5g==
X-Forwarded-Encrypted: i=1; AKwUvBxX90FJ4ZZFq4G7+xoTDrlteS+3VbXku+wk5C2pJjewZPTKNV+tE0VVHI6BBR5hIRf4U6AYZ7eF1SBBuG4qPJKwuRatmeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLECd5dq/iTA736bsU+p0pi2BnLOL3G4cwZEEJEi+wACdMI2guD
	xBRtoDSi79a8UP+6a8jAl/S2A8f0ZB2Eu0huCRaaPEvOICGtKCVZcgD7eH6YQtnYEbE=
X-Gm-Gg: AYBFou2hJOuRDyprJl3b52tImAfMo52Ko32Lof2B//91qARd+LXb980lS8H6NxT2bAK
	240w0RHv6uaC7JAGdN7OVqXoGxiiEFg/aJt6pXAJCsxBgchPKNir8d3rx6MVSm1ByII9odEmlVw
	2Weh1ubivn2JzDBDPnVrkeImpiwgx0zmZKFinIaM5ZDEMr21XLpbm1/8xCf1ENgmCmU5mLwq2DF
	9vgnV0R6RcPzC71NhCL8WU5znw31FbD97HCBvp7kW0CoTZnQXd/tzKj3afotZiS9BcqGZF+LrTm
	lAEd7knFJ4Joo4yPIJjf93CL/3kdXkW6jf1ujlGyYA2ZQAPMSy16qsgVowa1EAiOrLmOf3NHenQ
	Y7b+EBquNczJ5+zzXKYCVa4EUrYC8qcocOf8O3qg7NaZjDkaxqH9ox1BlgoNF2MLJ2zVMqbdZJL
	wOKKqHxEHBPoGnkyIlsSPrYsj6WIeu770g0sccHq0coUh5TVzG4INAL/ZG1XtAYMDpLgpM1lJTp
	6dbEU5yy8rN0ECtvPFeg7FW0CcaSkzARaD72sOxxy/g16HusHHFv3Gp82NqOiGprhYo7M2HY7/z
	7gaqZ42V7lV7U0C/UkmS3D+7YREmAlZwWdd2v8rL2rKK18GuV9ZUcqyjXh3Ff/AROXM11+wuZNm
	LxrRb+g21SGKiJFef2HlyLBjZfL14+Up2AqdHmNqD9U581DccBQiyFzCpZ5Vtbfw49LzwLfGsDg
	==
X-Received: by 2002:a17:90b:528a:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3adead57da9mr8291010a91.15.1793119235223;
        Tue, 27 Oct 2026 09:40:35 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm4569992a91.17.2026.10.27.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:40:34 -0700 (PDT)
Date: Wed, 28 Oct 2026 00:40:32 +0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <auDUAN9xAQRQhnCo@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
 <auC7_5XYr31fimvL@gremlin>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auC7_5XYr31fimvL@gremlin>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Lorenzo Stoakes (ARM) writes:
>Sorry, in mm we require commit messages. Even for tests :)

Sure thing, I'll add one.

>On Tue, Oct 27, 2026 at 07:43:25PM +0800, Chris Down wrote:
>> Signed-off-by: Chris Down <chris@chrisdown.name>
>> ---
>>  .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>> index ea75ad537620..83b4fadfbfe7 100644
>> --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
>Why on earth does 'mseal_system_mappings' have its own directory...??
>
>Ugh I don't know how I let this stuff go on the original series :/
>
>Please, for the love of all that's sacred, move these tests over to
>tools/selftests/mm/. This is an mm feature, for our sins...
>
>You can do the move as a prerequisite patch in the series.

Will do, I'll make the move the first patch.

>(And, again, I really do insist on your change doing some cleanup here as
> well rather than extending this stuff.)

Yep, see my reply to 1/3.

>> @@ -10,6 +10,7 @@
>>  #include <unistd.h>
>>  #include <string.h>
>>  #include <stdbool.h>
>> +#include <sys/mman.h>
>>  #include <sys/utsname.h>
>>  #include <zlib.h>
>>
>> @@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
>>  	EXPECT_EQ(expected, sealed);
>>  };
>>
>> +static bool find_vdso(unsigned long *start, unsigned long *end)
>> +{
>> +	char line[MAX_LINE_LEN];
>> +	bool found = false;
>> +	FILE *maps;
>> +
>> +	maps = fopen("/proc/self/maps", "r");
>> +	if (!maps)
>> +		return false;
>> +
>> +	while (fgets(line, sizeof(line), maps)) {
>> +		if (strstr(line, "[vdso]") &&
>> +		    sscanf(line, "%lx-%lx", start, end) == 2) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	fclose(maps);
>> +	return found;
>> +}
>
>There's shared code for this kind of thing, please don't duplicate a
>/proc/self/maps thing if unnecessary. Also there's a nicer ioctl interface for
>all this.
>
>See vm_utils.[ch].

Oh thank you! I will use that.

>I mean arguably this is an mremap test that belongs with mremap? I guess
>debatable...

Hmm, I'd lean towards keeping it with the sysmap test, since it's really 
testing that the seal is enforced on these mappings rather than anything about 
mremap() itself, but I don't feel strongly if you insist, just let me know.

>This all just seems like work that should have been done in the past when this
>feature was proposed, and doesn't depend on your changes at all AFAICT? Maybe I
>missed it though.
>
>Valuable in itself, but probably worth sending separately as a result? Otherwise
>it's a little disconnected from the actual change you're making.

Yeah, it doesn't depend on it. I can send it separately on top of the move if 
you like, I just don't like touching things without tests where possible.

Thanks for the review!
