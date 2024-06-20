Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B421AED3B;
	Thu, 20 Jun 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901694; cv=none; b=kqgicMBsSWOIchTxw4Sn4jalO9+ZRzujmfxRmjq6wa3P7SF9qdYAGi7KtxGlk7A5US7BrJbe10z/Mo6Utkp05dU2J9IJMsUIvBn01k575bvisRJ0GLG6zEPd2LtO64r9r5o3AeS8PN1UknPiCdXiz9bviimU5zLpMqdkt3wxrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901694; c=relaxed/simple;
	bh=qGawXLVw4L1VsNo7+DMAcs7Y1m2pJDSmWkpIDHqyYus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRr8d6csiGuGzG6sQr9fqhQVKPTDJJAvR9+zVcj+KaQGMVv3sgIaExVowlXX3kl573TXf52R2X/t4dvU0x93T7mZGMZ/h8vyJzDGFwRe3JabRWKOGfpJ2uQdTRCNZvN1zpindZA3f2QC2Zx/1zHfLe7QG4LVaTLZlFE8vUPn5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/j4HiKd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/j4HiKd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a62ef52e837so127127666b.3;
        Thu, 20 Jun 2024 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718901691; x=1719506491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqFMf+YA6WaCF8UVxLhtLxGRBqYbo7Uv1IbfXsLd0I=;
        b=d/j4HiKdeKuuzBZ6tXkyz7+AL5e5JVspjpGGw1ZkvPdV6oG7hXoqlonE4KPI4XicMt
         j5yakAxfjBCSy3xzF1sJxupWCQnvBwXzXaXTHeYi3o6Dmu+u5JTRmVgddMZApCJfEFh/
         7wqePC0kYwK9GWTq821w67i3VnAykARqpgfo9HAm+bND7M3m0NX2bSzfhivnvLc/0tK7
         PgDDETe7ISvMfuMcQMqIr364WrdatNXWK7kow7gs3zxqOoRhoe1Oe8c0oHRi/0sMlfEJ
         /DmS9uPXAVRnWgz6feHztS/T9QNxMFBLASnoZsVuppOOYb44/mSQ3+xHhjyoIK5MMk3g
         TzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901691; x=1719506491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVqFMf+YA6WaCF8UVxLhtLxGRBqYbo7Uv1IbfXsLd0I=;
        b=Kr5X4OWZf9KBQBMDgxviCQKOnmtBOhqqGBVvwTlqaZaoVtOA6hyNj2lcky8toUnIAg
         0r0u3oVTdNv9GQptkSS/yXySUjXmpQBvqhwX42jxMPtimwsUKNF8Wrzcnxdcsiy7g1Z4
         MOhDE9AFBOrydbv4YKmqMiXNHtrksowjjAiWZqv7S07rD7iZ58JmyL1JSWfzevvqWElA
         uPR6bI7+zqhhFZ0pqrQrVOjGVMQfHeWrEx5QSR2yH4vZgQAvmd15KW9vN3hbwgnFJvx+
         XeRS2u69gYzoQpwdscwP1LOiDMVux194yPKvUDa975/uAk4m0R4lPuL8HluvNgHGFOLN
         mg5g==
X-Forwarded-Encrypted: i=1; AJvYcCVccRP2Gg6ce8/1pBmHtpcxLDGc3JUWxP2wSX1jf/U+9nKnQ27+N8BDneZQBaH1eTGeLBUToR6h3oJkDflkRSgpF+1aciMAuh6pNTwO7zXoRU8GY4RcR5oaGiSE6GxdVfMaVRfrTC6QVs/842Lak8etNbRE
X-Gm-Message-State: AOJu0YxO4/WFqaOlfuY2nzU1+f9aO8YXmYEX7CkBvGhf3gNeFrGcPJ/x
	fSUlgbYaIpo2NzuH45beRqIqNMOeNav/bQ8zgGZMgcXpyfPPSy9J
X-Google-Smtp-Source: AGHT+IFYCMPJHTVF90AK5hSCiAHLK5/uxoQ/V6aN3/XvBLsizCv+mz3Iu4ITX/MA7fl1zsEVva7nEQ==
X-Received: by 2002:a17:906:dfe2:b0:a6f:ffa:9596 with SMTP id a640c23a62f3a-a6fab7d0b8dmr345856866b.63.1718901690803;
        Thu, 20 Jun 2024 09:41:30 -0700 (PDT)
Received: from f (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecd666sm784693266b.135.2024.06.20.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:41:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:41:22 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: John Johansen <john.johansen@canonical.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] apparmor: try to avoid refing the label in
 apparmor_file_open
Message-ID: <3ijkwqkrynfxi6t5bj2jingkpebsnomdcwduhe4pgl6pu25sfs@smvxx7ewexkc>
References: <20240620131524.156312-1-mjguzik@gmail.com>
 <71c0ea18-8b8b-402b-b03c-029aeedc2747@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71c0ea18-8b8b-402b-b03c-029aeedc2747@canonical.com>

On Thu, Jun 20, 2024 at 09:26:00AM -0700, John Johansen wrote:
> On 6/20/24 06:15, Mateusz Guzik wrote:
> > It can be done in the common case.
> > > A 24-way open1_processes from will-it-scale (separate file open) shows:
> >    29.37%  [kernel]           [k] apparmor_file_open
> >    26.84%  [kernel]           [k] apparmor_file_alloc_security
> >    26.62%  [kernel]           [k] apparmor_file_free_security
> >     1.32%  [kernel]           [k] clear_bhb_loop
> > 
> > apparmor_file_open is eliminated from the profile with the patch.
> > 
> > Throughput (ops/s):
> > before:	6092196
> > after:	8309726 (+36%)
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> can you cleanup the commit message and I will pull this in
> 

First of all thanks for a timely review.

I thought that's a decent commit message though. ;)

Would something like this work:
<cm>
apparmor: try to avoid refing the label in apparmor_file_open

In the common case it can be avoided, which in turn reduces the
performance impact apparmor on parallel open() invocations.

When benchmarking on 24-core vm using will-it-scale's open1_process
("Separate file open"), the results are (ops/s):
before: 6092196
after:  8309726 (+36%)
</cm>

If this is fine I'll send a v2.

If you are looking for something fundamentally different I would say it
will be the fastest if you write your own commit message while borrowing
the numbers and denoting all the wording is yours. I'm trying to reduce
back and forth over email here.

> > Am I missing something which makes the approach below not work to begin
> > with?
> > 
> no this will work in the short term. Long term there is work that will
> break this. Both replacing unconfined and the object delegation work
> will cause a performance regression as I am not sure we will be able
> to conditionally get the label but that is something for those patch
> series to work out. My biggest concern being people objecting to necessary
> changes that regress performance, if it can't be worked out, but
> that really isn't a reason to stop this now.
> 

hrm. I was looking at going a step further, now I'm going to have to
poke around.
