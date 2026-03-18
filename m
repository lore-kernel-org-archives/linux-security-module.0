Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF962D77EE
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853187; cv=none; b=Q9r3V4x7ccteiYK9gTR3F2yLIu+ifEzKja5/fNCqAiqIZKTaliyl9f7dxLLdYG8g1XPZ7xY38+wUrpK4QVQWK1h26x5LHykr/2l28wAMyugXg/UQ5zwCGb5ys6GuMiLwEQrMgxtkuE8mgTWuA52ZrrzphH3/ai5xhg4/9sza64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853187; c=relaxed/simple;
	bh=OE561+bwr0ImnAXUAnNKfDqVI84HyMIDMQE4OL35/ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce8BoRyDZp+UBW94LqBnuxYLmiWZqdm3HtLJ4cN2zi43ezyyNgpiyIAawbPw8cy1eW6pHyJfxl+xk0LQrJrCNo2rwn8vMPc0nqtWQboOplLpb9LmcTiQWr+DexxgM+ZpkQ5Y6/pB0QI0rud2sj/YEiX/3+H2AGAaECG6Q4KcLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lC6hHGZy; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lC6hHGZy"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZcW6YqwzTdc;
	Wed, 18 Mar 2026 17:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852731;
	bh=MYtdihUMwxUX2Pa43N99OkSjpkN85df8glmHgPl914M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lC6hHGZy+PM25brEYh/Ogf3qvrUKYkWcWeamh0bpmgu7UFdROghcep1NnJtdKbzaH
	 YOKoKAHJqjwnpEKyxBKafF1w0HwVelLfnBpsudRuMaYTS97f59KoUxdkibVBnh+q16
	 BYBMxQVjxrqdDVYMFIbQisa4bbOenTV4gsSvt2NI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZcW2LdczvgG;
	Wed, 18 Mar 2026 17:52:11 +0100 (CET)
Date: Wed, 18 Mar 2026 17:52:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 2/9] landlock: use mem_is_zero() in
 is_layer_masks_allowed()
Message-ID: <20260318.ePee0acaeng8@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Subject should be "landlock: Use..."

On Sun, Mar 15, 2026 at 11:21:43PM +0100, Günther Noack wrote:
> This is equivalent, but expresses the intent a bit clearer.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a03ec664c78e..97065d51685a 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -564,7 +564,7 @@ static void test_no_more_access(struct kunit *const test)
>  
>  static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
>  {
> -	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
> +	return mem_is_zero(&masks->access, sizeof(masks->access));

Thanks

>  }
>  
>  /*
> -- 
> 2.53.0
> 
> 
