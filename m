Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716E305057
	for <linux-security-module@vger.kernel.org>; Mon, 22 Dec 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442017; cv=none; b=S5tiwrEKAeRPstXFKQuP+YWETxc5wv8vo5qDJrTvdQR8bqlFgSSxnuSpHAMW5RvB7fBjN+XLMYtL8vqEdF++Puz64AQeunPPwzZHdWursvh1uybaDa8iPMGRx+YLof9sud0L3ePyocvKcBqVCC9wodLCT/AsS1SwYd83RgNvxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442017; c=relaxed/simple;
	bh=CRbxHp2OiumWjwoB68+vdR6prQIhFIoH3X0MsMUXSA8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=deedG3uRwg/tyN3rqm9R9bMf2DKDR15B4HN8gyT+mwwUvgofmticOZAV47B8L/XE5jQV3yglVN3HdE/vuXZiZPJ7zjV7aCZYBkCVp8M+m095v23gRRZRqdNs5RdHKiigHsonrFNwD//JFVNZcuIT0KINcqrm6qdOKUfvx5gmtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtkfYhIb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtkfYhIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRbxHp2OiumWjwoB68+vdR6prQIhFIoH3X0MsMUXSA8=;
	b=DtkfYhIbgGo4bXsTcYohcO/RGOtRx4eWh+GLMhnTdrfJE3RMPsUd0S5HlqsnK+tlJZxxJz
	O1LTrf5FgtupPezPPzInFwJ05IQQ7MWMnjtJGCu+i4Hqy6JcJ5m1z2Qajk5bKZBartOyZE
	93a7k8imNGaEM8GwhRGuJPZXMThDDpg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-KhTaHuLlMkWdPdMdTRpX-Q-1; Mon,
 22 Dec 2025 17:19:50 -0500
X-MC-Unique: KhTaHuLlMkWdPdMdTRpX-Q-1
X-Mimecast-MFC-AGG-ID: KhTaHuLlMkWdPdMdTRpX-Q_1766441989
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A614195608E;
	Mon, 22 Dec 2025 22:19:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5445A19560AB;
	Mon, 22 Dec 2025 22:19:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15895666-464c-4349-9fb2-f24e10aac8c7@schaufler-ca.com>
References: <15895666-464c-4349-9fb2-f24e10aac8c7@schaufler-ca.com> <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, Paul Moore <paul@paul-moore.com>,
    Linux kernel mailing list <linux-kernel@vger.kernel.org>,
    Serge Hallyn <serge@hallyn.com>, max.kellermann@ionos.com,
    LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] Cred: Remove unused set_security_override_from_ctx()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1075250.1766441984.1@warthog.procyon.org.uk>
Date: Mon, 22 Dec 2025 22:19:44 +0000
Message-ID: <1075251.1766441984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Casey Schaufler <casey@schaufler-ca.com> wrote:

> The function set_security_override_from_ctx() has no in-tree callers
> since 6.14. Remove it.

It's also declared in include/linux/cred.h

David

