Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59B45025
	for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732781328; cv=none; b=uqiDqTDJ2X+ben9+Uoz7Y3vQXfOOVY5CBCHJAcqWqJFkmlp2uCrQz+NU31RshJV0YhTLbxsoKrRcjp97vPYGDs/7UyR2lJG/KqQxLdFkFigACJveLiDuuN0RyAK4CBps4WFY1nRwb6SERaa3qweppJJc1v5Ei1W9uSlj0lvtbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732781328; c=relaxed/simple;
	bh=4srSRusTbIfBMVE+olmx0QPHrbQqHJUCthbkmng4gck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gas5YNeDLU5dzdKNdUMseHbTWzm3oD9hOphZkAcel1yjDJ9Lx3sZBfQGa8AwT/k1hLwg6ZOiFVBnPpLcJMNMGQGLz7T1Q9aWC7AjLu8n74d0cwE7VUHdBe7r5EDqheW3a6HfCXZJP5odkr5CrtkbcfFGH7ME7ZsRlDkvMepFx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjKCfrD6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjKCfrD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732781326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4srSRusTbIfBMVE+olmx0QPHrbQqHJUCthbkmng4gck=;
	b=AjKCfrD6G6OhZNn5kuQXcLbotSiTRXmlYsVLLEVMF7TwrQdp/vh5Sn09VeR9ligY8vZHry
	j6ZvvnGRtgWehO5Cczb1ZFdmnXWSVmESLytkFYBczROfo0QAAlbjihXQdMq/snbqH7hjZJ
	5781IsHvRddQ7pSxsKSfqRrl9IHnZOk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-Xz53NpUnPR6VcAlAbiZ5hQ-1; Thu,
 28 Nov 2024 03:08:39 -0500
X-MC-Unique: Xz53NpUnPR6VcAlAbiZ5hQ-1
X-Mimecast-MFC-AGG-ID: Xz53NpUnPR6VcAlAbiZ5hQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 946211955F3C;
	Thu, 28 Nov 2024 08:08:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D1604300018D;
	Thu, 28 Nov 2024 08:08:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 28 Nov 2024 09:08:16 +0100 (CET)
Date: Thu, 28 Nov 2024 09:08:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Ni <zhen.ni@easystack.cn>, viro@zeniv.linux.org.uk,
	catalin.marinas@arm.com, brauner@kernel.org, zev@bewilderbeest.net,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce
 contention
Message-ID: <20241128080811.GC10998@redhat.com>
References: <20241120132156.207250-1-zhen.ni@easystack.cn>
 <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
 <20241128071351.GA10998@redhat.com>
 <20241128073911.GB10998@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128073911.GB10998@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/28, Oleg Nesterov wrote:
>
> On 11/28, Oleg Nesterov wrote:
> >
> > The problem is that task_lock(tsk->group_leader) doesn't look right with or
> > without this patch. I'll try to make a fix on weekend.
> >
> > If the caller is sys_prlimit64() and tsk != current, then ->group_leader is
> > not stable, do_prlimit() can race with mt exec and take the wrong lock.
>
> ... and task_unlock(tsk->group_leader) is simply unsafe.
>
> perhaps something like below,

No, this is wrong too,

> I'll try to think more.

Yes...

Oleg.

