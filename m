Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7B1E52A
	for <linux-security-module@vger.kernel.org>; Fri,  7 Jun 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775253; cv=none; b=lyt9JBSVC/6rO3KrZ3hgDKsEuwMEiNaHRr+QJsWcJOzJ1UKSdy6W+EwMPH3jQ1xVazKUSTsph7l+bgJwPDJMe2v0h6aVbq8SFSGI2O6c3hdWx1+zjjgZAelol3ulPod8WDjwmnjR9cAkYLhjKfy5TWD5Tp4w7+rIZP7u1OYJcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775253; c=relaxed/simple;
	bh=CShtKqBAKVaWF2SeSkDUPmUqFbx6AeJcpaTZSt41drk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxAJIKBytCRtu7HncgjDu+AX2EDlo30VTRZkfKxtunI+da5hATXXA4ECnIe+4qJD3DBbVubjThsac3tUNHr9ab/6CUcntjkENlIvDFYrVSGrY3yEVMshn/RvZwGPwoZE3MAEL1QJTTJYwUpmj2vV9pSUYzTvYaznJnBTnT/usJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhOz2Nwt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhOz2Nwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717775249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQCecZL5TMRFpvq7f1WP4hnKckjUHkKLcuYm0ceE7N4=;
	b=VhOz2Nwt/nSs13/WcyNfN5J+dGAuZet+O4ROGthaetGPFXM2WOoT5Ul5C+yl7BWwvBD6FI
	ODLXJ9iU9CBDdbM6nlWcW/i4s3jLIMipg07+GI6nLaGNtfZF4foyFymOVoe7Rt2iSoZCoQ
	MQVK/37pUu23h4RHSI06SkkkxS6g0vY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-8nr0zMWeOeO2jaj8nywuoA-1; Fri, 07 Jun 2024 11:47:22 -0400
X-MC-Unique: 8nr0zMWeOeO2jaj8nywuoA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1aefa2d9bso2154470a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2024 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775241; x=1718380041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQCecZL5TMRFpvq7f1WP4hnKckjUHkKLcuYm0ceE7N4=;
        b=VOSE1A+mf1UXxYLS5DAPgAoHcd1TtK2YIOY1to3dKk8K87bXdNv+xdbX1qepNKq+yD
         gfXP6O82TtOGVUlT0C7//YCsZT6oFK8WM+cdVRqfKT8b9G04SmZcn8H+jEnYLItdwGDR
         +4dnkq5CFGcenZ4kxBZ7RvSvivHthigSuzG47QxDZvm6wcoBFXSWifEsUlNiwfkRB4nl
         EN9wTO9gJ1e84QVezCVlpB/HZ//kO1QGslay5tV7DzAzrYoBEs0KJe58GpB1WwOpSzvJ
         pSvhrwmwrrXZ5gsn3DDrL6Rj8ejslKgLb7Y550Srie3Nz+5015XeH1TLLq+9JZlNdXit
         Wu9A==
X-Forwarded-Encrypted: i=1; AJvYcCVuKcmE8Xa4ePeaE6+ADW56zGawDaekJzfuinNA0aUWvgVR/UYBuANOBF4c4DqWrXykWdWudAgqBcQIo5LeuabAEicOXGzhefx0/krlc/TE4TAr+b8A
X-Gm-Message-State: AOJu0Yz05GxyzVHQ6Pdg5+SoWJQf8VX+MMECuNvaxZoMb4YQnfVPHhma
	eZbkt1oCyfLh9iYPl/D/vRkovJbX86HV8JPu8PeNgrfmqRRQXonwB58bzE366Ae2JjgN7/qCSVB
	SEXQC2rC/Ab80Qza0JlB/cth7xgDujhXI2wr6VknHYCkm4k8jOhlDFW5H7DgcAuyTAn2a/QIfXo
	EG/BIEGIAVqJscS8Nn7EusOM9b2u9wFsO3dXw9JVM6k9yuT0ii
X-Received: by 2002:a17:90a:6541:b0:2c2:cfca:df5f with SMTP id 98e67ed59e1d1-2c2cfcae024mr1132776a91.36.1717775240977;
        Fri, 07 Jun 2024 08:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb87vcx2eefUnVvWfHkTcqB7wwLwFgHZRIdJn6Vi02LfBGmajNAAbYALuj51i52HcSdJLAdGZG0Iuqrxx7q7c=
X-Received: by 2002:a17:90a:6541:b0:2c2:cfca:df5f with SMTP id
 98e67ed59e1d1-2c2cfcae024mr1132740a91.36.1717775240258; Fri, 07 Jun 2024
 08:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
 <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
 <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com> <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com>
In-Reply-To: <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 7 Jun 2024 17:47:08 +0200
Message-ID: <CAFqZXNsy86uN0J41HOhjH_Rq-WRU2DVzhbJOx3xtxtB5PbwFFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, May 14, 2024 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > I tried to test what you describe - hopefully I got close enough:
> >
> > My test setup has 3 VMs (running Fedora 39 from the stock qcow2 image)
> > A, B, and R, connected via separate links as A <--> R <--> B, where R
> > acts as a router between A and B (net.ipv4.ip_forward is set to 1 on
> > R, and the appropriate routes are set on A, B, R).
> >
> > The A <--> R link has subnet 10.123.123.0/24, A having address
> > 10.123.123.2 and R having 10.123.123.1.
> > The B <--> R link has subnet 10.123.124.0/24, B having address
> > 10.123.124.2 and R having 10.123.124.1.
> >
> > The links are implemented as GRE tunnels over the main network that is
> > shared between the VMs.
> >
> > Netlabel configuration on A:
> > netlabelctl cipsov4 add pass doi:16 tags:5
> > netlabelctl map del default
> > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > netlabelctl map add default address:::/0 protocol:unlbl
> > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
> > netlabelctl map add default address:10.123.124.0/24 protocol:cipsov4,16
> >
> > Netlabel configuration on R:
> > netlabelctl cipsov4 add pass doi:16 tags:5
> > netlabelctl map del default
> > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > netlabelctl map add default address:::/0 protocol:unlbl
> > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
> >
> > B has no netlabel configured.
> >
> > (I.e. A tries to send CIPSO-labeled packets to B, but R treats the
> > 10.123.124.0/24 network as unlabeled, so should strip/add the CIPSO
> > label when forwarding between A and B.)
> >
> > A basic TCP connection worked just fine in both directions with and
> > without these patches applied (I installed the patched kernel on all
> > machines, though it should only matter on machine R). I ignored the
> > actual labels/CIPSO content - i.e. I didn't change the default SELinux
> > policy and put SELinux into permissive mode on machines A and R.
> >
> > Capturing the packets on R showed the following IP option content
> > without the patches:
> > A -> R: CIPSO
> > R -> B: NOPs
> > B -> R: (empty)
> > R -> A: CIPSO
> >
> > With the patches this changed to:
> > A -> R: CIPSO
> > R -> B: (empty)
> > B -> R: (empty)
> > R -> A: CIPSO
> >
> > Is this convincing enough or do you have different scenarios in mind?
>
> Thanks for verifying your patch, the methodology looks good to me, but
> as I mentioned in my previous email I would feel much better if you
> verified this with a different client OS/stack.  Do you have access to
> Windows/MacOS/BSD/non-Linux system you could use in place of B in your
> test above?

I don't think I can easily plug that into the framework I used for the
testing (there doesn't seem to be a convenient way to install a
FreeBSD VM without manual interaction and the rest is proprietary).

I still don't quite understand what exactly you expect to break under
that scenario and why - could you elaborate on that? If anything, I'd
expect the IP header growing along the path (which already happens
pretty much by design in the opposite direction) to be more likely to
cause an issue.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

