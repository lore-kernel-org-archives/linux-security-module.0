Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399041C9EB7
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800599; cv=none; b=QZLtIyx1Bi2Z3wlPR8xmRnSSefdWS9dJ61QlOao8KcmrPTMebCfzYbf9GFyb2aF2v1w6Ju3Riqve3I91HxpeklUNpBfbyst7e7MwbU1R6Jqxo0QbNGowvFSplAluS80h41aif3FmPl8ZYvfhGfk88S4TP7/zlefX06jOTFhrJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800599; c=relaxed/simple;
	bh=0sM+nrVfacbvTFodxDj9UKhTC/YS1eRFcVZP+fkLohQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/VONAG7JGv6916N8ZzcFo/EUdqGaT2A8E5DXSg1C7ujEPrSRTNHqBabkA7qUA4mPb+l22qP5E1WxwaKUA6mdOiFGBPHLZqyxla/Y5m9nke/CpqF8fSMwuvN8iO07KLSN7ajlIHI+OBhDWYOqo6OVemCdkx2blDL+2gwXly/GKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WEkCQkwK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WEkCQkwK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so3586769a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Oct 2024 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727800595; x=1728405395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxJ6pGYTMNRfHwEGgEc2uVDA4qU911HW1i7xc0Dagg0=;
        b=WEkCQkwKZxjU46D7Xfo57l1ApW0bufPzunGve7Fo4LXyzwx3oYTVnGTkQHe1MXTggx
         8/biUQr8PkLK2AZx5cgVyV8+7BL6kIaRvfz8zYa1bcKDOwXSO9ir9LUgLtryhk824Rx1
         JbEPb5sQuB+0iVdLCLL03FrOsE/a4xUz1ZoIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800595; x=1728405395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxJ6pGYTMNRfHwEGgEc2uVDA4qU911HW1i7xc0Dagg0=;
        b=AIWs6yKMLhy3VHRT1D197krcThrX79Finud+PeJBVrnG5ieeY/0fO5p8yjCesD7Uki
         vcPVW6xCb0+Xy/ZRzfsx1iuK4b8PMF8iODIhsbcCKl21ftaBIuEBDjHt4pnW4/r6fyIG
         YjUID4rSiDQzw/HAYX9MoCnr/SJe+BerFa9u+RnlhII9U60HJvrvvXX+LweEvitGUToV
         Eilkugy1kaN9LXF0d77myzoqLQgrJEmrMUFeIqoQChjIbAFrIJFTqvqOJy/vJRD0gupe
         XNilFj7EPCHuaHJf0kvRSq0hGj1/a9rLrkvjbrcUVUT7rPe2wQAjumECTL8DbC8etlcs
         IJpw==
X-Forwarded-Encrypted: i=1; AJvYcCVUAwA0Lio5L+YOPCu6a/N3dcSeZpGuykkENTr9RqjQwyOvTxDMgkQ915zwyfY1TTbCeIulzP34C1fSLAPtAWR0i4x/p7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglYShnKtItBL+rcdRph3hSqlRqtakfqTAxVAHZ3VZ9A3Dw8K4
	GeKP3RHADrXC5DqIRLklb78hmCqnZdA4aK52ITLTBkk2hYJ6CLMATw5mSJCxTFX7vNe5gyhg4OH
	Ns8WjGA==
X-Google-Smtp-Source: AGHT+IHZUJFJFhjgJrcl9PdntjWuXI0xD0R5SOSFJSRC7uCrW/qx6Rj2YQtWaX4aBNwRuJ8aO8fkHA==
X-Received: by 2002:a50:cc03:0:b0:5c8:79fa:2e4f with SMTP id 4fb4d7f45d1cf-5c8826084cfmr13062975a12.32.1727800595231;
        Tue, 01 Oct 2024 09:36:35 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051b7sm6681744a12.7.2024.10.01.09.36.33
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 09:36:34 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d4093722bso857912566b.0
        for <linux-security-module@vger.kernel.org>; Tue, 01 Oct 2024 09:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzUqrChGF13P3CCY73GykQtrl/59fGLkQfj53xV5db6f0VbuWYW97+ZJGdDYU7KSCG08PrJTO0MuyyUd+8UXBok2qre/0=@vger.kernel.org
X-Received: by 2002:a17:907:96a1:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a98f8261ab5mr17931866b.32.1727800592814; Tue, 01 Oct 2024
 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
In-Reply-To: <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Oct 2024 09:36:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
Message-ID: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Paul Moore <paul@paul-moore.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
>
> Linus, it's unclear if you're still following this thread after the
> pull, but can you provide a little insight on your thoughts here?

I absolutely hate the whole "security people keep arguing", and I
cannot personally find it in myself to care about tomoyo.  I don't
even know where it is used - certainly not in Fedora, which is the
only distro I can check quickly.

If the consensus is that we should revert, I'll happily revert. This
was all inside of the tomoyo subdirectory, so I didn't see it as some
kind of sidestepping, and treated the pull request as a regular
"another odd security subsystem update".

                  Linus
