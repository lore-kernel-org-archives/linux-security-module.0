Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B5303CA2
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483585; cv=none; b=LCe7aVm5DjioTZkKJ5cl6lZbWFBdlz7jdv4fpcqJqKb3jkwlBgcF6Sq8mV1TfETnAQw9Tdn05lZ1s2JTHY4xcWs/ox+XjwkZja9Y8A3FPAwirmVXj9F0RClfXgQoTl+Nq/AN2gbpOEyTneH4qStpdan1B9R22ZxYP+VQkvw0sQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483585; c=relaxed/simple;
	bh=THERYyfWpJts86ukp6+/qN9qrzmQKu6JuEBRRXPCS04=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=XJPuAOV6K96GDTWclENzTRstIf3tUQq/xdqFO5VDZ5SZk0QJNqsVon2pIRIEspGnBxEvEzhcVH2aJ4m8r6eLZ2e3aDAXOI/a9kU4LExS/z3ebEAJEH71fMpyNI/DU9p+o80frAH0hi+4jBCBYDsGb7uR5aw6GiQ9EF7EQz2iYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GkIkFMgv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GkIkFMgv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-854585036e8so840219385a.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483581; x=1761088381; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=GkIkFMgvsbHSUec2iqXrzQ6YkQNWroORiwcfzim1k+yimK40eAgy/MJ7vsZhnVCart
         eEL43wryNNCskIbZG2i4xyXjsZpW7jE60WE9uuXlFDvar85+RJXi6oEsYueFgaNTO8Ww
         YQuHfv509GC/Femn5YIK/rH54kyHYPj1fMFpxdNPOIgvikS+sraeWxz3eBjg27wkbX3F
         H0QXkiU9qtI9b4LiMp/KB2yPA0ysZuX+EfDeNfkbPKyRQlOHrgHtxfj4YQ3OkcfZLP4L
         4BD8k2RHQlcwYPGeINzZBMHXGM3N4fctvX50MFCmXFK4ZAt22Mb2WV1d+D9LuA2TW3tk
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483581; x=1761088381;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=SKyVbql1vbHq08HHeApSZ2rkupa9XPdXozWrGlnygpDamfmO40o7Y2SKd9Vcz2lL05
         kPja0t3/cCJoQsgX7QWttAkSqmvPr2gN/Yjm5KWE3JirFOFzsUTwk4s2J6/wCUD0pIfG
         7PTv82ySkjaoT3062s8sCjR/gjx0L68IEi/Ak1mljFUjjitTAeucU3JZLA+2MiNCvbsf
         g9W0bK+crTTAV7PGfuAYEuXqQBR8QQj8OSoSE2JKVJVVRnoTPZCU35HvMF7FobRZRpBj
         vEEYUihHirz7f080qHsVkMbucWsrggv7B7etyx6K7Yo/s/O+vtVEb+QgGmm7w9FCi+TV
         KF0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7Ed9h+uX2VgbcHq+QHspBATFiTl5t50r80onkW+eUKgJBKOcBoOt+CSpTX1mh3ijKl5hMwpfc3YvE16yNEdF6FYImp3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw74TV7vmVfc88nDQfX4Dy3Z22esXWxZi2c1h+bSFRaLF+44i/
	Dxhlch0k6mjVj8gP5hh51KhXxBhQu6gDpFx6i6KNd34Z/iFdobNdK3VZ6OsUMmllUg==
X-Gm-Gg: ASbGncty5yONV1pzZxp20GO7sodhOCOfyExEGWlEyk0pKh7ZsM3RjeKhISd4W+7oJCu
	q4zaN+wEeyfkF2SzDjOAxdSC0TrPJBPpXtCBFQz+mdX+TwKJfNhk7dK1OjQ5xcqn7XxP/R1ax+Z
	IktzRyibVXB2TVtB7DBGNqeu5gflW3kgFir9zyrbqJUckNovNLebgDcmaFe833GCDYDpFGc+fLw
	CZt4JqRP5HarriFUO5osnOtXnMAJ61WUH/IZ/Xoxx0os0bWYU79h0fbLAecG8LnUyekb6hETrbd
	/gHjZZQ95EoMAbjDf77BxjAjiJUMcLA3ygFeHf8jBUzGb2ykl7gY5uNZxKsjY+D8rxycsnp3dH0
	4U4J+EhqIxTL+X+0P/ek+VNR3JSjGae84QCC1Qp4Iv03Ns8dSJ077GsxRfSJDYUq4z4RUs9FNFL
	LrQzMkQLiNu98=
X-Google-Smtp-Source: AGHT+IHjfyLXfSHciAF/hfVvhvyE+ji/i+hx1L96OGYtoV5M7LCsXCFga6nnYCODgc+TQMAmXTHAGA==
X-Received: by 2002:a05:620a:4589:b0:84a:af34:5b7f with SMTP id af79cd13be357-88352d9a115mr3780054485a.75.1760483581287;
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a293bcbasm1290971085a.58.2025.10.14.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:59 -0400
Message-ID: <8f72249ed9358a895e6821495cab933a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 12/15] LSM: Allow reservation of netlabel
References: <20250621171851.5869-13-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-13-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h           |  1 +
>  security/lsm_init.c                 |  6 +++++
>  security/selinux/hooks.c            |  7 +++---
>  security/selinux/include/netlabel.h |  5 ++++
>  security/selinux/netlabel.c         |  4 ++--
>  security/smack/smack.h              |  5 ++++
>  security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
>  security/smack/smackfs.c            | 20 +++++++++++++++-
>  8 files changed, 69 insertions(+), 15 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
