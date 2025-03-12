Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF442A82
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763680; cv=none; b=Ph2IoRWLg9RpPBF//Q5tymgIIo53Sz0ep9V3drWoVDknED2mHMoMW9SuDErLaTo2Yt64ZNYfCykwEMv6sSJLzFkWP5QCxjtg62R5U/Vou6KTvx80ZvFzK+ObbxUxFZDonoqROJtPfJTx+9lHLuC1VFrP8UQOtmIBdFtlcWZkW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763680; c=relaxed/simple;
	bh=sSuXucqGa5rkQU4fOEm6Bhetn9RgoxFmKIs/Lh26dSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=D/6AYSoCsKtatD17OifuukVj3zdLNTD3tpiZZSjqISct6/Ln728hj0GzxWiYsRybH3uyH7k7a6JRyV/ZIba65OHg5hy+RjM0TFRSOduG5hpAvMmeBV1qawivQvJepjOCoPMJX2V062cwmComA1+stP+xKsZ3Kd853vi4U5CGtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 52C6KYAV072241;
	Wed, 12 Mar 2025 15:20:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 52C6KQSZ072184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 12 Mar 2025 15:20:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5d683299-fc53-4763-be49-9a91325a832c@I-love.SAKURA.ne.jp>
Date: Wed, 12 Mar 2025 15:20:25 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tingmao Wang <m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Content-Language: en-US
Cc: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

On 2025/03/04 10:12, Tingmao Wang wrote:
>     bash # env LL_FS_RO=/usr:/lib:/bin:/etc:/dev:/proc LL_FS_RW= LL_SUPERVISE=1 ./sandboxer bash -i
>     bash # echo "Hi, $(whoami)!"
>     Hi, root!
>     bash # ls /
>     ------------- Sandboxer access request -------------
>     Process ls[166] (/usr/bin/ls) wants to read
>       /
>     (y)es/(a)lways/(n)o > y
>     ----------------------------------------------------
>     bin
>     boot
>     dev
>     ...
>     usr
>     var
>     bash # echo 'evil' >> /etc/profile
>     (a spurious create request due to current issue with dcache miss is omitted)
>     ------------- Sandboxer access request -------------
>     Process bash[163] (/usr/bin/bash) wants to read/write
>       /etc/profile
>     (y)es/(a)lways/(n)o > n
>     ----------------------------------------------------
>     bash: /etc/profile: Permission denied
>     bash #

Please check TOMOYO, for TOMOYO is already doing it.

https://tomoyo.sourceforge.net/2.6/chapter-7.html#7.3

