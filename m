Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C470830
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768125009; cv=none; b=MDCvCE60xsfaJgr/4axiq+pUCVa4ItORBE7TfVh/pnVgsEoKCtGLZr6dgDcDg6/WnK7RVNgOXa5jjgskT5MF3G4R7llCt3mgrclFVcpBFXYDHgn2nFsxsmTN1rRRFghsS29UOqjrBty9reVLLlKkL65uf/uMB0Dgx0GjZZDvGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768125009; c=relaxed/simple;
	bh=eQ6fCzcLQumGW7AoY5cTimIuVMEwS4AzpD+PGCl5g1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtLf5TxGmr1SvSvKEMsyBJBCXJL4OvBCEEBmn7JvpSUt14xiAtW05ZA8U8le4b2Ttk1HQreH2YxS2cvdO4mIAFqDp/PPiyjI21Elae0R9t5TNhvSYUvg1A/PV2AOxyMgvuJK1X033RHOMsQdC7D5zCsg/mupw59lD9YOGWMyAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U428IReh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U428IReh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b802d5e9f06so807391666b.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768125006; x=1768729806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNDKxmkjOw4lxPdJREGcVXWfkWHi1uA1GjOb2BpowY0=;
        b=U428IRehB1BJ7sLuSTGY8GAihmxsCvxr2+/2bMEkMVVjy2oqCUsa5nQaZkFLOLYplf
         xvqKROndSmQsJ22w10Z5SGhmZpINtfaLyahd0vu0cCsqpOVEgdLQPQVqUalIfe7/9soA
         gddOXHraZ/N31OCRAkszu8xrUKrTokA/X9pOKfqBFiEXvApMhaMn+Bj9hNzd3Fyvj46C
         hDeqKDIUgUu1kI7p6+ik0g3xVDAUb4c6d3qkrfX8LAwgIUIJkexH35iUG7AMdRXDQQzf
         1R9BcX38k3LZ+voc6jyJMaBVZPm4m5bN4vj0fI8VhTkokzBSSD7ZF4Z8xDqTQZFsegKa
         KzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768125006; x=1768729806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNDKxmkjOw4lxPdJREGcVXWfkWHi1uA1GjOb2BpowY0=;
        b=RXHpaeXEeyng9NP5WplVUFzxm2Yokzp2M2O0Vzgig4PNmeCxGVZ92+UmOflFaEGUZ4
         b6RT0j3lF9hfn817FP9SJ30RN7yUMFRz6zzt32dI1Kxpzi3LcxkCVJeivC40bfuoNwUQ
         gcCBJElb+OaJ7BRSQC45vH6cEFiQ7ZykGl4uQWcDRUnDHjWzWecxSnbAkf/Pa/zxvhqy
         p90tAU9WvyPuzEqJk2p/bISskIdArKSTXZ9/HcEy8Aw3W8IwyMoa82A4hegrXN66T1VU
         L8ZBBC3s3dx4vgiXZ1uwNi5tYrYnSRNmeon+MPuyl8BL4PNs0eVN5NgW+vqjsdSyXOox
         oIsg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+0xSqsTRI7lnV7IiDeEiEmkPdNFNel07AuMkmCJlLcozAyRk9gWdzk3y2tjIw/7vIrm/Yi1zAPlYkzUSyJA16n6BmTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/z4wlflMi2NK31DjCp0Moi9P1BQCvTCJTmJQhR9Nghx8f6Hkc
	Va07LKTul2qhlFBhz5LqgUpJWVJh7riIvXGhpDXWNjJvyVCtbRZVU6hG
X-Gm-Gg: AY/fxX4yyL4OxeEYEtfQrAMpuggyMPnmVpdZaXsXG8de8ZMeN7d4bi/sPJSYR1J84oM
	89gNyZNtcKrNjgluKvFqzE917jLUWcBf43Bc05RN1GbzRr4s9ZLw9ZqJxMH1B1JZtT5Mz8gXbpD
	wgLrCjnbhRtwil1AIE2/rPLs6Qi/E0IA8H1B/WZSz2F5Z5FFnxjEGhJHEsIXZHWJuE2NnnpEJGX
	qWuCN0gQqdRDU7hRHyWGC8+vuoBreKPFnjf+4sTDV4e/TwzObjRlFQ8+6GoaJyR0pybr84CJ+8R
	zR8Xb2FIKGR4rxC5IwRhACFM9QRc9bMREqq805h9QepkeZVpj4g2gLuKoMaYE7fvW2rM6fpOi+f
	ZITBiDn3k5DsPEAYVrbPyHg7+2p3RQujSHSuSM6AneusmvaM71eVulW62KXGtFsQ8mPKK8oNX3v
	TjZoQRr1srdw3YoEIVDsGlMtoy5TClJKXaJGVl
X-Google-Smtp-Source: AGHT+IE7xTSnzxWIvCxKogjutNxsJ3yMX+h9ESquk3GrWstomY/i0hqqjtX1QW1rZ5ms7OA09VALLw==
X-Received: by 2002:a17:907:807:b0:b83:37eb:34f8 with SMTP id a640c23a62f3a-b844532ae51mr1502909966b.35.1768125005763;
        Sun, 11 Jan 2026 01:50:05 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a517cf1sm1584775066b.59.2026.01.11.01.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 01:50:05 -0800 (PST)
Date: Sun, 11 Jan 2026 10:50:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v2 3/5] samples/landlock: Add support for named UNIX
 domain socket restrictions
Message-ID: <20260111.485814f155b4@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-7-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110143300.71048-7-gnoack3000@gmail.com>

On Sat, Jan 10, 2026 at 03:33:00PM +0100, Günther Noack wrote:
> The access rights for UNIX domain socket lookups are grouped with the
> read-write rights in the sample tool.  Rationale: In the general case,
> any operations are possible through a UNIX domain socket, including
> data-mutating operations.

Sorry, I missed a part of the discussion in V1, which was suggested by
Tingmao Wang in [1]:

You are right, the new access rights should indeed become part of
ACCESS_FILE in the sample tool.  (When the sample tool is adding a
rule for a non-directory, it only applies access rights that are also
in ACCESS_FILE.)

Will add it in V3.

–Günther

[1] https://lore.kernel.org/all/423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org/
