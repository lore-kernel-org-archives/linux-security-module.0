Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC443ACB
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118629; cv=none; b=tnRJq/x6wIQKw4nMKITAusb/J5LMf/gh+iKkI4S72ByDN+iGEUYmmLbZA+JaopMsxbdK2nLnrJcWiDZI22s3valJ9fMHah+QBeSq8FY/KXPUw7xgU2hmYp78eV6tAoa+uBIPbHqo35G3Rex4xSKdm8MlbCE2vkO59Ppb5EpjjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118629; c=relaxed/simple;
	bh=zP4ojaz1TRNYXZ10g7tnMYLlVkv8t3Oku0yyBwL84c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9roGmnNuz+ZrKpcin0ehrfL2OfIhiiUJlLDTExYshS53MqXGZbHm9Ve6IjTNQcdsRiiLnRiw6ZBWijzQLlTcAH6HmMnbvLQgEw7oazh90vPNdY9Df5HOARKCDFal8sJVBUOVv0ZbdnlaXA2nx1Z2E5exNwAOMUdn4HyXr5yv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8wOLpBD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8wOLpBD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso3707738276.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711118627; x=1711723427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r11gan0bux9CWlThl7OmOfAkmlVcnsFKZdnlUg7ZkdM=;
        b=C8wOLpBDHI0/ha4b+hqC/ZQgELEPSG81Z/gz4B0LY18l/wfqBMzGzovCrBu9+OgHSW
         p9BMPctTGflfpcCkLvyvF9W7zghvkCunZhCIZE/hJBhXikNmao1GgEoUH2pQ3wHOFgLZ
         QlsMs0rYEPfaRzGaojlEh08DCkq8nMlFFkEVog1euY/NMWJK2Ono+pWnGTIIQeQO3Xsm
         W2FHbmqNFODq6NeQkWyHQk6v5Ei9AI3k9BuSLXP5HN379rpf82Cin20cr5WFl3bDk/9Y
         M2VFwttSQuLoRBeRa28+fYA5oXYRpMux04B/6hjVTdyoukXr4FmbDurgVaEM7VCZnvTX
         tzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118627; x=1711723427;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r11gan0bux9CWlThl7OmOfAkmlVcnsFKZdnlUg7ZkdM=;
        b=MMy/xMmHjw0Lh1J781QuFMOAisFaEAQZWBRyetWjpqHlYE5K6P+5knWvh0E/zzVmrR
         g/srdbB/hV25KNCwqnpzi5NwV4uCj/Hp6tuZza5TVPSSyBiOFiwRCrm1ZTsyoqp6xSad
         tuKH1DT4fwpVL8TzJFxAOToAnqBOBLneY1wcS7+Nol/EyMCDryIBEM04FLh9xL+BM1qR
         MJleD/d2S+vKebHbfrrylqK8lDiDnltQKVzMwzX7QVBGsqsPkA/CT6H+YBNNGrdqgkQf
         DAp8esWoaBrFhG4mK00FVNo1JCuw6X3/xAkcTOlcz4JJK8Ukb1lOPTulM8VaSQvnZIrb
         68eg==
X-Gm-Message-State: AOJu0YzwFS96q1JjtflguKQSI9OW53oL0TEtatww8++i4yvu0oaZtwO3
	zvofKQEEjDqGXFg/GEuOB5aszbPtxtRsd2hjT7GwH5StXt5n6C77pE/Pk1P6/Zr5uO7s1r5rCLs
	yLA==
X-Google-Smtp-Source: AGHT+IGLZppWbArfkXBdhvSgEmcTQvFfeoLPhk/b30YHyJF0avO1RLKN77X2gh7WjLmtSVntcYuXPkU5OfU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2408:b0:dc6:e20f:80cb with SMTP id
 dr8-20020a056902240800b00dc6e20f80cbmr70099ybb.3.1711118627288; Fri, 22 Mar
 2024 07:43:47 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:43:45 +0100
In-Reply-To: <20240322.iZ1seigie0ia@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com> <20240309075320.160128-8-gnoack@google.com>
 <20240322.iZ1seigie0ia@digikod.net>
Message-ID: <Zf2ZITn3CXksmIM-@google.com>
Subject: Re: [PATCH v10 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 08:57:18AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sat, Mar 09, 2024 at 07:53:18AM +0000, G=C3=BCnther Noack wrote:
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index d991f44875bc..941e6f9702b7 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c

[...]

> > +/* For named UNIX domain sockets, no IOCTL restrictions apply. */
> > +TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> > +{

[...]

> > +	/* Sets up a client connection to it */
> > +	cli_un.sun_family =3D AF_UNIX;
> > +	snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s%ld", path,
> > +		 (long)getpid());
>=20
> I don't think it is useful to have a unique sun_path for a named unix
> socket, that's the purpose of naming it right?

Removed, well spotted!  I did not realize that I could omit that.

=E2=80=94G=C3=BCnther
