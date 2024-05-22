Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A9EC0
	for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381963; cv=none; b=QGM2VTiLsQMNngHMZ1sDOpiXl6uZbzxz1lQ1TQdFDjg7mXj6W433D/GLxtvWJQHMyglPA+0rsg3n3l5lDx5MYV4haPYEbuAK6czRAUVvQ0E1wyuUlD61kL0m75LhhEpvtXmRZtuoWpR7VLSg6CwL00NLFsdVEE26/SKM+yboOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381963; c=relaxed/simple;
	bh=ZQJQmXhWg9nPg2zrXMvCQ7J/HQIRLAQCnGo6p6LlhiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJxKKXAaxCpNZhGvjbCocwh21FUPd4ZsYcv+qo1Tm4C8Tj5Z45ewhzkptpcIamJf1fQi8uW6fhYxXW74GobhcVGa1h52lPqZj5GDqKV9d2aEq+addYq7pcPyZ7ut+PcAU4ATi/OZT/KTYypzVbAenClGTu7pihaly6YnQT0aoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eY3zJIq8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eY3zJIq8"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso2564836fac.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2024 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716381961; x=1716986761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=eY3zJIq8qYY3iPPEEG+Ui/t+RVk6COnu0Icn3wSiWx2s5jUXUf902XD1btzA5YgLZ4
         jnkSwAb7+qIpUckLOOgLLpDMs91Bp/VMXgtBzC7ZVLNOfiwFIz9v5L857FQNlXouNUVw
         BcLWAkaSYpowlFkGkiwuF5PXIIeZM2nXmLIqKPdgZOvIUXQVg4oIfQ7jrMJrp8UlNfjW
         IiYWCdbvt7W96FE+2Y6p3Jv5pkKZ9Svfql7bjSVJ1hOseXJcKUnevTW3Io/dyzG+Cdio
         v7r38r4L55lhsrUngYmIE0RSfkh/gQTDkm7EFzB4M9Alxh5oG1hwM4hqywjV0itViPwN
         51PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381961; x=1716986761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=GroKatEryQIfr3AMiZRDuO0eP+x4TR6kfMeeSh524O4hxZBs6Wzro8WHNe1femoczB
         hLeghVcsEfWw0oSe8CtH1S4hT2qq58RpPwHNU2pnupcO7PJ7QfuB0t15d9ZVW8rqqFiM
         pg554U03pCN1eKDul5XH+v5wFEnl1MA1M597MCEIpby64OUu9x8PPcbPaxPp1cccqM7f
         BK+oBYR2VhpX+fYQi5WNPpLj1udUHn4cdDG/f41C6LYR79Qp/lFk5aSwf0KjAa1qkHO2
         FZu4qXV5wT7J8YDVjuckPo0LP3aEshe5nozZjtagjhtGlaOsatrLVzGhFDbSex5GjulN
         /ILw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Si8eJqd40EnEDZtJh5o8M6/0N5BbuZXbHx3xmOW8uAWYAX13z6oZjFtU+vCXPOkpit/bR19yiXinCXNNggCA0Yq5NA65gLFoI90S53TrwC/Ynkqj
X-Gm-Message-State: AOJu0YxXnlLGHUet/u1x68vIFKt70PcZAIz8GKFhJphQJW18GJthPBWf
	WhgM/xfqRej5nM5cXLcp8MTK7fFwsuQGQ0IXJNqtM4mlMPYlO27FU8Wwkqgz95M=
X-Google-Smtp-Source: AGHT+IETP3qReUQJuxRlhxnWJn7QpbV+LVqvRpkT9nppkVGnw4JfRUuMImdtGPF2qcpBugAZnHpoew==
X-Received: by 2002:a05:6870:d88e:b0:23d:a1d0:7334 with SMTP id 586e51a60fabf-24c68a33ae2mr2153288fac.17.1716381960558;
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e074719d1sm151805451cf.35.2024.05.22.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9lLy-00C914-Bg;
	Wed, 22 May 2024 09:45:58 -0300
Date: Wed, 22 May 2024 09:45:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
Message-ID: <20240522124558.GC69273@ziepe.ca>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-24-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522005913.3540131-24-edliaw@google.com>

On Wed, May 22, 2024 at 12:57:09AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/iommu/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
