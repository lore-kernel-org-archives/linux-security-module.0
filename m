Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7F30E851
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005674; cv=none; b=N56dxZlfHRCLbnmAYNprsb+jhPdB4R/omTHQadXckIafxcI6ddnh6swwsEmY2gZOHTlCLBCkD5TltBCJn390GKGpEA/03S9VcIMDML6DEqmnOnVsNvnmXAzvzVPN5W+VluIV1JOZIJVnBCBKfGHiWbMYa30ZA+k8KBR+W34bioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005674; c=relaxed/simple;
	bh=YIm3NrsAi9AWUSlzzRCR/LM5vToNV777otE5rrdBy5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muCCQhgXQPqD2l7iqkezlaqc6z8LCox3kabLQXIH65YoiXnQJcYWqcN2E04Zq5LSJo7JIYRWV+FvaGNWiz/YeqJJU+dBAMkaIobDb0/QICbsGFwT6R0ASMRBS0jMcTIgmwzcnkZWL+yI/40SgQ2GGP+Vg3OVfWSXVtVM8C6XaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bngvj4ZV; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bngvj4ZV"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso3127011fac.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780005672; x=1780610472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOPvfz9MYLu1Ld3S0G3koLTIHRRf0ypqVs8Nek/DcQo=;
        b=Bngvj4ZVDOOBP8J/mxb7GWpFo7BSprLXNsbOhvEzIz7pfUqFBZBEiYsUkagar4ou2r
         dvyqY1wpY5AS7+7vPp7+pivmAy6vMfCEJMjXMzm92FClYlRYgv3KT5b5dO+b4mFhVlpf
         zjv3Usr6mYTzRcXz3jLD0WQxMqLjFQbRAzrrtIkTw5fQ4zmbWkszo+H61wgTsPtOmL+Q
         WxJ9X4OzzefiIwIstbM7lOp8clsbsIr7GnFoBZwaqcZ80Ikgsse1Z2AbuqA5ZZRIwLJ5
         tilPPKiE5kTcf4EjGk+KeWEeeYWuBxHz/X5/zyzaPJrB0/9GpeQioRwG1dAZi/WeKy9W
         OHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005672; x=1780610472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOPvfz9MYLu1Ld3S0G3koLTIHRRf0ypqVs8Nek/DcQo=;
        b=AHgoqlAEkjIseTiISmcHIjs3UYoayfXMiQVXL57j4xtl6iL4l95WrcTbtswy1D+mn2
         jzlp+nXF6GYLN6+w3qOpoqxqjMWcYAqtNLbXme+WN0/Dxr6YqzVqXyCD1UN8wcVvUXji
         Q95Dg8Asd6ROY3yifHPfV2CgRPdDmHYntxWV8iNk+O6dSQYwAf3xtYEWH+kTAfemcYYz
         xwE/7S7jXcF/PkXJRmIMc3WEWz8nIl9K2qbyGhLrN/LV28DupFMJ3ullfLRUqceNzCuZ
         JOGbt+m82tJomhV9lQb09VlSF5rx56aa3zloIc902idgy98z/X1r8tusDZ+58Lk4SIHz
         zPJA==
X-Forwarded-Encrypted: i=1; AFNElJ9vjUhJ+VpPypRhkywm3k65cKCjuF6iGypGVVWfRRxdZDghjEM19Cb3Jz7KL3DpUx14YGh1jVe/V9L6VBF9fe451vi8Gmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqxRx/3lMSTiElnW2yXUG0GAyyUdSCdeu4/Jl6vSwF5RT3r6D
	m/lds+3GK2dpEtGC9noL2zjzvHhjAziXmA6LwZApUVDzRJZskDwTMksG
X-Gm-Gg: Acq92OEHN2Eyf8wnKEH9aSfOrxz3HhU4iITz4zslTbcC4/81IJRayRjE9N9xQLn110k
	F15OLnovy0r0cOGI51zIc4iqOWvRdn7STpDq+u34q+ggwBQkAp6GvoJa5Tznh+pDYSezLwF6NhG
	Zn9Hph1/OFp2S2WjzS20AY69t3IkwpH0oNaZOe/VIISMFsbgFMTHu9u5kIRwphQnM1U5YdK5bwl
	r6pmMeSx0M1WbNiP4g4eRHT8vkgXsavrs7Du6PeT0NWPJhd41sMZQYfj+Sa7a55w34QQYUkT1Xa
	BlZyGc5S7e5C08MHD3SXpBLOp7GVQ7Czs0ZKYOOP2Y1ICnO0XAPJCX4Kc2vdQABPJj36WQciJNF
	kD8tq+w/PyyPpHqIf8cNOA3J+4FshPq2DY9bd6Vo2z8Vaotyo65UBxJEdGkIT1qLLnbEJy0AvzX
	zUl7o8V+P3+d1HOI0z6mcJdzckzBE8dugnZ2ltwPipeitM38hcXSfic29ikqF8pgkxnuoktcWVE
	OTAHUYKpT0=
X-Received: by 2002:a05:6870:51a:b0:423:1cc1:f878 with SMTP id 586e51a60fabf-43c8973bb8amr161052fac.29.1780005671540;
        Thu, 28 May 2026 15:01:11 -0700 (PDT)
Received: from suesslenovo ([2601:281:c981:d860:72aa:f3e:ba18:5481])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c896b3e24sm179977fac.15.2026.05.28.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:01:11 -0700 (PDT)
Date: Thu, 28 May 2026 18:01:10 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 1/9] landlock: Add a place for flags to layer rules
Message-ID: <ahi4fYCiwYgr6S7I@suesslenovo>
References: <cover.1779843375.git.m@maowtm.org>
 <725de048a1756253dd2164c8f39b038e4e0ebdb5.1779843375.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725de048a1756253dd2164c8f39b038e4e0ebdb5.1779843375.git.m@maowtm.org>

On Wed, May 27, 2026 at 02:01:11AM +0100, Tingmao Wang wrote:
> To avoid unnecessarily increasing the size of struct landlock_layer, we
> make the layer level a u8 and use the space to store the flags struct.
> 
> struct layer_access_masks is renamed to struct layer_masks, and a new
> field is added to track whether a quiet flag rule is seen for each
> layer.  Through use of bitfields, this does not increase the size of the
> struct.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Assisted-by: GitHub Copilot:claude-opus-4.7 copilot-review
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> Co-developed-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Changes in v9:
> - Move a hunk from patch 2 to here
> - Fix comment and format
> - Renamed struct layer_access_masks to struct layer_masks, and moved the
>   content of struct collected_rule_flags into this struct, getting rid
>   of the extra struct collected_rule_flags and function parameters.
>   This is following a discussion in [3].  The flag is now initialized in
>   landlock_init_layer_masks as false.
> - Thus also removed now unnecessary layer_mask_t
> 
> Changes in v8:
> - Rebase on top of mic/next
> - Add Co-developed-by: Justin Suess for handling this rebase initially
> - layer_mask_t was removed in [1] but we still need it for the
>   collected_rule_flags.  Rather than using raw u16, I've chosen to
>   re-define it back in ruleset.h (it was in access.h).
> 
> Changes in v7:
> - Take rule_flags separately from landlock_request in
>   is_access_to_paths_allowed to avoid writing to the landlock_request
>   variable if CONFIG_AUDIT is disabled (to enable compiler elision).
> - Due to the above change, we don't need rule_flags in landlock_request in
>   this commit anymore (will be added later).
> 
> Changes in v6:
> - Rebased to include the revised disconnected directory handling changes
>   (without the "reverting" behaviour)
> 
> Changes in v5:
> - Move rule_flags into landlock_request.  This lets us get rid of the
>   extra parameters to is_access_to_paths_allowed (and later on,
>   landlock_log_denial), and thus less code changes.
> 
> Changes in v3:
> - Comment changes, move local variables, simplify if branch
> 
> Changes in v2:
> - Comment changes
> - Rebased to include disconnected directory handling changes on mic/next
>   and add backing up of collected_rule_flags.
> 
> [1]: https://lore.kernel.org/all/20260125195853.109967-1-gnoack3000@gmail.com/
> [2]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/
> [3]: https://lore.kernel.org/all/20260524.eFiz4hahrami@digikod.net/
> 
>  security/landlock/access.h  |  35 +++++++--
>  security/landlock/audit.c   |  20 ++---
>  security/landlock/audit.h   |   2 +-
>  security/landlock/domain.c  |  19 ++---
>  security/landlock/domain.h  |   2 +-
>  security/landlock/fs.c      | 147 +++++++++++++++++++-----------------
>  security/landlock/limits.h  |   3 +
>  security/landlock/net.c     |   2 +-
>  security/landlock/ruleset.c |  33 +++++---
>  security/landlock/ruleset.h |  17 ++++-
>  10 files changed, 170 insertions(+), 110 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index c19d5bc13944..3b8ba6c1300d 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -62,18 +62,37 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
>  /**
> - * struct layer_access_masks - A boolean matrix of layers and access rights
> + * struct layer_mask - The unfulfilled access rights and rule flags for
> + * a layer.
>   *
> - * This has a bit for each combination of layer numbers and access rights.
> - * During access checks, it is used to represent the access rights for each
> - * layer which still need to be fulfilled.  When all bits are 0, the access
> - * request is considered to be fulfilled.
> + * During access checks, @access is used to represent the access rights
> + * for each layer which still need to be fulfilled.  When all bits in
> + * @access is 0, the access request is allowed by this layer.
> + *
> + * @quiet is used to store whether we have encountered a rule with the
> + * quiet flag for this layer, which will be used to control audit logging.
> + */
> +struct layer_mask {
> +	access_mask_t access:LANDLOCK_NUM_ACCESS_MAX;
> +#ifdef CONFIG_AUDIT
> +	bool quiet:1;
> +#endif /* CONFIG_AUDIT */
> +};
From landlock-test-tools/docker-run.sh:


Warning: security/landlock/access.h:79 struct member 'access' not described in 'layer_mask'
Warning: security/landlock/access.h:79 struct member 'quiet' not described in 'layer_mask'
Warning: security/landlock/access.h:79 struct member 'access' not described in 'layer_mask'
Warning: security/landlock/access.h:79 struct member 'quiet' not described in 'layer_mask

Probably worth adding these.

Tested this out as a basis of my draft for next version of 
the no inherit series and it works great, handles addition
of more flags and passes selftests with no issues.

Tested-by: Justin Suess <utilityemal77@gmail.com>

> [...]
