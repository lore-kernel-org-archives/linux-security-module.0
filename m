Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52917C
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234495; cv=none; b=YXqWQIpxgJ25FjASOarlz+XqAcnlrdOZfKsb5DNpmf4UtZR4zUvnteirvZ3qO5nB1DqzuBmjSvn+GW0JCUhc8J3YvG4tv1QLBn+jtGPIhX9VjMCTVCrTEkTvRSBasqWhhUEubzpjJTaxPlG2RaPiKEAX+8WRdE6ghtDOAj7hjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234495; c=relaxed/simple;
	bh=mG+DXTW+A1g5POJQbvEOR2uCSsy3v5zu2m4K1wnmo3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=S0XJ0BjqXGkcVYzBYph2r/4xdSXWHcNHs6stYNW/30V/h80s1bTBP1Ll12+vRzhs0N/anZXsYHp6h96gNe75M6B7yG3pEvqMlxk9yjh9Etzz5BRnitTvFs3OM+ZAp0BN3uVrc35opoSTZQHtTkPX2FSkpEGLPfUoA5Di3Jy/Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4ALNM5eY072285;
	Fri, 22 Nov 2024 08:22:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4ALNM5Ex072279
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Nov 2024 08:22:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ad1b3db0-b5b5-40c4-9a44-ce11195cd1b5@I-love.SAKURA.ne.jp>
Date: Fri, 22 Nov 2024 08:22:07 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO and runc containers dislike one another.
To: "Dr. Greg" <greg@enjellic.com>
References: <20241121184207.GA11007@wind.enjellic.com>
Content-Language: en-US
Cc: linux-security-module@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241121184207.GA11007@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

Hello.

On 2024/11/22 3:42, Dr. Greg wrote:
> Kernel version is 6.10 something.
> 
> The path causing the issue is as follows:
> 
> /dev/fd/7
> 
> Here are the warning messages that runc spits out:
> 
> FATA[0000] nsexec[1291]: could not ensure we are a cloned binary: No
> such file or directory
> 
> ERRO[0000] runc run failed: unable to start container process: waiting
> for init preliminary setup: read init-p: connection reset by peer

Please try applying commit ada1986d0797 ("tomoyo: fallback to realpath
if symlink's pathname does not exist").

Regards.

