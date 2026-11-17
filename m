Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930104;
	b=MdbTpu8/3yT33tPEGxHGdZ0iQZIC3r6ExZObtPQKF5nE8mDb/kANM8h16oCR/kUd0xpv
	 /V2nBFhAbdgAylGuanTIrtkamVFHc9/w78pRzyBirJViqCcYTcICK3naQiX4wlaUQZqBF
	 3GeGTLtJ7E0oST4fX9B5lk+V6d/xrUngXlPKuqHnMMKl7QkG1iKp6TTvtkVoat56xIJES
	 0d2w7vPrSLQbuKlXy0D5FlX0uwZSsa4mOBdi+J69ulZivH2g2Nly4K4BZmO1DVPrSkzco
	 kXHhNUKCQb9HnOb/QhNLG8TxpJ4U0L4G3c6jP3gPj5cuUeLTwsAN+3s6PxJOJw4lTlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ynmtGThVfV9scNtYae6gYp9hmDX80T21RdywDg1Mt7U=;
	b=TkyKIkUdcyKMnKC7nEsRHb7W4m0qWXAJ4YLYdFljtj2P4elk4fmfnn4QTmLsa+xQeuPK
	 ogpQkdCHOBitvgMcQkAKv6TG1iyLoRuHSvntQ/nNfjISNvtdaCJACARXFV0RA0ZTGaMsx
	 kwh9r7CAYIdlPc/fC/aCPAKYuZS3za0VvcKn1X/aRrFuUwNvW/IB+z2AMv08Fef9fWsDf
	 YoeqvlhVIvFPAY0Gwewj4VoBN/woZAzMTI4KEZx698YtfD7HfwVWz1zBVv8TxbqUybxmB
	 Gcsk6uKzWzJlxouWFtyWytygKGxKSH/fOpxUzDm6RrLKm9uN0adVOG48QPpZB1hE1Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aaCtm8ia;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F39606A32A
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F39606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aaCtm8ia
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso54433625e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 07:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794930102; x=1795534902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynmtGThVfV9scNtYae6gYp9hmDX80T21RdywDg1Mt7U=;
        b=aaCtm8ia+vd7c0FVYlhQx82mtgp3Hnah+Qlm/51wHfJaqZeaLCO6yRn5d3tS3Odnpl
         dru0X3i5WADXm9cp1dVN4yzqaHNTAEGLY+0DEGf58Xhs+agh81pYOIcSJKda3d+NAT6Q
         OAarUle2akT2RBwVLnb18ibddaonrWd3TCkctbcQaSBIpbFTJKBgdJVYdUqKfuCWyHSh
         5Vpl163Jq3IyIMa3qQunmkyZmt/WGye+nTN5FxcYGC+k0OPgXxlWLHWctNOtD4c9jjhg
         N0rjsJYkYbniKEpCuTeygv5wTjh0vM+kG2Pb+9HSf3GbcQ0M+x/5FPnUEyT/e4IXoXCu
         pE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794930102; x=1795534902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ynmtGThVfV9scNtYae6gYp9hmDX80T21RdywDg1Mt7U=;
        b=I1kmS/CKGBhgfvFG0OpxdLZwCpzUSEqaNdAPy4Tqt+7m9KeDnOxLt+BLi/gvUNW1Hs
         +isQS/naKjapROHPDmCwu2dxjg4LwXY0ZIXrWD1KA/ehVIz0gaiDrU669l8zCdy9Ez0L
         sKHp5Dg6PxqiEL38n1d7/R9/OVISWzh8vqhuLIpCzXUyktPD5mez9ESFvuZZZEUWqz49
         wgM7sNAt38F2D92mS4jQUK4kizp+asqBQkBiPBjXm4vFyi6cHtyxuoddIeSo7I80TyBC
         SZe2BO987PThZU6kDlw5i2T30rhzWxIBPRXLlrvzQ1wbRD2zbneS5EljdWjzvxTP3Oai
         jquA==
X-Forwarded-Encrypted: i=1; AL+hErGnxkltoJ0ZPfNytL4XIKQymxFHsfY0+OqZ04sCkV2XhAdSaUT1DaLjGD3O+6S8DK4BaZQ45OLrpF/2dg28NbFNfYRCwGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LaKIswZqNO+RhBKOtSUfo0lYwi+16MMqmUokVCeG2vZWBiWGh
	KGti7iYddMBVjywTY0TaQhd9rwybIFhCTSclKg3HoLFB5iKGq3P7JODBX2ny0ah8fQ==
X-Gm-Gg: AYBFou3DSpcKDFUA9XGksTTGdWezXy3QxOXUSlUX80MnxMXvu6BdX+HJXFQME49gNG2
	qVk9V+XYW4UJCuhHVRFMC4IF+tRBQxRIf4LLS94wnnwE5e8/bFsask3RyHXL+j+ZJFdE8d6JED6
	AdY3nLISVeFF/z/AKxZ/xcCqwBAZDDeTqroRkr37KeMY0OGnFkD6yvJ8yvlrXMoci/lQKNuta6M
	rY6RMlPayeEe5+W1fhNOXIWSbLp88vqCPGzIUzhYmyVUeRBlkTFl4U8P+JeD39IofkmtqeefCbw
	GJYLg0gthgjiSpCwga76dPMS7LrfOEsFU2bIBP4JoXOwHuuoPMotT8pQUTTQlAAL7rnhbtzKDlM
	Ebxm7qjXIgPXgNQIObPzD84VnwCYpUyhUPPEuWg6tjprWiSqR0On82ybgCInaT18arWF1EGCcRY
	+lDc08OOoLkz4dAf5VP1ioQCfcvvUS8eNgnzMBZ2yNmhsNp52knzeeZ0kYaGE+jlPjVbywiZNcw
	0ZFKFiDlkjn4aoRMK1dTuPiQYv2VMq+Jr7RvFXTtCeo9e7RWzY9bEl149QoNhRBCw5BgovdHntU
	Mt0eBp/9IL/dzu9pNo2ToEkwd+b2X1/cJDa60Ng41Qx9b5xLfBn6lAG3Obu1
X-Received: by 2002:a05:600c:1d0e:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb55a7f5f3mr304992945e9.32.1794930101543;
        Tue, 17 Nov 2026 07:41:41 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:12e4:4602:d8d8:3043])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm46423145e9.15.2026.11.17.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:41:41 -0800 (PST)
Date: Tue, 17 Nov 2026 16:41:35 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Mediate CAP_SETPCAP for inheritable
 capabilities
Message-ID: <avx1r36MHsxhAzSf@google.com>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-4-mic@digikod.net>
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
In-Reply-To: <20261117101157.2520463-4-mic@digikod.net>

On Tue, Nov 17, 2026 at 11:11:53AM +0100, Mickaël Salaün wrote:
> A process in a domain that denies CAP_SETPCAP could still add
> capabilities outside of its permitted set to its inheritable set with
> capset(2), if it held CAP_SETPCAP.  cap_capset() checks CAP_SETPCAP with
> cap_capable() in cap_inh_is_capped(), so the check never reaches
> hook_capable().  Through file inheritable capabilities, such a set can
> grant new permitted capabilities on execve() when no_new_privs is not
> set, which is possible for a domain enforced by a task holding
> CAP_SYS_ADMIN.
> 
> Add a Landlock capset hook that checks CAP_SETPCAP against the domain
> under the same condition as cap_capset().  As with the mmap_addr hook,
> LSMs implement their own policy in this hook: SELinux checks capset with
> its own permission.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://patch.msgid.link/20261110202436.2408244-4-mic@digikod.net
> - Add Serge Hallyn's Acked-by.
> ---
>  security/landlock/cap.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> index 10e1ca772b9c..c89e8d76db8c 100644
> --- a/security/landlock/cap.c
> +++ b/security/landlock/cap.c
> @@ -91,6 +91,35 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
>  	return check_cap(cred, cap, opts);
>  }
>  
> +/**
> + * hook_capset - Restrict inheritable capability changes
> + *
> + * @new: New credentials (unused).
> + * @old: Current credentials.
> + * @effective: New effective set (unused).
> + * @inheritable: New inheritable set.
> + * @permitted: New permitted set (unused).
> + *
> + * cap_capset() requires CAP_SETPCAP to add inheritable capabilities that are
> + * not in the old permitted set, but calls cap_capable() directly, which skips
> + * hook_capable().

It has taken me a bit of time to wrap my head around this one.

cap_capset() starts with:

	if (cap_inh_is_capped() &&
	    !cap_issubset(*inheritable,
			  cap_combine(old->cap_inheritable,
				      old->cap_permitted)))
		/* incapable of using this inheritable set */
		return -EPERM;

where cap_inh_is_capped() returns true if it does *not* have CAP_SETPCAP.

So when this Landlock hooks gets called, cap_capset() has already
checked that we either have CAP_SETPCAP or inheritable ⊆
(old->inheritable ⋃ old->permitted).  So the Landlock hook can check
for the cap_issubset(...) condition to see whether CAP_SETPCAP had to
be "used".

Maybe it would be easier to phrase it like that?


(A more specific nit about this comment, "calls cap_capable()
*directly*" has confused me a bit, since cap_capset() calls
cap_capable() only *indirectly* through cap_inh_is_capped().  Maybe
"promptly", or "immediately" would be better?)

> Check the same condition against the domain.  commoncap runs
> + * first, so this only sees requests that commoncap allowed.  capset(2) discards
> + * @new if this hook fails, so nothing is committed.
> + *
> + * Return: 0 if allowed, -EPERM if CAP_SETPCAP use is denied.
> + */
> +static int hook_capset(struct cred *new, const struct cred *old,
> +		       const kernel_cap_t *effective,
> +		       const kernel_cap_t *inheritable,
> +		       const kernel_cap_t *permitted)
> +{
> +	if (cap_issubset(*inheritable,
> +			 cap_combine(old->cap_inheritable, old->cap_permitted)))
> +		return 0;
> +
> +	return check_cap(old, CAP_SETPCAP, CAP_OPT_NONE);
> +}
> +
>  /**
>   * hook_mmap_addr - Restrict mappings below dac_mmap_min_addr
>   *
> @@ -113,6 +142,7 @@ static int hook_mmap_addr(unsigned long addr)
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, hook_capable),
> +	LSM_HOOK_INIT(capset, hook_capset),
>  	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
>  };
>  
> -- 
> 2.56.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Code checks out, only minor comments about the documentation.  It has
taken me a bit to understand how the Landlock hook's logic matches the
one in cap_capset().

—Günther
