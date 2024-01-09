Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCD3D56E
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jan 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWlSS6Yx"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27733ae1dfso387868766b.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jan 2024 13:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704834497; x=1705439297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5OP/fkUpA71bK1KZM2DjGPMtohQ3KQSJyVNV5c2Cc4=;
        b=UWlSS6Yxl1p5721X8eP93FRoIWlkp5L5CYtgFZoMHT9P/aOafWpLOMJqTd3ZY/NPzb
         V5+jTMqeNMgWvAJY6xBtCQzMkFnwm6Snt3CIXGH0qewqwbODL5LYrCogFBOafLxsw4pF
         W5rriunfCkUIz9wnz98DglfZih3Jz3LN08K0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704834497; x=1705439297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5OP/fkUpA71bK1KZM2DjGPMtohQ3KQSJyVNV5c2Cc4=;
        b=w90pvcBglpDWkdA2tuBrQuxPEqjbwYcKhAH6puPm3eAViEVB1YEoVVrkfM5wiiSJO3
         F52/X1OTz43dc55n0Nqb8D40Zv+xwD2Wo+rv0hA0e5vVKep7Hf23BwNzGZ2TibQ8U4LY
         RDhyVSDMTp9U+BxhGyOn9J7iabKUxKDcjX4phhKQ/eKkUVPO1da8Nm3Cp0omW1YbuYvB
         CfUX/x97/TF3ierRaf4D+SF4X3MXqVTMnYbjZaChr1Foik9wiEa85jLHWlWpPFDxOca8
         mNYMKx8EAo5ytm/IYuPGVmGrHBKxsyQHCvF3HwfUnUszY0VteKFD8nrr+bI/tI89wKj3
         6beg==
X-Gm-Message-State: AOJu0YztC08+yaSmLfa6VR9Y/U3/319nt9hRGZRWmin+tRdV5L6vOPFe
	EdOwU6YOf7LXlOxLGTJp96PUlwTx7xKssYZJ20qe5z/t/rzUjtj7
X-Google-Smtp-Source: AGHT+IEhSvpD8lCL4RNCrM6tmPAi76Q2O92UZ/V6D2E7XC9HiXjUPY78kqL43zveqCiDnLxGYj27YQ==
X-Received: by 2002:a17:907:6d15:b0:a28:b554:f400 with SMTP id sa21-20020a1709076d1500b00a28b554f400mr29594ejc.143.1704834497175;
        Tue, 09 Jan 2024 13:08:17 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906595100b00a2a4086c6b0sm1403881ejr.82.2024.01.09.13.08.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 13:08:16 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso3973876a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jan 2024 13:08:16 -0800 (PST)
X-Received: by 2002:a17:906:f599:b0:a27:a00a:bd8a with SMTP id
 cm25-20020a170906f59900b00a27a00abd8amr37454ejd.151.1704834496115; Tue, 09
 Jan 2024 13:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
In-Reply-To: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2024 13:07:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
Message-ID: <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 15:21, Paul Moore <paul@paul-moore.com> wrote:
>
>             The hightlights of the LSM pull
> request are below, but before we get to that I want to mention that I
> expect you will hit merge conflicts in the arch-specific syscall
> tables as well as in the doc userspace-api documentation index.  Some
> of these conflicts exist in your tree now (syscall tables), with some
> others likely depending on what is submitted from linux-next and the
> order in which you merge things.  All of the conflicts that I've seen
> have been rather trivial and easily resolved, but I wanted to give you
> a heads-up; if you want me to resolve any of these let me know.

The tooling header file updates by the LSM tree were particularly annoying.

Not because the conflicts were hard per se, but because you had done
the header files wrong in the first place.

Your version of the tooling header files just didn't match the real
ones, as you had added your new system calls at the end mindlessly,
without noticing that others had *not* done so, so all your tooling
header system call number additions were just the wrong numbers
entirely.

I fixed it up, but it added an extra layer of "this is just annoying".
You'd have been better off not touching the tooling headers at all,
rather than touch them incorrectly.

            Linus
