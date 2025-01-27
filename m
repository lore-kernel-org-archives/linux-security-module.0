Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F51FCD07
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969041; cv=none; b=sej2bD4EzqYTwHVrOzthzLEauNmbfUA8+qHNlx8sqbM66MlOcS9Nrjw7VR+yyuRN5ycsWFYBaYaoAcAsB0tOTxG/7t+jtIaey53O5+LVPg5zLaTTFTxEzgGF0ONwRfYgn88T6HjbqdjEEB+76GElqumrxvRCAgHScwLAIbGQl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969041; c=relaxed/simple;
	bh=Fx0hftQxjQH+OA4pUAaTnpVQy7FufPHEfu2+Ds3/DF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=egLC1YNudJ7OEAW7BJnt/3bDiWLHVB4SPgAnfE8V/YbG5J7f9Hokeeg45jaxcekeuWawlv04h/CUOXjAfG0NsP6znBzU1lXzTo8D6nnJ+NG4l//ffJMyqCW9x0zusJNcUmOqvDGFZxU9U1njTQbgaHdF1al89+TpptanrTcvP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXWdnJPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXWdnJPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737969037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
	b=cXWdnJPjKq7OWkzLwMFMB0JValXqMeRhVNXoeRFqXGcrGOl7QKg0Y+/gVQtxIikICnHmFJ
	ByyY/I+2s3QlclbvfupGx0jFGC7sO+UqgQy+rX25C66rpBRbZjQTSzzE6RPqtuUUgNISrp
	wBDgNnki9YmoLJfRMq77VoVvDSK3BZU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588--4RrDyEGO6SdQwLpk6bB1A-1; Mon, 27 Jan 2025 04:10:32 -0500
X-MC-Unique: -4RrDyEGO6SdQwLpk6bB1A-1
X-Mimecast-MFC-AGG-ID: -4RrDyEGO6SdQwLpk6bB1A
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef6ef86607so9784226a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 01:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737969031; x=1738573831;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
        b=IbKi2DwyuB3WPLEucVZS5HApJWhvkmEt0cU7Mx6oNuW+moPQa2NNer91n446yPbBKt
         xhwYRO1usmGFicupHyrcf3s53V5Q5vCnOln2yfjEXpL1vQDo2A9E2JR0mYsah6gFePQL
         MrbmxnQipej1DtwB0VduCsfKrtR3LlcJGiyreWtU1tBmxcKpuc/pzBhCoV1SSuIs22DY
         7pQVcUec3h/Tbv1hVY3OPgZEkLLmvxUP+baVCrRBw632oruIkhwxnDN93UIP3O94yH+6
         OEidQrRa7SCcKUbkDXKsDHNq5TW0y6wZ5mdGZGVvkmo7a6NtQiuK19ExrFXagY1fthOo
         wQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVjPeCDg50hD0YxJqFfUGMPu80wfrBeUgnY6/W515wHylNdzJpI3BQvVpjgwyAZnd5yYUs1JkZrC7i46oWvkXEza58Hexg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetqcrvhJ8DrGAM3p6wASbFhNFhWYV5Sr/6/d2YpnC6x4+bbwR
	jo4SVyhI7jQ7HcdyN9KPzJuglqhBxgLAkH2/3H6DApNT2Dup+tMjgAO9TQWni/rSc2sN7TPpEzB
	/bf9Evc/R+glkBiLs60199vbai5G998nYCh/18vLzb+5cg0tTF3Xw3XPv5BCbxff1YoqiEzM5ds
	OaC4PlbVJt3YgCUmcStMngV0LiFquV07uMmM8Eod9O9e00UvEi
X-Gm-Gg: ASbGncuvejDBiv3eQ9bxPRub/HJCpIiE1qMa2dvfbLgEYjGhVikCntuq/mhfu7I7Ggf
	ZBbej0wzCKpihA0JrpwZtVbcTkq3IueUC5crSjr9fPMBVS7dfFVgK26ViR4YtRA==
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id 98e67ed59e1d1-2f7ff2574e6mr19936682a91.2.1737969031486;
        Mon, 27 Jan 2025 01:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2AUO22esWP/nMztcVYFDxN/JjQ3c/z9eP3DGIjhv6kh/a7NKlgjY9QDegkDnWn0ZTMiw3QZuE5pSKHaz0i/0=
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f7ff2574e6mr19936653a91.2.1737969031212; Mon, 27 Jan 2025
 01:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 27 Jan 2025 10:10:20 +0100
X-Gm-Features: AWEUYZn-ZxFRojTIs7YgjthZOQiPBt-34IlHaFiIPdvHK4hhLsus_0rIAMhWgeo
Message-ID: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
Subject: Possible mistake in commit 3ca459eaba1b ("tun: fix group permission check")
To: Stas Sergeev <stsp2@yandex.ru>, Willem de Bruijn <willemb@google.com>, 
	Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3-ePt9LyZM1wUtfBujMnU2jrBd8Jq0o7hFv1b34FKPs_1737969031
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

It looks like the commit in $SUBJ may have introduced an unintended
change in behavior. According to the commit message, the intent was to
require just one of {user, group} to match instead of both, which
sounds reasonable, but the commit also changes the behavior for when
neither of tun->owner and tun->group is set. Before the commit the
access was always allowed, while after the commit CAP_NET_ADMIN is
required in this case.

I'm asking because the tun_tap subtest of selinux-testuite [1] started
to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
so I'm trying to figure out if we need to change the test or if it
needs to be fixed in the kernel.

Thanks,

[1] https://github.com/SELinuxProject/selinux-testsuite/

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

