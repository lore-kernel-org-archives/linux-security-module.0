Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552115;
	b=se+wNgoy7PbkF2eUnsZLq9cxRivVcy4tfJvx5XQWQlbBGzg0enLbUxCb9dIrQMPG8FxH
	 /70+j95XZKlxu5s7rp/s27GjGOqQWYlQ32FKejUgdw+slf+WQHxMbtiyeiBtyPlnyeNfu
	 1WVrHZxbe4uXlMtGbgZq07c1cNhQmzZJ66TkXf9UaoI4FtM+ifKFZVysHAAtlgX92+ZpK
	 feyi6dZqrg1dSGbE/HgsAMxGTkZMNbWQF1/a1KRanarzJotAjvglHp+PokZ9jo53BfLl+
	 V1KTdsrStuLo14fUdKGF1EgLXI8sPxbHIqv3t+3PNW+M+g08VrKCcvBLEcX5fOUR3Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=H0JrP+0p0FdSoF5NOd6Q19o1kCbGqSFW4yMPm846y5I=;
	b=VFDNA4tXOlYnr4PyQXHUNw3yBEZQ14shhHXbXf8sWYX0MEc6DM6SxnYe3pjIBI2Zr7iP
	 dDBiieyGzyzMSoamtj1PSRePzHV16pNbYUPMWS87NCmFm4WBwD67bE7AW7EtS+LXcUgNN
	 JLUOR0ywJDqb0OMCsamOtWBa5BmRyf9CYKBsLGUFGKFc2yuGmlLPebWsjgSJC18un2P4i
	 V0gJX3P8Wna4o6MiNyoSCe0ShA34BqCDT10V1Y2OI/SMIiIF7vXW5rZt80fJ45afNGr9J
	 KcfqlKiWIEE4MfGQ3HK8pG6TRYARXIMZ9INh+opWdojl/i+SqsHn4TezsImkPeR+hkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2WV5BB8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3B606A324
	for <linux-security-module@vger.kernel.org>; Sun,  1 Nov 2026 16:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF3B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2WV5BB8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so19185835e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 01 Nov 2026 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552113; x=1794156913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0JrP+0p0FdSoF5NOd6Q19o1kCbGqSFW4yMPm846y5I=;
        b=U2WV5BB8hVBmxeU105mRvsaM+wcYyGeXcUoruk5KZkm/yn63Z9XE27RzyW4fFB8931
         cB1ZS6pTognUF/DJqL8+GU5Xk2rLzAt8YiKzN3HF9U/ACVUeBnSFpe+f9w0ZXvyVlgzX
         7u+3wTTo9WOt5047Ud12B4JtnBg7+MSsoHHKk6ddjE2PwtjfLw5wtU2WJ0UK4ISDMnRa
         PGhyiWgas0Afzj8lC03Rdi0gKl5JxHHGyIQ+T2pzPvxgmQBAdIUh1kXlH6nBtaUlpH62
         FVT98y0+x86PTo9NQrYgO9BZT3zskGrGHB6Ea2PXn9oOY3VhEo1laVBAuK7gzNPkelfK
         Taqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552113; x=1794156913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H0JrP+0p0FdSoF5NOd6Q19o1kCbGqSFW4yMPm846y5I=;
        b=W0fuF0k35qmSJTJ3P9K6K575mJJ7sTa6pGsas9dEg6xypIkN/8Wk84GCGd9EnnfMST
         4BF9T0UQG/N+A6Rhq4Jl+onXMJ2i7GCNxdVAFJ+kGpnYNp6oMwkFUqrvtc/RY+D8nQbA
         F94yaGnOJnel0Pz3cdydiqHz1XZ9QVIUSYDr+BO78V8vw29Osv0VOgCiQ6OlSHnY0aBJ
         4O/EvvCVBrMDGFQUiPgpwK0X/Q4QJafHBW0GgONDganroD8E0k3TKC6kuhsNTYejGKHD
         whNs/f776s+pGFy+rw3PplG3PTdn2O4wDSrK87Ec12iMM4hDrgVUahM90G8rJNJ2vdWv
         Cjjg==
X-Forwarded-Encrypted: i=1; AKwUvBwrJKdP+3j+HV51sAO/GIxkGdRw8Mr/rNHyJa7e0W7X1n8n9FdM7BhkXZimdv1MKfcuBjYkJ32ZAY7RKY4pPxGmqOtx1/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2HDDJyMkGOR/IAoa/aq1ivGM3yFfduRQAM7pNCwBf8GVbDerv
	ylvxpobVBz4reBv37ILSl2SONzIYQdP0HFp/TgBwM0dlu1PE7LSl0M+e
X-Gm-Gg: AYBFou2235acS0BBSsFEzW4ZtOvjHA6zB3ucaNnRrqHqVKXdDQIefE0qazFbhiOoqmX
	wXbKhgeJfNou0VMQuBOh9RlxZEOmCnQVDeb855BAz1bNjJuo3AT1I/+9+5WGUvElSQ4dO9YLASh
	iUkZzxGkBEWWNeATYHUHBI93/ed3mxg50HHnTQBVV3JvcjBXg2h2pSBP5id2vyAeY5FUJMYht3t
	EkCqX0Bdrsk5hJvsxyfKAAQ6R+0YsDpl8zg3qlkwgLVA4S8mxeCY9sYbVs5HtW9UYTAKcfNWUk/
	vwr0O6KLQganJc7Lq0GwA+R5QwhFmqn+CzgDHE7pTgDvrvmbO6SQaF9WKmopRhINlsHjmwPQrgB
	ViB2KWaqawLFlqidaR4EOvQLd8WvXtocqIqoKYFQqBeYhibY2k9KlEPwch7SyUP4Aw50UTH6ftP
	YUdmQH/UeJ2GgkOIIke3K7tfpEvIZrgpsozhi/TmkamCFOxXuMxSxxowFY0mN6nJTqFoljFQYU8
	QoPMqO4ZHGnro4FpYQQpCsJz/DOAiUe99j5B8vvMV5HfzdEY3zuu9GQmts2Nh9cfBxJ1vcFFHh/
	7IxcN8FJ+a/GBIp5kZdygScj58S49VfL2AV+urRVE1u5OMaImxl0DQ==
X-Received: by 2002:a05:600c:8b0a:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4ac1709a200mr186469945e9.16.1793552113050;
        Sun, 01 Nov 2026 08:55:13 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm198429955e9.11.2026.11.01.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:55:12 -0800 (PST)
Date: Sun, 1 Nov 2026 17:55:07 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Dwi Siswanto <me@dw1.io>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261101.b4743f477f67@gnoack.org>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
 <20261030102411.12985-2-gnoack3000@gmail.com>
 <20261101125114.19009-1-me@dw1.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261101125114.19009-1-me@dw1.io>

On Sun, Nov 01, 2026 at 07:47:50PM +0700, Dwi Siswanto wrote:
> I saw the docs still describe the old one. include/uapi/linux/landlock.h
> says:
> 
>    * For historical reasons, the %LANDLOCK_ACCESS_FS_REFER right is always denied
>    * by default, even when its bit is not set in @handled_access_fs.
> 
> and, for LANDLOCK_ACCESS_FS_REFER itself:
> 
>    *   This is the only access right which is denied by default by any ruleset,
>    *   even if the right is not specified as handled at ruleset creation time.
> 
> So ruleset that handles no filesystem access right never denies
> LANDLOCK_ACCESS_FS_REFER -- alone or layered.
> 
> Also, the comment above _LANDLOCK_ACCESS_FS_INITIALLY_DENIED in access.h
> has the same problem:
> 
>    * All access rights that are denied by default whether they are handled or not
>    * by a ruleset/layer.  This must be ORed with all domain->handled_masks[]
>    * entries when we need to get the absolute handled access masks, see
>    * landlock_upgrade_handled_access_masks().
> 
> After this patch, the mask only applies to layers that handle filesystem
> access, and after patch 3, nothing ORs it in at read time. *Someone* who
> follows the comment could bring the bug back.

Thanks for pointing this out, the documentation is indeed not up to date.

All this documentation likely stems from a time when *only* access_fs
but none of the other fields existed in struct landlock_ruleset_attr.

It is not very obvious from looking at this patch set alone, but the
intended semantics are clearer when you look at merge_ruleset() in
domain.c.

This in turn calls landlock_upgrade_handled_access_masks() in
access.h to calculcate the updated access masks with the same logic:

	if (access_masks.fs)
  		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;

	return access_masks;

The behaviour that we have for non-layered domains is the intended one
here -- we only add the REFER right when either one of the other
filesystem access rights is handled, but we do not set it when only
other access right types are handled.

I'll send a documentation update for this, either in the next patch
set revision, or in a follow-up if needed.


> > +	access_mask_t handled = domain->handled_masks[layer_level].fs;
> > +
> > +	/*
> > +	 * Handles all initially denied by default access rights, but only for
> > +	 * layers handling filesystem accesses.
> > +	 */
> > +	if (handled)
> > +		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> > +
> > +	return handled;
> 
> nit: I believe landlock_upgrade_handled_access_masks() already has the
> same "only if fs is non-zero" rule, so this could be
> 
> 	return landlock_upgrade_handled_access_masks(
> 		domain->handled_masks[layer_level]).fs;
> 
> Which keep the rule in one place. It matters little if patch 3 goes in
> on top, and 6.12 doesn't have the helper. What do you think?

Good point, I agree, this function already implements this.

As you are saying, the first commit is mainly useful to backporting,
and the backport to 6.12 will be easier to compare with the original
for stable maintainers if we spell it out instead of using the helper
function.

Not feeling strongly about it though; I'd let Mickaël decide what he
prefers.  In either case, the backporting will require some manual
work because the affected code moved around between files.

–Günther
