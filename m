Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424618;
	b=gb833K7HK8tu4VGjPx+VUbra0LwWLplgIDY9+amzf5oizaKcKeqohN0GlBoo5uiNKSeE
	 N9rF9wlenFN9m6L00mb1iT77biygQ6QoItUkkRFofRbIhOvP/pinl62Hpum+MOko7ChdK
	 4RHEdug7KR9d9EBw3+qK+8KJmpKM8IjIk5booaWzUcr6y9qec/exoaCD5mAB2erIWrpMc
	 q1kpSppii98OLK0Ex0vbIy+mA+IaVgYcPaHb9sfnQ/ijvGWtgudvLjtAmQ3VDx1L6WmDY
	 9q6rJQvbWuLLB34ykJ+T2/RMCbjvyqImzFfFLCXULoS0RuL8NE83UjzdZEV9u1Hdm/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424618;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=aWENVPvxx0/Tm7EYgjz9wevRNyQ6ebrJIgBkAgK1W1s=;
	b=IE4UoXnjwvXrEV5/5geBQwbSMNvXXx0md8R8To1FchLVrf9yNeD9aDOjy9JkcDM4CMqo
	 c7iNM0DzsUsxLrLWpsyr9s8w0AVmIZFPOZhFbVz7ir0QN+OfrIuYxDk8F3d1F/J0Z5xuP
	 UXdAWOE8jJ3kaPHJfmE4USY3U5t9Hgms8DAC+80tiSNNTI4pcsEug/GVYEfmIW9lOqwm+
	 9I9YILuZRz0dVCpNjj3MVQoEMv/BZvFwew649mx7Pr6QMeq8skiiis96VxPE+8/WBFfIQ
	 qz5fQBcjMuhHHoU1N+9UCYv22TZ4frh6v5xbS2Zmj45xooyJzFoFkoYk9f1m7ijrbOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LLigXAmQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CB606A31D
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208CB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LLigXAmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWENVPvxx0/Tm7EYgjz9wevRNyQ6ebrJIgBkAgK1W1s=;
	b=LLigXAmQ/bK7mF9no+IesegCAiHhdvrB8O/vi4hrwpQTI3rwSvzBznGmhxNm2dHCmv3t/w
	djAA9LXd20CeE8pWU20y0apYZk8OF3+2fwsijYmq8TtqNetOpemVcu9g4UMIBB+nsOsYEZ
	n44Ulu+cpSpIQLOGmIjBdxI8FcfuJtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-ASZMWjEQPqmWTLXlVQ0IaQ-1; Mon,
 19 Oct 2026 15:43:33 +0000
X-MC-Unique: ASZMWjEQPqmWTLXlVQ0IaQ-1
X-Mimecast-MFC-AGG-ID: ASZMWjEQPqmWTLXlVQ0IaQ_1792424611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 980321800671;
	Mon, 19 Oct 2026 15:43:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004B91956095;
	Mon, 19 Oct 2026 15:43:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-8-jarkko@kernel.org>
References: <20261019142516.300040-8-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 7/8] KEYS: Reject @datalen values over INT_MAX
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:43:27 +0100
Message-ID: <2610186.1792424607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: dH71KbNYFxLUasiTGSib0kL76wxaVNa5OPu_XVkeqao_1792424611
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610185.1792424607.1@warthog.procyon.org.uk>

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> -	int delta = (int)datalen - key->datalen;
> +	int delta;
>  	int ret = 0;
>  
>  	key_check(key);
>  
> +	if (datalen > INT_MAX)
> +		return -EINVAL;
> +
> +	delta = (int)datalen - key->datalen;
> +

You don't actually need to move the subtraction.

But apart from that:

Signed-off-by: David Howells <dhowells@redhat.com>

