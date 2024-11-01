Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F801D1E77
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491682; cv=none; b=YPtBaQdxFt/JDryKd7GWC+Rux2zlqitZ9ItMM/R6FYeUlgbHFSiyUDKpKr7LCcAQmiqD2YDoLfJUviU6NJ945MpilDRWnJvlXh1obq4jY28+KuaQkK/zgnQa6wJk9W1hVrlT3Ygc+wNkBnabIqxxbeuhBITqpC5bcJGJhAFuo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491682; c=relaxed/simple;
	bh=VR4FqvBnEsvLRoY1zv77QJD3sXqgdL0CVS+r85of4XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbUjddsnNy0PszU+6pxo81DvcqQRRCltDNVHfe1xH3oJMPTt5OFCobGPFOUY/4R+Gw3v1YvpfBrvzME9Pq73XX86GLM6DEk0KoSR4F0B8gAwVOYkPjvRMN/n+ABWqv+R5my3pnCiB3U7XSsAnPa5bHiMY13uuWE8wgKFT+Afxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aNbVg/+9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aNbVg/+9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ea053b5929so20346047b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730491680; x=1731096480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY/aMgJuGmogtnd0GSRrc1tukgb1zmFjr08wvyiufLY=;
        b=aNbVg/+9dvSlvtqNVi7Hiw1gM3+Q9wSRc76zqsr/TawQ1oVtzbTx+cjuPGNl1U2dq9
         ImFVA2IhXHruBNRcJ/kLSy+UBnOwesKfxehkvGDxrsDIM7o0QBHrq+lDmsDqLKgmLYri
         FcfIdhhl1M5Ol0miBqOo6SVuAY1V0p8GYHPWZ07whHDHigiezCkfyjttRzRqrZahMfO2
         BqY6Sn4Rpc+LAE08n7zqUTJSg6HxyXy4IXiQqS0JceqaAiHHICQz6KykDVJrE+lT/xaw
         zKnKneCpT3tL7XpGH6giBkBuR37TjHq1SJSFkLy1146NlsdpkoI8F80Tp7WxYAMxewoS
         A2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491680; x=1731096480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY/aMgJuGmogtnd0GSRrc1tukgb1zmFjr08wvyiufLY=;
        b=JVGOk/9fqAJSaCFT2UQbRPheAlTuSR5/TmROv6QdBsmuUJPl79nR+0j1htgYsz4uyC
         h3PM6f84If1OMWket+drMO673V37n7xTPpVMhHlTaAsuOvi4OCyWyG/mbrw5fXDbp0sg
         S7jTbmERGI8lFjHYvR1SU34F/2ojqE1v+WImGjptpyZxsrLkwHQVT8k87RQbcUD1MmXZ
         q13frAqtprbiRISxuQ72gEjU5SLLuOKvePQ5ENg/bu8j3nttN6zBcFnEGn5vIN06T7w3
         0sgO5SJeTS0tqQ+OUsu1hl7vnfPLBqIqHgk8ij9t1bMYmjqNVMrSUQQKNWwGZUE13NkH
         VtNQ==
X-Gm-Message-State: AOJu0Yw2tY0zJDvc1OLo3bSp7q2ojr5E1W33BCgZaDKrLAkvbVOZl2dk
	UDyTFRjiv0h5xK8pddiqqI5LfCHBMoEpp0eLqoYZY/uvYZlXzO1F4qOLQCTLo8xY710QJVZkxTB
	8Mwb9c/tuus7FGpDUU8oTa1l+AGM8kjPygQxCbl2lbyb6cxg=
X-Google-Smtp-Source: AGHT+IG//dGUfdunoEVJTi2A3HFcZpQS3rbY71/a+8HLJ5+2w73tKA2dYpqIKVMycEq5/GJuDcSxOwoKk1zJgg9fpmE=
X-Received: by 2002:a05:690c:6287:b0:6ea:4b85:7a13 with SMTP id
 00721157ae682-6ea64a9f4a6mr53969797b3.3.1730491679847; Fri, 01 Nov 2024
 13:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97463c75-2edd-47e0-b081-a235891bee6e.ref@schaufler-ca.com> <97463c75-2edd-47e0-b081-a235891bee6e@schaufler-ca.com>
In-Reply-To: <97463c75-2edd-47e0-b081-a235891bee6e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 16:07:49 -0400
Message-ID: <CAHC9VhTAijBwEtqi5cpdpo1MwSW4aLL+jy9ctwbU1XVcq4wEYg@mail.gmail.com>
Subject: Re: [PATCH lsm/dev] netfilter: Use correct length value in ctnetlink_secctx_size
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:43=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Use the correct value for the context length returned by
> security_secid_to_secctx().
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  net/netfilter/nf_conntrack_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Casey, I'm going to merge this into lsm/dev-staging for
testing, but additional comments, reviews, etc. are always welcome.

--=20
paul-moore.com
