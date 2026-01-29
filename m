Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063E2F5473
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728009; cv=pass; b=b8HDNsR0wiXR9eRN2/8Ac9/21fBJxAqthgJu0MBQiqruW4k4YrRWRbRmc4EikQr/9HcZJ+ZzdCEKboZ9T33ioxwtCUmH3s0snj515/0DjzuquaSBk1OgPdzmXyYe4WXN/87TXqg4YQtJdUudVxHZrEJAwdSVYdLhbOhxyGTQRqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728009; c=relaxed/simple;
	bh=rjhov0GaazkCkB4BJQ8rdsawUcuL8ouqck5WKEqQ570=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEkbqsq6reCZwnnT0ZljabwNyf2Mul4D/oLouSYxgHasJn7j9Yh/gWS1mYvMHhutTTMogTX/bivmmUVLrC05HsxiPESJ/E3nlEpqNYxNTvRyj/9JPHEQvQ7EGnMlvPG5I0ORVAMcmKoCz/ubxPS/A6eGO40ZAj979DRW7is6j/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NN3bmjiX; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NN3bmjiX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3543e57a229so32977a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 15:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769728007; cv=none;
        d=google.com; s=arc-20240605;
        b=TKHe2DhQ0DvwcgwwFIbh9uA/PGwZEMzzK4D3tonJJcAGkW5H15C1vAQV5e7jxbz0dK
         0O7zhsPAhc3+xOJMz1ROFpPSMQtXgpD6ceaQGDTTAist2vvvMgIPXwP+zWO7zU/ym3PL
         Wg1jLDsDwwZTFoFf7okClVocNxLpA3LxUbF4Og+Za0INo+hNO3tpsnKOeLi2bf5bVULq
         R9weoC0WkF0UqXBafJ1Dgxz+yYZXS0r1+qH82yClQWYIM/0m0N8I3yNny1BojBkNEqh9
         vjVQilVHQF0ynqT5qs/I9N5E7Ps7sDybpIMmP6bdyE33zhDVwiBxvIMAVa2BwM/8Cx8k
         MdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        fh=MGkSAdBTI56ki9BBLupNkAh3PrGGXt/ejGGtbdTb7n8=;
        b=FDWMiO/2XfZc53nMwHW+viNPTfokKK0MdI/t++ZtrABHe5esmYwJHrR4cDwvL9t8qx
         BDOZUJy/nUYcOqLYhKVXLO658sYZynjlk2VJeaBVP3DZkrHhPmfPzPD9uODcPrd08op0
         /Sey9PQ2AFqvIP+Ejxko9XDeqGaQIzyuN8YXtxeg0Eev16+kOA6dkkXakkJsnpcATT+9
         mY1CXNYni9Nb4IbpSVhRNsv6K/9j1PUJwz03EW2UEjPm9rgWZhaHAqBHQYY6OeiB3g8y
         c5UGxIO2NI19ne+gXeZ86y6eEBQF5PjCtc+Wcb7dkFJ5X6DmkSMiHMuWeJ+O3+NlBudM
         q2fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769728007; x=1770332807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=NN3bmjiXJ/1Rv0kUuYchAl9y4jCWJzaiPufbucyLnNUW5M9flMkq1Y1DGpUydxcAiI
         qb6HH2WBAe5GVSiGL5+rUimTErvV1CP3qxe+Go3H23xqJJICSalnAqvHBc7JjTr+u//O
         1RpmkBBfFBTyrAwGUFe3aSE5419JmQk7rD7CXkF9CaSsDciWjPMzSQSj+S8K/c/XJt/p
         /WYk7AhwbQTQnjeRgtZ6Ikfewos9c47YuuuSV/cJ1MY7lt58nccSyPGHxdSy7lr9cEUz
         szXTR1CA7xO+xvPYHUB6kIaVxcgDr3ixzFjfnEU+CYEpCILP8NcPI3MpmO7GnEJQDSgD
         jkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728007; x=1770332807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=wU7bkbFquhrPZynEHFyg9oeQn/Ps+BB9PXc3Sj9k8UZaiXbAGgURp6uFi8Kz9PRQ/n
         Q+q2uzuCwGdRE2B7uGt02AvuJy26Ws4T2s7kPYoyV55ZUzxoBEUL+YXGvNe8HtjJw+TI
         SXXZa23Kr+eFCPZpBeAu3o66F0qejaHMFxFEk7kRY0BzXkiQXcTT3d5nMtSJ30X1gn74
         2v2ERNOYZ9xAQ2XqxsXmUgFFztePcoEBcrM/Bt9AdephMnbM4oaEutTP+S/JqkKXtlTu
         hNASPrQE78kxPKkLfZUcr3evhqqPVzr49j+2FvXdB0dSXclS+CWG9P9FxeZIusKG3vzK
         HVyg==
X-Forwarded-Encrypted: i=1; AJvYcCVf5DkOnuu/K4w6UaGK0C70VgX/3Q8xI4kvBun59LgKMxubVcFXHo8lGoQvx8xVpVdH+lpbkSVtqLDE0nrdcVFaG3r6ZdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bbfwMrEvCJ6hUDNDezqwr+i12BKymW8a6nbPdNQ7A6QOL04I
	ZxWOA27bsmnSKVVNbDwmtaYgddc9zHIfogdzkTo44Xjpq8e+lRAwsVtXbxvhBou8xUY6b9BZvwR
	PASawAM6jREN1MNUFqEpCVIT94qvc5sXL4EoSrdF0
X-Gm-Gg: AZuq6aLynr4Y3IOa9OE5nbA3vMa9yTqwYN6bv5RV90eOlKDc37BSoZVJ3MzgCMloAcn
	e9I41b3Pr/RFBSgCpMj3w8Ho9gJ5dzV4bV4pFo85zzppbc8KxGVrZXtnuHDKdtJu/9q+UD9Ahzw
	DZha3b+thH1z+yvphbyC5eboBsedEKddSIU6co/EZB8qs6ljSv2joYo12aAZE2SoCaIvlr/gNml
	+jyfDJhBSou0eNaml5pdcfYl3igo6iYxpsiB+T1DQfMJCrkzH5c61yUqgHqf+COhygIPmw=
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3543b2ebe3fmr942700a91.6.1769728007348; Thu, 29 Jan 2026
 15:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local> <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
 <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
In-Reply-To: <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 18:06:35 -0500
X-Gm-Features: AZwV_QhVDVaLZs8JJVAmxYQR-vhXYvsk_Nd5ubbkE2VXzkBWSDq2lgRuz96U7i4
Message-ID: <CAHC9VhSqpqVT4oFzvFpReJbh247mJnAz6U9ax-DS3oapHRnf=g@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	wufan@kernel.org, mic@digikod.net, gnoack@google.com, kees@kernel.org, 
	mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com, linux-mm <linux-mm@kvack.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jan 29, 2026 at 01:31:05PM -0500, Paul Moore wrote:
> > On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:

...

> > > But that's future work, for an -rc8 hotfix ...
> >
> > Expect a patch later today.
>
> Perfect thank you very much!

A link to the patch is below.  Assuming I don't hear any negative
comments, I'll plan to merge this into lsm/stable-6.19 tomorrow and
send it up to Linus early next week; this should give us a day or two
in linux-next and then most of the week in Linus' tree before the
v6.19 release.

https://lore.kernel.org/linux-security-module/20260129225132.420484-2-paul@=
paul-moore.com

--=20
paul-moore.com
