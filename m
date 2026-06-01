Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664B332EC5
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340481; cv=pass; b=A/4JRgci0wFYbyVxSmH6I/e0SCAQ6NtI6Ewjd4f9pO3nY4mPehSmuIgFzYGGYySi6/NgmnQEaRF2J3rHw/6pxggWJqpoKHEMuTgcrUs7kypbtO6qSCcOsn1cgol5rTfrlJpPl+bNXPQDcuPDAtJhzdAq5B0TZQv2gYe8tW07tHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340481; c=relaxed/simple;
	bh=ixyprkSXuQ8/cej+CuJ8ZzH2+XWpSHoz4zX76Kw+DW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQBXJvJZltfPikV88xljqis5zwz1s5x08MQTrssNbehK6/3+kUnQp6yvTv/rpNJ6Hj01ZlB5/EF4PQHdWlIRne0qJgCZ4DJLLqZLoOw4LwnAZbG+pxlaYnyiKFs7P+4q31cR3sIrZhnHThc3AalLK4dls7nlJ7ZSCzU3b3nF0R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhwtn9jU; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhwtn9jU"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dfceeaf168so30767707b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 12:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780340479; cv=none;
        d=google.com; s=arc-20240605;
        b=P4DbonlT9erJTMzgt21B7Q+y+ZPFjBHsu3wsHlpRhnuncJUGI0annQpPyY8ZuTiO3k
         RZS0u+b96T/RtBi6OBtpSnM21zSK0ODJHN5AuZeRn8aNusv4e6kNKfRNW5BOhfoNVMZv
         8/BYuLVSEoYaUtYaz7MekrQXnkHrOpJrDkECb1AmML0NnOI3aB71CFWeBjq/8ofMQqIC
         bHPivf9lRFUqJbHrINTeciWIkZvty5jELyQTsUl6P2w5S8mle/BjKRdjpFFHavomCeMB
         7Nln7F+PDij8YfAHrr9fqBbr9Va1XVxoko28Nb9JgJ9Ro94rCwV72iDfideFZ6gMWjly
         8Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        fh=NZGbtH3moS2wCC9nAolPzrfFcfK4pqeWpOolksucVGw=;
        b=e2bAto/jh2CrZq9p0YHDAtsNaxpSkNw8xUhGnLe/IEScllfkKbcZ8DAcOPCGislVr2
         IQDiMyAHyDzYXMrr8rLQfm4lE3G9q2336HVCsJIHgtT149QGhTgKFHL4Ccb4wZNl0de4
         kQk3UYgsE/snhVVS3ciJmDbVbtxpf8+3l+dwY/kTtYhe8q+kbowZ25Pp3cVKrsui4HWi
         crjR38aDYS+Nlus2q0n9600Z3Rjq4OmCzbT3o4wCs1uiGLuJyW8lpFLOtt/aRXf6wdaG
         bp2t5ugycSFj3iPtzAzVs6Y5+W9fWHthynvWi8DniS1ObIn3H6AtHPR/CcOV9ru90oDK
         ZCjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340479; x=1780945279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        b=qhwtn9jUsrdQtd9NiJN6WO9AvAnSQ0H4rIg5yTie9XrxDU8RpV/hAYUKrzPkVs7Fz3
         PDE2NvZg7Rf+neM29qayCHhf9rj9DwIt1adWXJ+8T7LZUpv5l16ihQXYPKwU+yL45bL+
         telgvW+5/tOwh/6ROHShkjldF3rXqKTz/ZR+qb0yWgOgwWEa8nkPjthtG7rWPz6O3dH5
         1D5VosYNFit+Bq1d6DHsGUpz2BIU+pSPCwN/BNbCoetlIBqwqXpFYj8aLoDCv6lTXa8z
         jrH2ATFpgcn8f6VKTJI9Fe3Rig6VOGtbpEJcj4xEd6mVbwSUyRJz/B+WXfEIW68Dijk0
         quCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340479; x=1780945279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        b=qCNVYlNs/zDHPR1NWRk8+lrmEWhymm4TiAIOxuz0rxxwKV/LkJd0gdoa4ejfpcHnwT
         t3/kOQ4m2i2FFww9wYkRCUOT6xoJLF27yiDHatNZf09NOdO0j8jTGfJVlO4279HpGdvQ
         eYecdZVIhmhkVvq2SX2otjo5CR+aCRbTZAy9Uq3JhU8vXj+DsrQPqA7jwJHbHYGu1bwi
         3KmdgRMluYL8cKsCqFuLOHpMyvf58yFSsOqc+F44p8suWtbIpf84PAAr4/BEEt9T0mRJ
         gi6v/4S5Yy2MAr+80N9CH/HhIm0ZAW2LxG3eELNhdVTx5ASlcQTVbaVVxS8GrbGKvaOA
         dfJg==
X-Forwarded-Encrypted: i=1; AFNElJ/Z32tzzQ7OC0YK5thYMPiDh8b22/s00TqP8FWykvmT5JDk/lr8UhjN1S7ZzJ6iKXexuVREeIUhV7oRrv6XANMtCSRm4XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxm9pTwhTrZBO6OdKoLnkI+aYvG3OTdRGO1TLX4crP69Hq/zK
	SX5D6QAhQv4i/J+Tu59+8SJerIDV/kXM/onU2SE/ftw/pF7GOubGmEaPhXuFdPQPJdPKMD/Fkr8
	5uxW5Nxa7RwdnouWs0CN3wR2ftPbi+hA=
X-Gm-Gg: Acq92OHuoKdEDVZhBzcqpok8alGIbDCzktw7kxK6NlEG79c4YZXTjyaqGaJr7uFwzYT
	8zAa8z3Jn2cTsWqH39+j3Dzi/KzSlgW+92QRuOXsqYYB8mBaYTzqh5jgkJhyS+/sg3OZ04Ml8cH
	4pDotUZEMhGMy5oypF34MP5q1iqn/SzFFipkWtTFNvpiePeuQl8OqOZHAbACJrE1CvlMAb/Vryk
	Tg4Rj9L8Aj8guXEuYrEgDLhusE8fiie3oTFpKhWxXtiIdjTdFFlH0+ZJ0Og1CgbmulBOc+09y83
	0hmtqAnCGPpO32Gad4yu
X-Received: by 2002:a05:690c:6188:b0:7d0:5c67:200b with SMTP id
 00721157ae682-7e053c6e5c6mr108864457b3.0.1780340478662; Mon, 01 Jun 2026
 12:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
 <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com> <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
 <ahoaFz8DMMvWgqL+@mail.hallyn.com>
In-Reply-To: <ahoaFz8DMMvWgqL+@mail.hallyn.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 1 Jun 2026 14:01:07 -0500
X-Gm-Features: AVHnY4ICHP58idHeuZWxO_IeHj36zmgKmUPedtG3np4LABX7OFZlmUkRRLn3apQ
Message-ID: <CAFftDdqyTrr=wS2hUT1EvAqVsbegPRh9Y-rH5S3VEpvXbJ6QRg@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

<snip>
>
> How about security_task_prctl_allowed()?  (Mirroring security_uring_*)
>
> Renaming the existing hook security_task_prctl_handle() also wouldn't
> be too bad, but that's probably more churn than it's worth.
>

Yeah if something else is already done, I'll just copy their
convention. I went with suffix _check for now.

Another possible issue that I think other upstream communities may
have with adding an additional hook, is that there will be two hooks
in the prctl syscall path,
I am not sure if that's a show stopper?
