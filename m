Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7B15B137
	for <linux-security-module@vger.kernel.org>; Mon,  6 May 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028731; cv=none; b=MeDlNDX8UwJgj+sn4pKchlz475m0fVJXwewidpZqVFda58T0Omm7AuiKDPG+ciM5nQx/SSvbFycQ1Juzl3hSSqQ8jcJPd+Rc/ZvwxqHzaHaMIbi51lnC5RB9/Wane3crYJwJnk+ehqzP+ap434CZg0JhvgjoNKyTDRk8OoGbuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028731; c=relaxed/simple;
	bh=yCMlnDHuNBx/qGNlq8EvYeBs5TQNlNp2+Evuv2MUEr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBX1gVIgDkKxaf1JOMw9VlX9ABavT87O1RFBaoh6bDw74GJLmXrRsO+nKDmtCG/N2sj46kpBENRFA9J9Vo3II4D/21iAV+o3yTIJds57BSWiUS/ZbkLvp+kF/oJC+VUvrc/rI9HUiH0bd6r0gxl6LWHx/cf/oNaL2NxqPO3m4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gt8MPEO2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gt8MPEO2"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62036051972so26670057b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 May 2024 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715028729; x=1715633529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0aJldxObbqmwqRdokwOXsjkINM3Yq1p+ZO6p6LLpxY=;
        b=Gt8MPEO2qHWJ2stCzOWna5dNZ1O0qOonRuibtrYqYbsgnNpr6Z05meLxSTGs/5FdIi
         I+SA65HrZOv/ZBQYoV8kJsawBf73kqZsVlMGmUAd2g3DokCdr4p+BAAK+f2+2juR1r75
         3LOlc9/LS35Mz1h+vcJdWpxa8J8uxq4jFHA5YIrg+oHW96CUk6Ji14iu3WnD/apHPFDK
         1kq/gibn2HNy3ET38RIBMFfbd5JB+2eyi6Hb+ocztnXapRNcpRNGzRO0uk1T6uNQ4COn
         9enHzHigD3tumB6hmwu3q3d8uyFqisoK7B1ozmutjePwpkdHOenNJWSLAtb6bUBHu+oB
         ZGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028729; x=1715633529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0aJldxObbqmwqRdokwOXsjkINM3Yq1p+ZO6p6LLpxY=;
        b=QwTSXc6tStKmfa69Ug54s4M2L4M5fkMukzOoiJMrymoEcszKuGLopqjV46evRSNJ/t
         5pri1D/w8/vxR9hhvE1yZ+NPt6/pKYN5PAOcG8wIigbz3ObsrInKZQdHTjjNh5ZH+h6v
         Vc/RTF5SWKr1JyvbEzg2Lx/6xxVd5rJVLfKTotc7otFNLUGjJgCJE5h2tDEUeog5iqIM
         uwv+cqXKpK3XeR+0mdmnOIMxhD7uaOvPGnEpIrFa9ReeAyF5KM6ZcNcns5VJTsPqdqDz
         5Tud6lQ0yoRXQASmTukZgu5bZi6f4dIpyL1q/hkLIl8yvbVXQx6oUiI9GKvZUv0Do7AE
         H0EA==
X-Forwarded-Encrypted: i=1; AJvYcCVWkOppNk7oy/YCPx3dYqEA1A9L1mHEPiMpHlsOdWN550TfufLEfd2H6KT9rdXJRxoEAzRoh3/NjSVpCDKVzm0RFG1cFtF5g3RdQz5g57TTZHUOofWu
X-Gm-Message-State: AOJu0Ywbsj/S+lrLf6NNI7xqXTD2ZmSTe3t2mQMEHmIWAYemr+621k1X
	AkawtyaUKl/UjEI/r/saKi9T+9eZc0KKMH7h6XZLlodB/HzfR9YO0LHwwQo+xA6uBgpJxKIX0Hj
	GkOltOsgHcFJzQGvIJ39P2UvvnvUyuoO+Ees4sYrW1KLKKVk=
X-Google-Smtp-Source: AGHT+IGGFF3TGiRUMqSCC2WlHp4ApQwoT7T5/bWXwE/yklkvddWz3a47WbLGzgAyNG5Ymg5QfgMiGuECEknHhVdfwc0=
X-Received: by 2002:a0d:ccd1:0:b0:61b:33c8:7bcd with SMTP id
 o200-20020a0dccd1000000b0061b33c87bcdmr10805724ywd.21.1715028729248; Mon, 06
 May 2024 13:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
In-Reply-To: <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 May 2024 16:51:58 -0400
Message-ID: <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I also need to track down the appropriate commits for the 'Fixes:'
> tag(s); I'm not entirely convinced that some of the other patches were
> targeting the proper commit ...

Looking at this again, I'm not sure we can easily narrow this down to
one or two commits as the current flawed situation is really the
result of a lot of things.  If I had to pick two may be the addition
of the BPF LSM and the introduction of the LSM hook macros?  I think
this patch may just get a stable tag without an explicit set of
'Fixes', which should be okay.

--=20
paul-moore.com
