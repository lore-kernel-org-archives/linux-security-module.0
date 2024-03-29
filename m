Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5D101C6
	for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671985; cv=none; b=Eh7RW3pReU+gyUEqp4dHU3dzFocoJ7nvaD0SvUQ8aixVjXFolZb629UzbkIcBYnvXVtNbCA/YPPoBEi0FJsrlSQuerYGt/rdSkYvEiiwUQcHO1hFfJoyHs4y1CPN1GDVdgFssvOUERu2dQlrDFaxkcts9rB6+5MyzCehUONMdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671985; c=relaxed/simple;
	bh=KsljLY9lc3Iy5TvlPc2zk/yv7ZWjkSS4lAxo5jx0LSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf1PbfxxPFkWLup10XsoJ0bHddnET9u+vLMkBRdQZwps5T4ensrGfnQA6Xgmns+1mQUKfEbGOE6aSK7WqVgLB6BrRU46CzaxPEdgWgWXBTR+S3NyJY9FZAyDJFdH0GYWMEq8fs9GKCiAWA62gRrynkzSSnqELRP89NgkUqUW110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bt9eh9o2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bt9eh9o2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f3ca61e0so16757727b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711671982; x=1712276782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsljLY9lc3Iy5TvlPc2zk/yv7ZWjkSS4lAxo5jx0LSI=;
        b=bt9eh9o2VH30Zd6b9jzT/+yU0nf9c4kecAgL6RFQ9CnXCYy7Lu1yjPdm45w8YxB4Jd
         voujs1O2lzawf8bvaH16S9PQr4gy94GpngAvv0LBa0ql0hbGU5VWtfnDKDX92D0O2B8r
         K0qyfQ3DtzEBdiI6z1Ym5atsOQSGZgd1b585SHLmHeLPkCPXYGJGJqzqz9N+5Ss/s9tq
         mckevyVf1OYGgdvno5Cd1pMlzRE98W0yTPvMn8D8jbnmYvSs8hAgInKuPlp/alV8XbN8
         z9QLUkx4BgJY3hxf00M4MJ0yInqSpLCwOQvO+OepUn/yMUtqIbmXQYXwT1HcNQCo/3Qz
         JJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711671982; x=1712276782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsljLY9lc3Iy5TvlPc2zk/yv7ZWjkSS4lAxo5jx0LSI=;
        b=BwWFkOBMQmLtewd3F0D+qNF1CJ7hlwcXYLBf1nhwjqMUwV7bdxH/fpOEVmmUMxUCqh
         A25Ur7VadbjeKqCfqKjCo1b12Wb1QPg0eUssOgOyedT5Mp7aWu7GQP0N3Us85EKHvjdd
         NUcc/9d4F2D15d8f8PFJUqALR1LQX+345BvNMcUOZBbzFpxXLTCCZ3f7UtuqiAdGVrYC
         HD/CY9Ach3G8QqFzJBc1Dfqouq2pSZSJfk/SjGokDs2VzzJNdoOvuzXHpMgeRYMQkG+w
         yj3nXe3P3paBD2Ytc+UydcXeVRw+V7wZHmVheyrQjk35GfOyWfa8oKtIMgGfH0Xve8Z8
         jaPQ==
X-Gm-Message-State: AOJu0YzePukpiVNFZyPTfcHUbFwK9ODl1R1Lr0eUKXBMEYPBjD5Ezth4
	wv68JQOr6RCl+JmEk2raI6nTO711+zsf5P09wiQcDcSZQSaVBuNqWywQcd8JKu9H26mrxGGQfsI
	ZiK+5J2fAnHvH2i8C5gH1K7IDV/lgNxijAcSPDTkW9RThWt4=
X-Google-Smtp-Source: AGHT+IFEWiB+xhSIdkgvKEIy7OHmDeckb5X3kUfoF7aNXKTFAV2hTiGBmQkLgLVnd/my/oo1O7U+1Z2UyLNJshdAe3w=
X-Received: by 2002:a0d:d511:0:b0:614:2749:b062 with SMTP id
 x17-20020a0dd511000000b006142749b062mr1064200ywd.36.1711671982475; Thu, 28
 Mar 2024 17:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
 <20240328153800.GA17524@wind.enjellic.com>
In-Reply-To: <20240328153800.GA17524@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 20:26:11 -0400
Message-ID: <CAHC9VhTwZD7OU9v36HOd28a6jULLJeoQTdNSBYZWSrsY+jf7ZA@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:38=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote=
:
>
> BPF provides an implementation and would be affected ...

Casey pretty much summed up my thoughts fairly well, including the
"Bear poking trimmed" comment, which was worth a good laugh :)

--=20
paul-moore.com
