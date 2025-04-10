Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF11EB1B7
	for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322305; cv=none; b=B/OYxi3e959ZUBzeBdBp5TZl+meZWPFHP8MuUAHA7U48CDU5Usp7Q8am9/5Xu+WNipEROiudkDCDqyRbNymOxOCufl6WWPsrCyaOQoPAFSmHJPiJMd18RWJ2bOKMYpuxZFxryuQ+2mSdi8RSfLB9dijqz6eJG8I3ntRBQ33YAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322305; c=relaxed/simple;
	bh=xf+Qpp4fWLADurZF671LO8FaLAy3yzJQjgSG7swl/Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh1crAmu+h06iaMDL/lVw6evXRt6zuAR5TudXTDSgcf5Mb2fJ4c7tTmortCY1v/2rlpA/L6TGZN5yqfwewIfb/Jm8FiaXEryNMb3WrIXqFujVCz9SKkZmvt1XqU1pXT+3ExOZQOzcBpfNmRfcz7g0WL9QUs3zkZJbvlB9eoeF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UZ/0PdFx; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UZ/0PdFx"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e702cffe574so1097255276.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744322303; x=1744927103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a99uw9N7Lzivq2ccoM3Ykb2u8k0fY7Jrmxn9hUy89Pg=;
        b=UZ/0PdFxQv7bPChJ97kD+qQfIPAMcJI25EjZjyXuzLn26lSnA177P8F7uaE1s6WUzl
         JzpEhnl0/DfdioGAWFxvTv0dONXQlg3Sl+BJHY2yryzVwuXbUVutqAGt5cLahhTTibjn
         p4xGQ4wJ7blZFzxbDcG43Ml0QhMhkVl+/OaafeRwebKkqr33vpD2bKvJhT/d/l8LJPpV
         zPSo9EPmEeBeeiv0tu9+1lThKUGu5slSaBmmkntMu8wJ2Syh6DomdpOFwzbrvgLl7DKm
         J8ZM35RYusnmcOVccOV+KVSKmRh0CLPQ+YfwYaaIzC9p0Nn4PnM3xrTt74+NkS90L66l
         UB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322303; x=1744927103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a99uw9N7Lzivq2ccoM3Ykb2u8k0fY7Jrmxn9hUy89Pg=;
        b=PpYehW0brmo2cmoXNb7aR6e08FUEVdRiuRwPGg51ngsY3hbvf63/8TO0JYwR2Yb6xt
         1Ud7f74J6y2MG9gTT0wbPldy/ptqQFW66jcPz/wc9W1wQJPoyHhXHyRWftn3HNl4o7mh
         8fd52ftWayK7tA67VY/i5lGupFTeiDguNhUqUBrqX0f5C4uW3YZCMYMV+gBIWWQ2ZDcx
         InQafR6txHlC2MMSoAW27i1ZfbTDEFDzTe6npDoaL6pFWt8NWqzV/ZtHcHkJf/OePp5b
         c3TyVQDFYj13HHQhwg8xpnrJPZLXk3otheNnD/3263nMat5xKJNp6Msk5KowSopcy/5W
         70ZQ==
X-Gm-Message-State: AOJu0YyYkhgZWeA9BwVC6EGB0Nn/eH4e1uaOp+A4SNh82P0pMFS2g7Nc
	HzsvCwIp3ifx83x/rL7yuqW2q5TxgOu6SSIgG9L+CQWzJZQ4OoE5UfFZstLKATVDdrYAPHnEcpO
	MgGWwBGhPV6QueMYPvyyx19ChnxTjG5yq08Bv
X-Gm-Gg: ASbGncsPZ8qVYnIaIgzOLNnX6jzAdiAij6WRbai3roTn4BsA4UZ/T4ZtMvRf4L9LCXN
	Kcos5nx00JwVzXNNoZhU+etJYe5N4BuE9BBeOOwN/EUKVZ8JgdHC9L/6NQEn8FDTXPo8hTBGCx3
	O579MxDxuxDRr0Xj44rBLgCg==
X-Google-Smtp-Source: AGHT+IEhqGj1qeRSmULuZX8MBjusdWC5sjxEfjdXDaapWmerQoIjW7G/m0gW/nqxXOgQ7naOlGkeTmN/+rBMNMZGkQg=
X-Received: by 2002:a05:690c:4809:b0:700:b001:a938 with SMTP id
 00721157ae682-70559a013d5mr9801527b3.20.1744322302824; Thu, 10 Apr 2025
 14:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-38-paul@paul-moore.com>
 <3da6eb0d-9781-4d9d-b6ef-f9105c231b17@schaufler-ca.com>
In-Reply-To: <3da6eb0d-9781-4d9d-b6ef-f9105c231b17@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 17:58:11 -0400
X-Gm-Features: ATxdqUGFoxDpFViEAlbFwq9G2XjX-epmb8ySE4XY5YfFgHpmthXke_Xr2ekPqKg
Message-ID: <CAHC9VhT7eVyds28nL-Q=w=Qbe=8mtUCmfHi-1BVxK_0jk3COTA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:38=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 4/9/2025 11:49 AM, Paul Moore wrote:
> > Move the LSM count and lsm_id list declarations out of a header that is
> > visible across the kernel and into a header that is limited to the LSM
> > framework.  This not only helps keep the include/linux headers smaller
> > and cleaner, it helps prevent misuse of these variables.
> >
> > During the move, lsm_active_cnt was renamed to lsm_count for the sake
> > of brevity.
>
> lsm_count could be mistaken to be the number of LSMs compiled in
> as opposed to the number that are active. Hence lsm_active_cnt.

Fair enough, I'll preserve the name.

--=20
paul-moore.com
