Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD331A056;
	Mon,  1 Dec 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598944; cv=none; b=EwS8GhSVOwWUABjRColz8Z3WJOb4rrObk8tnlH/l95ieIMjKGsrj1MkxC6UnKV9Fv1G2f0HEI3VJ4bHX128RUuxlGDyFFCVXcot/rLGeZeWwZ31bbbD7Wgg8Dyf/KNT//WfkoV42sxUm05bDzDq/17awLwoMvgVRBjgmg64iFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598944; c=relaxed/simple;
	bh=2KeGtMXVZHlxNThqpiYLW1mH7HyjDvMrYi8LoPNr32A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9ttdfyvYOFiI+itlK/n5gFmPZC6ryZfBJEn0DZ0lnmZTZ9cSXqIAZD1Lbjw86/ARq/lrfnQJ6L24aHRszdtxVxupz89WcFo/1Tl5e+Vq+SVS0ch1uMwGiypAK9UpoO1sS6o+v8C2Wxw+/LHYfKl7ci04PHTsLaY9VctgCXtJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5B1EM6P1050770;
	Mon, 1 Dec 2025 23:22:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5B1EM0VG050737
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 1 Dec 2025 23:22:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <effd6559-8083-4967-91a2-5b47f035dcda@I-love.SAKURA.ne.jp>
Date: Mon, 1 Dec 2025 23:21:58 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Use local kmap in tomoyo_dump_page()
To: Davidlohr Bueso <dave@stgolabs.net>, takedakn@nttdata.co.jp
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251128222747.2174688-1-dave@stgolabs.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251128222747.2174688-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp

On 2025/11/29 7:27, Davidlohr Bueso wrote:
> Replace the now deprecated kmap_atomic() with kmap_local_page().
> 
> The memcpy does not need atomic semantics, and the removed comment
> is now stale - this patch now makes it in sync again. Last but not
> least, highmem is going to be removed[0].
> 
> [0] https://lore.kernel.org/all/4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com/
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Thank you. Applied.

https://sourceforge.net/p/tomoyo/tomoyo.git/ci/a9ea3a2e081d29350b7a3c0731729efbc70458b8/

