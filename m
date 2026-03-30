Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BF393DFB
	for <linux-security-module@vger.kernel.org>; Mon, 30 Mar 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897237; cv=none; b=sY5jKuAkbFA/mBiPQ0eY4SxA823g/sc4d40us3WTs5tHeGo9MmUrtZ8EM+bB7Oins2l/YS5gmW2QEQMIjWfQTekbo8CvgNLZ43xNIWcnMNaM7GjluqpuIcJmyW0GRDi0nlMSjjb/Gri55MsR545oztQucdZtiGOOLTLfhQmk0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897237; c=relaxed/simple;
	bh=jdWG70JAd8OtAyhRqPPHhe0sprEsCXmIDy0a/lY+JzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koO6OvktNlUvYRdfVIg0YnATqjDDXqtaP2BDcghqzBa3omU4Djv7yY4VZvoCMO15d9XdbdkRlurj6Gu8ghj2/u+JpOugZIPHCg8I2K53vf89CgTka/pCswF0mvNJqMtlr+1HMy03gdNmWjCLw4q8oCAXuwCPu24HjlYR7+EyBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH69iBM7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH69iBM7"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so8482357a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 30 Mar 2026 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897234; x=1775502034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ykz3/gOUH5An5cyE/2BWJho/3DQJWwugApX+wp8V1o=;
        b=PH69iBM71bae/eiGYNurLJlAuNsgv8p3N1YKYKZtqXI4q/4sl1OpoRcAl+ugMTxbYx
         fmSmBE9oqbT13JAnvQ9kON863i4m1vfPhK370EaydEmu2EkmrJM4AQ4ZGuBsGre4jmKd
         povF5zv+/JaOrWTP37K2G/C42LgTwx/x6dofo3DFhYLwr9UGtEIa9cjKJ1mMsZ3x/feC
         r0LdQo5RwuWmZxe/OnbXM2Iq0F3z0lZ977sBAVSRGJWAXf1AnlUO4UOwNFocyDOGiZKd
         NBPboH8q0PF+1ueb/IFPPDipRh2cWfnKGCsfNGJzu1obotYilLlDLan69JfEFu96ixei
         sQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897234; x=1775502034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ykz3/gOUH5An5cyE/2BWJho/3DQJWwugApX+wp8V1o=;
        b=M6u0mjH4Fdf9Ie2dV2nLK2p7uwxtxuW1Kc/ZdTOJFUX3EGvgbEG27/EbHWj2b5dKKV
         jDRTO9w2wKl+V1y8dH9HuN73+gKxyKb/NVrqJ/qCHm07W30cXQ9s0RZOhVhEtxOD+SYw
         CflWdKMzUxa0lMrmYSc5Pbh7Pm+rvV3yFvSHbw+ia8MEfPUXedI1zNgQ6MAGHsTh68Nd
         tjSR7XXea6d3idXPrH34N5brKbGx0wR7GkOCIzaQndHps9NMjB9v17sA4QXPjoO3LQsN
         CdLcmNLZY0TraTdc5R0ezM7M6D82PK5Nsyp/AeGQHd7Y+R0gLlbwMZ27c97YXmli3krL
         xM4A==
X-Forwarded-Encrypted: i=1; AJvYcCVCVnougBFDuZGsM2BRxPn/h0owr/nXVHk4L60CuVWoHW8Fe3FNrLXLP1Uvtt2o//rC4BV48eV83OSxX/uVjltaMg0mBAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvGlwI31uFUDXbERtEEU1Pf4FmHOlzcQIO5uNidlL08bVMWZay
	fXueyh4MJjeAn3HtD3Iv4rnHKVEr7owy7D7xBNclRG7yOKQVRkO0va46
X-Gm-Gg: ATEYQzz+Cok56NHbrMD/hVLwstyFtgJLV/g3ddbph6VfbHXYt8iO/+qoRKJ6GeiqWO3
	yNXyxEQIpJMJY0ip7qyqwaPm2J0PIVK+NrS2AORWWpcei42Wq33AUJO9k0kMOxeHdOgV3+Tjq6d
	4zindLfe8fDZckmdTg751Y4m77Co4wJBolPuaKjkm2RUsNeNdxXlimQzA4SjgNBS9g/3J5Ix1KS
	Wpti0bKYnNbLTg4ehOylSd+kmYd5fvAXJPRbBo//RLx+j0DHUsQw3SJ37ZhI7SA5/583s2rZg52
	F6kgFZn8Szk74y3IyMqOB9Wdl3zLy9uatAoZbpIxSOrdgf2qdbxaD6GX+f5ZRiadfC/DxOrFK/a
	vhbin8BJDqbpKQtTaRHOmhM59IWzvZdOgrLE6GjLU7A5TBMI0kkr7I05YMTJTzq7sCe8X1UkxRO
	FdRAENTzaoPgQ6nKQnaVMSEoaW6ej7UEwHsYl6U6HOdA8pB+W+JWQHwc+YvCs=
X-Received: by 2002:a17:907:1c1e:b0:b9b:452f:fd9 with SMTP id a640c23a62f3a-b9b50363076mr788424766b.22.1774897233789;
        Mon, 30 Mar 2026 12:00:33 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae50e6dsm336150166b.15.2026.03.30.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:00:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:00:31 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	kernel test robot <lkp@intel.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: Re: [PATCH v8 03/12] landlock: Replace union access_masks_all with
 helper functions
Message-ID: <20260330.6229e57c9563@gnoack.org>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-4-gnoack3000@gmail.com>
 <20260330.ohsoe7vu2Nob@digikod.net>
 <20260330.laew6AthooD6@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330.laew6AthooD6@digikod.net>

On Mon, Mar 30, 2026 at 12:53:21PM +0200, Mickaël Salaün wrote:
> On Mon, Mar 30, 2026 at 11:56:40AM +0200, Mickaël Salaün wrote:
> > On Fri, Mar 27, 2026 at 05:48:28PM +0100, Günther Noack wrote:
> > > * Stop using a union for access_masks_all.
> > > * Expose helper functions for intersection checks and union operations.
> > > 
> > > The memory layout of bitfields is only loosely defined by the C
> > > standard, so our static assertion that expects a fixed size was
> > > brittle, and it broke on some compilers when we attempted to add a
> > > 17th file system access right.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202603261438.jBx2DGNe-lkp@intel.com/
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  security/landlock/access.h  | 21 ++++++++++++++-------
> > >  security/landlock/cred.h    | 10 ++--------
> > >  security/landlock/ruleset.h | 13 ++++---------
> > >  3 files changed, 20 insertions(+), 24 deletions(-)
> > 
> > I'd prefer this approach:
> > 
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > index 89dc8e7b93da..bc9efbb5c900 100644
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> > @@ -50,7 +50,7 @@ struct access_masks {
> >         access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> >         access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> >         access_mask_t scope : LANDLOCK_NUM_SCOPE;
> > -};
> > +} __packed;
> 
> Actually, we can just use '__packed __aligned(sizeof(u32))' and avoid
> the static_assert change.  That would have no impact on x86, but pack it
> on m68k.

Thanks, good catch (and thanks for pushing it to mic-next).
Fingers crossed that this works on m68k.

–Günther
