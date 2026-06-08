Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAF3D8116
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939495; cv=pass; b=r0PFeV1TEKy+3DJAn9ShGkDiTkJ3jxznexpRHmPanWy+22KEJk8KJ/TsmBYl3LhZE+d46WzG6eeu+YsidJRL7ucIqmSKwNLt7nIs//Db6kZPcedRp1sdcW699dBkdRhpVU+c2ZYlSh3rR3jHFzNMuIlKnBbDPUrQ0qtq+qd9wNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939495; c=relaxed/simple;
	bh=7Kdsfq3M6NlEdFS2bnCUaBu5hUrHR4J7G1t7KNXfpvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku8vY1Xyp921TS4Yk77GU9oaYkHVGiT9ivHqpX5mJtGXK8cKjU4lcTjki4/T6+dL4AiK45t9DGGPs/eHICZcvh+ZyI/WoiY+dPDN3DKS5DwsBZFVf4o/MgzQSEaXzXhZ9WPMselfBEU1cVlPShA3cuSFPeA3/KoFrmWObV40XV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UjdtuYRP; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UjdtuYRP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c2a68d01so31347695ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jun 2026 10:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939493; cv=none;
        d=google.com; s=arc-20240605;
        b=i3CbfS3pgR0RS559e/1Mkr9bkx8mumABQfHS1aRrghx2dI+xCT6PJtUQmy12m87tss
         uC0UYCrtei8KWrVXO8CAqthvEjQJ6sBPgYYBugDXkObwTWx340ssGzHzbjcrp0VXtanU
         A3LkN+PWvFQu6aYNGUlhpNOyHWaxpFcljVLGc/1cwnQ1RLqmgipPj0OFCpHTF4T89MF/
         FD6w+TqPAoHXe2W9f7BmVoDmqoRRyXIkgUvlhPJjxB77GbbYub2U9ACplxWpuGJOcsS2
         yogUolawBXdtMg1c5CyIZ7Eo4laHWqo8Qt0xWjI90V6J//40+8PF/tKx3huSlg+I9GuD
         Xr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        fh=YY2LRGZna3qyl248s+ZGJIZnzbMQdqfbVFQCu8D/nk0=;
        b=TYXtGGz6dul1hzC1evepDepWnJOHBR4BrDQITlt2oaMdw1FVvkOOIGJQROqRc1aN/v
         kitfp0rnTEKgWSivjocSRYGaONOs+IUg2SKBiGDmao10MSyi3EQZhELjMW+jewxgLa7n
         z4uoyysDPDBdpgTwZ7LpTT5+3VIO27to4YeIC/6FFFF3wVH6YEZ4oeK0WSWygX0lMmHH
         LEG84Ql2zrudc7g+dNYbqJuVVC7CSWEJgADPabHWggJJfkdTRJRJIWscOSgojGuwmVDl
         Suno3uingA89TvR29+KzaGpr7YMYyh1txyZ85wjeVSizqOyH9263uXdi38cIUfidXLNz
         uvNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780939493; x=1781544293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        b=UjdtuYRPGjEVXBKOpyPMtogry1A7fN8YZtfbTK0gMFZyn052WbGsC1pBoKedD7hRXy
         WQe1hi3y2V+lYX/brFW3Q3036PAvrM8VGaWqWeYNhedRyX2JaHVm/iBlrNX4vCrDDo1J
         A298VqNwayOkk/IyTcOW4e8D0szLstksa3Qwhx4Q1AJ0nBGr4V0E4ZOOTSfMmckA7fiS
         bOJ8CDik94EWq6aaUjjcR2i8vToW4eEIN/sCP6fHLH1/3JKJh0b792s26XjVgFyLvLrn
         nNbjYXCVkGOQesztAdcYDYUF5f+DjDs1hPghtp8F9ZEbSxTq8Csez3nIGfKhO/2etamo
         Vd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939493; x=1781544293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        b=k2tElq5LjGiK8pTYLnm2ZoZCEYUDsvDO767Oa4U2zNF19dchJ6qNIpHuBpBpeuSxw5
         N0BanXAmPIIqwkBqFApmlJKXLUCPkrxXwWSYV2PzwSvpe2GFlICNe7J+htI7eQAoL8xu
         ib1GHQRRXM4N6NgPUR0mFO8y1wzNRsu9Tc6KnuJWletufILDw3032dzMuw8Cp27KSFJk
         e3KMsNsffewhxHMsugYSrda3cQZc1HUlTY5ZQPGOjVWbVd/gY9jhsOdQtdQtcSVRx2Wo
         8fMMDJXJl2NgPJIDBkaoj2RfeOtCvtaWkJjpTAH6+5E8S4sOUw9m0UHD+QUhum02G89Q
         kCJw==
X-Forwarded-Encrypted: i=1; AFNElJ+IDlI3YrqX5Syu03ptVbXxbE4DJWAq5RQ07O00OWsWIvQwdtgUwsPtjwNxVNhVZgIGgtqSEoeU8ZKmymS8KnUl7mQBiqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mScUN5+SZgzsqmp98HOmXiLNVgkJRtv/70Dq+ZzcnQGncm3Z
	YAIJmDrq+eTJU2zxcvCBTSPUR2kZ6F3ZvR7MnVw2qTvu5YzcrPtySu6FqmJ3VWpFYiUWjZD8dNA
	SDUFFQn6g4W2rZC/i+OeC5r6RfgMmpjdV+2iEVuGd
X-Gm-Gg: Acq92OFsgpWs/cSZRNSVCcXWIFALxusNQvDDluTdVC5uzDW0hNr38F0Br9+/42AkNSs
	Ze0Zh9hw55rwJliOx1FnfF8lo42GEmmrmwvyGnUYotzgJAKEsvd3x3Wp3pMDNns+zAuQ7xtWeA2
	CIgZF/zq2LhuB7k9RerbQ56agktEnEGx+ZaGXlr7xTwAXZfHZ3ne/0Q9zUR0AjWhtR2CI2YvD3i
	+jI8L4F7jp0gyPmyQscrmULErpiynE8STg1zIZLgixJ3CxpWIhEpeAuNuXgfKZrjBSVtCN+Dtfc
	X3/cl5JbPakRoIN6utkV9LFbncc0
X-Received: by 2002:a17:902:e88f:b0:2b0:b016:773f with SMTP id
 d9443c01a7336-2c1e7d3dba7mr185086165ad.11.1780939492837; Mon, 08 Jun 2026
 10:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605144325.434436-1-yeoreum.yun@arm.com> <20260605144325.434436-2-yeoreum.yun@arm.com>
 <9b499a2a3101cadcfdcd6fc32289f54df10fea80.camel@linux.ibm.com>
In-Reply-To: <9b499a2a3101cadcfdcd6fc32289f54df10fea80.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jun 2026 13:24:40 -0400
X-Gm-Features: AVVi8Cc6U7pcPpqOawvLTIEb90w3WN1G1z-dXh4nwGP7pqUP53pA_Sp10Oyc5n4
Message-ID: <CAHC9VhTN5xwBb6QFKeon-X1Px3AWesvPeyBEbebVQt1FLbtCdQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org, 
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:52=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-06-05 at 15:43 +0100, Yeoreum Yun wrote:
> > There are situations where LSMs have dependencies that might mean they
> > want to be initialised later in the boot process, to ensure those
> > dependencies are available. In particular there are some TPM setups (Ar=
m
> > FF-A devices, SPI attached TPMs) required by IMA which are not
> > guaranteed to be initialised for regular initcall_late.
> >
> > Add an initcall_late_sync option that can be used in these situations.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>
> Cc: Paul Moore <paul@paul-moore.com>
>
> Jarkko has already queued 4/4.  Paul, can we get an Ack from you?

It's in my queue, but with the merge window opening next week, this is
definitely not suitable for the upcoming merge window, so it's not
near the top of my review list.

--=20
paul-moore.com
