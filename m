Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB633594D
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736046281; cv=none; b=Nv1MjDcxjpead5rAg2YDgiektSYBdLsQ5NbEJywrGeL75W4gX364FQldoUTFvapM5/7Z/Uc1/DdFRyfloE2x66mnZA5aHeaXm4InZJuLGT7LvuQ9phR1HVfR6RUvOmywIwu2023xzO/skaieVofAGVfHzxEC5AYQG14dQACTfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736046281; c=relaxed/simple;
	bh=wVPtncUionGSGB6weARFJPnaU0WDaku2K1rIZTIFdI8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BpCSxHqCO1ru8vZiB5f7H1HanrJ04pDRFrEUlhVpL9nSnpWbTbRvQsJLCEFTu1ICrFtaQ6+tevhtll+an6jwnK9g/+N8+X41uUEMjqlh4LhRgnFXff2KEuNz+U9CsAtjxRIFsdYr2MrDarRQVKz7JnuGNnNFk8YaW3TLH8HhQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I1uzif15; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I1uzif15"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-468f6b3a439so114953521cf.1
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 19:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736046279; x=1736651079; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6955gtKfg5oEFuxtQGlyDD5kuPjGFQ5vk5JbxQicH/U=;
        b=I1uzif15fhgYjmpjRt0yNw+SM4AJCKHt+g7jGhO5eihJwni1DUXGpUbVr+dop6SVnS
         YsIKlUwbpw8X9kZA6mFdfzdVYLcqbpHVrpasrmE3fzqbAW3/L3WfwKpXDAzr3rPxp0SJ
         UdgZUKUDgthV5p1PMT6W/4IDJplWvo3XJ2LRFW8NjJ4u/+ycEHg9LHwzuik8Ngyp10wl
         D8uAq3pVK8x78hZLvZEqiqRj21m+2DVFGqBgjEtNH5Nh9pkRxqO6Te0etAfn+gErMeCt
         QctFrh4daK6yPzcdNNSYm9aCqLyZrILJOj12SIXmDDM5Nm1t/ixLRnHlqbMTL/Mz2nz0
         Pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736046279; x=1736651079;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6955gtKfg5oEFuxtQGlyDD5kuPjGFQ5vk5JbxQicH/U=;
        b=Wy1D41uogigvu0e6slwyS6o5NS0SNCDuGqKy7tP9ZPhkBZqqFVEGixQ3XvZwHWbzfz
         FZJRNuipta8KuZ+htGEh4/HToQD6YE5YZgqgxxWm6O6CWOhkkd9AhHN1AWKiikxfaK+c
         rRF8EnIzG2qU05OMx5qVmsX3QHebn/5tKzg66bCrjoH7Cx/nFxKR9BSkcOgEAOzK7/dK
         LNdlZ6dWPOts9dGttEiAb7zl+gLSJakd3iwR4xT5ulvgX0T5Kv1FbeBzKr4xbHh0AZcU
         h5aCIYZGYjGad3MsrcIc/vvxCpyFWQZ6qkb0f19KYT19LVBZNobGsTIVWSpE6wdz0QMO
         ry+w==
X-Forwarded-Encrypted: i=1; AJvYcCXinTL6AE9b49Fm61d8QePxG+aqhYOFY78e9CL3U/kSJqkmisrscUKKzuwpy3KRs207SqfEySJcmhcVImRcqUQqWUOBxpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U+oLCHV2UTRipPeYL8oitBnIyzGDJYHN0s0sggLL/Y4ZJrnJ
	S0bNyLu4+hgtWeDcX7vJMUTmtugfl/iDbJKcmf9heimjKJCV4XQrWkyyU4BJxg==
X-Gm-Gg: ASbGncs4LattH4KLB1/KS3DP7uGKAfiUUx8V0p4HTjnwudwEtcerUQ2PfJuOb2+EQeJ
	f/XK+rSZoE6gqQpIp63krJD/2J4L08dsftg2l577lI+yI5j2A8mT6ViQuM78ypOGNI4G1pKIpKk
	QBJO5yZKVdl8RbsRvRla4j/fnlVTZs/tqUsbCV/MBKUnd2yOtgIBzCig/9XHP39tWiNSN5oCZlD
	59wfLPaAZg6DubFrbCXFRBeKRL/kUJql6Hfckpt4vK/8lGn25w=
X-Google-Smtp-Source: AGHT+IE27NYmWwTdi5HNIXq4FMJ6UExsCybpWZLcTHc/1IkULeeLF6BI+iMXURnMbLFG6lC6o05CZw==
X-Received: by 2002:a05:622a:287:b0:45d:82a0:5028 with SMTP id d75a77b69052e-46a4a8b879cmr794375121cf.1.1736046278825;
        Sat, 04 Jan 2025 19:04:38 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb2c578sm161953691cf.77.2025.01.04.19.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 19:04:38 -0800 (PST)
Date: Sat, 04 Jan 2025 22:04:38 -0500
Message-ID: <a0d6421cd8fb725ebb627f5e22cca220@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] lsm: rename variable to avoid shadowing
References: <20241125105926.47141-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241125105926.47141-1-cgoettsche@seltendoof.de>

On Nov 25, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The function dump_common_audit_data() contains two variables with the
> name comm: one declared at the top and one nested one.
> Rename the nested variable to improve readability and make future refactorings
> of the function less error prone.
> 
> Reported by clang:
> 
>     security/lsm_audit.c:302:10: error: declaration shadows a local variable [-Werror,-Wshadow]
>       302 |                                 char comm[sizeof(tsk->comm)];
>           |                                      ^
>     security/lsm_audit.c:200:7: note: previous declaration is here
>       200 |         char comm[sizeof(current->comm)];
>           |              ^
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/lsm_audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
