Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B01714CC;
	Thu, 15 Aug 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737705; cv=none; b=rJt3msbfEU5gVoXjLO+RwEa9sqAp+i7TlTyyFwZoIpcXKHYes1QXx/jZXk1y1Pd2kPVaXR8EgrzGp7iFD4KZFoWpMZxrM3aPFAnY3A/GIwPua34o7jlHea2PM8/T/SiqYVrFUyq7p1IMrNtE0jf0oJZajyHpd8zwojMjLQkCav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737705; c=relaxed/simple;
	bh=vDn0PKPftCMcrAdWZ7ewofjGUgKWnZ9FUJGBk1JlJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXDR11tawhaYA3xznYTWXjM+/vhFds8/9ty8eqX5JivhahJxYEE2W/lq6s0PndcH7vqckWH3qzgDeWGo7J4UAc9HnI07EMPqKVAWKOPH6xLyRgCAEXnHFU3rw2JhlbwPgx5MUESuSyt4WjZOFKTZhyL8QsnxAnp7WqFfSgbccJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoiD+t8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoiD+t8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CAFC32786;
	Thu, 15 Aug 2024 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737705;
	bh=vDn0PKPftCMcrAdWZ7ewofjGUgKWnZ9FUJGBk1JlJtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoiD+t8Kd12u7DppWS2xeyJAkGiBHxBNMKasrbZ9UQtjmh0NPj1TqgFq4vJ4TR17L
	 ANyM3gbGqbfN0OpMEPgmgz3vtziyc0+m235A05pOkC8lLzUZEys+GhSV2JNyMfuaQg
	 ZC6lco6zr2Hrz4pBg5ZdCv0LOb8w94YZTVxN+hMxSAqCOFK5rBNeD+Po1oWRS21Q/W
	 FYCKCy3Gexv6Umh0d5y1C/wS2+DZYpzoCbVsEITUcAHj+H5Kp4qx6m67jf4vBiC40v
	 5qlDhdjy7T3fX/VABsJDVKosrQChocuSvESFsCI5VaQmILsqHG0qkBivYwHWiKAd6L
	 3+WhzWTJmjhQQ==
Date: Thu, 15 Aug 2024 09:01:45 -0700
From: Kees Cook <kees@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lockdown: Make lockdown_lsmid static
Message-ID: <202408150901.B9ACEE7C@keescook>
References: <20240814033004.2216000-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814033004.2216000-1-yuehaibing@huawei.com>

On Wed, Aug 14, 2024 at 11:30:04AM +0800, Yue Haibing wrote:
> Fix sparse warning:
> 
> security/lockdown/lockdown.c:79:21: warning:
>  symbol 'lockdown_lsmid' was not declared. Should it be static?
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
