Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987413C690;
	Fri,  3 Jan 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902664; cv=none; b=QYg/ZShtTiIfNKJVJqv6FiNvYiWQWNw27iy0yArXPBSsWJPZVWp4NkhdtRn9RK3PD3608XWl9e7CrT9KzA97CnwmcSuwitZw8BkTbHNJ6lfvJGdQ9MWvFcC2q2N8cflX9+q8xgA96LhOw+/h2z5O8yQr4yulmLc7YC+h8StbRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902664; c=relaxed/simple;
	bh=/NYIZgNwdWO5viK2vzTVn3mm9xIbKuh4wWwm48zI4l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq3Ymzp3WcKSzzzEVRVBhD1hx2JmlIFOXNd28FY3/GOqNnm8rkGrsaemPWYUX+Yfw0NqK4jBdeIV9nlpvKaGh5J0YyhZf22t5S2FEBFRAZgZ8aSlNMppPAIMrb5bRED+3ZtJlFC/zTJJa2WdT4Zff7uLAQWjjCJJK3AjYTgroc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePrrnZoX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wf4OFMy5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0WamaAjE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BZupZkr6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePrrnZoX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wf4OFMy5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0WamaAjE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BZupZkr6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCD8721161;
	Fri,  3 Jan 2025 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735902658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhmTV7gxNR5zx7IEvmVEwxcKzw+hnIzINA21GGHEbmA=;
	b=ePrrnZoX2OJgvOq7FNZHfepxnDlpflwjiG/2vg6pEQkITgugRm47Pja4HE5B+ZMiICS4jJ
	O6vZpo6zU9YrQQHXn1eC/E0DpRpqi2M9aM9dkFxXvv0DV6Kq2JG+AsrymshfDIbCZcbZq/
	0CJ7J2PhEMq07I150cupl1kBG/GJsmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735902658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhmTV7gxNR5zx7IEvmVEwxcKzw+hnIzINA21GGHEbmA=;
	b=wf4OFMy53/+I1FQQb44CyWobLvSQvqnHhX+K+/P+qu2ZP5IZJRFhmBd8leyPpcR3e6ZLCy
	8EA7SkCKpweCrkAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0WamaAjE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BZupZkr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735902657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhmTV7gxNR5zx7IEvmVEwxcKzw+hnIzINA21GGHEbmA=;
	b=0WamaAjESl/SnMoKa9ycFoMk3vTxcKnXJf+3VT9vj2/7/evum9lunA+jSDPvF32LvULOXi
	CoDFatr17TNkdp6YokF7CPV1XsSzoK9D71u+FhY8R4FYoneRCx90v347lsoWt3SuGJ/Xmd
	d7HOwwXDVqg2BJCeZTqVgKXP/ocr6+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735902657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhmTV7gxNR5zx7IEvmVEwxcKzw+hnIzINA21GGHEbmA=;
	b=BZupZkr6FLYE7ehNMLokbEN9sUANhdNsAvI9JYMUR9uf8Y4g3ElSvO8LbwGWyqAoP7jVqB
	4MEus7S9X4eNosCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC7AF13418;
	Fri,  3 Jan 2025 11:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7muxLcHFd2eVKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 11:10:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4BE8CA0844; Fri,  3 Jan 2025 12:10:57 +0100 (CET)
Date: Fri, 3 Jan 2025 12:10:57 +0100
From: Jan Kara <jack@suse.cz>
To: Shervin Oloumi <enlightened@chromium.org>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, gnoack@google.com, 
	shuah@kernel.org, jorgelo@chromium.org, allenwebb@chromium.org
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
Message-ID: <u6jt67meocvhxlzx4bjt7dyba2piipfznrml46lkv5oi4ft4u5@cbqocdezi7is>
References: <20241231014632.589049-1-enlightened@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231014632.589049-1-enlightened@chromium.org>
X-Rspamd-Queue-Id: DCD8721161
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 30-12-24 17:46:31, Shervin Oloumi wrote:
> The main mount security hook (security_sb_mount) is called early in the
> process before the mount type is determined and the arguments are
> validated and converted to the appropriate format. Specifically, the
> source path is surfaced as a string, which is not appropriate for
> checking bind mount requests. For bind mounts the source should be
> validated and passed as a path struct (same as destination), after the
> mount type is determined. This allows the hook users to evaluate the
> mount attributes without the need to perform any validations or
> conversions out of band, which can introduce a TOCTOU race condition.
> 
> The newly introduced hook is invoked only if the security_sb_mount hook
> passes, and only if the MS_BIND flag is detected. At this point the
> source of the mount has been successfully converted to a path struct
> using the kernel's kern_path API. This allows LSMs to target bind mount
> requests at the right stage, and evaluate the attributes in the right
> format, based on the type of mount.
> 
> This does not affect the functionality of the existing mount security
> hooks, including security_sb_mount. The new hook, can be utilized as a
> supplement to the main hook for further analyzing bind mount requests.
> This means that there is still the option of only using the main hook
> function, if all one wants to do is indiscriminately reject all bind
> mount requests, regardless of the source and destination arguments.
> However, if one needs to evaluate the source and destination of a bind
> mount request before making a decision, this hook function should be
> preferred. Of course, if a bind mount request does not make it past the
> security_sb_mount check, the bind mount hook function is never invoked.
> 
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>

Christian is much more experienced in this area than me but let me share my
thoughts before he returns from vacation.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..c902608c9759 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
>  	if (err)
>  		return err;
>  
> +	err = security_sb_bindmount(&old_path, path);
> +	if (err)
> +		goto out;
> +

So this gets triggered for the legacy mount API path (mount(2) syscall).
For the new mount API, I can see open_tree() does not have any security
hook. Is that intented? Are you catching equivalent changes done through
the new mount API inside security_move_mount() hook?

Also what caught my eye is that the LSM doesn't care at all whether this is
a recursive bind mount (copying all mounts beneath the specified one) or
just a normal one (copying only a single mount). Maybe that's fine but it
seems a bit counter-intuitive to me as AFAIU it implicitly places a
requirement on the policy that if doing some bind mount is forbidden, then
doing bind mount of any predecessor must be forbidden as well (otherwise
the policy will be inconsistent).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
