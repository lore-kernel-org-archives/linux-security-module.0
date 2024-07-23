Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9C13D248
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716592; cv=none; b=YGOTyeplpGRTTrn2sgTKkEskqCDkIEPqDnyaWtb/n2WB8L+UhJKuHz0hXQIF/IaChfIuUUgB3g4L2ouRpjGYIwUZ0VDQBZXk8JbhA9ieIzknK5TGsF89MReETnPwENPAx24sZc6CXIVrMHdj4Wk/QuTn8HDQn6zip/5GcbWKJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716592; c=relaxed/simple;
	bh=Rh1iU4QMSCWVRtVE9r8jRFOBzKUv8LzpqIXny499Dgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRXVfBMvmwqJbMg2NFy4V7hT+o/vwAFhP6NZEmfSDcmDZrj2rK9E9PzX56ET/KbYx2aStPZGZF6ZfNQS4uTSscC0TwJmPmWFTvj5hlQjkRzde6hE5bJs9+tYHtiAYmenphzJArKLM7fc3x/53m6j2kJDqIXuTV9jZXyowziqRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HEv87vCm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HEv87vCm"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so22313181fa.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2024 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721716588; x=1722321388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p96qSH2XGEzEu6XiRXjHGRDwLv6x0uLl02kl77T1vtg=;
        b=HEv87vCmKdm9JrYmLpz2wN6Q/NoNu3mfmLWtZ3nf2gmKWkBgg9/OFNhqC1kpv3HsjS
         pQktkLk8Qa9ytiZGy1SbTwbp5TpgHRt4VqAzlGvkc8A+VBACOcZA3TM4+hZJoVFoM4QT
         m9BcEtyIZqnq9DG1A/gpO3xZ8vhyI2dHR+m+HPxRU95jUkW+kHxLfHjolcnPN/nvl9QU
         2LDICX3T9VHWx6vy4U4jQHFUHnQyG420EDQHcgna9C9ttd+91oKaUaXib2UXbZn48jH6
         f2GaLodnE7+6LLV/C9UoegnR8JNYtZLSEGim5wdytBnUSqsrCYpL5IYepS+Bt9Yvsi+j
         AKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721716588; x=1722321388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p96qSH2XGEzEu6XiRXjHGRDwLv6x0uLl02kl77T1vtg=;
        b=RX5zL1qyvT3wdMwp6bdRijxbG+hwnVsFKrVxqQ0k6mrEn+U/+j22+pU2uSYAgajlMU
         jaOPIhvDYBqndI6SDUiXW3jMOu44zCqRD6jj3Zbzhqkmijr9K2YFJRuRwm+Ki2Z4XPNn
         +MSl9LQGNqj+TKvL3w6PQVRXSyJFFpGIU0O5xmVyXyZ9aJrixUu6/k9PQj82kIcNdpIx
         JjCAevWTcI6Ey2bomhpAy7TOw332wbwiwVcdCMp/Ez/8L0DhDaNT+Sq9F5PYswHWMy9o
         oYyx4+moQE3UJlzA2H0ntEprEMJPcGThpxb2cvLV/+uQYm/lfofOTwEzRaSYBhwluuAQ
         47Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWmbptSmG9I4mbUuZkpmxji5VM8VCxLi+vAf3JmxXVsuIN25rFuQsveKso9z0NKWFGYGfCVJzhKs04Zt4KFMnYV5Q6ZYVE6WBZ0ZJhnG+5L3aQSBQEE
X-Gm-Message-State: AOJu0Yz+nbl99GDBNICM2X5zcsnRU+X0bZyGbQSwgKQVoXDE8bUQWAZh
	IPQ6jnDHrpzq37qgxI2H9VqZ9/uxTvXjZHqXijgydvpMWAMIE6lODNQv5QuupwI3QpAUhFVhXFC
	E/js=
X-Google-Smtp-Source: AGHT+IHWuTVuB2KW4cQs3g8t7OXEEPzFwqn1ezI1cnjHR//9/ahmV71iGxRUiWwnmbYZkrCSD5Ac8w==
X-Received: by 2002:a2e:be92:0:b0:2ef:1784:a20 with SMTP id 38308e7fff4ca-2ef17840efbmr68420581fa.38.1721716588376;
        Mon, 22 Jul 2024 23:36:28 -0700 (PDT)
Received: from u94a (110-28-42-216.adsl.fetnet.net. [110.28.42.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d15c36135sm4215375b3a.60.2024.07.22.23.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:36:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:36:18 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Message-ID: <2k3v5ywz5hgwc2istobhath7i76azg5yqvbgfgzfvqvyd72zv5@4g3synjlqha4>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
 <20240719110059.797546-6-xukuohai@huaweicloud.com>
 <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
 <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
 <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
 <CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com>

On Mon, Jul 22, 2024 at 05:48:22PM GMT, Alexei Starovoitov wrote:
> On Mon, Jul 22, 2024 at 11:48 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > On Mon, 2024-07-22 at 20:57 +0800, Shung-Hsi Yu wrote:
> >
> > [...]
> >
> > > > As a nitpick, I think that it would be good to have some shortened
> > > > version of the derivation in the comments alongside the code.
> > >
> > > Agree it would. Will try to add a 2-4 sentence explanation.
> > >
> > > > (Maybe with a link to the mailing list).
> > >
> > > Adding a link to the mailing list seems out of the usual for comment in
> > > verifier.c though, and it would be quite long. That said, it would be
> > > nice to hint that there exists a more verbose version of the
> > > explanation.
> > >
> > > Maybe an explicit "see commit for the full detail" at the end of
> > > the added comment?
> >
> > Tbh, I find bounds deduction code extremely confusing.
> > Imho, having lengthy comments there is a good thing.
> 
> +1
> Pls document the logic in the code.
> commit log is good, but good chunk of it probably should be copied
> as a comment.
> 
> I've applied the rest of the patches and removed 'test 3' selftest.
> Pls respin this patch and a test.
> More than one test would be nice too.

Ack. Will send send another series that:

1. update current patch
  - add code comment explanation how signed ranges are deduced in
    scalar*_min_max_and()
  - revert 229d6db14942 "selftests/bpf: Workaround strict bpf_lsm return
    value check."
2. reintroduce Xu Kuohai's "test 3" into verifier_lsm.c
3. add a few tests for BPF_AND's signed range deduction
   - should it be added to verifier_bounds*.c or verifier_and.c?

     I think former, because if we later add signed range deduction for
     BPF_OR as well, then test for signed range deducation of both
     BPF_AND and BPF_OR can live in the same file, which would be nice
     as signed range deduction of the two are somewhat symmetric
