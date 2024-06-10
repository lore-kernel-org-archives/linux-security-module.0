Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C913F437
	for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032507; cv=none; b=iWJ7lzsWPsib9qFfhUMMDzUlF7yBXHU1pCcnrMnKacUY1m0cPG2udzVXAZGfnuE/lnPcBKbYuGhYMLXREpu4+3XzEbDLhg7oLah4rKpGvL1XAbwwnlMNpprRRWqH0g4VclTZpxgjJEb9cD63hLsx1AjtAHaBj2cVYXVcNG9bLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032507; c=relaxed/simple;
	bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRxeQuSvGf+ajjwPsUhJNlSOCL7SxjEWzNs0K6g1VYkPUFgzSgTwxEHWfOArV1sDC/s5QDZ24MoROua6ytptVFc9pl/dRYGIOR98O9v20RIwzyNSlNneJOOJ3SR0ous2H3svg2qt9HNZrVQXRzQkLZwC4d09x9sMi8++TCCkLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik9VoJlz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik9VoJlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718032505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
	b=Ik9VoJlzyTFHRyo4PcyyeHhojR530wZEO7bktzxgWXvMcMCwh70eMKKYDXjc2+pae1hm1v
	fDHNrT1uCaVp1cwAaYvfUctf89kwOeNPrcDvOmzNkVkjLi2q3qtGCCTdASJe1If6oWb4S/
	7yNS9vKGsxD9xeLW9b8PU/LGuEFwzyI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-EzNYx6SjPZuQ385CPrBgxw-1; Mon, 10 Jun 2024 11:15:04 -0400
X-MC-Unique: EzNYx6SjPZuQ385CPrBgxw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2d0e695d7so2662006a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 08:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032502; x=1718637302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKsQCqfN1ZQ4o2Ioge7OKkX52qONyWXvxqNAfzQqFbs=;
        b=lJxv7JF/6zpN2WodOxpnKCfiNFW0EbgTZixE/djCb3DXaanSH6VduCYHu7e+CDV34Z
         tX30Y7GYMufceq3gndDX8S3ppcInKbseKmujQFQZlb/fFRwutycVaaeSzdSZwYKTvpVh
         avXIVYvZcPMxuV6wWJGG7FOutMeYe8i+A/c2GbbBU0D1K77BN0OcBOecdOdQGkiZpgf2
         3fBWH2lvmJmMjbPBV40AFiV65tvCHl2ALb84FueDS+i1IeIJcVNAQR1A9wLByX1LIpYr
         lj7vhyMW6lYJPWt1NHo2BBA4hup3cX+Wv5TGJaf6HNxX+moaJGxHWpqyoTdWkBJB9GF8
         cl7g==
X-Forwarded-Encrypted: i=1; AJvYcCURP56PlMgyV83VAt0zf9hp7Ns3FRAl69TrTpI0NSKjNhd7RbR71L5GHPIEi0QvNTe7yNkQKVki8E+578BDfNpFHlSwxgdlJHYgsRXjwaAO04eVeT1F
X-Gm-Message-State: AOJu0YwtF+XvcIUKfRBpfxhlWEnguVJxAoQr6lQUFipqBVSqDrtOqBBq
	5eRBNcOdnX0ap9OXpYbqLu2RN+8z06w8ffY4HXSaa31MnTcXn7r1hDIhEUgZwelR2u8mztHLorV
	O9LFHMlS4MNMGnY+oFqxrKES3dvtD4RDF+7AfR+4rk5cX9oTMb27rSok7N6d/mt2UAa0VsPBjfZ
	+aw2B9jKQ87MBVb2lG6Bw45VtmVPilHK0WU53RWG9Xgwdzpdy+y+JBipbu
X-Received: by 2002:a17:90a:cf16:b0:2c2:edc2:6021 with SMTP id 98e67ed59e1d1-2c2edc26151mr4212534a91.11.1718032502566;
        Mon, 10 Jun 2024 08:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUX+qE30sOtQcdPcBO6cllJjlpNJG1nFcZzFDbNKN76d+4g6+6h4LDFL2zf1CaTNmhGd2dMj97g14KHF/lYOE=
X-Received: by 2002:a17:90a:cf16:b0:2c2:edc2:6021 with SMTP id
 98e67ed59e1d1-2c2edc26151mr4212523a91.11.1718032502221; Mon, 10 Jun 2024
 08:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
In-Reply-To: <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 10 Jun 2024 17:14:50 +0200
Message-ID: <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:50=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
> > This series aims to improve cipso_v4_skbuff_delattr() to fully
> > remove the CIPSO options instead of just clearing them with NOPs.
> > That is implemented in the second patch, while the first patch is
> > a bugfix for cipso_v4_delopt() that the second patch depends on.
> >
> > Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> > https://src.fedoraproject.org/tests/selinux/pull-request/488
>
> Smack also uses CIPSO. The Smack testsuite is:
> https://github.com/smack-team/smack-testsuite.git

I tried to run it now, but 6 out of 114 tests fail for me already on
the baseline kernel (I tried with the v6.9 tag from mainline). The
output is not very verbose, so I'm not sure what is actually failing
and if it's caused by something on my side... With my patches applied,
the number of failed tests was the same, though, so there is no
evidence of a regression, at least.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

