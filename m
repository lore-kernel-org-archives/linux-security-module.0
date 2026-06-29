Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FE347BBD
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754283; cv=pass; b=Y8r2Df/nyUtpNalF6pzzLn/170dNwNy0kpWipJazYcH9dvPKg5ts9MHxrSFW4l4oy839j15nie0RtuEs67JypgidULxPcCwVhRjqDyoHMwWjMyzcq6rQRAiNUbl0rqIpNVFpHcKU6lPjmJMZ8gwGM3NiKDTjkQ8qeniJCvqoKk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754283; c=relaxed/simple;
	bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRfUegwvW/USS2VWOwqlTkbVx7mmOEzDY9k7CTLGpZC4f4NJWae6KchMvsVHuxRpPC8FCzG5N8Ug6DXF5hRyMlw3YQnA0ItLaerHpD8xbrq11kW/mUjvYhltGL6oUdrchlJi8m+JIXnJUEJmmUwwT7ZjXmARCSUEXUv3LRM/Q+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOB0tbQz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOB0tbQz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6905807a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jun 2026 10:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782754281; cv=none;
        d=google.com; s=arc-20260327;
        b=MA1fHt7mNHKKAXTMwEbx3Q41oao4Nf8JFE7ADneNowC1D7LWZFlD8DIs2kazY6d8TP
         /+Ij4KHrOJRV4u21QcKftmtDe8EYB5ZWroP0nTqAexty4OztQ3G0lCdvo4ztruRd6wur
         +BrK7RFZ4C2R/lJ7dFwrw5Q6aEZOpeWWA+cQiI7E69nXbtV2DClHe9eXUJphdHzrmAAK
         RSJiPxl5cyrEufGHAJO0mKQd2B3hOW577txubvCtzd4Sf+EJpOMEGv9p2rJoWTRfWRq6
         1ahZM5NPd/CPDAfy/xe/obhQfK0i8tMnTixAdFfpHoe9FdFFZoXKMiOAUHWckjvlVtdv
         cO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        fh=czG+0mChg6ig1dOPA2VLgJAqZmesuBWljkVUv2Nt3zU=;
        b=q/9QOQTjvzZ9ZBnplQK8W8jWoLfbEuC1AMz07l3C1RRkd2uxgcnkhrKSRHDxLV77gR
         gRzTCnwaFUWvy2aXPOAX8oCSyH1o3B8acKf0HQqUHkMeQoRKjUBapuM5iyBhvKCK6bBd
         LejZerMnD4hUYjkhVx4aimKQ8av/6u/DUR3kFfXqecnFues5F3F95GLOMIBMd8l3gqTd
         QOam0lKblpGbVZgWlhOiOhZJ2p8zCQWk1YuW32SgLyVFiwgK79RqZejQf+zmxjeywbOF
         bP/iImziLPgOedgV4jlNIszZzcUMLKXdLS4dOR18LWUJSYaXi5sQy18JrXoAKiPU3QSz
         m0/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754281; x=1783359081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=VOB0tbQzXHx225/eBRLGEzWz6vX02N24U92aDSCNpfdq7DZv9iI6NGkOHF5VJSXBf0
         iZEHeZ0V5mC0F3hIMX5sla7sCwE6QUNe99CfMZz+3kF02NmreX29GtPeIhhn9/tvERdq
         6rIHJEfwGNs7g3Qtc2MU325nY7nvEWm2h/9qTqpSpa6S67zweReqCilX7ZHuwu06Afw2
         Tp0haJ2b/3LKr4BGQqiyRCz5NDX62Jd6SCIPaTHgyHwtVcs9J/8SW3WLPHp/mOLeDDnB
         HbauBnc7gNry89jY+RZ4nsQ9ECd+RxPZvUBef39i/RgCTiFo8PTy4LyUjrjbVd51dDKN
         dcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754281; x=1783359081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=WEMmd8atW6BZKOnlJslVHhDhR6fop8plaUfRUJTn946lPsOpLUdIPHtfphNfZddEKM
         yL1ClIjtX6T37ZGSTIKu4oDN6Qks/YqHoO3BcjK361LQnPWmxRW7iNH69kmal/ZeVfJ/
         nU+L+btiSA2xyHeM/fnIRB3OQTQDQNf4QjcrWcDe5W/AJEmuzplqGDL7h9JSDXrxvpJ8
         3Fj3F5VMJBOq9I34K24mQfdMsp56onYnonIEoQ2T/UxXHXrmvjja+GbSJvYiCf6Ab+70
         GRcwqvfIiTYIljD6RBZ02McfF3a8Ddg4Wuzkh4gpo9RKkWy9tfG0GMTGNpbcoR0oOLtp
         FX6Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro1s6J5mV1AQUeZgq+/n8mxKBuzMuLVIV7v6H784sGlIgvGWbqcnTFjbEVz3mOh/jVpDYo8xqFHxLQ2OWOZ8qlqywjvDpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Qii2f1CO/6+E/FZWLNRfN5tEsqMokkUbFX5r3XgVB1jh2spZ
	NfNZxhNBH3rJowik7fIyltfSo676AQ82SvbjbHx9g7YLgtDbaWcoPSkuudW/3FGGhYttj3kh6Ze
	UA6eB3Vvr0e7Hk+BcMslrtgWuMPKsENY=
X-Gm-Gg: AfdE7cnCCTQUl7qa1lQ6T1K4PQS4ZaqlJB1s8+D9tvxbputMQzTpRaM9dc697LKc2iw
	zEQ4nXAMgOkiw49ojSISXvOKUbNsqnwHukE1DT0jCayC5c4pO1fvxH7jF1o2VlB17AHCrHXcZcS
	gWxsivUC8ML+u45YyY5At1W38bxV7YuTs+9n2HhNZ7KpKsgkUZMOeecGPISQzxJr83WLfBASH4V
	Df33rVcqAj3EdhzEt33SZbSX709oFTt4PCcj/hmtW34KqmG8YG/o45XjMjSQyLogdocPAL6D1/8
	DNBUFI6NHq1NEhu9ODvfKopbwvfhp8c=
X-Received: by 2002:a05:6402:390a:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69879e4b974mr46982a12.27.1782754280332; Mon, 29 Jun 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jun 2026 19:31:09 +0200
X-Gm-Features: AVVi8CfvDZzdzYVHdraWAewZEFEyCZ6yZ4zu-tcKsdp7diMSLlszm49WqjY_Vvs
Message-ID: <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:38=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> ackport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 5.10 lts

Chai,

First of all, I don't think that stable maintainers are picking backports
to 5.10 that were not backported to 6.1 and 5.15.

Second, backporting backing_file as a dependency to LTS kernels is a pretty
intrusive change, so your description above is very much lacking.

Please do not backport backing_file to any of the LTS kernels without provi=
ding
detailed explanation to try and convince the vfs maintainers that you
verified this
bacport is safe for the LTS kernel, because honestly, this looks a bit
risky for me.

Thanks,
Amir.
