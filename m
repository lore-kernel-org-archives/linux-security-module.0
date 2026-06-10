Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763B27FB05
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083769; cv=none; b=HSX1FSsxQYiAYVhVjXcD0n6txPRWzPOkv+Lb7Ahh5EuUcSl2AWYQq1ftF/Kaby6yXnrxM2cJUqDSEW8cboT+a9lcJrjLoAhliLwmUmRVwI0quBWnSa9MY/kESFQn1ODoxBqNT5TgUbmyQWX8LeGt7bmsynXCvJlEpWSLbehyxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083769; c=relaxed/simple;
	bh=NIUGaFKW9+cC+M+IPJDoCTn+6wXXm3sBvxbrKnr1SfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTxW/3KHnKNLKxWnkcbn2w90lo9tzOI7nQBgV94Bnbnt4FKdhj8Ob44lvwh7q53b2KWhawjBrU8xxmrO1KcYcCraUGDPobPBWymPKKSdEGowb808SsirFwaYdmSzryyxpNKvxodzDpknxFwcmp+NIEENSILiHNCHSrS3RUTLLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l14gOU1W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l14gOU1W"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45fd464d51fso3562423f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781083766; x=1781688566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ef/NkKbOETgV+FyTfZSA45hX9hjPd58jKhTLLx7rzjw=;
        b=l14gOU1W9EClLuAkZk1CESTNj65RTFkb5RfBDtVzygoJ42LP9CV5yJPMD7B8Y3jUmz
         MxJ3LEkNWsTFZMZykAJIAY0amy2wlXTEEyE9iW8euT9VFJ3V5xZbt7HutqRIEUHRb6Dh
         ZT/hd8bhujVTBNj1RxUHTjDP/rdHFZvmey0aOYeekdhWTu6vn5cHQsIJWlmkpcdFypKK
         a7VAz8GR+Zw784CepdHoZucnz0vX6hnq5NL+xAcLy0pjzEE6o9V4r3CP9ogjg4rp0wyN
         XN0djlkDRLxidsyBWU6vVDJe7C5poKTo8bZtOhNNU87uehSZX7KMHebFKrWGSGo5fg57
         wj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083766; x=1781688566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef/NkKbOETgV+FyTfZSA45hX9hjPd58jKhTLLx7rzjw=;
        b=U4EXhRfOg/oLw0KQ4WTiVSqGEvOKvup7gIyh6T2nxZmVa5zIuNO3G0R0hG/5eVROJg
         5g39Mz7akqW5r8VDhP1bGxio4sJojCTrm51AxK7OrBWJ7NmkTIjBBuJL2NnZpWEh9vBj
         aBE4SeLJ49J6ucGJezdIYzS15U79vOaoq7Ux4tTeVaazb28nsV+Hulz6yI5QwHh/IXoa
         CR9eKyIYlDQ7KkAleHx1aBN39MhMKrjS77UYpnOY20LrrVUHbKhMpHFgXaiSXwOZlvqi
         /UNNw86A9EXHkz0U0AwhPse/zr/CIvHzuRr2zW0D38NoJkpNGGFCf1tSRG/rnA3i18aT
         WM6A==
X-Forwarded-Encrypted: i=1; AFNElJ89mweqovKIt7xt0JxvUT6E8WVnCmYUGyXQlWAtLD17l2KedFSnNHgLlS3Gtnyo9vRRoqqObmA65dHD7rcmiimMog5ksuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLBbw1lyaZN4i6NL+GLnKOAa5Wh6yA0C5+yUJDHdcTMGgVPk7
	THO/VyiIpSK5QyV2bfJTlB0r3ZbagrWUvAEc6wUHsYOQ/rKkJUSCLHooC9/tpOk9QhuPs2I3/7V
	IuDOZCp9v
X-Gm-Gg: Acq92OHHqpRh/hG0z5J/sj5mJ80Mr8Xh7p1BdJjdf6Tf5XT6E+rpx4iMNgcrAIr1WjA
	1+2FIv+viG1NGUTjgX94Rtwe5g5mRCN+JgI5ugrhuEZlcIOJEn9jTlUHhFM7g7pVULEgCyBfUNV
	NX7ZpuSFQou18n4Ens4gqCK7r5WjrsUCY5vZ3U75HYcwwDPT4s6pX8gXquDwc6LbQErLjnoYaYM
	v/NB2GF1eGNlry9emwu5t/Ln49H4Y/d/TrwrcYnAnw5rv7D8tx8ahD0RrwHioELbRq56Kcd0VHI
	+vSVI4B5Z6/cMDHysMTdV/FK/F7CVDQwNlJqy7lWwJOQ+ac7OQsyk5/amQ59hMhsRk84KpCSm0T
	FBfM9eD6myp84O8aHbszVC2HIFicfpjGS6zlzuZtSzHhsuuUyzw2cxG4cepduhs9pzElmrDxfoR
	aB/MDaFsbOHipokErz0iPTn6KdvDs0klKvlnlod/DTQHv1avoLsWx0Sjigsa/Vs5ax
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id 5b1f17b1804b1-490c2508a5emr419769065e9.0.1781083765837;
        Wed, 10 Jun 2026 02:29:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:904c:4257:6fa7:7289])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm633713215e9.10.2026.06.10.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:29:25 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:29:15 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <aikuazRabjEfKpOa@google.com>
References: <20260513160552.4022649-1-gnoack@google.com>
 <20260513160552.4022649-2-gnoack@google.com>
 <20260609.pait5oaTheHi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609.pait5oaTheHi@digikod.net>

On Tue, Jun 09, 2026 at 06:09:51PM +0200, Mickaël Salaün wrote:
> On Wed, May 13, 2026 at 06:05:50PM +0200, Günther Noack wrote:
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index c1ecfe239032..09de6ba5c3a3 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1519,6 +1519,21 @@ static int hook_path_rename(const struct path *const old_dir,
> >  			    const unsigned int flags)
> >  {
> >  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
> > +	if (flags & RENAME_WHITEOUT) {
> > +		int err;
> > +
> > +		/*
> > +		 * Rename with RENAME_WHITEOUT creates a whiteout object in the
> > +		 * old location, so we check the access right for creating that.
> > +		 *
> > +		 * See Documentation/filesystems/overlayfs.rst and renameat2(2).
> > +		 */
> > +		err = current_check_access_path(
> > +			old_dir, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT);
> 
> We should not need a second path walk, even if whiteouts are rare.
> Please propose another way.

I sent a V3 with that implemented differently:
https://lore.kernel.org/all/20260610092318.3868884-1-gnoack@google.com/

The tradeoff is that it complicates the common current_check_refer_path() to
solve this fringe use case.  In my understanding, the only software using this
is the FUSE OverlayFS implementation.

See the "tradeoffs" section in the V2 cover letter:
https://lore.kernel.org/all/20260513160552.4022649-1-gnoack@google.com/

I slightly prefer V2, but am OK with either variant if needed.  Please pick
the one that makes more sense to you.

—Günther
