Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DA3D8115
	for <linux-security-module@vger.kernel.org>; Fri,  3 Apr 2026 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250885; cv=pass; b=f2XE5TqqQLuDSvSiQbboXpEVhwF0jUcJt1DY0cN4ECCraiNMWmLhTQYbjsxyAAS7yIRnfUGoFoHP7SlDN/5gFLoAHPkkgYUxcOJX93iDQW4gL+GntNzE13tTRvAYF4LpqIVRByHjfz00QJhLM9KQuYjxDmWw5+5xdzExp/hFpv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250885; c=relaxed/simple;
	bh=iNQ9qdRSCL3uUh77rSWYNovDUs8lKN7UfJ+q0K1jN/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gshVRYTtIp+6ieDGLfZ4+Aeke8IX9F5aDwh/oJmgIjL16hKsa3qEZ176rsOg/ovgdG6iPp3pHpeC5xg13x08Bh5DUlyJIE7LZwiGyZ2YZLV2yimS7lZhaQvNymjzBD5Urr9n2LkjapsgUeunlIxVSJe9N3l2vFOp9Aji5wSVcac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ie+RQjJA; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ie+RQjJA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b256a4c6b5so13252535ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 03 Apr 2026 14:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775250882; cv=none;
        d=google.com; s=arc-20240605;
        b=dqXfYPzx9NLdFnD5U1p3IGipftQzg7YXGmevO/7YJ8aPiBsndMcj1Rn+iHgwf/w3/7
         UkE4gqtKd2gTOwNZkNNITYysex2+kJ4M2hiuDDORLaWLSpycuO7Dp2BYdjNZn7jm+II2
         H6NDrkKsv9J+w4weElL6FmAPpOE7q6MNNUSzXCL2Ljkutlm1RbUlvhM53XJKefw9C6JA
         9oRVpRvwvEPUMgavhWKr7IXbWenmDmtLc6chuA8pbeyGA/nR8gNf8fn/9cazZ53cWGv6
         o/ZMf/9jTwaas+jR2TtQszk4YwP+9UEnlgbypoKMUe5XSA7oBwOWmsp5gihqt8TNkBAO
         sY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        fh=qqEvKvFMPGbjluH0yZMDTk4BF5Y1Ogn2rOw1Di2F/uY=;
        b=T/Bx2r4SLFhpqsWZeCqlW79VX8PkSFtZY6lPuRGZc+VsA/i3ZURiExbvNIPdIIi8qX
         4Fm0vy2Ed74hgF9+XHhZQxKuB1ZlE3EQv2q8a3NIAniwYqHDHNu6RyyFtMWwACoMiSgV
         1Kx16X9FMhyQdaeeXv19Jb4VZaHsLq0qvulhC979TzkaK5zZvRblWu9biRzzkTrNK4sP
         BiSr1wTlXRZNz9TYlUqaro9uigyDIpHfmEOsZVtIXK1IYoU9/qpk+4C3MLvCfYwR34PM
         cNjM0pX+psiRIrHpWHl4Sj6rJM5gcJd4m4Fkfnbezii1C8IsgaJa3EMSLmYRfu4hbBms
         wogg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775250882; x=1775855682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=Ie+RQjJAjFlwLmuajd1+bQFaYVKDGeETiNfVlqMIuyVr+Arbdhb582dBjLK1c8gUvz
         O7uOwOG2Cw8nmaHA4crKYPsQeFFt1DZfnmQ0vwRALKMdKAbfFqoj5zL3pkKOST/w9yf6
         0amZgjxpk4U21DzkcEx4K3iJ3dylBGnObQEqbb+gdlw9I0DjU/gYNG5wOmWfPz2S7tSn
         MXghGHq0GXeZsos9sS6A0Q4DNZYmfQvOgePBu2W4K9Bek+r2hA4PQqYUxRag/j+b5Cno
         k9dx5WSBP+5AzU49wkTMU1itGd7DEnC6/pxwDRHQoVuLkjvMZGk+VJJnmHLzYuz+PXJE
         H0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775250882; x=1775855682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ7m/t07ozBolMzvyENjzR1B2LhiH3tODVUDturdZZw=;
        b=BaatHwTxmkYFARv4H7LTDa+lpYHPl2V0JaLVKJI+e3LDxDJYJ+8deWZUtTH9BpeCUG
         QS6m63+Ia+ViqNbd3N5asjHqZXHJZdLkhdC0ZMceiQ0Ver9GuXiAjnsRwuQNCA744S9M
         baS7WJ8u+2g2QMle82Irkd46NuSDMO39SkdlfrwAi/t8E8L9tIxTVfKbN0S+W0h+LfHf
         puFpqb5N28eXX8plTnUCDq6Evo34jlaQZ3+N8n8xdil6yeZQ1Ys62/G91LVV7r5QcCHL
         x/dW0A5w2+UvM8rXF1Ppnygom5chTHDPmdIxZycN4+O2h5mLaYjLElSB0+OIfDED7RJK
         2n7A==
X-Gm-Message-State: AOJu0Yx3ubkHmp9bbSJ1Q4sNywaHjdnLZZ4JtKwbfc9NROskTL2vbUXD
	JLlfehDFO9w2pphDolBSOE1jLRHlVIQRsaCxXzoZen92vtumHjNcXKRXrG69WyQnPFnBM8i4RNG
	zEvJRkSLuibtWyCFRqTUvSEDHHGMlqiekVWpjPNi8
X-Gm-Gg: AeBDievZ22C2v5ewsSJgXPDm/hh+1MR6kgjKkFjEmITusXYCvhKUGGuP4a1xvYqdlNU
	Hdix6/8anXChFDRw2F9ykULlQoqP8IzqxznjmHNBDmHgk9Tq+pyM6OgLXKKxMfUtVIG1OtOQYeW
	76cXK8hd4jbP8+ERx/wMzHFhTeqe2vlHtCD06hCbQ1EjsS9TMn4GLMHhEGSpqjPGuIiZudRtCzi
	gW/34Fsuiop1PkqHeVfVSUEs1UZ8ykIBRDu4Y98GbIPNbqUV9TcTp6X0HEtFj54AxI6PDIEtbQ/
	AAZx+3Q=
X-Received: by 2002:a17:903:2ed0:b0:2b2:5091:1c26 with SMTP id
 d9443c01a7336-2b2816d8626mr47571725ad.22.1775250882586; Fri, 03 Apr 2026
 14:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-7-paul@paul-moore.com>
 <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgd1wo9U32L_sQLfswY93LRp4yPzkJvKtj=wDKi8h13gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Apr 2026 17:14:30 -0400
X-Gm-Features: AQROBzBl5cCyhzn_4rsiKSOgf99yuNguIB3BwaumzWCCJnTdkerDXkp2yfIst38
Message-ID: <CAHC9VhTyFJottNM-Reg8dGbU4T_gAG63oOQjwrOY0x=2sCLR4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 2:12=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
> On Fri, Apr 3, 2026 at 5:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created:
> >
> >  security_backing_file_alloc()
> >  security_backing_file_free()
> >  security_mmap_backing_file()
> >
> > The first two hooks are to manage the lifecycle of the LSM security blo=
b
> > in the backing_file struct, while the third provides a new mmap() acces=
s
> > control point for the underlying backing file.  It is also expected tha=
t
> > LSMs will likely want to update their security_file_mprotect() callback
> > to address issues with their mprotect() controls, but that does not
> > require a change to the security_file_mprotect() LSM hook.
> >
> > There are a three other small changes to support these new LSM hooks:
> > * Pass the user file associated with a backing file down to
> > alloc_empty_backing_file() so it can be included in the
> > security_backing_file_alloc() hook.
> > * Add getter and setter functions for the backing_file struct LSM blob
> > as the backing_file struct remains private to fs/file_table.c.
> > * Constify the file struct field in the LSM common_audit_data struct to
> > better support LSMs that need to pass a const file struct pointer into
> > the common LSM audit code.
> >
> > Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> > and supplying a fixup.
> >
> > Cc: stable@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-erofs@lists.ozlabs.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> That looks nicer.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks,
> Amir.

Thanks for refreshing your review.  Since we are at the end of -rc6,
it probably doesn't make much sense to put this in lsm/stable-7.0; I'm
going to merge this into lsm/dev which should give us at least one
week in linux-next before the v7.1 merge window opens.  If others want
to add their ACKs/Reviewed-by during that time, I'll update the
branch.

--=20
paul-moore.com
