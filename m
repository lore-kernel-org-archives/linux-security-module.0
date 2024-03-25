Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46F74E3A
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376904; cv=none; b=D6E8M0Vd3OuCthbp/y4fwCkV8FNraUSDR10k4e4IawOleDZvyd4Ne/MH6lfxC49MRGdNEJy8WjMwNjflocp9sltTTozTyEsIYXt9KkE+16CH1B2zgBXcJQtnVRVu7nrUKNbg2na8lKhk6pJRMqP9VRYVsu9OE/85BR9qqhtU67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376904; c=relaxed/simple;
	bh=aT9L4s68iwSf86wxyvTDWmw0CpDA+2Zmc3akSVJlkp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoGcd4VTVzqwuYk3HJoMhG24qzew9sC28KQJVB2KiCjmgBPP9WftTWN0QjgDYz0N74qdUkpXmbbRhDYj2dxVD55AY1JBGn3xkRn47UnhfZ++LeNTbPbwfc4D4QcrHznZT2MfX9dNVdGHgjGW/zV1ChXEgeMPqhVzaF7irgtS0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e03OdyVN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e03OdyVN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso80579837b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711376902; x=1711981702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm3sG16QJNbWH1s2j0TGqj22cMhqH+vJ/EV7YKBbovg=;
        b=e03OdyVN9NZ3PYjCq5OB6WQm7PqbPRXWKRjVnq+2m+aI0vJSm3ZkAUdoR0wPfT4RdR
         7AeeFDSPlsgBC56jIeIqcLBwFF8H+xbabD/eWTYuLFUv+5NdcLrQCnXX9zHwT0j87v3K
         E8zfwmPyaWI1nuBCa0il/lPnq7xQlaY1evS0KZnMqIptVP9LbFpHQjikPjdG9/xZmGhr
         pmuAL6LtW4qy6qaEP+cPPTyhlkAfHTKYXliFlg77R+OS6r08rYxZEwLY4OWNv0uwNRYR
         +yIuiPR3HSAOwRpiNx/9Mm8gI5gSUJSZrVPmnKJ6gesMckUhIF5Se5GEmSQwYCMHE0xW
         uyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376902; x=1711981702;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zm3sG16QJNbWH1s2j0TGqj22cMhqH+vJ/EV7YKBbovg=;
        b=Xcswdj2M1HNu0kW7qc2XA5OAUIOaTuVEPV62y/LpqUxmh0T802pfApSjJaOwZxOsQh
         KQGT61KSp9xvLqssWUR86gxxiJkyEZ2df0SP0PdV0DpWh5LfLB2JmsV3+BNPy2vsVA65
         R1Np1Xo6HNxS6h8slKbPVjN7lX5xDlxeX7ZDYtag5mYWnA0/yjXwOmQLwtzjtbWOJYDP
         ifj506JBPMEQUDtgJrJCWPCl0jrXUUWEnCiqO+FwYatKH0/oCSiJ2yj1CvnpebEufEmF
         LQxmtFTqMRIgz4TIva+Y0RC/DazKnQyOPIM8UdhooRI4s/7XvWT8BqPA7ZMpCkck12+j
         siIg==
X-Gm-Message-State: AOJu0YxohELX0jg2xAD8bpuOjCil2GT3Owphcc8vEgXlCjzri4Qf1JEE
	tIXMAQluPlwTK9xrj4zRdqwmKaaPBDWT1XH73gXH8tgJMhb9532ZTWKO/SYMxEistGgcXg5QRTp
	RdpSZntfd7me7cAZyY07HUhnkfRgNx1C4LTKQmbmr9V2E5ypGkHR9Fk63tMZeth0PKHVUD+jDKl
	Gfo1BmlqYslAY1mDZ9zhnQvBkgVROXy9g4rZHyPYl1DgexrwkX5yuN
X-Google-Smtp-Source: AGHT+IFFIFlaGCUmEPhF867dqzxn4ErHTmd7pxZqWvXRYn3djCZ9hoUd4E+q7VHL1UI7QjcRlP5Mz94QgH4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6d09:b0:611:9268:b63a with SMTP id
 iv9-20020a05690c6d0900b006119268b63amr474258ywb.9.1711376902084; Mon, 25 Mar
 2024 07:28:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 15:28:19 +0100
In-Reply-To: <20240325134004.4074874-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com> <20240325134004.4074874-2-gnoack@google.com>
Message-ID: <ZgGKA4b3MxsmLTE0@google.com>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 01:39:56PM +0000, G=C3=BCnther Noack wrote:
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..b769dc888d07 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -248,6 +248,12 @@ static const char * const kernel_load_data_str[] =3D=
 {
>  	__kernel_read_file_id(__data_id_stringify)
>  };
> =20
> +/*
> + * Returned by security_file_ioctl and security_file_ioctl_compat to ind=
icate
> + * that the IOCTL request may not be dispatched to the file's f_ops IOCT=
L impl.
> + */
> +#define ENOFILEOPS 532

FYI, the thinking here was:

* I could not find an existing error code that seemed to have a similar mea=
ning,
  which we could reuse.
* At the same time, the meaning of this error code is so special that the a=
pproach
  of adding it to kernel-private codes in include/linux/errno.h also seemed=
 wrong.
* The number 532 is just one higher than the highest code in include/linux/=
errno.h

Suggestions welcome :)

=E2=80=94G=C3=BCnther
