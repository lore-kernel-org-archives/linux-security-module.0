Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C522433B1
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322687; cv=none; b=s2fb7zE98Pz8Vj36Hb7rQfsuA5C2PREqQzMDm/pzl07iRuvzX7Kc6N8ZmnOBZdP+PFr9ovqHREzAMDRkmg6u3deW58lY7PxCgWMvWobWuRenYiayw/QMUstgKJYwMocbw6Wxvr/by+/qNSM5ww9FWSsWnF6WlBctyls9sOkuSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322687; c=relaxed/simple;
	bh=6G+gvRK9/AJlxnelPy04VcTL+2B/if4jaiWFZ/RJpfw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gAvVZnvDCSLN1YIzC0H3+qN3wXK2/4LjXeelDLS2L4KsZ6su5m+zIHgjL3A2QcQnXoD08A/9dlN+jWTlHjpBbqPRBnKeScIy4lHgmiDHQR4+klzCMHcgVagCZjKwAxX0ocC2sXT9jNQgBXevemQWuW+Bx3uHJj9YTb2GWqv+Vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HkNrGDqM; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HkNrGDqM"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46769b34cbfso9502231cf.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 20:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734322684; x=1734927484; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG20U9rL01ie3C2zfS9wQq6XtgoTd/oZlEaXut2SVhg=;
        b=HkNrGDqM0jDVMFv3dXndJNqSiBpFrT5ekKRTv7ZlpocylJ+UrFDB+82bgRBG8Nh2Yk
         NPUqNZEBR6fkI4lh4vqYWoTjTkQHK7zVvZJHV6HUj6kwVeq6Q8akGKGqqum44EwtD5V1
         fCv5adYre8c1EsuY9m4l2juhCGExHdBdDKZzBIR4kvVvpOmFrQJfXqtwoP4LR2HIyevT
         ID6cqRCyvh9LCqLRl3iETzYt+0s/5Xy2+iPlVgQ1Xb+tHSE/51xMtkkie+N4DpKamVkr
         /ucZv3kRBbyp+Km41boWZuMzBCNj8xcrh4J86BCGpRyCvzsxjtPPjqAckhTlGWDNUTBr
         BJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322684; x=1734927484;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fG20U9rL01ie3C2zfS9wQq6XtgoTd/oZlEaXut2SVhg=;
        b=txX7guLtwMsrvW21wJcNuvN3N0dUQHLIzoOarbKdoNZiPABDHZwXx3n9cY5tzy40yq
         dh41p1Pd9UfwJ4BZBtcgjPGzPj3Gb5bKiRvW/bT5GZAX/obb7ngYW5l5lXO5s+O/E6/3
         fDdAsQ1cg2HpMkpCGnTL/0+9jb5JgPA8e2LcU03huGu+Z3KAM4AqeIfc8V6Et48tK87A
         kbFGDnpRpfwLit12CCWqbL+58lFluv0IshVEK87tc+5pWFSHoAd4999mwxzp9FeTte4M
         T2JrJm+TPzNkmPDNMFSn6epxbws9ov8x8wVzFOKmY6U5kykFa7IQvLJZ162rnlN63N8X
         Cv/A==
X-Gm-Message-State: AOJu0YwPUQW8rWK2H8REG41nQNhPRCMqK9Zi37Yzhhi/mBgW9qkaY4T/
	7/TC+xK2Jlhk5NjUcNnBsdlnCNdx0a4pm+4VwiOlJnM17+Pmu539Dosqea+uyQ==
X-Gm-Gg: ASbGncsD2pP1ZgDjCTpRPH57+A8tQ2062fyBcDDsqcMDTE5c9e6oTaG8qjLGbQUhds9
	53eewdYk24RbE+Y52vyojOALAPPKhnjfHnrXEH5TSTY5/xyv3ROG/uTizZL199jE4oGo1AJpM5m
	plNdVLa3kukcVMxyd2ANpObH3k2hCXDA3aBKVhGIQKvtcTA4RI6AAX5yP/pMb2ClyWIKCp3djtQ
	QgjG/MPAXFkCgOJUp3OxXSqTugLyNHRlWYs8YxJG80Oa8S2XqU=
X-Google-Smtp-Source: AGHT+IFPMgiwnNOzXTAlcyGdKVOiYH5SnaLc00WjrMZ2GrKQMfcy8Y2oc2/F5pmkgKUzQveaVfZgZg==
X-Received: by 2002:a05:622a:1f0b:b0:467:5559:39f4 with SMTP id d75a77b69052e-467a5855810mr261996681cf.56.1734322684342;
        Sun, 15 Dec 2024 20:18:04 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2cbb868sm23575471cf.40.2024.12.15.20.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:18:03 -0800 (PST)
Date: Sun, 15 Dec 2024 23:18:03 -0500
Message-ID: <57b468f404c46d23d7c4cb05152c7ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241215_1918/pstg-lib:20241215_1918/pstg-pwork:20241215_1918
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Kees Bakker <kees@ijzerbout.nl>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] Binder: Initialize lsm_context structure
References: <5859403e-905e-4307-9fc5-dcdc93f85cf2@schaufler-ca.com>
In-Reply-To: <5859403e-905e-4307-9fc5-dcdc93f85cf2@schaufler-ca.com>

On Dec  6, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> It is possible to reach the end of binder_transaction() without
> having set lsmctx. As the variable value is checked there it needs
> to be initialized.
> 
> Suggested-by: Kees Bakker <kees@ijzerbout.nl>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
