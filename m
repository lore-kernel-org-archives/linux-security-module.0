Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5162DF6E9
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930057; cv=none; b=dKqQqcy0pSx2HZzzUWG28L9bje7098Hx19a3+s4fX3kM59sTC0lDwI7Omf81mJ57TbwCLb56/qyP+gjhrsfvt79EZw8BAd7dqyrYhSywrAyVsBLirr75xtSS0/k+aDJTkGQPOdrcH9NDwxxCSELH9d7ZM7vrQ5LYmUVQJTNWLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930057; c=relaxed/simple;
	bh=yngmQ/ltButix+LVvtj/TMZq5fYiyFfS8swlHEL00yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdbR9bc8JpFMOKaLyv2nBGWEu6Ymnp/g7HtoFPfpfyqF8XJD9CzEA/uwRRB4Jfk9vl8om7nJSmSa7HRD5QlmdM6kQomnIgct5yPhR2YqhOZhJlAKJ9BuQnVgVMSo8KbF9CITQI2MvwWnrg/ruAzaj9WtPeeQEvvLUfxiSD8nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F9NvoDhl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F9NvoDhl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c7848519bso3238375ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756930055; x=1757534855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=F9NvoDhlAY1dl1glMsWEDjRfa0U//fMpkgS88uoGFcco6dl8m1oNuNB26SUGgwlUG/
         m+WojV14evsY8vDoqkVXyHzYsHdA1gmf8CmDMhTTcQ34rMyeSUbT3pRLhWeBL0ZkViGC
         dQUw0/g4qTjdMxbfHE4wzX4eCJOrsV9vM3c+5aTDFVjf0x8ChrPxYq/Wja2b6zKEhh4u
         2yrnDKbPtNa5xm4OQposUE8dY1hkucCl/KaYPtTGwziGajWiZg4eJOKNUiPjc3EXrzYB
         i1KpKWlFKX695pTqVRtpvgrRDY4yDuCjkMueHcb92zM8woATwBVsL22IFsOti1cukUVa
         ecWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756930055; x=1757534855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=rAI+dib62VWAYryqANr0H8ZHe1pfFBEwh8utm1pfAa+GI6nkOrRQ97x1lQmDMlUke6
         TxRcoOj5z+7bE55rSxEf4OwITRLI7s8ZgfBeEufAmQaM0kTZrXy1N/D+gtV1z3H2Gbta
         T0sBWdO/l9wouz76lB+vEwTTg1lCiXh6+RATr8Uwx0k/mtXEDn3+Y2kXb6Xoi+ikqyP/
         7eSWMOWHtsdrCFPNcKCBJ6WSmS7DdH/ap7Sy5BCzDPMHQiHfRA6zM1LhsFITBQTnnWU0
         8HRAMK90P2nEX9aQP2SB/N74g1IFZPF81WyTLZoGvt0VKXMGVDI7LOvlis9Kr7/ZmPxI
         +cuA==
X-Gm-Message-State: AOJu0YxgbzIkNmsaA9Qd7ZNfk00WehQr4gXeeqwmTSrc7W6up3J8kXNh
	CBEop5WDe7ONVqOb7JSFj6Z52O8yz8oBYk8y7DuFPbAOlKxruEKKkT8ZR/ZniQ1Evzo/z1SK0PB
	SOhYo2wWqWK3G4qUIFiKlumuI/uDG+b/KECHTVnqx
X-Gm-Gg: ASbGncveWcrzpOvJvzuq66XnqZkb3ZViEFpL2c2UUVrS7cAODmvS2HNOofBoxRnAsxo
	BgAf0NiWxz1nmxTkCM5XnbY5Hcy71KzGno5ZENDb7wcDZMNHVZae5wGZYsFe35QZNweMBahtY0r
	D0jFYg9LVCXtW95rDrtdcgp+PrVVLSAbeo8ChYZ4AhvI4g5R6z5NZpnRsAgil6ds1I/kGjqXAmQ
	P72MC5qXXxbQufp1Q==
X-Google-Smtp-Source: AGHT+IE/jxp5MGXQjY9oGumbm8NaKpkAlmwUE6015x88FR0z5hTMAkqxHgNJHhqTh4+JXLWysrNaHK0JYJQoNh58kjI=
X-Received: by 2002:a17:903:41cc:b0:224:23be:c569 with SMTP id
 d9443c01a7336-249448f4103mr192848795ad.22.1756930055424; Wed, 03 Sep 2025
 13:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-40-paul@paul-moore.com>
 <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
In-Reply-To: <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:07:22 -0400
X-Gm-Features: Ac12FXzD41H6XFdIb0vdFaRxcoKu4oQccezb2K9_6QR2TZu6fu1vwmKFxGVeaVs
Message-ID: <CAHC9VhRUNPbHnjoOuv+Yby0WPSztSFJJ2GT3NHu32eJxEjiWmg@mail.gmail.com>
Subject: Re: [PATCH v3 04/34] lsm: introduce looping macros for the
 initialization code
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:37=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 8/14/25 15:50, Paul Moore wrote:
> > There are three common for loop patterns in the LSM initialization code
> > to loop through the ordered LSM list and the registered "early" LSMs.
> > This patch implements these loop patterns as macros to help simplify th=
e
> > code and reduce the change for errors.
>                        ^
>                        chance

Good catch, thanks.

> otherwise looks good, and you can add my
>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

--
paul-moore.com
