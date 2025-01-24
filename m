Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1C1AAA3D
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718596; cv=none; b=QBC02CElgFyMsWAgKWIdexVg7axR4emlXwwfHmcC90bkpjM22uMOuAYQoX+l5FYwc8ZYcJG2zp7mMuM7JxbP0z06Og7o+g73qbmTszyIQDGKkLfSOOaVDy1fCjTDR5gpCfKfYaGAM0xPWJLkloDOgnrzJqRF/2X/zOHuJLIywao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718596; c=relaxed/simple;
	bh=c8v0iSP3uPz1sHXkNSRfQ9ZSki5mQZWo4zBufiK0DmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjJuKgPkz+9GbmrvzD+K/0eARdtyp1K0qTtjYbFo3Z6jL58zc4nETxP8cA+KljxSzcuwUxVFKwJwmeK8InGogbfTyZNwoefqJPAyCcdzsY3KI5nIQg0mqAh6gLzLlAWFVlwRyju0uQIvICb6YyVU4N5IVhj59uKUu/UTg8ScO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ORxxd2/Z; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ORxxd2/Z"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfbP40nvzzhJ;
	Fri, 24 Jan 2025 12:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737718584;
	bh=Yh+2ivu71VmKgJUy4kfSxaoQdkA2KaxGAolLf4ZizBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORxxd2/ZevHevUkY+hweA3VuJW8TgTymLzJof3br2Kj5rxDzwrEmZhvxwW1BIj2R/
	 3xGjzjaN1WyVkH1Vy0JS2vfwXzuUaFrnBto7xdkyhcqgw3knL5mhlSestGljgEvyCI
	 rSQpVh6NIMvKxcIr5Sw5cu0rMREYxPe7D9Efe2Qw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YfbP25t0vzXtS;
	Fri, 24 Jan 2025 12:36:22 +0100 (CET)
Date: Fri, 24 Jan 2025 12:36:22 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: zohar@linux.ibm.com, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] landlock: fix grammar and spelling error
Message-ID: <20250124.Zohthoogh7aN@digikod.net>
References: <20250123194208.2660-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123194208.2660-1-tanyaagarwal25699@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jan 24, 2025 at 01:12:10AM +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> Fix grammar and spelling error in landlock module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

I think Mimi's tag was for the IMA part, so I'll remove it.

> ---
> Original discussion:
> https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com
> 
> This patch set is split into individual patches for each LSM
> to facilitate easier review by respective maintainers.
> 
>  security/landlock/ruleset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a93bdbf52fff..c464d1f84792 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
>  		return ERR_PTR(-ENOMEM);
>  	RB_CLEAR_NODE(&new_rule->node);
>  	if (is_object_pointer(id.type)) {
> -		/* This should be catched by insert_rule(). */
> +		/* This should have been caught by insert_rule(). */
>  		WARN_ON_ONCE(!id.key.object);
>  		landlock_get_object(id.key.object);
>  	}

Thanks, I'll take it in my tree.
