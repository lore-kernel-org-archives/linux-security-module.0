Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384919D897
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140676; cv=none; b=Rpizv46mRHVcT5UGa9o80TNRsWrGtz9gMbDX0q7lZNmQSzlfSG6AaFH4p2f0+09WPI/Osithbj+XjD0lQderiHingUe2Unh4qRDIrlSe0DcnfSpfRnJc0Kkz50kdn6VPoePR+WnblwBk/IPJWcVVovUK62185k0ydkBtlHSzATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140676; c=relaxed/simple;
	bh=uV6jEBY/VNA2God+Z/LTrFFeXLFehpkYyWj0Kq9vXkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQgHVTzwkHuKhxRln8XuCqSpLiI/RNDtQpgw8nLd2B80chUgl0lVxZetHSFjev0TeFoR1fZMNJBG2Hr/IeyOj5oASw8zAc28qsEQyHVfM9SFq4MrHMb9u5bKuCYXZ1PiIk5+0cvXx5TbjU8h6aT/PPgiTFhEOxF/zwgAioiC+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0PGgVTI0; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0PGgVTI0"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNhVs555jzppZ;
	Tue, 16 Jul 2024 16:37:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721140661;
	bh=h0lhACXja6hn17y7ELrbWUVfRqsYW3kqD9ydNv/dHIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0PGgVTI05u5idlaK1N2MyCwOVsWoG+MBZv6t/7nuZhgEtPAehTx+M9yiNnr/Kp3na
	 pwbhZj7vm6koQWKduFD0SO/7xplve5dU0STt3Xl2RGZ8Ru+rkfG6OnFypOw+u0s+kQ
	 lrbH1YF00iLy6K60OQLGNuG2gBXH2vWn9VcfxqA4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNhVs0D0Yz9NB;
	Tue, 16 Jul 2024 16:37:40 +0200 (CEST)
Date: Tue, 16 Jul 2024 16:37:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Matt Bobrowski <repnop@google.com>, Alejandro Colomar <alx@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v2] landlock: Clarify documentation for struct
 landlock_ruleset_attr
Message-ID: <20240716.ooRe5oweew5A@digikod.net>
References: <20240711165456.2148590-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711165456.2148590-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 11, 2024 at 04:54:57PM +0000, Günther Noack wrote:
> The explanation for @handled_access_fs and @handled_access_net has
> significant overlap and is better explained together.
> 
> * Explain the commonalities in structure-level documentation.
> * Clarify some wording and break up longer sentences.
> * Put emphasis on the word "handled" to make it clearer that "handled" is a term
>   with special meaning in the context of Landlock.
> 
> I'd like to transfer this wording into the man pages as well.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: linux-security-module@vger.kernel.org

Thanks, applied!

> ---
>  include/uapi/linux/landlock.h | 39 +++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..e76186da3260 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -12,29 +12,36 @@
>  #include <linux/types.h>
>  
>  /**
> - * struct landlock_ruleset_attr - Ruleset definition
> + * struct landlock_ruleset_attr - Ruleset definition.
>   *
> - * Argument of sys_landlock_create_ruleset().  This structure can grow in
> - * future versions.
> + * Argument of sys_landlock_create_ruleset().
> + *
> + * This structure defines a set of *handled access rights*, a set of actions on
> + * different object types, which should be denied by default when the ruleset is
> + * enacted.  Vice versa, access rights that are not specifically listed here are
> + * not going to be denied by this ruleset when it is enacted.
> + *
> + * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always denied
> + * by default, even when its bit is not set in @handled_access_fs.  In order to
> + * add new rules with this access right, the bit must still be set explicitly
> + * (cf. `Filesystem flags`_).
> + *
> + * The explicit listing of *handled access rights* is required for backwards
> + * compatibility reasons.  In most use cases, processes that use Landlock will
> + * *handle* a wide range or all access rights that they know about at build time
> + * (and that they have tested with a kernel that supported them all).
> + *
> + * This structure can grow in future Landlock versions.
>   */
>  struct landlock_ruleset_attr {
>  	/**
> -	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them: it is a deny-by-default list that should
> -	 * contain as much Landlock access rights as possible. Indeed, all
> -	 * Landlock filesystem access rights that are not part of
> -	 * handled_access_fs are allowed.  This is needed for backward
> -	 * compatibility reasons.  One exception is the
> -	 * %LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
> -	 * handled, but must still be explicitly handled to add new rules with
> -	 * this access right.
> +	 * @handled_access_fs: Bitmask of handled filesystem actions
> +	 * (cf. `Filesystem flags`_).
>  	 */
>  	__u64 handled_access_fs;
>  	/**
> -	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them.
> +	 * @handled_access_net: Bitmask of handled network actions (cf. `Network
> +	 * flags`_).
>  	 */
>  	__u64 handled_access_net;
>  };
> -- 
> 2.45.2.993.g49e7a77208-goog
> 
> 
