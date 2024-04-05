Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8A172BCE
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353463; cv=none; b=QzHTqYcq5u/AWbVqK/B8UiL+wN6et9JKm7vcJp8tFfvCho8Pg74BHwpEBgiHRHAyUX/CgQTaxdb5Ec7LBYHntuvrdt0+y57/4O5UlOTp9J+/D7kmhpkmpP1RDk51MY8HedQnLTFAYShao07ybmjafSdOVjxt56mORmewrw0FaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353463; c=relaxed/simple;
	bh=oS5bb4M0EfmMnIH33JNisqjMupGydeXQcZNLxrbbly4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PB4D0UFeXLzXb8T9N2QOsQ7IYvjB9AivRe2T/s5WHNDeEf7Udk43290/1RuX2MvsvXfj2tgjVOLEM4x3xRNm4DfG+cJOmAiu45SCf7Fhs0EIBSTLHcoB5PFWDBwZUAIRNO/J/ZnnABD5m3/oHm3UyIoDAlCh/ZTJG0yKgEwFgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lta3KyJR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lta3KyJR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61506d6d667so44888567b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353460; x=1712958260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R124BriDa1gEiwbB6nVdKLf97X/einRvmCdS2X++C+E=;
        b=lta3KyJRCaEi3KaSYPNvt5VXP70HcVqIVRdMI917C4v59hLgryD1ncSlJbRoKJGlRK
         ZZRvgoHpWScryB9d14/257kqnVG4xUNVsoeqSvVE/ximhL1DHP6BLZnQh6aleJMLiBy+
         pYLG0XQWpgfW//5ye4DVI4t0KPREEQcAlunlJgPPOf68Ca2L4tvJ5lGBI39Hz6elbfa4
         AFzjhVQyyvNsRdSA7gWI6pDblvHYoHpN99PAvKXgHadt0ZuT4ssYRF1ff00b4SBMtZSp
         s2HjcAKKAJKcUKimeSY31M/IvSYk5uoNUAm6IFX6ljTI/Bh9fI9Z39HG2PvMujBsDv/7
         gCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353460; x=1712958260;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R124BriDa1gEiwbB6nVdKLf97X/einRvmCdS2X++C+E=;
        b=UCAXeK/NTCKWCf6DJH7Nn/QqseQbkcFhjL4oIJSSJDwLl7ga+ce6CtQtR5N/0fIlQa
         7EyuxbKNhfnbcBNGFfp8bmyoc9uO79zeFK1/N+Io0UK7DT9R0OdJZh62aLNogrXF9ZWw
         /UFMMIyndOlKoUs01mynbaOcrS/e7Q4Aux6bgBSAKpYALzW84EHG/raADsm9wIfmUKrH
         pQLz0RDN5gb8LE+ZONmS/Yq5TB7H8wM56yF+S+VzEI4tO/JwszSV7W2F0NWc9U1gkmYB
         05qV8y13/bzyuuMdVXfi7RoHg4g7UyYE5TzCOYNQ/3v6D+cNOpX7n9ezB/6lO47vE870
         B2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWoaYZCxjGerX6Fr60BALKKQOEHjsOpigkmEZaArTFnpoFiBDEQpUWlRLQtaAI7750TBdqW33awr0GTcXRGDT4GibKUpnsYgNoPI4PjEAZTs1uzcHE3
X-Gm-Message-State: AOJu0Yw+WIZJeSdALV9TTwrM+QVmk1bKKj0uL9RZEpOUS0ThQpHDuGX0
	SkvweMK2vp/kTVEoNjhY+bXNEeJSfkZw8RTUzy+XWulnYcTIjeC4p9WB17kDLAzy4h4HFqj9Mea
	y1Q==
X-Google-Smtp-Source: AGHT+IFY2apVZYCCOCia8mgnRYQHU6ofGDWpHC6UnO9fTT3+bl9y11zuY3q57PhPxvNesxXfwVOFIHqY+Ao=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:4ec8:0:b0:615:4805:4aaf with SMTP id
 c191-20020a814ec8000000b0061548054aafmr567604ywb.5.1712353460550; Fri, 05 Apr
 2024 14:44:20 -0700 (PDT)
Date: Fri, 5 Apr 2024 23:44:18 +0200
In-Reply-To: <cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net> <ZgxOYauBXowTIgx-@google.com>
 <20240403.In2aiweBeir2@digikod.net> <ZhAkDW2u3GItsody@google.com>
 <ZhAlXB3PWC4yyU8F@google.com> <cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr>
Message-ID: <ZhBwstt0zakE4uN2@google.com>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 02:17:29PM -0400, Kent Overstreet wrote:
> On Fri, Apr 05, 2024 at 06:22:52PM +0200, G=C3=BCnther Noack wrote:
> > Kent, Amir:
> >=20
> > Is it intentional that the new FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH=
 IOCTLs
> > can fall back to a IOCTL implementation in struct file_operations?  I f=
ound this
> > remark by Amir which sounded vaguely like it might have been on purpose=
?  Did I
> > understand that correctly?
> >=20
> > https://lore.kernel.org/lkml/CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqaw=
cu+H-MC5g@mail.gmail.com/
> >=20
> > Otherwise, I am happy to send a patch to make it non-extensible (the im=
pls in
> > fs/ioctl.c would need to return -ENOTTY).  This would let us reason bet=
ter about
> > the safety of these IOCTLs for IOCTL security policies enforced by the =
Landlock
> > LSM. (Some of these file_operations IOCTL implementations do stuff befo=
re
> > looking at the cmd number.)
>=20
> They're not supposed to be extensible - the generic implementations are
> all we need.

Thank you for confirming, Kent -- I sent you a small patch as part of the n=
ext
version of the Landlock patch series:
https://lore.kernel.org/all/20240405214040.101396-2-gnoack@google.com/

=E2=80=94G=C3=BCnther
