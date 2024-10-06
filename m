Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6723CB
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728172941; cv=none; b=OF8Tz2pE8u1ILaald2moFONSoIM0an5nv3eUB5ox6PILRhWmr5DPlfjrKlka29m63wonu85Am+e2MGbjAWkFiEUslxehVZpe40dJEJTnMxwVlCUdS4dpgPAuFwWs5D3WgUjw+n2WCdBRxpCIbV9kLcE0rBKVWk1iw+867agKyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728172941; c=relaxed/simple;
	bh=NLfJmAbCpEMcOr405qzxArFpyaFRthW1xuA+lkX9fyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4HuWhPse5+6i6Teb01mdOHyT4OdRPtULCKd9kv73eLKmMIOqmVPAHReTB2U12r3j1CbZMJ193MvPCaOR4EQKJwiOaXKd5qgnOjVcYm/RyT56atuHxm+JC9zNneYWOBZNSdaUI6o3P8+eCMk2K+NxkA1AzDRnr6Xt5z+FxHymhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A5CAB4D1; Sat,  5 Oct 2024 19:02:06 -0500 (CDT)
Date: Sat, 5 Oct 2024 19:02:06 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Simon Thoby <git@nightmared.fr>
Cc: Paul Moore <paul@paul-moore.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Kees Cook <kees@kernel.org>, Fan Wu <wufan@linux.microsoft.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241006000206.GA901131@mail.hallyn.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
 <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>

On Sat, Oct 05, 2024 at 07:28:35PM +0200, Simon Thoby wrote:
...
> Perhaps you would be better served by providing your users with a snippet of documentation
> explaining how to configure MOK and to rebuild the RHEL kernel with TOMOYO enabled?
> To be fair, I know that your customers may find this a time-consuming ordeal compared to using
> the official kernel - especially as you want to keep up with the frequent updates.

Tetsuo's problem, AIUI, is not that it's difficult to rebuild the kernel enabling
tomoyo, it's that once his customers do so, RedHat will not support/debug in case
of failures.

> But OTOH that's not end-of-the-world complexity either, which makes it fine for occasional use,
> e.g. to behave like "a sort of system-wide strace-like profiler" (I'm guessing your customers
> are only doing this operation from time to time, not continuously in production).
> There's no perfect solution I guess, but to keep lobbying distributors to enabled TOMOYO
> in their kernels.
> 
> Simon
