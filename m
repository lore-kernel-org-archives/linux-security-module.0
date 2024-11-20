Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924C2F2A
	for <linux-security-module@vger.kernel.org>; Wed, 20 Nov 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141271; cv=none; b=FGlwVnfbr28APbukZLZfvPkeThiJ5Smr+OL6ZwJBCMru/mYqKJUWZBztKDNeSX5DIr+JEqlA07MYK1zEHGWSWLRYRNORUUCMPvEy4pNotNurE2X+jHozu6IgQyeOby6gkQaMlfLTocqDjU6dGP5n28jlg3Bf6+nOTHyj/bH2cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141271; c=relaxed/simple;
	bh=ouB8/de/lCxNFcMrrsx07QJ6XNyLFzvpUW8HYXhGhM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FnMGAsEKg2cgQ18DUGWsT8nfInDGCgKFNnB1ZMkN0ww//Q+Is4oEBAUaJ0aLyA4VOylkc6uAIyU53tCtsjBip0gLMcRKo4tb9KPeDloLi4oyQar8GAYC7i08cu8D4B6Sv2MaUSQ1PjjJJlvBArragqluTvk20VMAbmf2ptYhoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjwf6T9L; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjwf6T9L"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso11786439f.1
        for <linux-security-module@vger.kernel.org>; Wed, 20 Nov 2024 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732141268; x=1732746068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouB8/de/lCxNFcMrrsx07QJ6XNyLFzvpUW8HYXhGhM0=;
        b=hjwf6T9LG9TzzRypZ7QQuwISSNhMxVFW8OjiLPdexCtHHIu2osbjXBqWZZV5bFmx0B
         EzxyPt8YgvKxopbhQdtolmDNgpwF+5U43i/rQcyQwKZ0hBs8x3JBlf/C0En6GPtFxUhH
         iYUYkAp7P6qUNpGfZ/46wAQCeeqH4vznCuDfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141268; x=1732746068;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouB8/de/lCxNFcMrrsx07QJ6XNyLFzvpUW8HYXhGhM0=;
        b=r2idF2NEmSX3AAvBZw4aqg3HZIWeTAth0O4ZZ9uI0uaV9sZFXiSltTUomQHYNVaLGi
         ZpkeFV5EO5J8vOsimU9bXQkXt8ntHOyZUhw4/IH5J8KaNP4a/68846HlzUMO5qDcj+t4
         9CcPVga+iaVWBAax/n+iSxeh8uKPsXSHuIeL1XG6Ipk+5Ka56gFiTNzviiy7oGMD0/8i
         50SxRhFCP7DJZx025asaXTi4Nlh+ssSJje4gBzIi9VoADghtArrUbVGKzyz7vXWhmBdi
         HWbAS2J89CVeuaAHxRYW0er1Ry7tQC9QNSb1phmcwUWCqovMECZ4er59soIkxBe4evhG
         e3lA==
X-Forwarded-Encrypted: i=1; AJvYcCW/UirpjogJQzBZPbw/8S6rH/rRgx71oeh+9A74Y0X+KdwPt+D2rHqGKv6XISowFoDFIqd7wxW67rWi2VYC9awsgZr24CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQrVemkSVN4pkf1PbtkQ9bYjWUuquOYQfW+gjh+ugj3KBFI1f
	pBzd+dLZx8bY5bZaZHL4oI+NMbDNk8a8vWAi8fxqOceCR6k/vdE9a+HtrROTWUQ=
X-Google-Smtp-Source: AGHT+IFmwjcCHTD7M7msR+ZombMchwunGMPWFXdbv0JlxupApzrqgjgRYqau+Y+HPtOu4H5jYx5Agw==
X-Received: by 2002:a05:6602:3423:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-83eb5f5de66mr521515639f.2.1732141268473;
        Wed, 20 Nov 2024 14:21:08 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e6e0ece8csm308117639f.41.2024.11.20.14.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:21:07 -0800 (PST)
Message-ID: <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
Date: Wed, 20 Nov 2024 15:21:06 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
From: Shuah Khan <skhan@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 14:37, Shuah Khan wrote:
> On 11/20/24 14:20, Kent Overstreet wrote:
>> On Wed, Nov 20, 2024 at 02:12:12PM -0700, Shuah Khan wrote:
>>> On 11/20/24 13:34, Kent Overstreet wrote:
>>>> On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
>>>>> On 9/2/24 03:51, Kent Overstreet wrote:
>>>>>> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
>>>>>>> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
>>>>>>>> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
>>>>>>>>> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
>>>>>>>>> [...]
>>>>>>>>>> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
>>>>>>>>>> in the case of bugs, because that's going to be an improvement w.r.t.
>>>>>>>>>> system robustness, in exactly the same way we don't use BUG_ON() if it's
>>>>>>>>>> something that we can't guarantee won't happen in the wild - we WARN()
>>>>>>>>>> and try to handle the error as best we can.
>>>>>>>>>
>>>>>>>>> We have discussed that in a different email thread. And I have to say
>>>>>>>>> that I am not convinced that returning NULL makes a broken code much
>>>>>>>>> better. Why? Because we can expect that broken NOFAIL users will not have a
>>>>>>>>> error checking path. Even valid NOFAIL users will not have one because
>>>>>>>>> they _know_ they do not have a different than retry for ever recovery
>>>>>>>>> path.
>>>>>>>>
>>>>>>>> You mean where I asked you for a link to the discussion and rationale
>>>>>>>> you claimed had happened? Still waiting on that
>>>>>>>
>>>>>>> I am not your assistent to be tasked and search through lore archives.
>>>>>>> Find one if you need that.
>>>>>>>
>>>>>>> Anyway, if you read the email and even tried to understand what is
>>>>>>> written there rather than immediately started shouting a response then
>>>>>>> you would have noticed I have put actual arguments here. You are free to
>>>>>>> disagree with them and lay down your arguments. You have decided to
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> Yeah, enough of this insanity.
>>>>>>>
>>>>>>> so I do not think you are able to do that. Again...
>>>>>>
>>>>>> Michal, if you think crashing processes is an acceptable alternative to
>>>>>> error handling _you have no business writing kernel code_.
>>>>>>
>>>>>> You have been stridently arguing for one bad idea after another, and
>>>>>> it's an insult to those of us who do give a shit about writing reliable
>>>>>> software.
>>>>>>
>>>>>> You're arguing against basic precepts of kernel programming.
>>>>>>
>>>>>> Get your head examined. And get the fuck out of here with this shit.
>>>>>>
>>>>>
>>>>> Kent,
>>>>>
>>>>> Using language like this is clearly unacceptable and violates the
>>>>> Code of Conduct. This type of language doesn't promote respectful
>>>>> and productive discussions and is detrimental to the health of the
>>>>> community.
>>>>>
>>>>> You should be well aware that this type of language and personal
>>>>> attack is a clear violation of the Linux kernel Contributor Covenant
>>>>> Code of Conduct as outlined in the following:
>>>>>
>>>>> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
>>>>>
>>>>> Refer to the Code of Conduct and refrain from violating the Code of
>>>>> Conduct in the future.
>>>>
>>>> I believe Michal and I have more or less worked this out privately (and
>>>> you guys have been copied on that as well).
>>>
>>> Thank you for updating us on the behind the scenes work between you
>>> and Michal.
>>>
>>> I will make one correction to your statement, "you guys have been copied on
>>> that as well" - which is inaccurate. You have shared your email exchanges
>>> with Michal with us to let us know that the issue has been sorted out.
>>
>> That seems to be what I just said.
>>
>>> You might have your reasons and concerns about the direction of the code
>>> and design that pertains to the discussion in this email thread. You might
>>> have your reasons for expressing your frustration. However, those need to be
>>> worked out as separate from this Code of Conduct violation.
>>>
>>> In the case of unacceptable behaviors as defined in the Code of Conduct
>>> document, the process is to work towards restoring productive and
>>> respectful discussions. It is reasonable to ask for an apology to help
>>> us get to the goal as soon as possible.
>>>
>>> I urge you once again to apologize for using language that negatively impacts
>>> productive discussions.
>>
>> Shuah, I'd be happy to give you that after the discussion I suggested.
>> Failing that, I urge you to stick to what we agreed to last night.
The only thing we agreed upon is that you would respond the thread
to update your sorting things out with Michal.

As for the discussion, I will repeat what I said in our conversation
that the discussion will be lot more productive after making amends
with the community. I stand by that assessment.

I will also repeat what I said that the discussion and debate is
outside the scope of the current issue the Code of Conduct Committee
is trying to resolve.

I didn't pick up on your desire to apologize after the discussion in
our conversation.

Are you saying you will be happy to make amends with an apology after
the discussion and debate?

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
