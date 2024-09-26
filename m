Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7F29D19
	for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357060; cv=none; b=jHKFudGE0IH0VlF1Ojc46vHNlniDBQ/ARGf7td+ImWauHY6soCSSQw0vnfqPs07hxnklG55m2p7j3a2L2lUAe2Z274B8WyrBdr6c+jZ6ia6kIWEdXPN5/+ZoqzzGPfswAx9iPh/yH6cX95w9eCzQ2F+qBDrUAqgJPDNnY4dyNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357060; c=relaxed/simple;
	bh=6j+mzlnWAWJV5uPHlCprLTX12kVXn1FsJRVXPyosNkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4lMBNxR+IFPqk5p0fg0qzSVSss4MOnnpQ6EGV+n20CkeApmOYq5NSaLTvrTIM8Wn8XkrC19r0gCTXKY13EdUY440ZOvllq0UR3fm+qkSJHanHiIZbjpacMyhQSzfe0UHgTM77QpNYhdwfq33phdsbbtbh37sYlCxfaUPfNK/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PSK/enni; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PSK/enni"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso908954276.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727357057; x=1727961857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaR+IYkh+EyQ3fyb3HT8rJF4x0m/bFBnBjNuJ/zZ6Uk=;
        b=PSK/enniRvSdNGtYtS2EHLPxHPPDqMEEdNXz9+9pvcIHUzry7E2Dw+GCf0SMBBh/Ia
         0lkO5/C+4RpSbwGzJpv5HCBP3UZ0bKS6pWihmfNFlTlkFNe53MVfKnAi01AkDOs0Luna
         fx7KOLCus1eiIubpMMIXXyN5iQsoMCfrI07MdLeQC31w6xTIUo8QGZm8AUHjrk5s5a3M
         JkSsfVuMxMpBn+PvQKWSM0hpm3DL3tr6eaLOU9D/Jnm87gOHQXCVg38WveOsqhNeQ4Ri
         UWVxxecir75wJmqAviL8rpLhRT5hvQRvETZ9dDivzp1fIEws8P0W1HT0ac25RkHzYKx8
         EGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727357057; x=1727961857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaR+IYkh+EyQ3fyb3HT8rJF4x0m/bFBnBjNuJ/zZ6Uk=;
        b=fh/w1HLAU08Thn60BDs99JvS6uxEQciCBmgp3bXfMGqn6fpT8NHV3QZyc2OmSh8b0G
         EsEVgPCOtQbHz+D20py8FBOvAq9FI8+Jp4VBT4zMzQkIpobyfNkDWqISNIbFNxlX0Rhr
         E00WGK8LVBodQ96OJwOWfXSCVXFd0SjVCVeOzlp/ZoRbwMbBbO2aVsysa+VpHzBcE2TL
         +I4iTkPB66W/HWDgubcEU8YwLDi3BRNGD/nwb05wOit8Qq7hLGZESmuOA4IZNYAjsQEz
         CjaIOxgwZK4WTroFHWuMWNfiAjemvc6A2uHqAsgSLrPnxKCFY/bG4/+c7xr9T+XE4Frv
         Rxdg==
X-Forwarded-Encrypted: i=1; AJvYcCXUSXhlVQOIEirlhuXO0ZCx0NuMYgXUOgX8DQ9EcV4iUZeNIF26GgPKrw7BG7nqpzNF4MrxWqcJovxsV1zXWqywiumrNCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLsdlFzuhmaxF73G9xVI6XkBUbgOes7gsMeHIFtgaIqTu5+e3B
	m6dssqrcPcb8RmkOWZrvDpe5L5+FygK6EC2vJ7jheF0xa31mRC4bPkCLmt28PlFHNJG++Y0v81e
	V2UwrhR4GzQeFtobo+9TNzOJRPY0E8iWz0yZO+Asq8Rb4uWY=
X-Google-Smtp-Source: AGHT+IGak9TZqcajKgGgL29wpoQ2d12+IkKhxbz3DewK9FjrSiQ3CXdUuHntAM4Q7cuRIhTGZ/+DPCZ/ynlsqSUs60I=
X-Received: by 2002:a05:6902:2b03:b0:e1a:82d3:b59f with SMTP id
 3f1490d57ef6-e24d78234cemr5415186276.6.1727357056745; Thu, 26 Sep 2024
 06:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925192018.15290-2-paul@paul-moore.com> <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com> <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
 <20240926132251.GB683524@mail.hallyn.com>
In-Reply-To: <20240926132251.GB683524@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Sep 2024 09:24:06 -0400
Message-ID: <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:22=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> > On Thu, Sep 26, 2024 at 9:11=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > > > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > > > The cap_mmap_file() LSM callback returns the default value for th=
e
> > > > > security_mmap_file() LSM hook and can be safely removed.
> > > > >
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > Thanks Serge.  Any interest in pulling this via the capabilities tree
> > or would you prefer I take this via the LSM tree?
>
> Oh, jinkeys - I guess should take it through the capabilities tree if
> only to check that it still works!

 :)

Sounds good, if you change your mind let me know and I'll pick this up.

--=20
paul-moore.com
