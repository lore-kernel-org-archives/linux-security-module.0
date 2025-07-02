Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCD28691
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421949; cv=none; b=llLtJQ/lTcEXrDRkJwFrfQtK2tBlGEUCi0X0NdTSEH48STOtO9GKY3AD8AMTUsWSo3nBNmgi/2QC77bzUbhR4FEqT8epbbEgop1wGILct88jmT79UeepYlkAx7D0PdEDZKdjntHT+kuWfGIWKgb/h01ozJP/NRdsQvPoRm00X4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421949; c=relaxed/simple;
	bh=911hV8a9I+jklZB7gFMppdMt0wbRmCLRDBzPj/JfoSU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KPg2lMG7yGaiUom8fzTQcDAQwxdH+XSkgpEfVZHDsZSeGwePYj6Hzqk46hmbxiG09+b4VAuEv8riIr62Jt0ffheEi/NbQwzjO64pZVB+9ozrK3+uB6aRkjRCBmFhLrXOy+vLI/30B9Hr74gz4tv6jmrYIfxxED/g+0Usy7pVJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q3tj0vUH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q3tj0vUH"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a44b3526e6so83305481cf.0
        for <linux-security-module@vger.kernel.org>; Tue, 01 Jul 2025 19:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751421946; x=1752026746; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRF7BTdcMuqSJi+MjD5zQvav9o5CcNF+4OHE5C6zwqU=;
        b=Q3tj0vUH3+jqMniDPksImnXvW5ybqJv/7bj+RHcA7ZLt9QXpAJcYgl42VmpqRJl7fJ
         sR6jgWGCjuwMATSFV7f3qD1f4bpLHMXk8AnlhARbbjZ2l5g8b0QcUkcJmTW1121gbQDE
         HJa8/2TTv2aq/z5VPOwj5ZTnwnj/qZVFTiI8ZyPPbKrNuu2m2DeP3oWzU3dMAX7kxgOz
         1WL6F3lifTmlYfhmTFn2aaJnBWD12adCaC37YGlikrQXNnRyEjzYIbp3RT5+PhH9E9ji
         ycKxcJChLBawDou0kIDkrZqSK5f4EfxDHfhyzS7HZhk+a4BrUHRBkLLtc6yw2OBtK3vg
         dkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421946; x=1752026746;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oRF7BTdcMuqSJi+MjD5zQvav9o5CcNF+4OHE5C6zwqU=;
        b=gcTvTBYRuXlOz7iRTxclig8pownfAHrNPAxRHWcKlGK8dbH6U3R4y62oY9W0H9h37O
         YhWPIYfeYbU8VQ/RcDfl1qZHcVvN34mmCxWfjDeMfx/l6CftFMT9B5A2Zf5hT38UbMb4
         qgDPmpBGjnZXZ/9zRGOKPKZHpxDtXAGTrdxdMnsPMTE7VB9PgQPT4Tmo6nwzj9Ji7R/6
         q6vMDy9BkNvKY9lbA4+f9NYzp5pcQ3ZJLyisOqMpZvfTJtdZZGFJ2ciRCn3GgfeD5J5F
         J2n4Fk8BiseAlHTfA9oRmPhOVygxFRVDaorhh2s5JyerQySfkB4qLlf9hSsN0+xrInE7
         PtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBMXGBqgUb2uh/AM6d9A3T5uQKUUP6QTWBqaaNDEkCzYk1S7wwL2MAzSbOJXenu9lJNIJ3gtZSPj+EDg+4F+Y1xFVoIcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfh8rCK8Wp/Z7H5T61Ct29NavxZX8yTTlfV5q1BSk7BelpQkk
	kQZR0OF1MZJG/Pq8Bn+7FHSfFheezoDKiiPXZsdqNfjlTxUcX8WKqWDuruRA9dIg/VrAjH3pyvP
	xQY0=
X-Gm-Gg: ASbGnct2Jm4AgalFOtR5ELJ3DMyaUGp6GM/USGRko7RFoqv8A1g+hRWmVZJWFBmq/M6
	SV86pujr0TnCZW7CZ4q2IdpJbF0LCanYIA8jjT/bNAGZBx35D9dDwpMNTKp5h1PJf3U1VViLwiW
	44v9LUDEJmMi/KPxMIZMPUKeu4E4G4FkKu29i2pncpDZZPRgbL9ujKRKTVDhLfjZYHXbq+tUZP8
	m4ULgQsaG8gafOFe0mwi1DiebczGYdQAqejDdEf0zvp3JsOqn6jJI7LP3IuLG0lKMTM4gqrmyBi
	8uFZvxCta1UcpdYEXmXy5GqOtNFHulgYtyh6z33HA2JMjA42ju9729naWd7Sp0g7IGyl9wmNQZc
	rUgY5aTLfzPaUQ17/UTr2VqUQhfEie+M=
X-Google-Smtp-Source: AGHT+IGjfL3w/fQAJ0CWeLV8lWxYgGu7s5ha1+wQoIIQO6UFJBUQtlCsVaOcGLdpobVapuPadBATyQ==
X-Received: by 2002:a05:622a:646:b0:4a8:225c:99a7 with SMTP id d75a77b69052e-4a97696f5b0mr19029411cf.22.1751421946213;
        Tue, 01 Jul 2025 19:05:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a7fc55c67esm86875451cf.48.2025.07.01.19.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 19:05:45 -0700 (PDT)
Date: Tue, 01 Jul 2025 22:05:45 -0400
Message-ID: <66376202561209641dad1c8894ec62cb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250701_2201/pstg-lib:20250701_2201/pstg-pwork:20250701_2201
From: Paul Moore <paul@paul-moore.com>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>, linux-security-module@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>, Serge Hallyn <serge@hallyn.com>, "Andrew G . Morgan" <morgan@kernel.org>
Subject: Re: [PATCH 1/1] uapi: fix broken link in linux/capability.h
References: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
In-Reply-To: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>

On Jun 29, 2025 Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr> wrote:
> 
> The link to the libcap library is outdated:
> 
> > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/"
> >
> > <html>
> > <head><title>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</title></head>
> > <body>
> > <h1>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</h1><hr><pre><a href="../">../</a>
> > </pre><hr></body>
> > </html>
> 
> Instead, use a link to the libcap2 library:
> 
> > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/"
> >
> > <html>
> > <head><title>Index of /pub/linux/libs/security/linux-privs/libcap2/</title></head>
> > <body>
> > <h1>Index of /pub/linux/libs/security/linux-privs/libcap2/</h1><hr><pre><a href="../">../</a>
> > <a href="old/">old/</a>                                               08-Nov-2007 06:34       -
> > <a href="libcap-2.00.tar.gz">libcap-2.00.tar.gz</a>                                 11-Jan-2014 16:49     37K
> > <a href="libcap-2.00.tar.sign">libcap-2.00.tar.sign</a>                               11-Jan-2014 16:49     819
> > [...]
> > <a href="libcap-2.76.tar.sign">libcap-2.76.tar.sign</a>                               13-Apr-2025 18:20     833
> > <a href="libcap-2.76.tar.xz">libcap-2.76.tar.xz</a>                                 13-Apr-2025 18:20    195K
> > <a href="sha256sums.asc">sha256sums.asc</a>                                     13-Apr-2025 18:25     14K
> > </pre><hr></body>
> > </html>
> 
> As well, give the complete reference of the POSIX compliance.
> 
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> Acked-by: Andrew G. Morgan <morgan@kernel.org>
> ---
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Andrew G. Morgan <morgan@kernel.org>
> ---
>  include/uapi/linux/capability.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

My personal preference would be for a commit description that doesn't
wrap when running 'git log' on a 80 char wide terminal, but ultimately
that is Serge's call to make.  Otherwise, the updated URL looks good to
me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
