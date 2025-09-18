Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721D1DF74F
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225080; cv=none; b=oSlc4OWHcvmAaos3Xlrx8fT5qGsl1zFOkqXujANZ1eNMuX8e0VhgP7hMLgftQvzNO3ba2nKQEp/AToZT0SAJVP1Se8mwdQXNbcE1ewSNQ0kstQpoFqZvCDQKZAtnvXaZHvv0d3pJNiVQ8rr64a893qTxfNCAudHrayGmlcJ58rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225080; c=relaxed/simple;
	bh=6syJdSpwOuKgxvfK6CJQXA1mo4R5z+GK0PPQjQL52Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU5YEoQd16e1hfvPFQNeEWOMhC1u51f8yWSmp+0RqKx13656NNBJV0ykUHKgqd4wIUFfOr4Bte890ls2gdYDwdtw6L9Rw4MKCbpcl9a267+xlINfPvLdCaVbF6h5VUQkdlqIOX/Z6NAVrwibDnU+cdU2J8/G+M0FnIt7MLanARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtlC/w5o; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtlC/w5o"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-82946485d12so123648285a.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758225076; x=1758829876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=qtlC/w5o7oqOt5KSb8eVYY1qgdu3W7fm5pAqzP3WjBB5U7exzjiIZcbYBt0mm2kOxZ
         OIOV3SMCZF5x+Clo7Oafwv8CnJbMP2DICBWQuuv4WUo4My17i5uejgr7oqOl31kV6inJ
         1lEps0ZL4zreN8RteZmoMCipGv2TFW4VokO7tHk2Y5pPOSWq7DvlVVsHfsN9hW12BxTQ
         Ing7kEhgkMvZPosbxf75UJWJjWBbLlfRwtDNQGabgqrvmjNfFwEyD9ivpQA91ZqHuUI0
         DR5pTEkkFys3awuuAmviJb5LI0z4KBQPjaVmX1vex08ieXfUDxD+8YpBIC6Eqm5luwTJ
         wvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225076; x=1758829876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=XLVgJ7/GX0dEuLXovdrFnUkc1qL3cJaxuuXgHr0OrYNP3Hy15+P1cG6d6N4k+zCTe/
         T55dYXv9O2Jfy+bqeKSXNqWza8f5TqsnD8vJYLjxqdoorYfALzpn256WvXyLEZP2NlXW
         ZvicMIi7z9gnxDB/jm0cNV1rKmwKTQ+hBZypmkWQagBanYFmEav0AWmbwAlQhqfznImX
         39sU9USWdnQRvZ3g9VjGFQU/wWw5Pcb0Lka7kK7CPKJ88rja6R9mAg+ENIXf10av0fAV
         k2K26UHypv9zun1sPIwYJQh1FvZRwIs6cscFCILJaViTIhPBZ+uRI5AGXnmprt4qqURV
         dkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqfrYMRRurE2CaJEZsT/cApyVbFgqyKdByYcUvyniF7OeKBfoYd6GRZQnj5NSDbTGYKcjV9z3/mAHLbaCo39KpA89w7DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/6kDQBeE5ZKKErSC6QYGLpNq2Ezqd+BAqqcqnpF2qEtVzj6g
	/vB8aOx98djrO+MnLnwgcDuAoVdnHnET83tBzoQOjIar0wNHOetSaV6AgPCgFMIHEvT+DeiBYAy
	3eK9cDXdKVySwZCAJJwqSzjgGMXvmKOOYNqCi9YCUiLuayMH64Q0cb6cw
X-Gm-Gg: ASbGnctQGo35L73Yu5AsQZ/B4QW3jPk8720hUaDMPSQC/xxFTO5vAtCyDGOzuhbeQDR
	vLrRbrTX4JNiMFEO7/TGslvAc96HYEgjiSb3yEDyQChtZwJsLgcnhqPCGWeGdoJ5q2ELHflaA7c
	pn0f5bWEL2tJ2HtOPtHR8Pq407OHe9XHprHYJ1FBLRcgt66FnDcuL1vkenLtS+4uXrf5pClZI8w
	7R/wICWsOe3gT/Em/tnp2nVp1bYcQkg0Nf4UoG9HqFgHtr5qVhR9pdLtj1a9WM=
X-Google-Smtp-Source: AGHT+IEBRicdafJf3u77ctjkGg0qQE01vvq76y8OfmUEZq9l+r7vlVJkRpkH6O+HQWrp9aS+8G9GRAXwfO+KbOCqR1U=
X-Received: by 2002:a05:620a:2615:b0:82b:15c2:509 with SMTP id
 af79cd13be357-83ba29b6776mr106004485a.1.1758225075919; Thu, 18 Sep 2025
 12:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825203223.629515-1-jarkko@kernel.org> <aMxV9fB0E72QQY2G@earth.li>
 <aMxZlHn9bfa5LGEU@kernel.org>
In-Reply-To: <aMxZlHn9bfa5LGEU@kernel.org>
From: Chris Fenner <cfenn@google.com>
Date: Thu, 18 Sep 2025 12:50:57 -0700
X-Gm-Features: AS18NWCj6f0C0cTQbPavL2yzofztQlVPZRuus3lDO36bJFzWpZEEGANZWXKMSrk
Message-ID: <CAMigqh2gJ+ALqxb8RcNFENJg-Z0FfKE2DZjaGdOER7G3AGZvKg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	stable@vger.kernel.or, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, the feature needs some work in order to provide meaningful
security value, and disabling it by default facilitates that work.

Reviewed-By: Chris Fenner <cfenn@google.com>

On Thu, Sep 18, 2025 at 12:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Thu, Sep 18, 2025 at 07:56:53PM +0100, Jonathan McDowell wrote:
> > On Mon, Aug 25, 2025 at 11:32:23PM +0300, Jarkko Sakkinen wrote:
> > > After reading all the feedback, right now disabling the TPM2_TCG_HMAC
> > > is the right call.
> > >
> > > Other views discussed:
> > >
> > > A. Having a kernel command-line parameter or refining the feature
> > >   otherwise. This goes to the area of improvements.  E.g., one
> > >   example is my own idea where the null key specific code would be
> > >   replaced with a persistent handle parameter (which can be
> > >   *unambigously* defined as part of attestation process when
> > >   done correctly).
> > >
> > > B. Removing the code. I don't buy this because that is same as saying
> > >   that HMAC encryption cannot work at all (if really nitpicking) in
> > >   any form. Also I disagree on the view that the feature could not
> > >   be refined to something more reasoable.
> > >
> > > Also, both A and B are worst options in terms of backporting.
> > >
> > > Thus, this is the best possible choice.
> >
> > I think this is reasonable; it's adding runtime overhead and not adding
> > enough benefit to be the default upstream.
>
> Yes, I think this is a balanced change. I agree what you say and at the
> same time this gives more space to refine it something usable. Right now
> it is much harder to tackle those issue, as it is part of the default
> config. By looking at things from this angle, the change is also
> benefical for the feature itself (in the long run).
>
> > Reviewed-By: Jonathan McDowell <noodles@earth.li>
>
> Thank you! I appreciate this and will append this to the commit.
>
> BR, Jarkko
