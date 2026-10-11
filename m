Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705923392D
	for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724278; cv=none; b=VJrR+Cud0Uzj8MZJgEK0U2Dt3NiKwNQk5MhXRhN60hnjgxmgxiBA6CTcrvftat8vzAFZNxqMCCO+r4c6RreY5+YCeD3CX4tDr1oyrZgbna4CmP1oudBd5w/Utw0nmx0OHedxFN6i3eMStRUvUZiIDrSRmi0IdBe/cV7AAQKZLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724278; c=relaxed/simple;
	bh=aErJnkieOCM3MhfmM3LqUVLaeFiqhygrEa5kgMqxaXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqKo+9x5xnNGWP0gJHoQKgO7DfmRSXZp+CSRIbcQEyzIpPelv2KWM57tvm6FtKb4lQUEz23vcPOfyVjdHRG66km9by9+heJvRwRSHGvp6OS3jr527Ueau9NGmwY+6FQ+4t4wzgvVzGTWmcRCmiSKtiQb7t+wB+2FBrzDEFdjFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+0d24bz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+0d24bz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b03f23305so923545f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791724275; x=1792329075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQKR4lZeKCCSF3S1g9JSmEoRlY8sr+ryqydnKO0O4oE=;
        b=R+0d24bzOsZp3jRXkVbfwMqWUuVpW10a51601phLmewh+lBJd/M+h0xYQcQGvxc4do
         zOku7RzZ5LPf9ERFuryye83z3rEbSohuSTW3T4fF0Tk7Ybl/DrCKXN6k/SSzGtilVPrK
         7rfFGKJNi6E3R08FTtpIayAiaG/lW7l30YpozmjWbiLYvXPbBwxDI6qEF1MbicgewuPe
         OvNWl3Fn19RHVG718k11OLPtSsZqQHOfOK9oZBDGWpoU+UaBxvqhV8cP29fUZPlm4KS9
         l8FWNGxQ3CB8+NL0fFWi8cmtwG6sAXgFf/JRN4Pk7o8L8TepfBJEw2WDMPuI3LG1k0QM
         I52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791724275; x=1792329075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SQKR4lZeKCCSF3S1g9JSmEoRlY8sr+ryqydnKO0O4oE=;
        b=rGbFmP1WK3/dMGlF8vh4/IN9Ujv6z05SckmZuRFrAkg0/MEKAl69RfU0kBCU7kj9oA
         2fkwevuvBR28NaPXuKY+QDoLLXEcqr5UISrGSaSIcNsTzyDAcpESj0jizP6UsfAiVm1W
         O9dLIeLJjTV7ZuoZqTaVv6dh5R6T+5lXI7clbubKl7EECixQjRCD3A1DktvazuS/Zqz1
         1vNUjHoO51gTbmeBFG7t/h9jyfItk921c6edEDdDWgj0FHuNOt5eNC2lk3sBEiA1CieN
         XA4jLMo0KjMwZ9e0vrj/7tw2YsBYzmyQaXoU1irzYZb7ohvx5ief1N9zJUd1ew+8wcDd
         6POQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1aoZ6BYKyYSDCrm4ia7daxmpQplc0XBl8H7Fw86Q1Dku2OmDC38ihJ4OEUHpc1OixO/dus3e5O0N7LxL4KeZVBHfgcWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLVenXopY+SV+41Ll3++cBrcf75G5Ow575EJc6hFpXDNqSehNt
	ZZlDLJb+Um6arRsxGj3vG9W72jgn21/wWJCRzeAmU/QGhUfaCN2goSGX
X-Gm-Gg: AYBFou0lVRIcSM7P1iuux7m1ERvNl2Z1xxN1YkAU/fOTy3Em2cFVHndTRfBcg/zlm0n
	ozfQJDomTFZPzl0CaZX4H6lhm10P0QkCx6wL/bxAVydEqh3Idm6/MouepA+stuXYYWZgVW/Nxbh
	ImvLK5e2MkQux6L7YfwLjkHLrT0w/IBjYLEu2dznIAFQWGH1w9xopPMTbc2EpJF6/sSzMhKzTRh
	rf1nqDjd1UQz2NpuZ2JSfuCCc1TaV+f4rrn7rhKRlqyJ5ARuU+EwsPIJCG5iTJ3EE/rZhIU+iI3
	uPPelHlcPedGiXVCfn9sVI4AE8C3cfXVviG3X7vio6mIHr/bIPJpsW6Wr6wrUef69+COffozLEg
	5q953rrzLaSmhVTCQOLa4fQGMspQm4FV8v0YuQImZVxuRkkc0pMHf3fgmlTmL20KpAoHWMEzIJW
	NdkB1eumBOD+RgSKYea3gt6p8yxeODneM/hsYBWRW7NfIPhfl6B2joGUEGZXakF3YIyCss65NB8
	ASzAEeWtnoL8Zs3DHnu9usYIqSuNS+t9OM=
X-Received: by 2002:a05:6000:25c1:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-48dba78a613mr11734232f8f.1.1791724274680;
        Sun, 11 Oct 2026 06:11:14 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abda3csm14712714f8f.36.2026.10.11.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:11:14 -0700 (PDT)
Date: Sun, 11 Oct 2026 15:11:12 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>, linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Message-ID: <20261011.c1055cd53b32@gnoack.org>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
 <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261010164450.194439-1-ngocthang2710.1999@gmail.com>

On Sat, Oct 10, 2026 at 11:44:49PM +0700, Nguyen Ngoc Thang wrote:
> With clang 22 and CONFIG_FORTIFY_SOURCE, the second
> landlock_restrict_self() call hits a bogus fortify report in
> inherit_ruleset():
> 
>   memcpy: detected buffer overflow: 16 byte read of buffer size 0
>   Call Trace:
>    __fortify_panic
>    landlock_merge_ruleset+0xc46/0xc90
>    __se_sys_landlock_restrict_self+0x2bc/0xd40
> 
> layers[] lives in an anonymous struct inside the anonymous union
> that overlays work_free.  For such a flexible array, clang computes the
> address of the __counted_by counter as the start of the array instead of
> &num_layers.  The bound is then read from layers[0], i.e. from
> the first layer's configuration, which is not a count.  The same layout
> crashes clang itself in a standalone test.
> 
> The annotation was added as documentation, so drop it rather than
> restructure the union.  Keep the information in the member comment.
> 
> Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
> Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524):
> the second landlock_restrict_self() hits the report, while 16 nested
> restricts run clean with this patch.  Mickaël, if you prefer to just drop
> bd3a19800dd1 from next, that works as well.
>  security/landlock/domain.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 60e8eb2d6ac2..4bf1555a4349 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -246,8 +246,12 @@ struct landlock_domain {
>  			 * properly handle merged rulesets without overlapping
>  			 * access rights.  These layers are set once and never
>  			 * changed for the lifetime of the domain.
> +			 *
> +			 * Not annotated with __counted_by(@num_layers): clang
> +			 * miscomputes the counter address for a FAM nested in an
> +			 * anonymous struct within a union, which trips FORTIFY.
>  			 */
> -			struct layer_config layers[] __counted_by(num_layers);
> +			struct layer_config layers[];
>  		};
>  	};
>  };
> -- 
> 2.43.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

I agree - it seems better to drop the __counted_by rather than
restructuring the entire struct for that.

Thanks also for adding a comment about it.  The __counted_by() has
only been added very recently in September, in commit bd3a19800dd1
("landlock: Add counted_by in landlock_domain").  Better to have a
note about it so that we don't accidentally add it back. :)

–Günther
