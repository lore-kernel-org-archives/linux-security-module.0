Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE02196DA2;
	Wed,  2 Oct 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913063; cv=none; b=T9cjSUoISn+m5OvPoYlxMrbOlxS+62gyNKEDz4HUAz5s0XA3GA/L9xXTiT5uDXrOeUNTwnLCqBcZy7deZs+NZrF3SFyGdLNoA+odMuAKhOAHi56RQ8lusaosyzR7DSGCL/nJFZKDff4gPx+nu8+Ise8eSzBMxqUSXcnqFQlXKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913063; c=relaxed/simple;
	bh=ILXs43+w/CiIKRwyNeDQh+sUP8t10jgJm4isqpvrfyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=suj4R6rvqM+wbFLNQH3n+v657HkTkFaJTQdS+4V9GQdCxJ1/sgdh/mBoaSdf4SGk3e/+gX+IhFuIFtH7kwZIbe2T7NljkSR4f6I9DVcr5yTpmZTdmAa8Ua3n+3nyfgKD7u7aoGmDxbU9lEn/Taw4ql9GeaI+S9N/JdNmUm7byuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 492NonQb082062;
	Thu, 3 Oct 2024 08:50:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 492Nonk7082059
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 08:50:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b4d6f4b8-2ee5-4aa9-8356-b3af89eaa9b3@I-love.SAKURA.ne.jp>
Date: Thu, 3 Oct 2024 08:50:46 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
 <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
 <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
 <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/03 8:09, Tetsuo Handa wrote:
> The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
> negative impact on the user side, which cannot be a viable solution).

For example, some out-of-tree device driver supports RHEL but does not
support CentOS, despite there is effectively no difference between RHEL
kernel and CentOS kernel.

Also, for debuginfo packages, one has to share/distribute debuginfo packages
when vmcore is captured while using a rebuilt vmlinux. (Well, debuginfo
might not be limited for analyzing vmcore...) That makes troubleshooting more
difficult; one who captured vmcore cannot directly contact the original kernel
provider, due to discarding the baseline provided by the original kernel
provider.

What Paul is saying is effectively "Do not use RHEL if you want to use TOMOYO".
Just rebuilding RHEL kernels impacts negatively on the user side. Who can
force users to rebuild RHEL kernels, due to the burden caused by giving up
utilizing existing eco-system? That cannot be a viable solution.

