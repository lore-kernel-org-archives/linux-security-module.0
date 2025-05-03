Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B31C9B9B
	for <linux-security-module@vger.kernel.org>; Sat,  3 May 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746272712; cv=none; b=J54Cuexl9fuOMA1IlpEldhnm4bf2kOum9/rESvabAywI2w+alodDiSa3uGjbNqIgP4FWi8ug6RqurWyzQgD0zcnkb5NB9q5BmPag0t7BHsDzrCi17gBWYXFM9rcmtZl5TvR3R7QgEwMBtak7Pchbzc19+Viizgo2enmldzSgZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746272712; c=relaxed/simple;
	bh=c+kCMQm/NMANedXrP7Bp0fizEhhmAZf+Eyo67gYz93o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvMsJaEWetBElxTZrMwnP4Q4wwz1nKMnFwB43O8rHdJZPViXzOFGGzA47i3mIR64rJGKdfL0JLdUxWze3c7hDNvtBp2e/oT6mjbRnoViKqO2sH6+uxqsP9WNfdLwmRWKih0mSOgrJrEzrUVvQnrOcovYzxTVYY/xuD4vSGwzd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 543B7YSU087653;
	Sat, 3 May 2025 20:07:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 543B7YAK087641
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 May 2025 20:07:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
Date: Sat, 3 May 2025 20:07:34 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

On 2025/05/03 5:01, Paul Moore wrote:
> ## Removing LSM Hooks
> 
> If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
> in progress involving the hook, and no expectation of future work that will use
> the hook, the LSM community may consider removal of the LSM hook.  The decision
> to ultimately remove the LSM hook should balance ongoing maintenance and
> performance concerns with the social challenges of reintroducing the hook if
> it is needed at a later date.

What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kernel LSMs,
it will be difficult for users of BPF-based LSMs to respond (that someone wants
some to-be-removed LSM hook) when removal of an LSM hook is proposed.

> ## Removing LSMs
> 
> If a LSM has not been actively maintained for a period of time such that it is
> becoming a maintenance burden for other developers, or there are serious
> concerns about the LSM's ability to deliver on its stated purpose, the LSM
> community may consider deprecating and ultimately removing the LSM from the
> Linux kernel.  However, before considering deprecation, the LSM community
> should make every reasonable effort to find a suitable maintainer for the LSM
> while also surveying the major Linux distributions to better understand the
> impact a deprecation would have on the downstream distro/user experience.  If
> deprecation remains the only viable option, the following process should be
> used as a starting point for deprecating the LSM:

What about users using the major Linux distributions whose kernel's major version
won't change frequently (e.g. some enterprise distro has 10 years of lifetime, and
would require 3 or 4 years when updating such distro's major version) ? Such users
likely fail to know that deprecation process is in progress, and likely suddenly
be notified of removal of LSMs one day. I agree that the upstream kernel may need
to remove no longer maintained LSMs, but it will be hard to make an assumption that
any reasonable user has already seen the deprecation messages.

