Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF523C8A3
	for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134659; cv=none; b=GIXqJvD2mtDPCvTImnZ8wx1GgiK5ZPV9GXsk1YP8Wh4m4tnTRh+ALxE5nD2TW0wg/tHERT7sDFBc+dpSzN6A0fEyIDKl9bwbFXV+31oqH2CCO9DxGSEB6V0KOKj1NFhZu6IEaPA1q1IrJyyqeBKJM4aeWXzR/692WNXaJg9OuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134659; c=relaxed/simple;
	bh=G/Iuvk97lCj/ysnGeDq5y/E/uY+SQmDZiycYuE0QgTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUS3epLT5dDCMOncMImpGBZwd5WYILpaeQa9Vxi7vYmV82CN3ycO+5n31F4fcUgF05FKQxToePHj4eJV9DOUiTzsBShRUwfQTZ9LqvMMdQEDi9jLVqY6xjwazvRTt1BOpRBtZk5FHKY09Apyk3SLlkzns8GC7vDrrtNyZvbpYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LxFMMsdA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LxFMMsdA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ff8f218c44so110524a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747134656; x=1747739456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih47wa8lOcapFnPoJK//XfeRJyzOSt0KNDPZDlIyojo=;
        b=LxFMMsdA+unHEy0luz9ADhLKIm319iUBUARgLnrwf87H22y/UsBCvKhCbIfen2dPxz
         ifJR9ahExQ+MmqxpyqOkdXZ095fTIzMPyqsQMxeGip7DZbvzonE4+wWIqvhKIdDFNqBS
         gQ3tZFDOwogzxw27+2yMDMK+Yt/hDQv2ASsx6FpR7JZSQQu48/dny5Ci6QBWBVLuswz3
         TdhMIAvn4azyoY9YuEiChCuLstDScOiBYk5pQx5hE2uSFReEhDp27OfK6LjAweFdAQ6k
         CNNDT80TtklC5PtY1MM0YSNd3KyJ5jXqEuDPZL/RJN/6uBY6rufpUhjvZatYcHmkuYLc
         iJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134656; x=1747739456;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ih47wa8lOcapFnPoJK//XfeRJyzOSt0KNDPZDlIyojo=;
        b=MAZf0USM2F6C32raEtSViwLXkrOhOFojWgJqBL0y50IefHQo7eai6nzzucu5ULNlG8
         rwAa3LroZDE9S2vYqe3o++1eZJC/IbbeCZ/oeTMAgMHotEOY5DVvbqa3/jNIcKEvLugd
         yotMt0JWPYgFldK+wMrE4bYHg/iX9Ye10rxM+1fqFVZl5TIOPACMkLsgGSpD9QzNudkQ
         WCpQoL/cxPYTcOZvjeKiXD39Zw2yHdn1Ljz80Isw6obW4RpFVXOG9yYr7x0eqPfWk4pD
         9FD9jP5vHuoeAPItvFSGiCbR7yBryPIGzdaBZD7jWrOvPK75gn5RQ9ljjTdeUe1+BTzH
         c7zg==
X-Gm-Message-State: AOJu0YxIZVsxmTb+BVp8fjBKtARnjVsYBbF7SWHlJCcT6R5TR5O3DkN9
	LbLEh3RQHi35U3NYFFD0cWEQnfQOHcyAU5sbJrZio4Asgw5RkdK+4hdPSWgzZDE=
X-Gm-Gg: ASbGncsGTNcxkXiFR3GU6P1dBpbDtARfUkYrxBinSPA4CEnrblHNFWouP8vpJWqNJ2y
	WodFTZ6OY0Z0xoy+/GUv9BMKqvMP9uwZn+3TQpcd6GAXNzaHfhrO5uqOcjp36ojvdORsfJ7nTjV
	KODzyWDPaSwWoTPGxkX+w8WDgbrmR2fspO/F6kxBwh3MfMVRVFfPMOYBIrO1eU1h2IrQmigFyLD
	FY+2EouLXJq1IGxIBikCjW+/fO5YzGFDU53UFtaj2rHo8wTCDL86yA94xqHNGMHdBhzW5z3N104
	R+5P9xCOFhXrl29L4ZOptDxd9N/jP/S1QiS2tbdp9tRsAtROjQqDkQI=
X-Google-Smtp-Source: AGHT+IG/1KGBzYEjomD9ooGdFK5Z+PWpP4n15tO0ehecLA0mQwOQvBEHF+6qJupAbbVt/rBjAG8RAA==
X-Received: by 2002:a17:906:99cf:b0:ad2:39a9:f1aa with SMTP id a640c23a62f3a-ad239aa04e2mr1057420766b.47.1747134655593;
        Tue, 13 May 2025 04:10:55 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad24121e992sm496096766b.14.2025.05.13.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:10:55 -0700 (PDT)
Message-ID: <efcca734-2c80-43e3-b347-2af39f811502@suse.com>
Date: Tue, 13 May 2025 14:10:54 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Paul Moore <paul@paul-moore.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-security-module@vger.kernel.org, serge@hallyn.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20250321102422.640271-1-nik.borisov@suse.com>
 <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
 <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch>
 <68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHC9VhSyz2MqMjnHFbTiMqYvhAFZf162ZabnSsyyCQEZj-V9=g@mail.gmail.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <CAHC9VhSyz2MqMjnHFbTiMqYvhAFZf162ZabnSsyyCQEZj-V9=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/13/25 01:01, Paul Moore wrote:
> On Mon, May 12, 2025 at 5:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
>> Dan Williams wrote:
>>> Paul Moore wrote:
>>>> On Fri, Mar 21, 2025 at 6:24 AM Nikolay Borisov <nik.borisov@suse.com> wrote:
>>>>>
>>>>> This simple change allows usecases where someone might want to  lock only specific
>>>>> feature at a finer granularity than integrity/confidentiality levels allows.
>>>>> The first likely user of this is the CoCo subsystem where certain features will be
>>>>> disabled.
>>>>>
>>>>> Nikolay Borisov (2):
>>>>>    lockdown: Switch implementation to using bitmap
>>>>>    lockdown/kunit: Introduce kunit tests
>>>>
>>>> Hi Nikolay,
>>>>
>>>> Thanks for the patches!  With the merge window opening in a few days,
>>>> it is too late to consider this for the upcoming merge window so
>>>> realistically this patchset is two weeks out and I'm hopeful we'll
>>>> have a dedicated Lockdown maintainer by then so I'm going to defer the
>>>> ultimate decision on acceptance to them.
>>>
>>> The patches in this thread proposed to selectively disable /dev/mem
>>> independent of all the other lockdown mitigations. That goal can be
>>> achieved with more precision with this proposed patch:
>>>
>>> http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.com.notmuch
>>
>> Just wanted to circle back here and repair the damage I caused to the
>> momentum of this "lockdown feature bitmap" proposal. It turns out that
>> devmem maintainers are not looking to add yet more arch-specific hacks
>> [1].
>>
>>      "Restricting /dev/mem further is a good idea, but it would be nice
>>       if that could be done without adding yet another special case."
>>
>> security_locked_down() is already plumbed into all the places that
>> confidential VMs may need to manage userspace access to confidential /
>> private memory.
>>
>> I considered registering a new "coco-LSM" to hook
>> security_locked_down(), but that immediately raises the next question of
>> how does userspace discover what is currently locked_down. So just teach
>> the native lockdown LSM how to be more fine-grained rather than
>> complicate the situation with a new LSM.
> 
> Historically Linus has bristled at LSMs with alternative
> security_locked_down() implementations/security-models, therefore I'd
> probably give a nod to refining the existing Lockdown approach over a
> new LSM.
> 
> Related update, there are new Lockdown maintainers coming, there is
> just an issue of sorting out some email addresses first.  Hopefully
> we'll see something on-list soon.
> 


So I guess the most sensible way forward will be to resend these 2 
patches after the new maintainer has been officially announced?

