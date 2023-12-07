Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOJFhZm+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB273A8E
	for <linux-security-module@vger.kernel.org>; Wed,  6 Dec 2023 17:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701912201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CW13ztakVZhLN0u8Ukxwl9rI2DJkfQlOliL6y3zHOd0=;
	b=KOJFhZm+1sYWek5Tg9HSOU2qHxQVDNwES9qHgtiMbFrT15FHNhCbTDTUIK3CA49OuuDJ5p
	Fr50rsTRYkTuybNAJf0YE22m5UT+QdoaPqGg9aLEPYJ6eM34cWpDKClFyTNZY/IvX7nzCI
	7TpFhwhfNsZaQaDxC5IPiFLXwe6a4yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-hpV8yEeLPf-wBBWaDOVKVQ-1; Wed, 06 Dec 2023 20:23:18 -0500
X-MC-Unique: hpV8yEeLPf-wBBWaDOVKVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF9185A588;
	Thu,  7 Dec 2023 01:23:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 97A98111E400;
	Thu,  7 Dec 2023 01:23:11 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:23:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZXEeei6eoDW87xcN@fedora>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
 <ZW6jjiq9wXHm5d10@fedora>
 <ZW6nmR2ytIBApXE0@kbusch-mbp>
 <ZW60WPf/hmAUoxPv@fedora>
 <ZW9FhsBXdPlN6qrU@kbusch-mbp>
 <ZW/loVJu0+11+boh@fedora>
 <ZXCT6mpt2Tq0k-Nw@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXCT6mpt2Tq0k-Nw@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Dec 06, 2023 at 08:31:54AM -0700, Keith Busch wrote:
> On Wed, Dec 06, 2023 at 11:08:17AM +0800, Ming Lei wrote:
> > On Tue, Dec 05, 2023 at 08:45:10AM -0700, Keith Busch wrote:
> > > 
> > > It's not necessarily about the read/write passthrough commands. It's for
> > > commands we don't know about today. Do we want to revisit this problem
> > > every time spec provides another operation? Are vendor unique solutions
> > > not allowed to get high IOPs access?
> > 
> > Except for read/write, what other commands are performance sensitive?
> 
> It varies by command set, but this question is irrelevant. I'm not
> interested in gatekeeping the fast path.

IMO, it doesn't make sense to run such optimization for commands which aren't
performance sensitive.

>  
> > > Secondly, some people have rediscovered you can abuse this interface to
> > > corrupt kernel memory, so there are considerations to restricting this
> > 
> > Just wondering why ADMIN won't corrupt kernel memory, and only normal
> > user can, looks it is kernel bug instead of permission related issue.
> 
> Admin can corrupt memory as easily as a normal user through this
> interface. We just don't want such capabilities to be available to
> regular users.
> 
> And it's a user bug: user told the kernel to map buffer of size X, but
> the device transfers size Y into it. Kernel can't do anything about that
> (other than remove the interface, but such an action will break many
> existing users) because we fundamentally do not know the true transfer
> size of a random command. Many NVMe commands don't explicitly encode
> transfer lengths, so disagreement between host and device on implicit
> lengths risk corruption. It's a protocol "feature".

Got it, thanks for the explanation, and looks one big defect of
NVMe protocol or the device implementation.

> 
> > > to CAP_SYS_ADMIN anyway, so there's no cheap check available today if we
> > > have to go that route.
> > 
> > If capable(CAP_SYS_ADMIN) is really slow, I am wondering why not
> > optimize it in task_struct?
> 
> That's an interesting point to look into. I was hoping to not touch such
> a common struct, but I'm open to all options.
 
capability is per-thread, and it is updated in current process/pthread, so
the correct place to cache this info is 'task_struct'.


Thanks,
Ming

