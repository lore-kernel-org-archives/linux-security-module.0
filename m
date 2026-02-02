Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62252F363C
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057562; cv=none; b=QFmMul3CFenhcWrmBXup0kJhSwMyuhTY77S4TcSnXGhHkUEOENiBNInLdx/9l7JVd6uvIDbI4nabA8VXuBQaK35b+uPc+wHIiEcJrY8XG5CfKiLFWMtSQgKbPGE87xTf00IxA2HOP/enzDWm97NIxaTsXUDRlyEa3nEiCz/RZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057562; c=relaxed/simple;
	bh=zhZXoblavFyWqc+R9HaWDbxNSfB6JnVeGXofhWAmli4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JhaoRj929uGDOeT36OVDJXVZBNoJs4qxbK7lTNCCnsHeEXkGn7cLAHivzVRTJTM8m4XlVgR0FgaxALH0x6PJ0JBQzM/kkzBN17n8Hs+XVv3ngMaNnzHxSAXJbOYr6LrP/lzGkoGZ5zEWeKn8Zl0Chi0CsTCo+n7V1KlSeoZ94C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbllDgyJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbllDgyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770057559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAqpkXq2kL2gtcSXa768E/ZejVg2PGn4Rs/J2aKfSBg=;
	b=hbllDgyJ3zOSBv474/T14Gx2tduFTXxnfeUK0viE7oYJIjwxQvXxy7l5ay8cumlvEpYGVs
	+e7ITgfOPtGG5sqq9tm21N4l6unw3/u9qBiy36YkdYAuztOPU38VKkED8E6CPDgkvySqbU
	U28q5DxdaFuiyNxLBz9J5VOcxOb7r0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-eAiG1k3lOsGBC8Pm1b-xlQ-1; Mon,
 02 Feb 2026 13:39:14 -0500
X-MC-Unique: eAiG1k3lOsGBC8Pm1b-xlQ-1
X-Mimecast-MFC-AGG-ID: eAiG1k3lOsGBC8Pm1b-xlQ_1770057549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F1921955F34;
	Mon,  2 Feb 2026 18:39:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21EE21801768;
	Mon,  2 Feb 2026 18:38:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260202183055.GB2036@quark>
References: <20260202183055.GB2036@quark> <20260201201218.GA15755@quark> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk> <2339369.1770024079@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com,
    =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
    linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
    atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
    christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
    da.gomez@kernel.org, da.gomez@samsung.com, dmitry.kasatkin@gmail.com,
    eric.snowberg@oracle.com, f.gruenbichler@proxmox.com,
    jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
    mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
    nathan@kernel.org, naveen@kernel.org,
    nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
    npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
    petr.pavlu@suse.com, roberto.sassu@huawei.com,
    samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
    zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2513498.1770057531.1@warthog.procyon.org.uk>
Date: Mon, 02 Feb 2026 18:38:51 +0000
Message-ID: <2513499.1770057531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Eric Biggers <ebiggers@kernel.org> wrote:

> On Mon, Feb 02, 2026 at 09:21:19AM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > With that being the case, why is there still effort being put into
> > > adding more features to module signing?  I would think efforts should be
> > > focused on hash-based module authentication, i.e. this patchset.
> > 
> > Because it's not just signing of modules
> 
> Module signing is indeed about the signing of modules.

The signature verification stuff in the kernel isn't just used for modules.
kexec, for instance; wifi restriction database for another.

> > and it's not just modules built with the kernel.
> 
> Could you give more details on this use case and why it needs
> signatures, as opposed to e.g. loading an additional Merkle tree root
> into the kernel to add to the set of allowed modules?

Because we don't want to, for example, include all the nvidia drivers in our
kernel SRPM.

David

