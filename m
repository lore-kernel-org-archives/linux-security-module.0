Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F2BE6C;
	Sat,  7 Sep 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725704071; cv=none; b=Eyu0PQH7b5W6yOdqmKe0/OcqWzp6XSUPCqBo7NVgrJJZNu05FuDyTxFWe0objLLudVAgHJXtaa7Q5jqb2DfYVwegabhzr5KPWsAjxHB8us4duSFfsKIVw1iuRzUE5tZecLQLTnvorgG2J7z7QJXpbwiE915qODTC+yPVCJwMH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725704071; c=relaxed/simple;
	bh=hi2xrJZBDuY0k+Bd7WbG4vjSF/HP4IxQQqOVAY4lq6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4G5pKNOW3x2xWfpEthIrkCJ5czbGDdW1pYL34J1Lhh20WH9GB0Zfu3T0bn1Ci7tiLUKQQgNn7wmMVIvNfUlgVS/1HsALHTh5LjyVIUWXvgVega6lugxGdeV799jzRyz0w4gHEec+CjGhhMp7GU4o7BZrjQ0hgcqKx414BOh4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 487AEGOt021346;
	Sat, 7 Sep 2024 19:14:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 07 Sep 2024 19:14:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 487AEGYK021343
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Sep 2024 19:14:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d1e5b74a-5161-4906-96eb-4987ff440d19@I-love.SAKURA.ne.jp>
Date: Sat, 7 Sep 2024 19:14:17 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me,
        tomoyo-users-en@lists.osdn.me,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
 <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
 <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/06 23:24, Paul Moore wrote:
> On Fri, Sep 6, 2024 at 3:43 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> If you ignore my concern, I have to NACK the static call changes you are
>> going to send in the upcoming merge window.
> 
> I'm not ignoring your concern, I've responded to your emails and
> patches on the topic over, and over, and over, and over again by
> trying to explain to you that your goal of supporting out-of-tree LSMs
> regardless of the impact to the upstream LSM effort is not something
> that is acceptable to the upstream LSM effort, or the Linux kernel in
> general.

I want LKM-based LSM support in order to allow one of in-tree LSMs (namely
TOMOYO) to be delivered to my intended users, for nobody can solve the
realities that commit 20510f2f4e2d ("security: Convert LSM into a static
interface") missed:

  how difficult/unrealistic for Linux users who are using prebuilt kernel
  packages provided by Linux distributors to replace their kernels

  how difficult for Linux distributors to allow their users to use in-tree
  LSM modules which that distributor is not familiar with [1] because Linux
  distributors are supposed to support kernel packages they built and
  shipped

  Linux distributors do not want to enable out-of-tree code due to upstream
  first policy, while Linux kernel development community can not afford
  accepting whatever proposed code due to limited resources

One of LSM developers commented me ( Mon, 22 Jul 2024 17:12:05 +0200
in off-list discusstion) about AKARI

  Ofcourse you found a way to hack it. You want me to curl bash pipe
  your kernel module code that disables certain protections and runs
  arbitrary hacks on my machine? No thank you!

  Ofcourse you change the memory mapping of data. You are misleading
  your users into trusting you and instead of contributing code and
  working with distros for your use case, you are shipping hacks and
  making noise without any constructive code contribution or alignment
  with distros for your use-case (below RHEL won't eneable it even
  if we had a proper API). 

and this patch is for following that comment. All concerns about updating
__ro_after_init data is gone if we move to a dual static call and linked
list based approach. I'm very very very sad that you did not respond to

  I think what you can do is send patches for an API for LKM based LSMs
  and have it merged before my series, I will work with the code I have
  and make LKM based LSMs work. If this work gets merged, and your
  use-case is accepted (I think I can speak for at least Kees [if not
  others] too here) we will help you if you get stuck with MAX_LSM_COUNT
  or a dual static call and linked list based approach.

in [2], and started saying "No" to this approach after you accepted
the static call changes. You are ignoring my concern!



Link: https://bugzilla.redhat.com/show_bug.cgi?id=542986 [1]
Link: https://lkml.kernel.org/r/CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com [2]

