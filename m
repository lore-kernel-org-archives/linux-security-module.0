Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986361E132F
	for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592829; cv=none; b=W0QhwhLTiy0JuhwZZWMdh6Vgx3CZpMAJ4+hC7BVjSvniUiOAwktfH8mtw18YjALluDABSkvzO7/MndfNu76xUgvmbMjuGnQmk9g5+P+asRy//p2KiWX0skAEFKJ84Gjo9Mqgxu3QmuTZitOI8CwQF92pNhwpnMkrw1m/lr2S42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592829; c=relaxed/simple;
	bh=zkZ6yU7DAD7YlmNJhmdip7MiifrOdjdqdbURkrcZAYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjVyn1O+ntLoCHTTohj47evxZzpS4frnStw3nubUgmryRKp/F2aIIYZVb9NEYlQc9PxCXzf7msTmwte9xWbN5wnE8FDVRV/nlBxw88arL6OZjqm8R3+SjX6bCTB8IIPKJSmlB7S9USXCPxDtjAtyzzrNfj5rq8hTEsSs8BdUwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Vb26OtuE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Vb26OtuE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d39d9f782so810684f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728592825; x=1729197625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO42RQZBShP/lWCFh96DLSqblFSQl/8nGpu3kPW9gUQ=;
        b=Vb26OtuEA5psk8oKRqbL9ncjFN+fSdcc05gol3AShlW2GBEilMuCE6vjNCikA1j0av
         eWCcEDeJpfgjg0IYatYWao+zQpeqOYdbX1rTPuNPto9IPiRQ1i71tx1Oy1eTbnFgTVZK
         lCj63PU0FWQphuTL4NmojGHEjHrlBTCtzL0u/fkNzI7EoiDptj01HX4ejt5TpvtehKBH
         4DnXHvkq3zpeSbAl3osmghVDT1OlCL4tRuzRcehauHhq/MudRbtdgsW6ilXKiHvwNFnp
         aQsSHKcfMlRUxwQk9FOLyhUoMa2aIpkvni8hbR2vHTchk71lgYxig+asFofWr470cchd
         P0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592825; x=1729197625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO42RQZBShP/lWCFh96DLSqblFSQl/8nGpu3kPW9gUQ=;
        b=DfxabUPAZ9xNH77B0HWuJ/5YogqDLAryD1KLcVZUaqxnI0LFAXCC33RI1WaHOip8u3
         ym78YG8FqhdWZkNP0Uo8yo+/11eqkoukYAOURDf8hLHY68O393zvHaqBZSCFTEUDUcXP
         eFJc8JzJUK8HvqBynnFX6xwtqa9CwTJ3YnH92+a/CrOjvu8liNaSQKvR1DGoT+duRZdW
         UlBrNTUoqevII+PKj67qyjb/dwg7A3P2YUNBGyPSls/2gIcdNeQVUobg+X0aoDjGjqzJ
         7iT6l4J4AqUOBmOTWOWy3k0Bq49XFl0nMJyBdVjBwxNRwppleMpY7nnxntBlbDhIXXVQ
         2UuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDes93QMBKXw3KTjGnuQm+lQGiwjG90ey2cGymhvaFeUn4ZELygqeF5L6mePBGMpVV5duOYhDULIqIg71a+2wq9K7EUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvPNqXg23joc9mZHBOjC0wyH+mrvVZW3zW9KP1vPBRJnLPf6G
	TW8a2wc2OwIFG9a1jCQmwVm7xqqPOcalyI3hEDSWK5uvq/gjBtKVKKQ5y3dDeio=
X-Google-Smtp-Source: AGHT+IHxYd9hOLDOuUcfxARzg6HTs3XT+7x6QJejf/5EJIDnBLsxJtYDpjq4FC6Qz2lH63Rfd81qjQ==
X-Received: by 2002:a5d:4591:0:b0:37d:498a:a233 with SMTP id ffacd0b85a97d-37d552ee198mr196344f8f.43.1728592824756;
        Thu, 10 Oct 2024 13:40:24 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8928sm2339875f8f.7.2024.10.10.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:40:24 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, upstream+net@sigma-star.at, audit@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
Date: Thu, 10 Oct 2024 22:40:22 +0200
Message-ID: <5924990.Vcsy2DjxtS@somecomputer>
In-Reply-To: <CAHC9VhRDZVJbhCbVkfs8NC=vAx-QdQwX_jMq51xzoTxFuxSXLg@mail.gmail.com>
References: <20241009203218.26329-1-richard@nod.at> <4370155.VQJxnDRnGh@somecomputer> <CAHC9VhRDZVJbhCbVkfs8NC=vAx-QdQwX_jMq51xzoTxFuxSXLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 10. Oktober 2024, 21:09:31 CEST schrieb Paul Moore:
> However, as part of that commit we also dropped a number of fields
> because it wasn't clear that anyone cared about them and if we were
> going to (re)normalize the NETFILTER_PKT record we figured it would be
> best to start small and re-add fields as needed to satisfy user
> requirements.  I'm working under the assumption that if you've taken
> the time to draft a patch and test it, you have a legitimate need :)

I'm currently exploring ways to log reliable what users/containers
create what network connections.
So, netfilter+conntrack+xt_AUDIT seemed legit to me.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


