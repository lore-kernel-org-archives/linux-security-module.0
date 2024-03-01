Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB737160
	for <linux-security-module@vger.kernel.org>; Fri,  1 Mar 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320501; cv=none; b=gGMXOw/x8RUIIFVI6wwpFUIALaDiocxZrCb4+U0X6f7G+09w/65TmtTfgT24ZoDgGN9QrUB/OmYq+CJMM7LarxFAGWOeg+lw967O6h8C8oCoBkhl3noH6r3u5vjYzBLNaIAexjBH2VZ0xW1RRwbPv6UlHeZwKFMdooA+ln4KO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320501; c=relaxed/simple;
	bh=DoHD+IlZGZGFnoeTiJY7tCzcXTc9M0i8ugtMzjvfO2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Srh5EKDzwP94oQCG3PTFmzA1fYcX+3/h/AdV1jN33B/99OrIWtrawC3O37A9hPSEKbxF/BHFd1bx/o9wfpOo1ZAE4/RVfeyggt4BI5Jlq12M341vX/ftIO3MXog71pXYqlsXEf4OesV5Y1FU4iVDjD3pyt29ZFLgKpE47s2adVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a/B6/TFt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/B6/TFt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a441d7c6125so318095466b.2
        for <linux-security-module@vger.kernel.org>; Fri, 01 Mar 2024 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709320497; x=1709925297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3NhK1nZHCx+JgrAFg4MO5evKGLZk3EUlzp4L7qpvxU=;
        b=a/B6/TFtNlCUdMeKXfJLX/fNvyIO7tdq8xWf9VOJ+AdMsZodb3veF+XyBCE+4EcBF+
         JJMr9aznjP05YAyoRMjjnBv9RJb2sk2db/4VB+/T0/qr0vMgsv5Yxjp0cyUohKhnAKuy
         DFcN/RrKaF2vyl3+XojFB9S1+gz4oTnt6fwEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320497; x=1709925297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3NhK1nZHCx+JgrAFg4MO5evKGLZk3EUlzp4L7qpvxU=;
        b=S3ambMqd3v1k0F/BnDOvPT6Zf5rkaKHBKx1uFMHDCFWXrX+S7/9tEC9d6nvbU7mGus
         ReP10Lq6Z2OHGvIfVuOYnnitbGyMY5ipySRrI1DeXyGYSFTh3UDp+lF+N7CsSvwO0h4Z
         o3tngTGCOV8dw72nubmxcjxI3r8rjWWUEDSFS8OEvmPYBcXp6E0EEwnR597SFzSWpPIH
         xvWxhxskscFc7NWobW378+kZsrQmE4oA1aztmz79lCAQPPigg2Yk4fPEtp+kg/Q/LQPR
         hbY/4Q3MGjtKSuidxsJL+wi0BoVudi6bjKTzCWRFfiAyckEtshJS+GoGbY7UW/m/M51L
         WmLA==
X-Forwarded-Encrypted: i=1; AJvYcCVoTrYcgw86wuTEdAyiSkosT/tpz+1GfD0Eb8rwjDH341p+mxe9QgAbt0Iu6OdOc5FSUoV0zZHRtg8UjuHRJWLxMTmx5C5O1HslIBBFbJT9tksCdlL7
X-Gm-Message-State: AOJu0YzZW2EaDugekDJEEgpLlWk21n/jcA3KBlU4CaTMJT/XNhOJBjKo
	SxwI8nyOeIlwGtjfCtWavlw34q801Ny3pT5wdWPjLvoc8gbcll+fEpOnD8z1ObhtMacRGyubvtM
	SIbOkSQ==
X-Google-Smtp-Source: AGHT+IGtGjcJgyM51OP8rwXgZzStN1RNi5VBhhGMPXELGgVjIGYw45o7xvbqrW2oXZrygMruTn/S4Q==
X-Received: by 2002:a17:907:397:b0:a3e:b188:fcf3 with SMTP id ss23-20020a170907039700b00a3eb188fcf3mr1736072ejb.48.1709320497678;
        Fri, 01 Mar 2024 11:14:57 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906049100b00a40f7ed6cb9sm1951168eja.4.2024.03.01.11.14.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 11:14:56 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so3784993a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Mar 2024 11:14:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRN8pFPErJNjmBCfBRYJN7hBVkawN1/LJDCs6UaWeDh9IOrQx2/sdDf7rkm6XWLAXJsestR9/hBhr//2AZLVONJqAqJgkfMKPtXkRagpU5gkL2T2Ot
X-Received: by 2002:a17:906:6c8b:b0:a44:8daa:684a with SMTP id
 s11-20020a1709066c8b00b00a448daa684amr1910978ejr.23.1709320496462; Fri, 01
 Mar 2024 11:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com>
 <70bfa1c9-6790-4537-bdc5-5d633c6ea806@I-love.SAKURA.ne.jp>
In-Reply-To: <70bfa1c9-6790-4537-bdc5-5d633c6ea806@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 11:14:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnYs-jYR-omTJGB-WAH4RQH4b=9NU6N_7foZxjTWK-fQ@mail.gmail.com>
Message-ID: <CAHk-=wjnYs-jYR-omTJGB-WAH4RQH4b=9NU6N_7foZxjTWK-fQ@mail.gmail.com>
Subject: Re: [PATCH for 6.8] tomoyo: fix UAF write bug in tomoyo_write_control()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sam Sun <samsun1006219@gmail.com>, paul@paul-moore.com, 
	syzkaller@googlegroups.com, takedakn@nttdata.co.jp, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 05:04, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I couldn't reproduce this problem in my environment, but I believe
> this does fix a bug. Linus, can you directly apply to linux.git ?

Thanks. Applied,

        Linus
