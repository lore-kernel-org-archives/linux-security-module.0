Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E91ACE89
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895572; cv=none; b=C0W41bwXibqYBMJXbvnRwjYGjhnmWQfkKcgiDq1PkzLe5m3eTM+vB1G4p+mPzxB+gnlTeF81/4Lsdm7A6VSVDZlY2UrHdmjVFNaYncAvPVRhCn4OwGHVEWfVjqVWaDHxTPgXMk41Mnv/hexLoFVvp7egBWBQfI3XQMDXgzKzBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895572; c=relaxed/simple;
	bh=RVoCYmkTgVmfPe4ZT90nxNe7lOQxWVND4bVbR/RNIRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHpusS/gTiZUTEu/udEcPr/8dYo3Q/27q2xW529K1jun7sQeb4eZcB67Jz9Tb25RjQzWeGGbFK2Zpescfr7B95vbRgwGHM+1pIiRfORLCHWA7E1Hk9R31koXsjXKn8JXpXVKgGJjxeC0rAsFiT0+3w6jcsZSWFkBiS1rNFhLMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KExQTj067327;
	Thu, 20 Jun 2024 23:59:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 20 Jun 2024 23:59:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KExQLO067324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 23:59:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3e40424a-a73c-4258-a796-b5d75de323b6@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 23:59:25 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Yet another vision of Linux security | Endpoint Security
 Framework
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Timur Chernykh <tim.cherry.co@gmail.com>
Cc: linux-security-module@vger.kernel.org
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
 <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/20 23:28, Stephen Smalley wrote:
> Note that a number of the LSM hooks are called from interrupt or while
> holding locks and thus cannot sleep/block.

I think that that is because LSM hooks are intended for avoiding TOCTOU
problems. LSM hooks which TOMOYO checks permissions are allowed to
sleep/block, at the cost of giving up checking permissions for e.g.
sending signals.

Since I'm not an AV/EDR software developer, I can't say what hooks they
need. But history says that there was an attempt to use LSM hooks (and
the quality of an implementation which the source code is available was
too poor to recommend to customers). Analyzing vmcore suggests that recent
kernel code used by AV/EDR software tends to rewrite syscall tables.
I don't know the reason, but I think that that is because LSM framework
did not officially support loading LSM modules after boot, and LSM hooks
did not receive enough arguments needed by AV/EDR software. Thus, I guess
that adding security hooks into locations where locks are not yet held
would be helpful.

