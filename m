Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425563;
	b=sGQdPYwqzT/iwF6wB/J6bAPMxGH7GJVL+Lg1jSSY9+14k5RLFlbOM2HKHo/btLEd0fBW
	 l/wiBCB3a6qyKWleSRmppmtqIOt5jA6tHp4GJTfvl56VnT3GT8MtygXxNsuszISbb2bN8
	 L5Jx5lZm8fkCYGAJ9J8yEh+/IID5cQ+WRzhW/uNk8+0uTjiYczg3U1U6MREoxuZbYH7iz
	 a4mR5q9m8N8RycdEf2IzlXDNvM5kEnF5dhc8eGQQqnD9dFo2Y/TImyc+9BDE2cijLDRtn
	 p8Gmil1vctMGrTPKS29dQ+cwo6Bn0MtX90OWQ88GFIJvWaAHnH78vZJEw+GTxbcM8Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425563;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=mxDUftepPPOUZ/7SCslBnNQlYRdDOMe7AAGS48la1a8=;
	b=C/JCtSovWpSErTrnZdpluRaNSW7aaWjhA8PfBFRZjHP5UUMZUItZfPXsdoe5TOqi2UOs
	 rw3oB3CrlPixlFjpLS4Mg0nQ7+S1JDllsYXfftCLStig678I9xdZ1OAosvIke23wHJx5W
	 6twS25XtxnE91Bp1iX69E9KXhsE9CyiLg+ReK/vhlCOKpvu5R3lFxU6fU7ugz5Np46o/M
	 d+9Me4OUUesj5oOfvWO8PjoZm2hI6n2SJEm7v0ebTMkPPlvmU+p5ax9cmSjyn4lGPWGxJ
	 xMChK9g3En0xrqCJumP317gjuM9yeqSoE9xBlRL+JELUI3Qkglt5wVJxMRMQVFrriag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XU7PYeby;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0A606AAD3
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF0A606AAD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XU7PYeby
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxDUftepPPOUZ/7SCslBnNQlYRdDOMe7AAGS48la1a8=;
	b=XU7PYebyC/LTM4vMxXl0U136tL8E3WZoaCq8I+BwMI2pEUDG+WV+ZOQl1Yq/siSYTtiTmj
	nJu6PKG3KjF/DUOumybK4W8g2fpxQ5CM8hvbEyFAfTsQ54ULMmZqviwyozYH+z3UCrUku4
	zvLuqd4SPoIzDuMrtxFDA70vB6xRCE0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-I0xvQN0zMnCVxghSPcACeA-1; Mon,
 19 Oct 2026 15:59:18 +0000
X-MC-Unique: I0xvQN0zMnCVxghSPcACeA-1
X-Mimecast-MFC-AGG-ID: I0xvQN0zMnCVxghSPcACeA_1792425556
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F64A1954ACF;
	Mon, 19 Oct 2026 15:59:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AFCA41B;
	Mon, 19 Oct 2026 15:59:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019145624.309790-2-jarkko@kernel.org>
References: <20261019145624.309790-2-jarkko@kernel.org> <20261019145624.309790-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Randy Dunlap <rdunlap@infradead.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-doc@vger.kernel.org (open
                         list:DOCUMENTATION),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [PATCH v2 2/2] KEYS: Reject keyring creation with overridden credentials
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:59:10 +0100
Message-ID: <2610820.1792425550@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: fPRDNR_cvBJtjNBtEJd7k9a5bssFduUGZTx2KL_fqSk_1792425556
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610819.1792425550.1@warthog.procyon.org.uk>

Would it make sense to just reject KEY_LOOKUP_CREATE at the top of the
function if the creds are overridden?

David

