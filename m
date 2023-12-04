Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtBtaw4T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9CCA
	for <linux-security-module@vger.kernel.org>; Mon,  4 Dec 2023 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701717748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuE3wvKVXZ5LaoLyCftMFlpvjjYLnjdW2HQklzJBS80=;
	b=FtBtaw4TogWy3o+P9uq3xCSalSzxJUWQOl9rXxRgc5FyKgRcfGcGMOgmMBA0uaHWd+uirq
	/yBmRCvTe78EJVJePUGUrn3Z8brvhHbY2ggbGhHi+5kNf3bwSTki7NUquDGTlWG3ahr7nK
	ONUK63pnueuoNwhglZ4bOcK1CFxeg9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-fjyfe8TTMMa5a8OWjU-AOQ-1; Mon, 04 Dec 2023 14:22:24 -0500
X-MC-Unique: fjyfe8TTMMa5a8OWjU-AOQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1D41811E7D;
	Mon,  4 Dec 2023 19:22:23 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.10.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF464492BFC;
	Mon,  4 Dec 2023 19:22:22 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>,  linux-nvme@lists.infradead.org,
  io-uring@vger.kernel.org,  hch@lst.de,  sagi@grimberg.me,
  asml.silence@gmail.com,  Keith Busch <kbusch@kernel.org>,
  linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
References: <20231204175342.3418422-1-kbusch@meta.com>
	<x49zfypstdx.fsf@segfault.usersys.redhat.com>
	<9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 04 Dec 2023 14:22:22 -0500
In-Reply-To: <9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk> (Jens Axboe's
	message of "Mon, 4 Dec 2023 12:01:38 -0700")
Message-ID: <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Jens Axboe <axboe@kernel.dk> writes:

> On 12/4/23 11:40 AM, Jeff Moyer wrote:
>> Finally, as Jens mentioned, I would expect dropping priviliges to, you
>> know, drop privileges.  I don't think a commit message is going to be
>> enough documentation for a change like this.
>
> Only thing I can think of here is to cache the state in
> task->io_uring->something, and then ensure those are invalidated
> whenever caps change.

I looked through the capable() code, and there is no way that I could
find to be notified of changes.

> It's one of those cases where that's probably only done once, but we
> do need to be able to catch it. Not convinced that caching it at ring
> creation is sane enough, even if it is kind of like opening devices
> before privs are dropped where you could not otherwise re-open them
> later on.

Agreed.

-Jeff

