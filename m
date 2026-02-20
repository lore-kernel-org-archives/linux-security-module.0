Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0F2EC09B
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607059; cv=none; b=BNywCvXV8PJ+UVlJtCOozIEVBl1so2y0lWG4x6iuDSrWvfKsulQ030SGUU1K0V9gPH6Ntnruz33ObGkSDLQGA22iY5clu1410GZa0tu7TraHtOHdZ06SQ0xIWIjEvQXaN0nBJ5DJTojeTSKHhKiK3/YdjKq1KKnSR5z4psBmjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607059; c=relaxed/simple;
	bh=mVGMzlBp/zKS2WuyHj4fPueFbM857Q0+D3SHuBAhBjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5ZajYtZl8zaedmLp6SBENSiSdG9C41wn/w/Qw+eNwDXKXbgDUpHWdSyYetzbAzuUIDjpFj4Gx92nrnypKSp0sTPxXSzn9q0UJLKiAMORDxWIwU3eUYdAEnTYmqyi+eTH8ZRP8auQXBNdgHMGC2tah71Cl4VJW8PPNlDEUTFTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfLtBkcX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfLtBkcX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fa449e618so370004266b.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771607057; x=1772211857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/5e9TDGtwgKfqRsbZxRhZr0cNvciiHHpo2k9qkGPDs=;
        b=BfLtBkcX5tQZqeDJxFP0cCTNWoWS5A94jz6wO1iaWDY8eDY+L0LrvewG9wBg6bCjOW
         yMx9Kg3jQXe8JR1+v7nuGqcj8+CdSD5qY4ps0ROCm1bwccfSFamAccV5ilT7wDlDEPRy
         oSxObUbCziJXf+0EIiH2k+OV6gAbNqn8pgUC51cJIwzUm58tu/V/eHF3co8KseQFafcB
         feuOwGY++jaAiUSeXRF9D/QM8i8A3jqBoQ74o4A+NFzQjBwBMtN7RusOlMCgdyyLrArm
         dMALdIDWYK6DeMBsL5KgZ9ltqovgzFZOjG65B6sfKFUlNaJE6IgySREJoqYnluYGQtsO
         hPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607057; x=1772211857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/5e9TDGtwgKfqRsbZxRhZr0cNvciiHHpo2k9qkGPDs=;
        b=DgMtVk9dK5PGllb2Q3QxuavnC+cg+qDMnnRQcd676EZzjGzhIfFReAJ8W2bV350uRi
         O7m2H3fp7DwzGuOIqqD+oegYNSF5XCl2+TR24QIkw9s58V20jAB7VYhURVLbA8/upH+b
         Z8uq9UxLOa2Edutj+LJvUnAXJ5ytTcxGxqgHH9RaS+2avMeR/Hy8Y2I4DVsD/schZX2a
         /HRhdF+sbbbWrtM5DqJfAPD+mj5COBphAGusM7KJ23t+2wjld7vgxd+yc2HPW5fNs2Rn
         ETeXFyYZ1Hv/PS+yT4HDmd5p9n8Eh4/A7kpYYNq9CGmb4diYkrw6YdMh8GJ1P0Cf4zeR
         cbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgSlWiUvLRXblVcUWEyi1KAlTf2ylp/4/zchRR+nkHjVn7kJwmkf7F4vQX8b5QaVXlIPqTLdSCTsGMYPWDapViaNGT60M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2Hb4/+ufIK5bpZaIsrrohN/vvtNqOuuq2qpXSbT0FAmLxc/s
	GNjTKjqQUbFOJfnoj7X+9HqfZu7KKSwsjmNb0HhW2QBE6N6EaPSMkPBe
X-Gm-Gg: AZuq6aJwXIYjkZ/hU1cLmFR3BV9mqFP2Jb8+BTZY2eRpRcWES9/MyS3FE2mH+HFyjp3
	tE0D33UVR/5e0GJQHNynTLGXNH3ZOCU5rtwpBnxAxtt5XgRrJb0O2i4vAPS3I+NFf6dagJKS//t
	ufxwiHhwAeKHb5Z/J8tPy1hrCDU8UF0rzUXhi0CSU33vm3LI4OoTVi/ot95RW/VGPDBAzTc7ytm
	TNU1DavuBxyqwPG31FVIGQniUbizLMby0jmXDu/cq4B3gLeXvLYZj1pK9uLx3wpxpAFJhp6qq3h
	HRzbMDcbj5TZ2HVPyZoGscMY+E0BnP7HOeodjyvm3PunC0XErmir5iqC2NI2x+07To6jWEQKHCr
	P7iUtkc8Z3TlWhOQo3ZkEj3O6SaKaMVn0+4tCFlMAaCNzFGA0H5cm/iX/f5oLohwTYlNzSCDNf5
	6uQ2zCvULuwlRg2Hg+41RfcTaTMqzDLyQEajCKjPFa76zsP1dF
X-Received: by 2002:a17:907:e105:b0:b8e:d04e:e510 with SMTP id a640c23a62f3a-b9081bd4308mr7906866b.55.1771607056463;
        Fri, 20 Feb 2026 09:04:16 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7663d30sm696433366b.49.2026.02.20.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:04:16 -0800 (PST)
Date: Fri, 20 Feb 2026 18:04:11 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 4/9] landlock/selftests: Test
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260220.4219f24e3894@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-5-gnoack3000@gmail.com>
 <20260218.aser1cu7Aewi@digikod.net>
 <20260220.5f431119d04a@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220.5f431119d04a@gnoack.org>

On Fri, Feb 20, 2026 at 05:27:52PM +0100, Günther Noack wrote:
> On Wed, Feb 18, 2026 at 08:11:26PM +0100, Mickaël Salaün wrote:
> > On Sun, Feb 15, 2026 at 11:51:52AM +0100, Günther Noack wrote:
> > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > +++ b/tools/testing/selftests/landlock/fs_test.c
> 
> > > +	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> > 
> > fs_test.c: In function ‘set_up_named_unix_server’:
> > fs_test.c:4125:9: error: ‘strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
> >  4125 |         strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > We should also ASSERT the result to make sure path's length is not too big.
> 
> Fair enough, will do, because it's less confusing.
> 
> (FWIW though, I think Linux can technically deal with a sun_path that
> does not end in a NUL byte. See the long comment in unix_mkname_bsd().
> But that's a Linux peculiarity.)

FYI, before the question comes up why I didn't use strscpy: We don't
have that library in these userspace tests, so it is now:

	struct sockaddr_un addr = {
        	.sun_family = AF_UNIX,
        };

	ASSERT_LT(strlen(path), sizeof(addr.sun_path));
	strncpy(addr.sun_path, path, sizeof(addr.sun_path)-1);

–Günther
