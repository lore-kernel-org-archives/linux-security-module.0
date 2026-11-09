Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268567;
	b=hMWxloI2aVVJoFaoQpkImoFbexnxAfHTsr9t/RpzL+E+Fqr5f+I1fLShuNe18K/tgppf
	 5/WHPTRoSoS7OBgQaTcSXp/QqOdZHN5zNnSbaenywMllTRD2IxNAlbgw5BgjjRjPKmHRA
	 KpwRCST/6+wE7+GI7uR3NaoUJGZu3VIivWqxobZAEAmPuhqGPpl/IBfeRmBylGKgqxS3U
	 8fbxiGms/kE77yL2ONExOXyMF4zBC55yO6+18N3Ou1pBwhR+XOWKzxEdHlIxN7ZooL2Gw
	 VNFF4CzdF75tifPYQPOlNcgJr3O+fB4xp4aIrywwqpkdC4fK2jX2Pg0P1Zf6DBBxY6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
	b=kK8ggsTFs+jfiI7JnYjhwr0bj1f8OWWbmpu1LERNlQo6avcltNMVV0ClSy+AMGhn43Sv
	 dRMeOfDnJJT3EZnlks8GyczKAvYC45QF3nuEL5KJjf48ktELQRVSmtKUR/asjg8NcUP8P
	 p+5f6LxaPqa1PxWJNaK+BhrPHLe8cZ11bcx8q3FaKq/Mbah8mZJoS3mSwL1yImIMItyH9
	 j1HyYnzqfpbgvjg3B2SdJzcgz2xeE7xT1i8mAJRzZsl7jTH3u/3j/sCEQhmB6joCfJ2WN
	 9PxHOFt6DZHs0XfVuSr82GPhLXjGhoO0jbe+3Eez4KoYmyIKwTHBmLwpHQoYPWYmOIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="X71+CO/U";
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FB606A32A
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 23:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=X71+CO/U
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91eb53957cbso19921896d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 15:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794268566; x=1794873366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=X71+CO/UAe8HAQkMdGHqP0bP6m6tjZ6XRSvDGuH1my8Ndb0JVf4fQ2URnECDJrvpfA
         reKuJ2eBA/ZA2j7txXFsYAdmaRpa6qkNvDNPxaLog7FCBEDlTaKbSnQ9UVGdO5JOfnyc
         /dHaEM73uSGSetbd1gS5r7XZ2u/f9Le+jynSfHCCXbp2cqabapOEpkqV/c3bbvevlgAo
         ePjYjVDuPAEaWKuxgVhrlYAptLVu2F5XEXgUw3CmOoJzKQ8oEtB92JEcN+VDfO85PwZc
         uJYKEDM8M5o2cGcIGKTD5o/lbtSWk+JWgklHsllKWcTPCfiBY5B3FGCYZqQojx0u1b/s
         hF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268566; x=1794873366;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=0At5PvxO5+fjQe22g3wx65RwNMAAJSNKB+1JtWsXERZj9t3EWqa4KvGpGpqOvq0OFM
         JjFdRb5PyPUIPNgi5Zv1hSETOujIoQEOQ4N4MLEHUzrqPZPHTuw0C9y2NR8HomQYrwZe
         i/+bjgh/zHVRJ6RRUuPtCJtU2qESAPVuItxZ+eAYhNVvgVEDFsYwDSI7Js4D0pkLksnf
         YFYBkogUq2jORCTAhE2Yxy6oaES+6RmBv5QHH5i7Z56F03+EhClS1ePqMZWrua/8rEdz
         qLt4FjhxSxOwUEPYQ5EXam2dNT3nfuHbeHVD5fPcmpZK46ExLPD/rBtFR0sgtE05fMET
         UaYA==
X-Forwarded-Encrypted: i=1; AL+hErFd+5Ds5fpBRCqS/8VgAt6mXzMgYis8JMn+6ydKsiWHdtPKGw19pRWKcx2CVob9XXvD5WFPllop4fkGHfK863R50AsrgUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9siTxgsZdyY91538xvxzWTGDa0MDN7NTDtpJyvOLPTHh4twH24
	Ok97XuvAzH1A5MGu8BwEw4HMF4gIhG9soXyXidcFMbA17FUkEjZpDVWoVJf03tWt0Q==
X-Gm-Gg: AYBFou1bpMpCLWF8HksZwqO05H+4ZnFyke7Yyn6tYGcZchPs0zOrPxjUXVJ0+kJ4iOJ
	izeDVdVN3anohY6gGf9eTgovgekxaaGvoBaewsjuU2QONv12o/g31MqFoQMcSWdMD3ydgjtELTD
	XMd4vv5dPPMacUUL6qOxH5rt0gU+ci37sX+24LLgF8bbCt2GzocD+8IjGBBD8YSSl/BqP4D+8Z2
	NDMx5gUKQrLYTnM2PHuYLgXBuUc/QtwjilsrY8MU3YT8cTYYrwuHzjdvf6k3y/onGgC080rClRK
	0lgG5jsM+MRooQjefbqPCS+TzBsEu2ql48gMWdzH3MSB4sLCWsK14QzCbQ3MHZo60lmeoVhXYhS
	zDMk9V2bT8iMu+jxHYlqrA9DzF+y4HJi8Qsr9AhYgZCr4GtQTc+l3ZC9bMDbHtHgdlrmj7uxyxY
	7g0NNfzoGsG2ljXQ3UDriL/rkh/37Aq4OcKn28tTOJk/LqRbmhxZEhn5DlFXVZHr0JnhYUTROvR
	+Z0gUfX9XE3EyIfOKh4tfuXKa9mfcQ2w2j3PA1MXmcNx8fNxyWU9oHnxP+thsVwbFLQkwtu4GYi
	MyTacoaH3rHLWXBVqwtkhwMsdCV7W9cNL3gUxPyTdaRAgCILs5xor8QIlTRjhzOuzPWwZ6aPFUA
	P5VnLX6DXAkRjQ2BPG/+I+Zz6w2BCtPg=
X-Received: by 2002:a05:6214:54c8:b0:91b:5d39:e13c with SMTP id 6a1803df08f44-91eef8650e9mr21004816d6.49.1794268565495;
        Mon, 09 Nov 2026 15:56:05 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04ae351sm7869386d6.12.2026.11.09.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:56:04 -0800 (PST)
Date: Mon, 09 Nov 2026 18:56:04 -0500
Message-ID: <a8542108f56e8cac5c6e65977ee01ffd@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261109_1829/pstg-lib:20261109_1442/pstg-pwork:20261109_1829
From: Paul Moore <paul@paul-moore.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: don't label bridged packets in  selinux_ip_forward()
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>

On Oct 16, 2026 Joas Antonio dos Santos <joasantonio108@gmail.com> wrote:
> 
> With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
> packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
> calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
> CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
> header and reset the network header, but the Ethernet header stays
> where it was; when the bridge pushes it back in front of the packet it
> picks up stale bytes and the frame goes out with a garbage destination
> MAC and EtherType.
> 
> Labeling a bridged packet based on its IP addresses is not what we want
> here anyway, so leave bridged packets alone.  Add a stub of
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=n.
> 
> Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
> the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
> per case:
> 
>   case                                        before        after
>   CALIPSO packet, unlabeled destination       MAC garbage   5/5
>   unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
>   unlabeled IPv4, CIPSO destination           MAC garbage   5/5
> 
> Routed packets are still labeled (an unlabeled packet forwarded towards
> a CALIPSO destination gets the option, 5/5).
> 
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security attributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/linux/netfilter_bridge.h |  5 +++++
>  security/selinux/hooks.c         | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)

This looks good to me, thanks for all the work you put into this!  It's
been several weeks with no objections from the netdev folks about the
nf_bridge_info_exists() dummy function so I'm going to assume they are
okay with that; if that's not the case, please speak up soon :)

Merged into selinux/dev.

--
paul-moore.com
