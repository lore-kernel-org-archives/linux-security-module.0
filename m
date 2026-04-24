Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C134A3C5
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068794; cv=none; b=cJ1XaKi9cardw2meicbrjNSz26GvdbTEv+xDndejMlQItA7qj3j3j7UgLCV1zlcdw0iEcyEkUI+USQ5OWkciuvNflsPH3AtWD2AF32a78SLqUH/74z1aSKOUqrWEnpvPzoagEB2dopDr23lTQh1B/EVAd2SJiLYean05K7TZiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068794; c=relaxed/simple;
	bh=edkfnYqeyMC0Qt+W6n8ze5hGF7NTNhj3oyNEAcTDdxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlCV6GAuGTprAeaHaec4Ha1iLdOb4lzzFBK+XeOfrj8wXJ5XKXPAUNjThjOUNqsHyAsx2N17mXCs6jS5gv1jHHKBYzoicVLu9veAiyyaWL30/5GbFxYPBd/ArhB3Bww8o2kvXrm+zDbmXYJl7iFvgOd6w14Tu1IzUqO+ld2XhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H5m4vQCZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H5m4vQCZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d67a483d3eso945506385a.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777068792; x=1777673592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Bt8LRPmWuCECk46OUK1KhCrmrzQEbzIWvPlDI3cp4=;
        b=H5m4vQCZE27E+gDtn8BVCf5jLiPS6GNSYRuHd7oK/ryAnR76eU7gh4QWRI3SAXCvku
         xwbAjZ3hIBI5GEUgbOSGuhXCViPpczYPF9VhNc2dh89l7qQROTD8YZ3pfblRmIXAApD+
         LLNyElsdRzbz0O8P7asNE1yJaILYoWrFSeatd7+ExO8xnYjLQgg2muQOyOklYWskuFkU
         cwfy9M7PKhf/GFqDNR2idR9iNUU//TC3BIEIHtpqSrhi/HtxH3xMTkMDNiCC7PJfnIaI
         RfTF+U+c9gQck78mXjxg5cQFxiXkgiK0mPHrBDKGiKFmfg+/2VAfJKkgnb8JLTc01FjS
         F9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068792; x=1777673592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1Bt8LRPmWuCECk46OUK1KhCrmrzQEbzIWvPlDI3cp4=;
        b=SGWPQsBkmKMk7jL84yQ1rhmFjO9lOBX1+D5e4joPe11QJGGwzFG+r9P/FuJT1cpcsH
         EsiRQy2TKp0DMpCEV8iSmZtuXSdIW1/5OlRXTpBmWVie89JQoFdTVhrhjYKShdaOlgYl
         IOneLl3PBNJ4Me1CDeBhw1WvLry3IbCCcbwtAAx4B8iaJtFdAeqg1NL8n47p/nAJeNrM
         NmNbvnLN3yw/KRDwErHnFkk6VDKSl6rq8VQj5PHrlu+sEWqaNlBg4Hge20ZREWS7QKnm
         Cq9XjbT8DYhr5hU5la/V1007pULZmx2IPOBnInBiICfgIar7joBUpPVHQ1TBhJbDyYec
         qu+A==
X-Forwarded-Encrypted: i=1; AFNElJ8Q+y+8BvErzyVqzE2gBwoZjTNIj9nq6/MB2qZVvz0R8vlw7zvpT+HJiHuNEh5CP0S58+92Jrd480cpvaf0J+DMcPcoXN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw653P9cU0bDE97762T1hvrRKCLyENLg89v/7I6rVRloCB2udsK
	WLDOMuTI+082p2DjUOx1VqpM5wNqthgW1x4QnVq4d9akiEF6+tCagvDGFkYSUj8AzQA=
X-Gm-Gg: AeBDieuyux7bN3wySddMNcIjHMmUA/SE2KucRh8OsihwvT4gqhYP9cSf5z5l9fKCCla
	Q6e8ANiFaE9shcGqTUp+bLlixrCXLB1ocbP135jyd6oKF+QolO6XammlttM9NhVenlCHbUdRYfR
	erGDJ6HsfH5+Hqf/Q6SsrPbby2fys55RinZ5/uxmC2SpJHBKpwzLWW7MKo8WBrgoBsKdKJTtnRq
	sknzBzjGK7zT0KQlzrf//GBdqtKjncQyja3ID0v47WxOIWNllcyFDkxXjYaOW4xIb56MYjBqrXv
	F2ugKZLMvIR++AtujxR8WE9V9BxQH8255T80TmVyZWBJvqq7EER57wpw7TEIAm+gYgYYWmTlBP+
	58etqI2ayGRmPWirFedEY/+EXeoG9udUK2SO82iEY6EYgxgRiQoBFLz1uLLef7lW2fdcmqQyGFB
	naTgQrYfa3bbho9v8/mrincTfnD1Y3w8ECf2fZhjpNL9nzS6B8e9zuAQAUUHjAiWOhnqK2X5QwH
	7YiaN4TQic3h26A
X-Received: by 2002:ac8:7d15:0:b0:50f:b13e:b740 with SMTP id d75a77b69052e-50fb13eb934mr273244551cf.9.1777068792308;
        Fri, 24 Apr 2026 15:13:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fc42c7fabsm78174021cf.9.2026.04.24.15.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:13:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGOlq-00000004lHz-0nuV;
	Fri, 24 Apr 2026 19:13:10 -0300
Date: Fri, 24 Apr 2026 19:13:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paul Moore <paul@paul-moore.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260424221310.GA804026@ziepe.ca>
References: <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca>
 <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>

On Fri, Apr 24, 2026 at 04:59:30PM -0400, Paul Moore wrote:
> >
> > > Most LSMs will want to know who is initiating the firmware request
> > > (the subject), the requested operation/opcode (the action/verb), and
> > > the target of the request (the object, which in this case is likely
> > > the kernel or the device).
> >
> > How is
> >   system_u:object_r:httpd_packet_t:s0
> >
> > A kernel or device?
> 
> It's not.  It's one of two labels on a packet.  I've cautioned you
> about leaning too heavily on the secmark comparison as it falls apart
> in a number of places, this is one of those places.

But I want to label a packet too, you keep going back to it not being
the same thing and I keep repeating that all I want to do is put
labels on FWCTL packets :(

> > It is a label for packet contents. I also want a label for packet contents.
> 
> According to your explanations, my understanding is that you want a
> fwctl RPC operation.  That is not the same as the secmark label
> assigned by an iptables/nftables rule.

I view fwctl as an opaque packet based messaging subsystem. It
communicates a packet to a remote CPU and returns a response packet
back to the userspace.

Trying to have the kernel assign fixed meaning to the content of the
packets inside the kernel is contrary to the entire design of fwctl.

It is like demanding the netstack parse HTTP packets as a precondition
to using LSM. It makes no sense.

Any LSM integration requires a labeling system that is not hard wired
into the built kernel. I don't much care what it is, so long as the
classification and label space are defined by userspace.

You say it is not like secmark, fine, but I see a perfect mirror in
secmark...

> > You can take that view, it is certainly one valid way to look at it.
> >
> > But it is completely impractical.
> 
> Elaborate on that, because from what I can tell that is the valid way
> to look at it from a subject/verb/object perspective.

We cannot have the kernel predefine verb labels.

I'm completely fine with using verb if it can be dynamic and userspace
can tell the kernel what the verbs labels are.

This is the only reason I pointed at secmark, it shows a system that
has both a user controller classifier and dynamic labels that are not
fixed into the built kernel. ie it is flexible.

> > > > The same way secmark cannot pre-identify all the XXX_packet_t's.
> > >
> > > Once again, I think there is a disconnect or misunderstanding, on a
> > > SELinux system using secmark all of the packet types, e.g.
> > > "XXX_packet_t's", *are* pre-defined in the SELinux policy.
> >
> > "Pre-defined" in a text files in user space controlled by the admin.
>
> That's not correct.  It's kinda like saying the NIC driver sources are
> simply "text files in user space controlled by the admin".  

That's very pedantic. I mean to the point I wonder if we are even
speaking the same language.

I said the labels are defined by userspace, you said no, and then
explained that they are defined by userspace going through a bunch of
steps:

> The SELinux secmark labels are defined in the SELinux policy sources
> which must be compiled and loaded into the kernel before they are
> valid on a running system. Policy must be written not only to define
> the secmark labels, but also to define the access control rules
> which govern how those packets are handled by the system.  The
> iptables/nftables command lines simply assign a secmark label to a
> packet; that's important, but only a small part of the total
> equation.

I understand all of this, I am totally fine with it. A package will
install, a distribution will provide, or admin will write these
things, and do all the steps to load them into the kernel. I don't see
any issue with that.

Hardwiring things into the built kernel is a problem that must be
avoided because end users only run the kernel provided by the
distribution. "recompiling the driver" is not an option that is
available.

Jason
