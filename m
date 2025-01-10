Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58320B218
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508265; cv=none; b=YAaxpRCi8Vt+6vJKkhXTszO7nEXNnCpfZcEirTTNMZcCWvLaOlcCtrVTKt2rTNWIs5uCaH/6aHy7iY3VRovLdlR7lI6EBqr27PMu4os6jmk7ZcM7s73NmpyHS6YWcpG5gHxvJl49Bn+SvqDAkaGQE4qGSLmCpnlq9XB0hOLiqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508265; c=relaxed/simple;
	bh=0ofzsNBeJwsceqHy80qxVNumuzBRVawm1s2qo6K045E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCbu7T0nvLaSlael7i/8o72hMgPfV6U1AcByqJHeBJ3V9HyMh6waCaXIAEQef5UCAZdFWZ6i37ctzV11BUUSTeuIa25GntP2OUf4f4nY4DUGYMP7jfDtq49sXbFt0OLEeXLuhT8IPF218wuv55dD4KCKALehRMEUfst4HZBNMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OfjVX/00; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OfjVX/00"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTznW0DglzbQq;
	Fri, 10 Jan 2025 12:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508254;
	bh=hsqoIUmFQ8PGR8DlEAvfzOpwE0yufLTkSbhiASC8chM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfjVX/00mDbJqugIYn52ue0YCPoQk9bBTdyiL1vIRgmZadghf/m5wjQMdiKuircri
	 D4KK65r6gFXmyxL5uXzyLOZarfc0CDOEW8FlvcVW1Xe5gQx4DsG5GCeSQZ5DqedCZE
	 bTX+/QmmzeDuugyAwh+1YSLIrdSmArtgqeuyX63E=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTznT4yggzLpM;
	Fri, 10 Jan 2025 12:24:13 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 11/30] landlock: Align partial refer access checks
 with final ones
Message-ID: <20250110.igh2Cor3ahng@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-12-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-12-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:19PM +0100, Mickaël Salaün wrote:
> Fix a logical issue that could have been visible if the source or the
> destination of a rename/link action was allowed for either the source or
> the destination but not both.  However, this logical bug is unreachable
> because either:
> - the rename/link action is allowed by the access rights tied to the
>   same mount point (without relying on access rights in a parent mount
>   point) and the access request is allowed (i.e. allow_parent1 and
>   allow_parent2 are true in current_check_refer_path),
> - or a common rule in a parent mount point updates the access check for
>   the source and the destination (cf. is_access_to_paths_allowed).
> 
> See the following layout1.refer_part_mount_tree_is_allowed test that
> work with and without this fix.
> 
> This fix does not impact current code but it is required for the audit
> support.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-12-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v2:
> - New patch.
> ---
>  security/landlock/fs.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 171012efb559..ddadc465581e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -567,6 +567,12 @@ static void test_no_more_access(struct kunit *const test)
>  #undef NMA_TRUE
>  #undef NMA_FALSE
>  
> +static bool is_layer_masks_allowed(
> +	layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> +{
> +	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
> +}
> +
>  /*
>   * Removes @layer_masks accesses that are not requested.
>   *
> @@ -584,7 +590,8 @@ scope_to_request(const access_mask_t access_request,
>  
>  	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
>  		(*layer_masks)[access_bit] = 0;
> -	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
> +
> +	return is_layer_masks_allowed(layer_masks);
>  }
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> @@ -773,9 +780,14 @@ static bool is_access_to_paths_allowed(
>  	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
>  		return false;
>  
> +	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
> +
>  	if (unlikely(layer_masks_parent2)) {
>  		if (WARN_ON_ONCE(!dentry_child1))
>  			return false;
> +
> +		allowed_parent2 = is_layer_masks_allowed(layer_masks_parent2);
> +
>  		/*
>  		 * For a double request, first check for potential privilege
>  		 * escalation by looking at domain handled accesses (which are
> -- 
> 2.47.1
> 
> 
