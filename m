Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989020D4F3
	for <linux-security-module@vger.kernel.org>; Tue, 18 Mar 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304495; cv=none; b=OEd+50u9rLG7quXzigK7djl9kTAfgrZTwKctXfQ+rEiPiQUuH1gR6rXwtbNYCmMeCKFLBCgF4eWV78Bd9oY0YN+LKUY35XB89Hx1e5m0avdvX5cK5a0HujKtWR3MfsJw4zdUBS6lFD5sVsklmjN2otepHVfY5ihCOHJxVVNufCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304495; c=relaxed/simple;
	bh=K28A5Iqks9eUdQnH/UFHyuM5lvviHy9zwChNneKoG0k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZPjEAGerznX9LfKzxrWfHkpmVZuIEApr0/hWfuRoc/QA2XK4QptfeY+G2LbhVXjM8CcCAxyczmvuHmN4BIZXqy6yam3UkefbLmpiw5cz5bI4+GcCKqbbGXSBkbD+e1NrTDnGgbwHIr3gXOuFK5myTOvjyhTb5D6D6u7e9NeMfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv8zn6XI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv8zn6XI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742304489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Beeev61c7/gahsqlvIiUDN5d6/87COyb0m7dxtmgRck=;
	b=dv8zn6XIuavJyNRlNv1rcvnYtVN7O9wXA/DCy1uKK3OZlr1DCDtLcMy6BY5EiGlbrT40Hz
	W1D0eFALgJPWIdT9yTSxrWpq5RDGxlTG3rqtf4IASMuVMu+6oN3NYiSJ8/8x5Y832N36G6
	oYkjK86i41ZQTrFWyY/yNYlp9MOMHpg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-YQnjInrDNcW76Md3_ibxKw-1; Tue,
 18 Mar 2025 09:28:06 -0400
X-MC-Unique: YQnjInrDNcW76Md3_ibxKw-1
X-Mimecast-MFC-AGG-ID: YQnjInrDNcW76Md3_ibxKw_1742304484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 723FA1956055;
	Tue, 18 Mar 2025 13:28:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 554491955DCD;
	Tue, 18 Mar 2025 13:28:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250318113655.GB14792@redhat.com>
References: <20250318113655.GB14792@redhat.com> <2477454.1742292885@warthog.procyon.org.uk> <20250318112245.GA14792@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
    Josh Drake <josh@delphoslabs.com>,
    Suraj Sonawane <surajsonawane0215@gmail.com>,
    keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
    security@kernel.org, stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix UAF in key_put()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2526767.1742304474.1@warthog.procyon.org.uk>
Date: Tue, 18 Mar 2025 13:27:54 +0000
Message-ID: <2526768.1742304474@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Oleg Nesterov <oleg@redhat.com> wrote:

> and since key_user_put() takes key_user_lock with irqs enabled,
> key_put()->key_user_put() doesn't look correct...

Meh.  Yeah.  I think it's time to do it the other way (i.e. putting keys to be
destroyed onto an explicit cleanup queue).

David

