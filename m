Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93F3EF640;
	Wed,  8 Jul 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500924; cv=none; b=peT35/oVhAlEMM8TOFU5nKVpB6seRA3btpYPeVmIaJ3+8vadiYT9l4D1utoTKHkJC124bmwokRRPUHTmqdn7VvntHXeYtRlJzIMQ4lmaD8fg6LpKpjkhGh46vnvyAekrf3vB+LNHM346bPhJTEmJTb6YUGt0XY719ZizcCmZXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500924; c=relaxed/simple;
	bh=9abVzmJ9Hgn3wClwuyXO2NX03txga1uhuZaSP/BzjUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URNCDcsjqH+WQgEA3eYrNyD2DfjOey6gspvyQEudM7mopBF+EbwMvQAureO6/UOjHfqDQE+b8KLRlQcNCu6NGqAVJpzDT1qtvd8tGpkkpj8vktFGDGK+ILVKkpavJ07a1WCgNG+YYu4DwPotg+KeqDicaUrIubyE4+Z8DTWpOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj1IusOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj1IusOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CF41F000E9;
	Wed,  8 Jul 2026 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783500921;
	bh=S1n9snT3Hdu1xVNyEtbj9ccblxU1FXZmlHN2Xb7nQc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oj1IusOVnCXzMts7AijiSaH4y6/eaVR+aeNEv7Bjp5OzyCRDtNamVohyeaXMq4v42
	 sI6UbzxRuU0tKU9egNvr/c+lkeGFArQvPnzI87Gnxvmy4m6c1ZBlFOzKeQRYkxzDwB
	 MB9/uhmMa7TVi5V1hdwIHutgGiQJg/eS1vA+Cr9VaoVGtcasbMn4pQ+gwZvsdeVhj6
	 yxa+gbhENrviKmnraxQw3Fj/RJAwiqKHcSLQt8Wp7VhzgDPMeuOv0Nl4PaZ/ZYdtKW
	 7jqPjBle5PLlm8ECfGFN1kiwRz/s5+/z+3sRqR0n0x9q0ricl1lFmvNeO0I+aNF4og
	 Ze3FoBNEq5OcQ==
Message-ID: <fdea847d-340a-4fcf-9df7-870b8d434d5e@kernel.org>
Date: Wed, 8 Jul 2026 09:55:18 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/8] bpftool: Check EVP_Digest when computing
 excl_prog_hash
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: kpsingh@kernel.org, James.Bottomley@hansenpartnership.com,
 paul@paul-moore.com, bboscaccy@linux.microsoft.com, memxor@gmail.com,
 torvalds@linux-foundation.org, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260708075343.358712-1-daniel@iogearbox.net>
 <20260708075343.358712-5-daniel@iogearbox.net>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260708075343.358712-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2026 08:53, Daniel Borkmann wrote:
> bpftool_prog_sign() ignores the return value of EVP_Digest(). If the
> digest computation fails (context allocation failure, or a digest
> fetch failure under OpenSSL), EVP_Digest() returns 0 and leaves the
> output buffer untouched, but the function still reports success.
> 
> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>


Bpftool changes look good to me, thanks for the fix.

Reviewed-by: Quentin Monnet <qmo@kernel.org>
