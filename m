Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D02D8364
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098543; cv=none; b=d64vVZOOzfW8Du+RO+YP8zkVcY4gpWAW6ueOabZGuXC9GoHQBk4zXqYeQbvhBBrRtdqMCllaa5CnjT7AAJxj6zzTfSvUnU8xaf9iqh4+88CxDHFSXLyzEMnUZotdh2kWTZAaSodJbuoUfx8wvalRjtBMH4C1gqOL7ZJIBkF83bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098543; c=relaxed/simple;
	bh=G+WYrb1BBVDoPFmFwGScCNyDrJlyYOjXSYKOQwe+8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK2ADZrahT2Jf5IuyU/MN55wMKd1FXnM5Dn5gpXcSiJvsysqYEtw4jujOs+dQsNyzU/mWzJbch0QwlmZMcT5y/Jur2hleV5T2G2pJ7u+IxdIMXsTn2h/RKTL34KfZyLpNFncvYO7DNofOjYZ+McUrqTjK7nA8dbUxNQfbJoM5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E2wavPRL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E2wavPRL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d59d249fbso48812021cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776098541; x=1776703341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUiNyilK1I2myoXjgAEGP+spYezLcxgAYqqWit3D6Xk=;
        b=E2wavPRL5AmyZgB0g/U0hP95w+LHR0CODATHBR29H0d0H1ZgOljvH8X8HvEY3mXt5a
         YlnadNIjO+fQDkEchqiV9cHty+PdpSlVJ0f4C9c9V84ivaVyIHJVhYYiHOq6kNaLYdCy
         RS6GxQgi6h43fT46Qsn7sAG84AXG/H7JJnfCpu1q5aml+RfpX8WXFWxo1JtI9p6txnZa
         PdoMOOEpmP/FwRH5QMlO4oHklEDiJJ+80RerI/KkkD87VkTNCjDn28FG8unDsu3pExSz
         eHYOVnR1ITXBzK/9kIafEqDD5d9qV0i6BSWJek3gMW5q99EoszY3lceECT/YF1kRVaZz
         9cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098541; x=1776703341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUiNyilK1I2myoXjgAEGP+spYezLcxgAYqqWit3D6Xk=;
        b=PlpYjPB7QfvjM0KhGboB8o4WmA35RqNwfpJKEMz6EIZjLv0Lgm4uLJXW7dEexh2ALT
         FwBjQe273aYj3aEmRQkBnViyrWlyGcjYFG1HUnZxCBNr6GASJOf2Wjl0JVJkpWqAd2UB
         BYLyo0zv/LHnv3Tou3MQF1EhB1Jj9bp0iRqIFurHR9pDPHgye7G7hG30iRsWQnIK671C
         tbHx5J7WdFTKvfIA2UR0I7AVmiu0gv96dsbWM8uXiQZV1vE53yLpFy1Qct8RZdTO0V6T
         nTsKjI4R70KaVBEN2I1Bq5Gij3rRMJxSvHw0ACKFMGnLNrMunQoozvD+2A8xdIYD58u4
         uDjA==
X-Forwarded-Encrypted: i=1; AFNElJ+qljgvZcB88ed2RO1UcBRo8gc60Vn6gfVmSCFiGt4Mh36hXKhD4wC1xN76Kx9yJK2drWelEI2geKRHlbrBHSk3KR3BH9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZr2HgQswPbeXyFdhLXVztX3i1x2eLFUO6HhwQXri1uqoT+Ku
	Q4lbb8rys1M/f3/zvup6GDmqUTrU3O9fwhX903opyF/sVUJZDSDO/rXsF7/JMrpLwz8=
X-Gm-Gg: AeBDieteRWaZM4ffiel8nKamSVn/VUNy7RnBzjh6/s2ZHII03W77Z0b9jqKeakQCLkm
	CMpzxsnGFouiypGXJ+SXroym7vcrCIxYA7tMh8vHJnDpqgqU9KaN97FBHUmbjnL+DFyUeaRMpvS
	2Ah0/O6odBdAxJEV4mqpYcUWba5s1JeXHX2/MTQcvWWMRyYGqs4cPjvy9wRJd4Qo18ynKX5qwgh
	xN97ZByADKTVGttndnkEE09Tc5/S6n/ojKPuBnADgtVAt8ddpXLaCRpaOsO4g8ulWZJFfuef36T
	rSuyGFvGK0qh3gI6Vhc2/55WLh6qEYTkz5wq5bmbH7Qw6gNRO4LgTelIUhE0vFmDzlScN+WvvEj
	diKr2wNaQ+ABX295JuoiojWnMjvHELi/rUEHFnH7orM/qYzYonb23qpCOV5DnRb2vwGA/bFMXF3
	NEfCijJv2CHehS+8p0hvcZ0oeYX1eGG0e26kMO8u4O3Nl/sJ0IR7HXQ6vJVlgqTaDZmU3zryDVs
	HkEFQ==
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id d75a77b69052e-50dd5c02761mr211953761cf.60.1776098541243;
        Mon, 13 Apr 2026 09:42:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50de6bc04e0sm60997991cf.19.2026.04.13.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:42:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCKMe-00000005Zr4-10vb;
	Mon, 13 Apr 2026 13:42:20 -0300
Date: Mon, 13 Apr 2026 13:42:20 -0300
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
Message-ID: <20260413164220.GP3694781@ziepe.ca>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>

On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > We are not limited to LSM solution, the goal is to intercept commands
> > which are submitted to the FW and "security" bucket sounded right to us.
> 
> Yes, it does sound "security relevant", but without a well defined
> interface/format it is going to be difficult to write a generic LSM to
> have any level of granularity beyond a basic "load firmware"
> permission.

I think to step back a bit, what this is trying to achieve is very
similar to the iptables fwmark/secmark scheme.

secmark allows the user to specify programmable rules via iptables
which results in each packet being tagged with a SELinux context and
then the userspace policy can consume that and make security decision
based on that.

Google is showing me examples of this to permit only certain processes
to use certain network addresses.

So this is exactly the same high level idea. The transport of the
packet is different (firwmare cmd vs network) but otherwise it is all
the same basic problem. We need a user programmable classifier like
iptables. Once classified we want this to work with more than SELinux
only, we have a particular interest in the eBPF LSM. In any case the
userspace should be able to specify the security policy that applies
to the kernel classified data.

Following the fwmark example, if there was some programmable in-kernel
function to convert the cmd into a SELinux label would we be able to
enable SELinux following the SECMARK design?

Would there be an objection if that in-kernel function was using a
system-wide eBPF uploaded with some fwctl uAPI?

Finally, would there be an objection to enabling the same function in
eBPF by feeding it the entire command and have it classify and make a
security decision in a single eBPF program? Is there some other way to
enable eBPF? I see eBPF doesn't interwork with SECMARK today so there
isn't a ready example?

Jason
