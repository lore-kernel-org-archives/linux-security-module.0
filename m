Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424131;
	b=MWdf8uiATTJ7weDJFCLmO4XOEhDnWn0r1ESTVQ/Vku2BnZn8/go5m89J/VH37PPrYsE8
	 uMjtmz/B2GKGhl0uaFSLjCY1UXCqWJYvYB9LU1g6JdSwEgyUMbf6NF9n+Ps9G/Ne2jiER
	 KCNpGjPN+tow7htQpV8BRkjdsaOxxD7zmlscebJsStDlUxUiG9e3J8aRPESi15a43ZcvK
	 eH9OY7f5L6F1EmtNpfC0sfsWB6RoHXH3KRPXlDh3ylmL4XasWyCV84QJHm3/EqyYpXOg5
	 3BxKrmXIsu75qZ1AkCRUaLEzcJr9lJPYGrttImRQ9tOc/JoPVfzhud6WWEzXhUHEk3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424131;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=l9Q4UMh62ih54xKZZA+hG600zf0HWv1kidaciNLBM80=;
	b=fXixgHavbnswzbSfthXgJ37xM/kR0Ywccagrfu5snifthb47VrwECos6PXN54Cwf8lhP
	 52Gbl0dDn7b7huN9AoJB4wSPq/nnFJ2XBo/G1imnBx9f5W0+2Kr5lT9YloKSklIaPEJ/+
	 +mB0Ea3w3LvNMOvRrbC8S095sxuCmAn34PdDFooRHpEibwfixflCUeP3T28eY7I5n4cLu
	 BQErS8UPhf2UGoC2K5zZb9YkCn9vn8Y+8iFeYUDDE9kt3asBR6lxwQ171rY7ZcvUCCJ3u
	 6Yu9meyIyjhsLv6m7XcTBwhzjl3b6uFffqzNQDjyC7krEWc/OCCrcKW+1KhMIpFXeHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPN5XYT1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5749606C152
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5749606C152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPN5XYT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9Q4UMh62ih54xKZZA+hG600zf0HWv1kidaciNLBM80=;
	b=hPN5XYT1PLf3X0K2qjsHOfK78YYP21GxrG9yxAtjjaz/yQWRPSQGBTgdsWbQO8/+JIj7tB
	3afObZuvWP3cfLQtrNieUtKH5srNzW50J0JENZQi/SC/fPgT3Ip4lFRjf163YMveJoPdp4
	BHVGyA0fvA2bquKRBtkJ5Y6EUc50New=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-8SkUrmygPuSklfyw_LsWDw-1; Mon,
 19 Oct 2026 15:35:26 +0000
X-MC-Unique: 8SkUrmygPuSklfyw_LsWDw-1
X-Mimecast-MFC-AGG-ID: 8SkUrmygPuSklfyw_LsWDw_1792424124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3788618002D7;
	Mon, 19 Oct 2026 15:35:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 312A518004D2;
	Mon, 19 Oct 2026 15:35:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-4-jarkko@kernel.org>
References: <20261019142516.300040-4-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 3/8] KEYS: Reject @desclen values over U16_MAX in key_alloc()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:35:19 +0100
Message-ID: <2609869.1792424119@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: V2UFZTQDNfoizokxfNfO2yOMH2vUSg0Wcxe9FEpplQY_1792424124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2609868.1792424119.1@warthog.procyon.org.uk>

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Reject @desclen values over U16_MAX with -EINVAL in order to prevent
> integer overflow.

KEY_MAX_DESC_SIZE.

David

