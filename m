Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742617C7C
	for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778070; cv=none; b=Gn+tQ8ETB3UsBslhQQjOdylbNGb1heJdxh6MlVuPCTYyxIJX/K8ZF4vAtS7CEbf8FW7yZ7rFAC5aOGWHKkmjpUCQvJEpMPzKBc11hdAzDtSj+dHkTLGLHiIPtKhhSbDfR+BMFELcVgMtIANnvd20Tb/KjpaP6o9crr+mr1TcmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778070; c=relaxed/simple;
	bh=B2iakYxH1VOf5Ugpok1chaqtnlLpZWmut3sK5bvBsnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6LjeoJ38AU2UDvhEXO/sCx9KylUdM2wesHU8bnTpiV7XidrX4TDwnU12tco02hozws57N1JzKk2Fqs/8RN0zRYHOpQRlPLF8dRVMrg4ZGqO6yVbFabTor13t8U8XR7s2LEad15NNqcYI+vT7T7hkOgrHuWQ54kHalZd5XkW7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3V9gonZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3V9gonZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732778067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZKA8/3eMLftSd2nzxwTONVGz2/e1uBSYFA+1UDyoX0=;
	b=S3V9gonZkygjIIUFqk26jYH6Nf7/etVbNtrA+LqO+pXpYM9pjQEe5PbwiRGxDGna18Omw8
	cjqBKi5V95z3roFHc2sIIaGw5J7ybPTLSYt5zjlnlRUP5nOa1TW45kiUraeljBmIcsEucV
	BnVKgBe+FgjLzlvyH75V1Qt3FwxhgRU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-tUWEIjb9O4qdQrPA4d_9CQ-1; Thu,
 28 Nov 2024 02:14:21 -0500
X-MC-Unique: tUWEIjb9O4qdQrPA4d_9CQ-1
X-Mimecast-MFC-AGG-ID: tUWEIjb9O4qdQrPA4d_9CQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0F421955F3E;
	Thu, 28 Nov 2024 07:14:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BF5F21956095;
	Thu, 28 Nov 2024 07:14:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 28 Nov 2024 08:13:57 +0100 (CET)
Date: Thu, 28 Nov 2024 08:13:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Ni <zhen.ni@easystack.cn>, viro@zeniv.linux.org.uk,
	catalin.marinas@arm.com, brauner@kernel.org, zev@bewilderbeest.net,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce
 contention
Message-ID: <20241128071351.GA10998@redhat.com>
References: <20241120132156.207250-1-zhen.ni@easystack.cn>
 <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/27, Andrew Morton wrote:
>
> On Wed, 20 Nov 2024 21:21:56 +0800 Zhen Ni <zhen.ni@easystack.cn> wrote:
>
> > The security_task_setrlimit function is a Linux Security Module (LSM)
> > hook that evaluates resource limit changes based on security policies.
> > It does not alter the rlim data structure, as confirmed by existing
> > LSM implementations (e.g., SELinux and AppArmor). Thus, this function
> > does not require locking, ensuring correctness while improving
> > concurrency.
>
> Seems sane.
>
> Does any code call do_prlimit() frequently enough for this to matter?

I have the same question...

> > -	task_lock(tsk->group_leader);
> >  	if (new_rlim) {
> >  		/*
> >  		 * Keep the capable check against init_user_ns until cgroups can
> >  		 * contain all limits.
> >  		 */
> >  		if (new_rlim->rlim_max > rlim->rlim_max &&
> > -				!capable(CAP_SYS_RESOURCE))
> > -			retval = -EPERM;
> > -		if (!retval)
> > -			retval = security_task_setrlimit(tsk, resource, new_rlim);
> > +		    !capable(CAP_SYS_RESOURCE))
> > +			return -EPERM;
> > +		retval = security_task_setrlimit(tsk, resource, new_rlim);
> > +		if (retval)
> > +			return retval;
> >  	}
> > +
> > +	task_lock(tsk->group_leader);

The problem is that task_lock(tsk->group_leader) doesn't look right with or
without this patch. I'll try to make a fix on weekend.

If the caller is sys_prlimit64() and tsk != current, then ->group_leader is
not stable, do_prlimit() can race with mt exec and take the wrong lock.

Oleg.

