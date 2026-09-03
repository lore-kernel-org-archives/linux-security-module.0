Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7223468C10
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435003; cv=none; b=Zr8OdyznzbO0L3RJ4nWfegW1JpA/hObgwPzGPd7RM3OWjnrB6msqk0kvQv2deIeAAkI1hjv1fFqvOJ7sPbeFEFpU7QLMSlmS2VkgNWLlwpBrbWdx5azHpJrwwk6iQOy+Hp5x5psI5SVOO/nK8eVQ2KWdJhsWIlNvpftVirVxnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435003; c=relaxed/simple;
	bh=zVxEUER+vovhITHpwOAeij4FL/yULLzNoKNM7GtRucg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=u0ehfrbSjPQ3retvIwIVwVND1CM6LZKE1Jd4ri72SidJGRHNmHJ+fBCERXEMSb2Fksehdv0NuxcB7+WXnNZKPgiHeVXAL8+ZRWhxN/07ARksOJelUEOSusdYFTt8HOLABUPOhSWhyy9LrjavhbrOHT3lDJ+tpZQX1diyRnw7Frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsTtA8Y+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsTtA8Y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788434989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
	b=NsTtA8Y+iZ16l1mCXQY2hoUVWqV7b+0sDAEaIf3yA+b0CecOiEaJVQJ7flPsv0MDj9MkgJ
	J8Md/G+MvyjcX94334bqqQqrjsqc9tsDaADOWSQRIJ13aFrFMWBZS/hYL6RGLvLKMwevTh
	HJOr12jYY7DI1KHBCRZox/YIY2xM91g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-D2JvhJ9TM9eKSb8QCY-8lw-1; Thu, 03 Sep 2026 07:29:47 -0400
X-MC-Unique: D2JvhJ9TM9eKSb8QCY-8lw-1
X-Mimecast-MFC-AGG-ID: D2JvhJ9TM9eKSb8QCY-8lw_1788434987
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so3721431a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 04:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434987; x=1789039787;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
        b=dJIYYu2eT9/r6lzL9ionxsRJ3hg8UYys8/4TPZ3ywqF6entbCouebwH3oEVa7qBjrm
         Ce5uaKRqPO/MLxLY27SgiGz48jfd/c2psz6BTW6azfX6NEk+nFiDC1d6Pvax147b0Cmx
         AGkuZAqsUY1uHJqs9K0HlKqI5UWUm1dIhTh2xp2m96C3eVQRYwUKrWZYEyIEC/u4kpca
         L8Dz2FWh4IoL6y4tWd8AHcLqfyRhcDhp3DElLYq7nRD29QK6Ds8WMHOkEx0duullHHGB
         FdyFUlpaNiLAmoGczIfc3AsM5LvKT43RHBFFWSEo14MwCnA81pILX2AhbXR4swWDQlpv
         wJyA==
X-Forwarded-Encrypted: i=1; AKwUvBytTUK/xG7HZxeuNmCrOu2ikW8bCDqcGZzaavG8WIdbVa5Axhej56/K4hpfo/udfd8mOFPAKxXsOwLlZR7Gme6f20oWOL4=@vger.kernel.org
X-Gm-Message-State: AFuF++kNfW3ZZsK8cwwVSRyu2BZPE8TOO/D02fBgubicVnvaYwSlrHUU
	tcF4OHz3XkVbFIqySnkgbNUeuyK9kuZeP+7ElO8da5cOnJa+gJeQwWU0OO9I3XFVml+Ay7GiMTc
	d3xQqFpNS+4ttcxJ2FVn1yvYp50qAF+l+6ATYsqd0EhqsHy5NwwoUWLUxVYOKtzwQgXI5HNLVjg
	s6cdmO5hi6XL3UAxf7xjW73s0SCjbfQUk5n/PWvdljbbD492BMO9ZD
X-Gm-Gg: AYBFou1PDsrfZebur2F6QBVsCP67TJzmCatmcZd/1kY4GVsGn3K1LzIQUq4GrRwxi3C
	z/gMxE4K8qGs5MTlyN79KaAUOHgCH1+AjnlFn7KNuAg7Yeh6zXagJZK9Xk7bvG+7HUElIPaXPo7
	4OZ/dwfugmf5Mg3T1KoNlrNFvS6p+H7jCbqDEI3IYMrQtBbDeG8sGEGH6W
X-Received: by 2002:a17:90a:114f:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b13247f46mr3961967a91.7.1788434986634;
        Thu, 03 Sep 2026 04:29:46 -0700 (PDT)
X-Received: by 2002:a17:90a:114f:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39b13247f46mr3961904a91.7.1788434986124; Thu, 03 Sep 2026
 04:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 3 Sep 2026 13:29:34 +0200
X-Gm-Features: AcwNN1XauK1UHYRFaqFGM29UmCm7nNRZqtPbHkS3EwnXkUnjWmV2sSB-gTg8_vI
Message-ID: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
Subject: Heads up: Moving to a different email address for my Linux
 kernel/SELinux contributions
To: SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 14xbWmQ6x8Z5-_SMcX5VlA-QGmtXDPsAQ_BphBTcP4k_1788434987
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Due to certain upcoming changes to my employer's work laptop usage
policy, I'm being forced to more strictly separate my work-internal
vs. upstream/personal environments/identities and in relation to that
I'd like to transition to using my personal email
(omosnacek@gmail.com) for my future kernel/SELinux (or other upstream
community) contributions.

My work email address remains tied to me for the foreseeable future
and nothing really changes in terms of its abuse potential or
whatever, so nothing bad will happen if someone accidentally sends
anything upstream-related to this address (or continues an existing
thread), I'd just prefer to use the personal one as the default from
now on.

I'll soon send patches to update .mailmap and MAINTAINERS in the
kernel tree and SECURITY.md in the SELinux userspace repo accordingly.
My future git commits (e.g. on SELinux GitHub repos) will also start
to show my personal email address in the metadata + Signed-off-by.

Hopefully I didn't miss any important detail and the transition will be smooth.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

