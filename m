Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446427;
	b=iNU8JbDGVHJgayaUl4rTlaMbD46bCNxgQXEtLN2RYwqg20zww5rvM+nRl3LB1ngr1U7X
	 f1H20/ggi6Jkndg+1OqUg4AEY8v20vQsoUCmIbpnnIe4C0p+me3ruqyIZ4F22VkdIO/zD
	 y8KLYE1fGMUmwTKnDD4wV5Eff2zb6EPl8xXQcY+il03Vq9KK4lPV6SWm58N1c9WjmMD+4
	 bvPwMokqt2yot8fsFR/lR/zmGXhe0H9bfqlYrpZKX+MHIIyfHyPFEc12r5GNbOWbgZYfw
	 cNl9Rkv25RzKRIBbhh5De74adggmxZVHhBourS3JxknQd/Ah/CeQOUvPiNSa6EGjKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446427;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID;
	bh=nCuZlJhYpzEDE8MZyIKHldrb9zK6HERF/NakAdQi+bo=;
	b=y67gag4gLQJehTaoMZ4mtjK+Su/jOqG9ND5TC3I3KjGabebWUW7Lxnd3Gw41/Ra8Znq0
	 +fyh6flCbxBMWQKRbH3D5SUI4MPZYu04rlkdrVJzLpkwkxRCAPpdLfG4ZmLAdkiRMmCrk
	 u8NCS7NS+9gRKQcOSNEpOq1btKt4x/PJoay7m4EK6HHwg/Wj+JCRno2kiqGZ2lYuJDse1
	 xUpx+EgFbBSRsluZ2/BocayAFd8BITDlINOA34x50HOlooNagbYl5IfmBb0Lky1pPUi+1
	 hJTJe0JguF+SrvPBkRVrvZsWeZ7aUBioKUM335uN5CT60wVItt2bXjfcannGIQ6QkPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feo3VPL0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BD606A325
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 621BD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feo3VPL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792446420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nCuZlJhYpzEDE8MZyIKHldrb9zK6HERF/NakAdQi+bo=;
	b=feo3VPL0HdRJom+S35JN6t3d7U9stRR1zTeFImFFZgcnm2qHxwzfDsYHGEF0STj0nOEYZv
	p5D2kRBg8uVMxOHTrWW5ZSzwOL8JzzapkBKMEJYHsMiJRDGF6KxxnxfDHEvOYSRBYy1imv
	kg0hjX3zj5xkdMj3qz0hUg6lgyxvJJ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-xWjmjAB1O92E7IPUm-h4dA-1; Mon,
 19 Oct 2026 21:46:54 +0000
X-MC-Unique: xWjmjAB1O92E7IPUm-h4dA-1
X-Mimecast-MFC-AGG-ID: xWjmjAB1O92E7IPUm-h4dA_1792446411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D19AC18011E9;
	Mon, 19 Oct 2026 21:46:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 712CE1800257;
	Mon, 19 Oct 2026 21:46:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261016215326.4110064-7-jarkko@kernel.org>
References: <20261016215326.4110064-7-jarkko@kernel.org> <20261016215326.4110064-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>,
    Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
    Andrew Morton <akpm@linux-foundation.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    Bagas Sanjaya <bagasdotme@gmail.com>,
    Pasha Tatashin <pasha.tatashin@soleen.com>,
    Jani Nikula <jani.nikula@intel.com>,
    "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>,
    Pratyush Yadav <pratyush@kernel.org>,
    Frederic Weisbecker <frederic@kernel.org>,
    linux-doc@vger.kernel.org (open
                         list:DOCUMENTATION),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 6/6] lib: Remove unused assoc_array
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 22:46:41 +0100
Message-ID: <2630215.1792446401@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: cAUWkk3N0vwWiSb4I-7TfFZ_nBtTLaKozuOdHbJLpMg_1792446411
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2630214.1792446401.1@warthog.procyon.org.uk>

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Drop the obsolete leaf-count reference from a dm-verity test comment.

This might need reworking as a commit message...

David

