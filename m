Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31492777F9
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668381; cv=none; b=Q9J0nFf9ZgH7KDHO6rdr9hcaVuaMxQ1+NVUOamntvMlDQ5GJ5+owzNeVkcl94No1JV3eZP1u5vT5YVlVvrC4DVkO6Ljs4f5ONwdqDu1tdI9aJ3ODk22MjIFEL9J7CzZvhPCCnpp8A1tH2ZaNn6To5fFOW9lfctKyT5B+Or3DMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668381; c=relaxed/simple;
	bh=novuMTuhYNzqynSwAmnzr3dM+uqQhwQCtXMewPa/Wkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkJ3j8W8WQ/rHkATiLvdCI00E1139sV2K7mvyFM2QFNKBIdTw68DYfJJ+8apECviltYAC1cQJ1NShz8TfauMffOEyrG7Hty/j54rDVPEK73eoBTY28ytD4jRRsB2npbMF+JZUXbzANhRtQZnNVyVWrQJGVICC60LYaRdeGnPWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGUwc5Lc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGUwc5Lc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb4e36904bso30423366b.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749668378; x=1750273178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4nKI6dictu7VKkBmue+gE/ANqM7N/0dOk6jpGABvHA=;
        b=CGUwc5LcY/RKYUQmw1G93Y6GCRtWiXcYG7pedu+cPr622ChpXEu1BMslwTpWid2zPC
         74d1mPILRllHcn9IiEzRHs2eSI3KKNIO8PuLrpQNXeIEtUTGQzBF82oTDwfR59Qskcoe
         jsf3AP1ejl4BxquhUL1OIR3QgRCjcDq9BSDSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749668378; x=1750273178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4nKI6dictu7VKkBmue+gE/ANqM7N/0dOk6jpGABvHA=;
        b=i7Pi6/nifkrYO5lCr9TS8snNbEPk97E+44jyVCT34p1zbM/dxTdArqxOAiov1ilKlg
         MQ5sDqz2aO7lNHQSp69Y8D3ahd+2wg4vGOfbnGt5V9DH3Jy2G92SJinTkh628meSOYXU
         p3VUtyCPIptD0dtO+iF0Pyv8rkhPY16JztepBwD2jK30qiXFGhVjCtlISs6l+sLzGYPs
         fCLY/MD+Cmjfevou9MZHexp/gbaSJBRp66iswVMT9j6YG6QQPWnwgACiFlaMFVgkNHRr
         YIbLJa0JOpxtzQI5d8JhdlZ0rKmLlRUZ+fPQl130vJFr0AyGCZH1UBId74+mvWuj/2s2
         zOTw==
X-Forwarded-Encrypted: i=1; AJvYcCWkdzZejsSlBpKUDdCWdGZwg5Vbq2oFhVCzCOXWgkAXIELrTygjPGEWNE3I6ETYzROJTgIfk6vfLZ6/iy9VqfjcRNfEfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLzxc8NEnKCcaLhN9usGPOAeEAxoFn8huRQDM7OPCLVx3NUqc
	YM2vMZE9FOzscixWp4R7qLXT7fHR+Lnn6uRlRQBu18bloJqE3w3MtP0bz/+BW+D9yOzk7kgx6GF
	naQrAipQ=
X-Gm-Gg: ASbGncuLscAUMQqNqg2XNneT4bl/O8ulMkclVtWysZ7DZWApf6J3EUTskpW6fbSfwht
	iP27V8IMRl5SJF6HP6VquC7fNF3UziRBJB//Dps8lRmK1qiXlcGwMkeg+veHKPDyuRLhV/oPRtg
	RUlTN264FVAlO6AHNrQkUeDJHUnVnlvgh7PSXigZ8vjvDN/5r0T0iO+IAxP3guKw4cRepzKmyE1
	2E8iBe8skfph5Pgpf/VWi+kiLaaigJcXSN7A1FDR9x9RYwBXmLxZSI7/9XUfxFpGjLnL8lEaCrZ
	TW5U3mhdnayGpikgaxdnTld6wT+9VUikKguBrMQ32oTjfAxf39MaaBbQxnAPVVcVwDSz7CoEK4G
	Rov+4fLVHBeKPoqMDc+lPMkp3klAMGl2G9HOS
X-Google-Smtp-Source: AGHT+IGdmjW9tzvLRyScm47dWlYcTweuxRgwKNY3n38P5XmIapyjHutxz83WVkB2n6PDMip7VeDlVw==
X-Received: by 2002:a17:906:6a29:b0:ade:17b0:9f48 with SMTP id a640c23a62f3a-adea2e8b3f8mr76277566b.23.1749668377752;
        Wed, 11 Jun 2025 11:59:37 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55d0dsm920215366b.47.2025.06.11.11.59.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 11:59:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so431207a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 11:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnQKh86rcbTdCWwjA7tqv3jLnJv/LK5Da0WHIP1rvrLk4MtxgC8FV8k0GKwE9t8/imhpIUPjITXy2X8bdIAphVV/5Zzt8=@vger.kernel.org
X-Received: by 2002:a05:6402:2344:b0:607:77ec:fa8c with SMTP id
 4fb4d7f45d1cf-6086382094emr984600a12.1.1749668376614; Wed, 11 Jun 2025
 11:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com> <382106.1749667515@warthog.procyon.org.uk>
In-Reply-To: <382106.1749667515@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 11:59:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
X-Gm-Features: AX0GCFtsLno8Yfd-XNr8pAuQD_5-TGkXF-CBKKMqVdzdI6GXK5Wl1KZHm9JyRfA
Message-ID: <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 11:45, David Howells <dhowells@redhat.com> wrote:
>
> Do you want a signed tag and git pull for it?

Particularly during the merge window that makes sense just to make it
trigger my usual "git pull" pattern, but now that I'm more aware of it
I can just take the patch directly.

Anyway - done just to get this behind us. But for next time, just do
it as a signed tag pull request, _particularly_ during the merge
window when most other emails get much lower priority.

             Linus
