Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C135957
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305958; cv=none; b=dLBs8klvxXu7G3K5Kq7WTl9euOnR6kFUehDX6hkNW9gR7i1sLr8LgCR3infBnDryHiQhlWvcyw77yZVxFZfxyjThdx2ucyjWKQ3Vtjf5R9esJfFGRHm8F7ms2o7/g3WhRt5j8dMJiMPmI6+oCBJNkZWCd9hopehkxwj0cpZGcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305958; c=relaxed/simple;
	bh=xIMC4bq7uZ4ioQBTr355K9FujYdeJ4YhFlxoWgguuZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uopZQ7ZrZSW3WPQLGdr4PJP2IayA0PG/v3oNiEuJMH6MlfoBwci937b+chizYIhFz8vxN/9GjnGiP5jtGwMglE5p+VlSfI1vP+cBUYd48QV0ASU5oJd+WI3Rjj+QcumglV1LyRlgYBDePbYPb5T1EhT8D8oN110B36sDcX4W0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+99DHBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+99DHBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A451F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305956;
	bh=H9S/xaCTQQEXNDiBFJ0R+Yw2Wjdk5fXUi9JEdArLGjw=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=k+99DHBhyR7NEbL3M3OYAgfI3V19O6KxCZbjppB6OPaF+TaDuDayylMskGkgIBFrB
	 kq7VxV9mokjnydIug06glh0ymKVQ4yT6SjFhVMiy7lP97ZjfvlXHLrQ28xx3Ac7aGd
	 INUsGmmTN+5VE5h3MJVJAVy4CHR8BTBG/mlVY8M8xOOe4UbA75oBEpTl2ynYnAidWs
	 A0WGQlveOt7cpgAEF0J4YFQ0Z0Q7Vpa2OcrhLbwSXd5+G9N/r/N2S+uQ/ApPj9fapE
	 KkR3FoFvzFIjctcPcwzknU4+fvCSofGlbRAI6zJEfmYPxoK3bhUKyDap0DQIm94EB3
	 t+DGDEiQiaB4w==
Message-ID: <fd65d32a-3ccc-4c4d-940e-3c970d558b8b@kernel.org>
Date: Tue, 6 Oct 2026 09:59:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ipe: cleanups, an audit fix and updated links
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
References: <20261003025135.3666767-1-wufan@kernel.org>
Content-Language: en-US
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 7:51 PM, Fan Wu wrote:
> This series contains small IPE cleanups, a fix for an extra empty audit
> record, and updated documentation links.
> 
> Patches 1-4 are cleanups with no functional change.
> 
> Patch 5 fixes an extra empty audit record on enforcement changes.
> 
> Patch 6 points the documentation to the new IPE website and test suite
> repository.
> 
> Fan Wu (6):
>   ipe: constify token_default()
>   ipe: use designated initializers for audit name tables
>   ipe: check parser token table sizes
>   ipe: correct policy text ownership comment
>   ipe: fix enforcement audit
>   ipe: update the project and test suite links
> 
>  Documentation/admin-guide/LSM/ipe.rst |  2 +-
>  Documentation/security/ipe.rst        |  2 +-
>  security/ipe/audit.c                  | 52 ++++++++++++---------------
>  security/ipe/policy.c                 |  2 +-
>  security/ipe/policy_parser.c          | 10 +++++-
>  5 files changed, 34 insertions(+), 34 deletions(-)
> 
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

I'm putting this set into ipe/next for testing.

Fan

