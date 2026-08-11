Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7B3DEAE3
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479400; cv=none; b=rKhq/viV2u6wXHJcPMLzhe0AfyKJA8MW83TpVC/Ov4n9SNqV5qbeme42hoPObBqgAIaEPgI4Hi4MYKkRjPMCh5w6kofPPU7p+Wo2W+rYPFogLTB0QYP7zA8i4ua3L4YODGck/d5rNoC/e87HR555P9/fbtDiLDVIIYp5HUax724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479400; c=relaxed/simple;
	bh=Gs5qktynB3HDXrcuUgXkDPkA6vP85YgVlznC3ykj1ZA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BlmVh+xBllxpfzhYNFNgtlFySk5LVDltjJcGccYv4FGCb+KUw18VmgoHKr58B0gAYJOsGB9tGrPplhDt8+V4WT3B/RAFYvrHwUMjxqw1K2en0CwjX/RzqNypAS4ido3s177zfeWSeFKXIdMg1l0xFBBKx4i2nw8nUiLJpwlRcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F0mHMS9v; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F0mHMS9v"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efec2c28f8so1823866d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786479397; x=1787084197; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xH0SwTCGvwIVAyy3MlPE//WhIac69+nmmcFLLqN73Jk=;
        b=F0mHMS9viwiPwd7gMcx/Lv3zHNyIpx0e7AU5waZ+QLlfHPSplJZq/C19lIA9Iwoh3k
         Uaiq5PmTULwhJ7sqgwpOlaukxaxUSRW/J+8AJM79bt9VODWEmHPop6cQy2bjPg0CbeqB
         WCgMIM4OiBCKf6gNkPOoL6XSRm5ZnrFTERIDCB6INW5af8/LxRCay9+ruBFVVFsZct60
         fgMNIqBtjAPYvqSSVLIXkfH2SrAEDbCOBPutibL4PMMc4Jjl6rsbs6bYv/l0tvw3ecmv
         34p7tYeXQmmcP7+tUCORbyL5cs0doTsLfyfwzX6cW5yM5dmfW5/psvN8LOegYgCqeOtU
         Nl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479397; x=1787084197;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xH0SwTCGvwIVAyy3MlPE//WhIac69+nmmcFLLqN73Jk=;
        b=Xfmah2h0DytBRcw+SLfQfHFuHeuX3no1jtH6vi1nOHxWV+LkuXjNmFu3TNKj76Adqi
         EsC5hk23Asi43+2VcHF8JXq3X2XcZRYKdDT5G3NUuk1hXelu804OzHajMVrHPTfmqp6h
         80f9xlHSrz1J+T9C4xI3nn8k5h067sFwwurYHStLegPXK5W41rLJH1eFNpjp7ypnVHQd
         SLB62dE2UjQRCoIGpjY7Xg8qnheWythdlJjAIYr2TE2IzmUZiWH7nY3jTzIEraVYsIKk
         6eakWAickVl3FIjY+hSCaPvkwfQs7LOYVbjCgplSub/IXA+6d95Xf2GV75JohqsOnYUq
         E+tw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8FKbk/ESmzd96QwIlRK9X7d7cvBfMrnsrF+Kiv12CPd7iSfkdUd6Nri+vYE17DHkuhGFKlJfEm6E6BnehWtna24SogSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIaHEWOd1Qg2u4AZeoNDF8CxEFfLDVMmFshKyUDIAR3U7VUZA
	C6ja3D4HzllQmwP385VSBeUbmvJigNqnIwOsWSB9SO2wnxX+jpEAcFynjm4LQ7SQ/g==
X-Gm-Gg: AR+sD11rHmKnZMYxkWJ5URMD7szL82WSuzo+A5JbmWcGAi6Ht1JNFSrAojZjFimMKIQ
	KzfVW5EhbQAG1Z79mI0VEuRGBbQgayvwRMZ1gW6znSlJJA5DUOcPpei0OfVwJdXc3yebMRyVcv2
	fXD49x0X3DdQQyrmUQBmd9Esml20XuX6EZZJIzNpKfFMY+nqin258pz9GSTJJkqgU+770sj+hEk
	AyvGjFwT/bTOvWeEnscj8Fe/nahhrtqYPhA4EOeaOFHkDVzvpcyJLIZCaeSEjXyOVH+hWhP+jEl
	k+EuWxnMpmWOPJDtDbQa1FMu/xhZrQYK6oxrQ1bzZxphKMJl7xETYiDmQUOVMKOGHfSZWhBCKYk
	Y1WkIfKfH6/Yt5ugrr45zRYtElBAit9GISx9cVTGOop8tYKujjJCI+fcNMLJPyIGzpfD5IdAFol
	cejEkkIHEtC69Y7iCMp4wZoWJaMMTB97DRsCf13NGvodMbrZlTe+Mht8GSQlsO03rWCnhH15Uyb
	2ehR7uOC7fo81cYgTdzp2Fk3vYUCgjbSg==
X-Received: by 2002:a05:6214:8589:20b0:90a:6c34:ed5d with SMTP id 6a1803df08f44-90a6c34ed7amr22377466d6.13.1786479397190;
        Tue, 11 Aug 2026 13:16:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29a1f3sm6900626d6.17.2026.08.11.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:16:36 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:16:35 -0400
Message-ID: <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260811_1529/pstg-lib:20260811_1529/pstg-pwork:20260811_1529
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace  audit records
References: <20260726161400.3010511-4-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-4-mic@digikod.net>

On Jul 26, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> information in audit records.  Two fields are provided:
> 
> - ns_type: the CLONE_NEW* flag identifying the namespace type, logged
>   in hexadecimal.
> 
> - ns_id: the unique 64-bit namespace identifier, retrievable from
>   userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
>   (inum), ns_id is never recycled.  For namespace creation denials,
>   ns_id is 0 because the namespace does not exist yet.

Based on the code in this patch, "ns_type" should be "namespace_type"
and a similar change needs to be done for "ns_id".  Regardless, the
first three patches look fine to me (I can fixup the above during a
merge).

As mentioned previously, I want to merge at least the first three
patches via the LSM tree since we have multiple LSMs which depend on
these new hooks.  I'm happy to also merge the remaining Landlock
patches in this patchset via the LSM tree, or you can manage those
separately; let me know how you would like to proceed with that.

Since we are at -rc7, this is obviously something for after the
upcoming merge window so I'm going to merge the first three patches
into the lsm/dev-staging branch now with the understanding that they
will move over to the lsm/dev branch after the upcoming merge window
is finished.  If you want me to merge the Landlock patches too, just
let me know.

> A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> type carries namespace information.  The closest alternatives (e.g.
> LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> either lose the namespace type or require ad-hoc formatting that
> bypasses the structured audit data union.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> Changes since v1:
> https://patch.msgid.link/20260312100444.2609563-3-mic@digikod.net
> - Replace inum with ns_id in the audit record: ns_id is the stable
>   64-bit namespace identifier (never recycled), accessible to
>   userspace via NS_GET_ID and listns(2) (suggested by Christian
>   Brauner).
> - Add Reviewed-by: Christian Brauner.
> - Add Reviewed-by: Günther Noack.
> ---
>  include/linux/lsm_audit.h | 5 +++++
>  security/lsm_audit.c      | 4 ++++
>  2 files changed, 9 insertions(+)

--
paul-moore.com
