Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F93AB460;
	Wed, 23 Sep 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134658; cv=none; b=ZHGi+BTTWYGUA20jB5UxIzMcCq7mpyXFZMmLDMzdCpfkXQw8t3M53XxMzB1J63oOYYgqToBmoBKOM4qOsqGRcmxJ3pqKFm8Oi5yUGRenrimcTgkFYGXQZ9un3KA+BMqK+GnOfZZX0VXAkpQqocb/sx8KWucL0QjSgU5oN9+hXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134658; c=relaxed/simple;
	bh=LwEBsAqy2kaxmJPco+HJPXrlaRjRSgu6u/J6jLjIMXA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KLeqjPk11W+TjExxRfbZD7Lx4Jt3bKLuM9IbOEHiMnFuAoj9e3H4msTRJLEK6aZrxIqGlHpv2fL6HtVGlFxJQV2tw123mwUHP9sX3UamCYW3vJE2Auesqg9gU34YHlVYeTzJOK4Zp8f2Jcaud2Szb8KfkOIYWAjjsGnWsmEF9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO8R6H0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO8R6H0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED101F000FF;
	Wed, 23 Sep 2026 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790134656;
	bh=NCEwDbXrObk1rckEMTNkFUc4FVStu/eY4fKu3KlV41I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=FO8R6H0CPTMkG1KDz3imP/dnMlF8LXOKqVBXJP9zXL2Z9ymIinlDX+KaQ6ML6xhFF
	 +5Bq8Vcbm726inQxdyxyTafg1fFHHRjZbKjSpTHblDTAOsM15qANbUUzvlLkK4MYWX
	 jFh9MkFzVrE73UH/ckSpdiKC1Q28twUmzsABbHmks+glEM+rUF+7s/6e5PbQpnMRWV
	 EOWOPXdRmcQB5dTlDYrhBCYJJDor2Z5dOh5CVVtQEyl7hFkmLExCKypZZ0UVPDeX5o
	 u4WFLmm25dlu4rAyj5VHUKM2uHMWQPVWFMWwWEnAzKi6irnOgHnuoXV4rcq/WBZ4nE
	 vnv+L+/Fdww0g==
Message-ID: <5226d18b-f144-47d0-9d43-d1db0356cc18@kernel.org>
Date: Tue, 22 Sep 2026 20:37:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ipe: fix two use-after-frees
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org
References: <20260923031349.1216431-1-wufan@kernel.org>
Content-Language: en-US
In-Reply-To: <20260923031349.1216431-1-wufan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/2026 8:13 PM, Fan Wu wrote:
> This series fixes two use-after-free bugs in IPE, both found by a recent
> AI-assisted code scan.
> 
> The first one is in the policy load audit path, where a concurrent
> delete can free the policy while it is being audited. The second one is
> in the dm-verity root hash path, where ->preresume can free a digest
> that policy evaluation is still using.
> 
> Fan Wu (2):
>   ipe: fix use-after-free when auditing a newly loaded policy
>   ipe: protect the dm-verity root hash with RCU
> 
>  security/ipe/eval.c      | 12 ++++++++----
>  security/ipe/eval.h      |  2 +-
>  security/ipe/fs.c        |  8 +++-----
>  security/ipe/hooks.c     | 22 +++++++++++++++++-----
>  security/ipe/policy_fs.c |  3 +++
>  5 files changed, 32 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5

I added both into ipe/text for testing.

-Fan

