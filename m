Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E617623B
	for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098937; cv=none; b=pHFWokd5PJimBglins4GqSGKywJScXL9O9xwHvZSdZi0e8JLheCCjtrXg1VBdHvUrWjZOu/ZMng2mlFrr7/YKqTDAarOTTG33BuGG3iYPMQmofb2EvCb9HY+H5tINxwXG5l9UwBVVIWtHerKd7bLW0gmOzn5SUThBuhUVypkQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098937; c=relaxed/simple;
	bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL3Eb6GYA2UBdJ+DaNtTZ5pqXKdl5N1ZBQsh1if2dIiqBK7wgwW+p76D2DSD12LnjjcURUCPeN74zMc79aM5ewnU9E4U1bPVGOIXbXJ4mvHn1LaFJnqVtMoDzJoCnNLOFBa6+rfrNO/5KFNNCNJFvwJV/LVmWz/6npeDq6MFdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feeAwJZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feeAwJZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718098934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
	b=feeAwJZJHeU9v0pWhikAt+DVvUcbPA3bSAB0jguhrU6qiI54LxiGgYZCAlilax6aKZVSeT
	59gJXJjHenjNEjE7ij14fSFUYqKK+DyAoST/rnREOQ09SFN8KRzHjnbBuWjai0w3eXdBdK
	7qqDT4XX4Pa7G343l+NkpfdU5IfcL0c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-tTDhBdgKNNiStSiSMRRZKA-1; Tue, 11 Jun 2024 05:42:13 -0400
X-MC-Unique: tTDhBdgKNNiStSiSMRRZKA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2d0e695d7so3497471a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098932; x=1718703732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
        b=P8eU/KWtQdXgd+ZmnzU1v0z/6EYot+tU1jIYN6cySwoiYqDd6Oscj5HbYlE9kEBZ51
         A8I9CMw4Bj5FT+el7bBBzRuIxohN2k4HP1LbpEQlqMsy7uhFE72apOpZkrRd5SVbX91U
         zCZ7oR9jvVSuxJFizQeF7AgkNphEv2fppcDjzSNhzOg0Wvlr7ViCKe+8mtFzZc1u9Fru
         AjIU37RZ9phtrGpEaxK5JxA6YskXzEADUCbgy7BqfgG611RGqqzdfMQuo9xfj5KHRZcK
         pfqggwA6ZFltgN8SMyAlbvvLfox6BAsLuimIevAgT39G+9vlAcxZKqprzhZjCiuXw6OT
         bucA==
X-Forwarded-Encrypted: i=1; AJvYcCV8q0InRHpC1ePZ63ezpRLkO1JgC4nhcw/FLl4LJVSVKWyvxV9wH0S6Sf6OjS6i0Mndi+H/a43FP6KYYS0WDNegF6O92qShPVoPPXDcnVaTJFqJr6IE
X-Gm-Message-State: AOJu0YxddPUylD5NPF4xT+moRNUss5/l7FM7I0as4TNaZVCUkGykQbZF
	el1iix5ezMz1CMDAxn0I9vKynJ6hjcDbweVwPI3Udsc6E5CMXGcz7iRFfyrEAYXJEz86vHs/kAD
	s+Da8WWRsp0LArdeUqrc5MX88W0Z2wv/QScQSjCvHi9rHIAA1HRMpopcJeS/T/zhpw4KJ1ngIWk
	bY1fE+UeVbFzbFYQiiFIMtDRwf4sqHucmTNlTiQch+F2t7Zrhxyz73G0PZ
X-Received: by 2002:a17:90a:bf15:b0:2c2:ce08:d0e4 with SMTP id 98e67ed59e1d1-2c2ce08d1cbmr9733678a91.23.1718098932301;
        Tue, 11 Jun 2024 02:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyzDYIkyxO8ToD8S9H2/1wx4M7N2ou+ok5olmea8867gAIpOUjLlGIlzn0XE2htX5QCza7k2rCZTyNncWAKtU=
X-Received: by 2002:a17:90a:bf15:b0:2c2:ce08:d0e4 with SMTP id
 98e67ed59e1d1-2c2ce08d1cbmr9733667a91.23.1718098931890; Tue, 11 Jun 2024
 02:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
 <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com> <2812aeed-ab49-492b-8c93-c553c2a02775@schaufler-ca.com>
In-Reply-To: <2812aeed-ab49-492b-8c93-c553c2a02775@schaufler-ca.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 11 Jun 2024 11:42:00 +0200
Message-ID: <CAFqZXNuYpe130gL2qurzEsxH69rdLuw27Atg963ZCWewU+q44A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/10/2024 8:14 AM, Ondrej Mosnacek wrote:
> > On Fri, Jun 7, 2024 at 8:50=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
> >>> This series aims to improve cipso_v4_skbuff_delattr() to fully
> >>> remove the CIPSO options instead of just clearing them with NOPs.
> >>> That is implemented in the second patch, while the first patch is
> >>> a bugfix for cipso_v4_delopt() that the second patch depends on.
> >>>
> >>> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> >>> https://src.fedoraproject.org/tests/selinux/pull-request/488
> >> Smack also uses CIPSO. The Smack testsuite is:
> >> https://github.com/smack-team/smack-testsuite.git
> > I tried to run it now, but 6 out of 114 tests fail for me already on
> > the baseline kernel (I tried with the v6.9 tag from mainline). The
> > output is not very verbose, so I'm not sure what is actually failing
> > and if it's caused by something on my side... With my patches applied,
> > the number of failed tests was the same, though, so there is no
> > evidence of a regression, at least.
>
> I assume you didn't select CONFIG_SECURITY_SMACK_NETFILTER, which
> impacts some of the IPv6 test case. Thank you for running the tests.

You're right, I only enabled SECURITY_SMACK and didn't look at the
other options. Enabling SECURITY_SMACK_NETFILTER fixed most of the
failures, but the audit-avc test is still failing:

./tests/audit-avc.sh:62 FAIL
./tests/audit-avc.sh:78 PASS
./tests/audit-avc.sh PASS=3D1 FAIL=3D1

I didn't try the baseline kernel this time, but looking at the test
script the failure doesn't appear to be related to the patches.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

