Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3729CE6;
	Wed, 15 Jan 2025 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911598; cv=none; b=qxaE7czs5D6Q3rC/ChlP0VjkGCxAa+viPvRNmfO6gD8vaAsZl7ZkyNw3rRyKepLW12cINxOLxAj/t1DYkk1FltnAX87aqWJKHQB+DE+FodYMU/vSxTYhn0M4SuQ3oc2At/Mv7L/AUBp20AWqU4L5OOZ6WnBVnul+H+3UstJEQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911598; c=relaxed/simple;
	bh=c6p5MNLk1gS0UOoUHzQPV0qMzsGgrFJlLWgxAeXRZIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDlpkql1YTBGu1QDccO9B/8GsdzOHvRiGImkdKYDyPm/B48bfhKYNH8EfjWok3hT3vnK2HmqYta+5Pfz/0smFj9VdPx4W3/bTIv/fQuSfNz2zvWh4h+zScE2fAF0uBRY9da/fG6gFnPyudNr+FiQ8orIxxCbzGAhN7Motfw3bcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DPlvX8Vx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DPlvX8Vx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=pm1m3uzwJlbFVVi6I5yV6EAXsMLspu2WZq0nMzxIyVQ=; b=DPlvX8VxUrcUJyadC4Kj2SkugB
	Edo5EVe6wZiqqVRnJEWpZ2xRfqdUZ/DMZNqS6e+QH39Kb123e6WUd1XtbtQt7HkGzwhCbZynDLK21
	NFktL8gtK3RPPIcPfE8w/9tnLxgEBpC1iGXtjquYZwWTb8/AdX4vS3MtO/U8n5Q3vTbcIgaZcquYT
	9zTJ51v2uBG2pRXL0HFMQQisLnc6YAA8VDiyti+ib7aiwXY2Sz0aP5ixHRRGWyFDBTQjxA+jl8zAV
	aF+VrKUFU/HQ/jM3al/sjr0IQvliOzYp0DV4yD4hHgz1K7YEgJjE3v1uFN6Hl3e/8I8RhSG9ZwLCC
	1HbEwcMw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXu2w-00000007EEr-32xR;
	Wed, 15 Jan 2025 03:26:22 +0000
Message-ID: <b97a0ec7-763f-461b-a510-6d3e409b7652@infradead.org>
Date: Tue, 14 Jan 2025 19:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/security: update cmdline keyword usage
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <sergeh@kernel.org>,
 linux-security-module@vger.kernel.org,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 John Johansen <john.johansen@canonical.com>,
 John Johansen <john@apparmor.net>, Jonathan Corbet <corbet@lwn.net>
References: <20250114225156.10458-1-rdunlap@infradead.org>
 <1b4275ad-a07b-4647-9d2b-48af08cdbebe@I-love.SAKURA.ne.jp>
 <07909d9b-7ec1-4eae-a20e-38a8a15dbc31@infradead.org>
 <CAHC9VhR23zCUsb5hnH4KzL2KbKHVZ=yJ+AvXVNP3369Y_aCa8g@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHC9VhR23zCUsb5hnH4KzL2KbKHVZ=yJ+AvXVNP3369Y_aCa8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

On 1/14/25 7:08 PM, Paul Moore wrote:
> On Tue, Jan 14, 2025 at 6:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 1/14/25 2:59 PM, Tetsuo Handa wrote:
>>> On 2025/01/15 7:51, Randy Dunlap wrote:
>>>> Use "lsm=name,..." instead "security=name,..." since the latter is
>>>> deprecated.
>>>
>>> Sorry, but security= is for specifying only one of exclusive LSM modules
>>> whereas lsm= is for specifying both one of exclusive LSM modules and
>>> all of non-exclusive LSM modules. That is, you can't deprecate
>>> security= using s/security=/lsm=/g .
>>>
>>
>> OK, thanks for the feedback.
>>
>> I am still confused by this part though, in Documentation/doc-guide/kernel-parameters.txt:
>>
>>         security=       [SECURITY] Choose a legacy "major" security module to
>>                         enable at boot. This has been deprecated by the
>>                         "lsm=" parameter.
> 
> That wording is correct, look at the ordered_lsm_init() and
> ordered_lsm_parse() functions in security/security.c.  The legacy
> "security=" parameter is from a point in time where we didn't support
> running multiple major LSMs and for various reasons when we did add
> support for multiple LSMs we moved to the "lsm=" parameter, with
> continuing support for the "security=" parameter for backwards
> compatibility with existing installs.  If present, the "lsm="
> parameter overrides "security=".
> 
> Looking at Randy's patch and Tetsuo's comment, I think there was a
> minor misunderstanding which has led to some confusion.  Tetsuo made
> the comment that you can't simply do a search and replace on the
> kernel command line substituting "lsm=" for "security=" as the
> "security=" parameter will ensure that only one major LSM is activated
> while "lsm=" would permit multiple major LSMs if they were configured
> at kernel build time.

Yes, there are some subtle parts there that I overlooked.

> Looking at Randy's original patch, I've got a couple of comments ...
> 
> On Tue, Jan 14, 2025 at 5:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Use "lsm=name,..." instead "security=name,..." since the latter is
>> deprecated.
> 
> The "security=" parameter only supports a single LSM name, not a comma
> delimited list like the "lsm=" parameter.
> 
>> Fixes: 89a9684ea158 ("LSM: Ignore "security=" when "lsm=" is specified")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <sergeh@kernel.org>
>> Cc: linux-security-module@vger.kernel.org
>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: John Johansen <john@apparmor.net>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/admin-guide/LSM/apparmor.rst |    4 ++--
>>  Documentation/admin-guide/LSM/index.rst    |    2 +-
>>  Documentation/admin-guide/LSM/tomoyo.rst   |    2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> --- linux-next-20250113.orig/Documentation/admin-guide/LSM/apparmor.rst
>> +++ linux-next-20250113/Documentation/admin-guide/LSM/apparmor.rst
>> @@ -27,10 +27,10 @@ in the list.
>>  Build the kernel
>>
>>  If AppArmor is not the default security module it can be enabled by passing
>> -``security=apparmor`` on the kernel's command line.
>> +``lsm=apparmor`` on the kernel's command line.
>>
>>  If AppArmor is the default security module it can be disabled by passing
>> -``apparmor=0, security=XXXX`` (where ``XXXX`` is valid security module), on the
>> +``apparmor=0, lsm=XXXX`` (where ``XXXX`` is valid security module), on the
>>  kernel's command line.
> 
> The problem with the /security=/lsm=/ conversion that you've done
> here, and elsewhere in the patch, is that when you use the "security="
> parameter the non-major LSMs that are built into the kernel (see the
> CONFIG_LSM Kconfig knob) are still enabled whereas if you use the
> "lsm=" parameter you must explicitly list *all* of the LSMs you want
> to enable.  As an example, "security=apparmor" might enable both
> AppArmor and Yama, where "lsm=apparmor" only enabled AppArmor, leaving
> Yama disabled.
> 

I see. Thanks for the explanations.

-- 
~Randy

