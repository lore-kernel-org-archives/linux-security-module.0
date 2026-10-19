Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425327;
	b=KSQ4tTdBOsZHWmnLpq/qrSibS3BBwdetvxzpmWfHed20r/lIHzkpCN+3dIM5BrY0sxVm
	 LS8SQn8dl0ZJ28uphWQlvyO87QrwcaskTOxRHgDXLz+oxvwhkct5zS1SEkeEtempYsH0G
	 InrsV2TSkgI27ttBBXsmvhs9ZliV04jfmjiC8Mi2CQbNlVKp4DyBfmwlCSDg49Bx+f2Ma
	 bt00sRhQA1Q4hKUIH1t/tm7GDFzyzD31fG7u4Fyh+B2FL555/TMI7SCi0YNN884op+/Co
	 GRiPSk0v1LxfjxXkj30QnsOGNnk2hj9FA5aFINCNENW84bh+0qZ8NYc0xySh9Cy5BFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425327;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=rutENMajq1V1U3rINnISmb9MHW7iJ6RCHaeAN3MwYeY=;
	b=QNUEQHRRvwWw8sDxSur5zgJXLL18lN2XonsU1k0Ry0c5YxxBrcLYFcs4vm5x+AXnyDQi
	 6ZEENH01VEL9FgEPczEqSAW6D+FmIymiYjC9aG5niUc6xgr6qxu6S3InIU+lSuVQQZHE6
	 HAZ7AvjAMWIWYJJo/TVkzv5F4Te/cn4M70Y9necG2NBtFJlY1KsHBaCln89E6m686kmBw
	 4MVXNHDD8drj+usf/rdzsh/roRmZBX2nxsSozTBqAR1iiFH3DcuxjAkpz8c5fu3o/0W9P
	 5mlQGopYhrf2M4lAALHSd64aCFQJn/xDz6LsvXj3pWfqwarPCM1hfn5MFdeuvPJGQfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUMuD4qK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED25606EFC9
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED25606EFC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUMuD4qK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rutENMajq1V1U3rINnISmb9MHW7iJ6RCHaeAN3MwYeY=;
	b=AUMuD4qKQwx/d0o/WuyC3aNucQRJtQfs5wGk/QY5RWKLQsu6R1mEHpDX/s/nwNyj37EPwh
	JVMLzqhqDi3i8otUYTorji/17O9x/+Av8y0O32lJwK92MtY5KDXRXkULADR4p3HAlJcQen
	3WQe8Eecc+iX4ypTYf6pqyTlT3zs8eI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-896bG0iVMQ2wFWwxFeUxFQ-1; Mon,
 19 Oct 2026 15:55:20 +0000
X-MC-Unique: 896bG0iVMQ2wFWwxFeUxFQ-1
X-Mimecast-MFC-AGG-ID: 896bG0iVMQ2wFWwxFeUxFQ_1792425319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7AF81956049;
	Mon, 19 Oct 2026 15:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D45E518005BE;
	Mon, 19 Oct 2026 15:55:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-9-jarkko@kernel.org>
References: <20261019142516.300040-9-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 8/8] KEYS: Verify the key identity in __keyctl_unlink
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:55:13 +0100
Message-ID: <2610587.1792425313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: GGLO9vX-IhOoU_mUhJBKGm8coEEl1n-i70HqXOwG-Jw_1792425319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610586.1792425313.1@warthog.procyon.org.uk>

This will show it:

	keyctl newring ring_a @s
	keyctl newring ring_b @s
	A=`keyctl add user A ss %:ring_a`
	B=`keyctl add user A qq %:ring_b`
	keyctl newring R @s
	keyctl show
	keyctl link $A %:R
	keyctl show
	keyctl link $B %:R
	keyctl show
	keyctl unlink $A %:R
	keyctl show  # R is now incorrectly empty

Reviewed-by: David Howells <dhowells@redhat.com>

