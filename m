Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3771D529
	for <linux-security-module@vger.kernel.org>; Tue, 19 Dec 2023 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RQui2A1u"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso3776878276.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 Dec 2023 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703001041; x=1703605841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVU3xgdBvk8XLcWcWDCVL/vRqj5MRBe6Jvgvwc1AhvM=;
        b=RQui2A1uT8eC2GJrweOL5umZPPoynwMDMBJJ2Y0zFoE0T9vUAg8H6KXW8JE91DzzKO
         vj1VtTf6rL1xIQAUuG7ovAS6yne+hn1IJErB3OC1AdEhu7GndJgNo0szuW+SJcJoPhW3
         /xYpv1o/IoOE8W9LTQW6weNPAt+HnaJonXWyxiGE+MskHQ7oqWoM3uJZrWFJ2pmGbwVy
         Sv+JEQ3ohYk28AGtaju4a55ve6Pub4cGnD/n5LZuuG8TcQtrWOfPKCqj1gSZjhuoVMDf
         hVdKDgdmp+tqiMm9vjreJdPppgl68wM/teQMH3Y4Q/yoQWoiUB6JcYMkTlJs46RpDf1O
         krrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001041; x=1703605841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVU3xgdBvk8XLcWcWDCVL/vRqj5MRBe6Jvgvwc1AhvM=;
        b=VS6MYGoHUyCVrON4EQKv/EM1m6ySw1Z0dxMQNAOB4YIWxs2RV8ynq0RDlPC5j1oStG
         xw869cecw+9qz5JI3IX81MO28dDNvxgcYuGiJW4Yj8MGBi4/5fU0/qu+ySsmpf4klFKk
         t2vpcCHmSPx3dePsayuz13jM/rNJ6fHomVlq6RhG80ycT2oEunv+PUzRwyUWqn15hw8o
         lHG+ky/H7Ei/sOYd4hNFYuu+OrrYdzhu/xPlxwI3X8YQA/UY0P9tS0hVj7G7kicQwNOt
         QEwhjjHN4Idgkd7VSMK4F9wNugZpxsz5aZYKYFfv9pM7ayVoZgcnIsK5FCuLzmJkRMFW
         QHqw==
X-Gm-Message-State: AOJu0Yxd3d3L51c2aemHfYhAoR+DN/nruasvTLegvKu8QKLhfBwc6U7u
	hHOBLFEOfgGRYYldHxtho6GTzwHMu4gUyhm4HlbS
X-Google-Smtp-Source: AGHT+IHXCsS5gaTDuiAV6NwC9RdUuO5SFm8NffKn5PZ7Y0ea+RPB//BbuwYD3fRBEFlSewNUS1PpOmkkp2Mq1xTeyL8=
X-Received: by 2002:a05:6902:534:b0:db7:dacf:ed96 with SMTP id
 y20-20020a056902053400b00db7dacfed96mr10313762ybs.119.1703001041508; Tue, 19
 Dec 2023 07:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09e4992c-9def-41b5-a806-2978b3ae35c6@I-love.SAKURA.ne.jp>
 <CAHC9VhR_27_LtskFF_0Bzb_9R5r0NRvdW0z0bd9iU8JBOe+HPA@mail.gmail.com> <e7c8c948-edfc-4ac7-8a11-2ce11c1e88a1@I-love.SAKURA.ne.jp>
In-Reply-To: <e7c8c948-edfc-4ac7-8a11-2ce11c1e88a1@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 10:50:30 -0500
Message-ID: <CAHC9VhRibiS-FYs=NHe04_51C+KBy2AAKHut8CKpYs-2KVij_A@mail.gmail.com>
Subject: Re: [RFC PATCH v3] LSM: Officially support appending LSM hooks after boot.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, renauld@google.com, 
	Paolo Abeni <pabeni@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:19=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/12/19 8:19, Paul Moore wrote:
> > My objections presented in the v2 revision of this patchset remain.
>
> No. I answered that your solution is not a viable option at
> https://lkml.kernel.org/r/d759146e-5d74-4782-931b-adda33b125d4@I-love.SAK=
URA.ne.jp .

Let me be very clear, I'm not merging this patch at this point in time
or in the foreseeable future.

--=20
paul-moore.com
