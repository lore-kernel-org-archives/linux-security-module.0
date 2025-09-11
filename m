Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD551547EE
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570394; cv=none; b=nsnFbvuED2M5civVuWR84UfkzHiDjfz9HbHL0d2tVVaOS3OeZ5Dak6tAwzVyUYHgYRiHNmTLrpDFte/wkG84ponVhnj9328Bw/lV/BbJion7D4DSh6xkUVXuwYJBBz6FXuDYIM3ld56AeTNF1OhT9gAk9kRBJCPhPKNIh7/uXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570394; c=relaxed/simple;
	bh=YLJ7E8D39ZQye1/XBWf2REKukXkr7dKknYd/ulrZr5w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JaUODl7Prqk1YDfMpDQv9Bb6OLZzuGS7b0l8zr5PKjrLxTcwzvQ4RfT799OmzY29DxW+zmo5v0v5/WuY/EWdvO43HuSiz3v08kaPO5/FWa6vRvcmvxLN6tGe8SjA3uCDoWM23jA+n3f/7QQGMfELZ1UVOCbmjfvCOkJ44fhu76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBE/GwkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBE/GwkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757570391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvIv0Fme/12Gy6QkmPve1p56d0YuJiZc9uDe1Fge2qw=;
	b=JBE/GwkSGJR+dHxrs1rFkoS3bnBh9tWvogXeIF7TqACCMNjtnDPb8WgSCDxSk+4P7gZeCM
	a099NCp2Fm0U6vZV17fDwxiby3/f7Zq2ZhU+3IRxFA3wM8KZG6OMbz0d+65hrqZKOtD+8o
	MMSZkVEXYKTNxehG7UzmapAm2R4PrhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-thmt30oePk6tg_klA7gfxA-1; Thu,
 11 Sep 2025 01:59:50 -0400
X-MC-Unique: thmt30oePk6tg_klA7gfxA-1
X-Mimecast-MFC-AGG-ID: thmt30oePk6tg_klA7gfxA_1757570389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 876411800291;
	Thu, 11 Sep 2025 05:59:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12C46300018D;
	Thu, 11 Sep 2025 05:59:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250911050149.GW31600@ZenIV>
References: <20250911050149.GW31600@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    NeilBrown <neil@brown.name>, linux-security-module@vger.kernel.org,
    Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCHES] simple part of ->d_name stuff
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1910270.1757570384.1@warthog.procyon.org.uk>
Date: Thu, 11 Sep 2025 06:59:44 +0100
Message-ID: <1910271.1757570384@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Al Viro <viro@zeniv.linux.org.uk> wrote:

> 	Rules for ->d_name access are rather unpleasant and so's
> verifying that they are followed.  There is a relatively simple part,
> though - nobody outside of fs/dcache.c has any business modifying
> that thing.
> 
> 	So let's make sure that all functions we are passing
> &dentry->d_name are taking const struct qstr * and replace
> ->d_name with an anon union of struct qstr *__d_name and
> const struct qstr *d_name.
> 
> 	It is *not* enough to guarantee that another thread will
> not call __d_move() right under you - checking the requirements
> for that is the hard part.  It does make it easy to verify that
> nothing else accidentally starts changing it.
> 
> 	This stuff lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.qstr
> Branch is -rc4-based, individual patches in followups.
> 
> 	Please, review.  If nobody objects, I'll put that in #for-next.

Reviewed-by: David Howells <dhowells@redhat.com>

