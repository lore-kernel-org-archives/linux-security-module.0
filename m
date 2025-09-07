Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04C1F0994
	for <linux-security-module@vger.kernel.org>; Sun,  7 Sep 2025 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757230802; cv=none; b=M38XN9wACaOqgAbmbztQAANEhyeKvO/mqbf3EWoe2WAsqNURPiblot7tH9r+QSOhhmxbIQJSg2hFMwnwqVkdwq8YZoxrjvm1+RasFby6O6gOW+s54xn0GNkl1hSZZCNe/8H5poWYjXPsti+PVFQ/PGVLa/fXpeadQLkGjaYnQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757230802; c=relaxed/simple;
	bh=akt3KaI6e2yInlVQxdYzqTOksac4tAGx1kskAB1zrM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoWU6htG0fO4O+5vE59/NU3CT0i4efMJ5x8hTDKtDe8wCPkNAb48l3+1YE2Kz0Pse2ihDmaasK2nAf9EW9fzZmANgbhf5/rkR0w+KWvGBvBfTIp2INi58SfnM8QUXoECniuqJ1VWBZt2cRjiAFPH4zNZsWh5AInaIWD6hJTJeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5877dun8057662;
	Sun, 7 Sep 2025 16:39:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5877duD1057659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 7 Sep 2025 16:39:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2c42b87b-d22f-4ac7-9c1c-200e1241833c@I-love.SAKURA.ne.jp>
Date: Sun, 7 Sep 2025 16:39:56 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
 <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
 <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/09/05 0:02, Paul Moore wrote:
> On Thu, Sep 4, 2025 at 5:53 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2025/09/04 5:32, Paul Moore wrote:
>>> On Thu, Aug 14, 2025 at 6:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>
>>>> Reviewed-by: Kees Cook <kees@kernel.org>
>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>> ---
>>>>  security/tomoyo/common.h        | 2 ++
>>>>  security/tomoyo/securityfs_if.c | 4 +---
>>>>  security/tomoyo/tomoyo.c        | 1 +
>>>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> Tetsuo, does this look okay to you?
>>>
>>
>> Yes.
> 
> Thanks for reviewing, may I add your ACK?
> 

Yes.

