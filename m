Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0515FCF0
	for <linux-security-module@vger.kernel.org>; Tue,  7 May 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093777; cv=none; b=qFJfdnn98LOR0rWiUYPhlc4bUSd1n0pq/lcFLkKxxSXv2smc4pVMmrAqsIj11xILzSYd25v0OLwEyTOZjVa3o4A3pc8dER4UvrtEHH6Tr5766Mo2SvfkPR4Ay3YncziR57ImvyuSJcO/y21o7xNFIOkGVWlsVF/99Tbqv4IRtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093777; c=relaxed/simple;
	bh=U3aPuCdf8BbTSweuMDZBoEtz3ysiU7++KCuwqbH6O1w=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=F5OZaJCuPPJqlYOSe//dzMrqTPbZpuf7KIS+8uxKKDtcmcAgZnNpKDC3M51+6O761DPTb/OFgGvUT++3J17KkmZ/ibiMnqtqiGgWhP6VTcctpdBHllSLBC08xq+uznIH6S1x92d30ikCCVwX/xbTUFKJ2YHMbbd5lDakGsxkse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DN3fyCly; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DN3fyCly"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7928ec5308cso299713985a.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715093775; x=1715698575; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dAG7TUb5hoiO+hKAcnLS9PzWLaNdTanXbfa2plm364c=;
        b=DN3fyClytqoCR4cfD3WOtNU+djSVllhQO5tGwqPEIt0ipIqZSK+d0Y5MviA/Yp39PA
         ZI6e/YWKRN+f8o11TMzv7+6DamdydPOJ9Dg8gmiuPVLwsewKoGEME9ECawBu+0CZ0NLM
         qkyZQoCDT72LxXWdGzj/zOzf0pVjQ5qDi8mShWxTOvOROuYcHgNV63iODnNteDIj29XP
         OmNftbCk95mqCYVAYhSSPlpRHsZpajCXUuFrdF0rQTUHI1yj++J0g47QBPNnsdkl6ypR
         hsM7guqSL5/o9L2bLT9fWKiZyu3HoLc2ItlYlFjUyAJJo40nu5N7Ic7659+Mv2acIAD6
         YTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093775; x=1715698575;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAG7TUb5hoiO+hKAcnLS9PzWLaNdTanXbfa2plm364c=;
        b=tNwAhqadnhIixS9IcR+yKwOQOCAQ/o2WPXnp2evRTGGfyt8f7fRPQvoppJw0AsoZ8P
         cW8aSvWz9MBx/ZIIlWEErn49EqEQeJvJ8yj8+oW0/J1iJq1NDE50SMgznrVCcm9Vj/Mn
         g36nvAA3YejMSsAD4IYc3X1BU63rTs8TYRC3vfYmeqE6FOc3dG0cjkm8or+jpjmGe+K8
         jGVsdSjxXyVTnE6wjnSTWEz2Moy+qnyqHzUt00M1YPHHRNzuvMjYvHxI/VQr/ucHXC2C
         M41DEddeg74kyDCuphDcbcbZVZMaGCUMGczy/Ac3Kc/rdC0NgyiBMIqATOPktNnsgt5D
         EVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWghKmJlNhZvZbZl///c9v2wli8fdpDM9x3RhT2ZMYs7MN+sT0mBsDtR4mpgH1i9LzqRUspaCAA5NXtjmAywfMvKPKE/igyKwPoYGvQ8wGatV88STB
X-Gm-Message-State: AOJu0YxnZSPxNCtgZz9ey4833Y2hPVyUIQJcKSWucWuLHt4H15i3qeAW
	mCLpygDWEwXJaveZp/RjabDxXHDL5Pxf1GM3HfFzSORnqP+1P6q1f1A6wQZWSA==
X-Google-Smtp-Source: AGHT+IFJ9/XdlpsfijSJp8NgxZMyJgNfVe9RyIheVG2oMchZOjGjf2Ye6/u1d77c4EA1le1mWmQnVg==
X-Received: by 2002:ae9:f443:0:b0:792:92cc:41f6 with SMTP id af79cd13be357-792b24c8372mr3784685a.17.1715093774767;
        Tue, 07 May 2024 07:56:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a04cb00b0079293ebf935sm2562969qks.54.2024.05.07.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:56:14 -0700 (PDT)
Date: Tue, 07 May 2024 10:56:13 -0400
Message-ID: <06a6ed315cacd41043f9f9e67ea379af@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
References: <20240507140122.176304-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20240507140122.176304-1-lukas.bulwahn@redhat.com>

On May  7, 2024 Lukas Bulwahn <lbulwahn@redhat.com> wrote:
> 
> Commit 67889688e05b ("MAINTAINERS: update the LSM file list") adds a few
> file entries to lsm-related header files. Among them, there is a reference
> to include/security.h. However, security.h is located in include/linux/,
> not in include/.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this new file entry in the SECURITY SUBSYSTEM section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

My mistake, thanks for the fix Lukas; merged into lsm/dev.

--
paul-moore.com
