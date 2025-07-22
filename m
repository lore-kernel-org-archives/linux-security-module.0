Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50E2E3701
	for <linux-security-module@vger.kernel.org>; Tue, 22 Jul 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188781; cv=none; b=rPJ9l/vhv2uTlYIXC/rqrOrDBcMZi+ZpnxRYQjdivLfW9dTfgAeW7450vibIhnmCywhwr/p5g6K2jQ0iqwi/3Nr3keCYA5pptenvzM9oP9b3OyjRREpauNd16S/3XcIZnlOhtZPMEhLOkHU6ayAgcWWqQxIaRiQteNFLK9SWJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188781; c=relaxed/simple;
	bh=unclxwUwkHJB+zlphy+D4JjPANj7XVmeM+d28PpZIQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsfAdwj0UJNzGnG80qyKWS9G7cT1rTNceb6+PR1CGSicOqhbnpjUYFCV12gBf2MEBywoMrwGs4xfl7ffmeFE9uI+2w3xYMFGTzghNAavnmsZs+qe86yPB3cAGOYhV25H+KqO2cGTz5hJdHYKQLUCC6Cx50uVSTYgKG6NNl00rF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ilo5V673; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ilo5V673"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bmccZ67n9zHQp;
	Tue, 22 Jul 2025 14:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753188766;
	bh=4BCqvtZ48OEN1kkoyipLq6VcTxhuN0F/qR+fCkGvOHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilo5V673QmRdlrloSVI58vM5uxFCx8vy07PSark15wHhLY5tUaqccTMD60pYEB+hm
	 WHLbQ3mxcB+7U8blPvXvhumTViSAMNC5HuW6xgfHfl47Ak42SByCxJP5dv18ELL+1u
	 ajIDjTb+3F71rr0vko1aQQx5xfkC7EQLQ/v8pb4U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bmccZ2yDhzYy8;
	Tue, 22 Jul 2025 14:52:46 +0200 (CEST)
Date: Tue, 22 Jul 2025 14:52:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock/ruleset: Minor comments improvements
Message-ID: <20250722.aeyai8aiVeam@digikod.net>
References: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

I squash with patch with the fs.c one.  They are now in my -next tree.
Thanks!

On Tue, May 27, 2025 at 09:54:48PM +0100, Tingmao Wang wrote:
> Hi Mickaël,
> 
> This patch contains some small comment changes.  The first three I sort of
> made along the way while working on / trying to understand landlock, and
> the last one was from the hashtable patch but extracted here.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/ruleset.c | 11 ++++++++++-
>  security/landlock/ruleset.h |  2 +-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ce7940efea51..2ed7043ed2f2 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -83,6 +83,10 @@ static void build_check_rule(void)
>  		.num_layers = ~0,
>  	};
>  
> +	/*
> +	 * Check that .num_layers is large enough for at least
> +	 * LANDLOCK_MAX_NUM_LAYERS layers
> +	 */
>  	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>  }
>  
> @@ -290,6 +294,10 @@ static void build_check_layer(void)
>  		.access = ~0,
>  	};
>  
> +	/*
> +	 * Check that .level and .access are large enough to contain their
> +	 * expected max values.
> +	 */
>  	BUILD_BUG_ON(layer.level < LANDLOCK_MAX_NUM_LAYERS);
>  	BUILD_BUG_ON(layer.access < LANDLOCK_MASK_ACCESS_FS);
>  }
> @@ -645,7 +653,8 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  
>  		/*
>  		 * Records in @layer_masks which layer grants access to each
> -		 * requested access.
> +		 * requested access (bit in layer mask cleared if layer grants
> +		 * access).
>  		 */
>  		is_empty = true;
>  		for_each_set_bit(access_bit, &access_req, masks_array_size) {
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 5da9a64f5af7..dfd883a9a52a 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -27,7 +27,7 @@ struct landlock_hierarchy;
>   */
>  struct landlock_layer {
>  	/**
> -	 * @level: Position of this layer in the layer stack.
> +	 * @level: Position of this layer in the layer stack. Starts from 1.
>  	 */
>  	u16 level;
>  	/**
> 
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
> -- 
> 2.49.0
> 
> 
