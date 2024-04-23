Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E21C2A1
	for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890252; cv=none; b=YB1Da+C0nBcGVFJjpd8CrVMC4KJfSXz4OFo54R+UbomTAHkp2sqOU0bCYIx6EqEx8R0DCC/kEkRzK+x/4kVng66o0wU2csFB/A1jzk9HeTcUkh3ijvadgqWFndxr47cJ9mV4XB+52zbLE+LK8vc+nfAlTOfgpBnbxWBIZcpBQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890252; c=relaxed/simple;
	bh=bVqr/UHJsQYfjpIFdbjqCtbPtG1Cdn8rAp1ojwEtgqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjFdJLCbVvXdC/qhQoearoE+0x/4GaIwJpf5M5REkAtMYcSawohsVYoLCSfUo8xEfS7JIliqS/Xf9h8xgC5hMnimuYLmjdnPrDY+NObsgBred24VrD1JFrNI/wUzAGSsLbvW3h+eVAglhO2WAo1ANVvDIpDiztXrFQ21qiY1tAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VDN4tGw7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VDN4tGw7"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5193363d255so7834713e87.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2024 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713890249; x=1714495049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlPNa3LQZABLSUUaNRkv4uhiNmomWFCxtHuSkH0weN8=;
        b=VDN4tGw7YfKGmooKf1kYsYcMQoe6WEhVySlL1pXpQOxiLrJi6tJfE+r7f9DhBikRZz
         syiGQWrRGkhaU5q/kkJpQKZMoXRxW/Uzzte6ymzq0gfK7+Om8jR4IlGrS/vLQI1fdMIU
         hBN9DYIkunPzyRkiCE7Apk9kSlEkb2wVVyZ2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890249; x=1714495049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlPNa3LQZABLSUUaNRkv4uhiNmomWFCxtHuSkH0weN8=;
        b=qJY+Xl7q9dtnE1fGn2DReOxam1jh7SFHz1T0Y/LqcdNAgarOj1yiYsaVRn8+RF+68n
         vOAHnJifndOkT8/tcQKuzP+XyILMjL5d+lcSS8vayLCJk+rV26BOb94WOzNzt9KirZKu
         hwDO+ZYF9KkINFm+4MxRSO1elQFpr1Ib2ME94LDNfT0jykkgmGCkXmgS3n3qWOoSRKrT
         3tIyrKjooHWw9aBesosut8tNdzyN8OMSw8ll4EwOcJQKwyIvHAeB62gLgtbMj2lMMHxV
         43DtoUtoXUqHss3v+Ugc8TG74zYAwDhNF4djMYRf+MMnI75Bj4QF1gm8dthAeRsfQUc1
         KH5w==
X-Forwarded-Encrypted: i=1; AJvYcCWOk1xglNA9QI3xA9bHF13f3z5EEot89YnznCCavEtsUUzbXiHKQ2Usebq5Jqx5U1A5m9olXLp6ehVY3dr3CGCldTZE7hIChtKQYBP5opJ7yGZ0O4/f
X-Gm-Message-State: AOJu0Yxg+UjD1+/AyTeKk4VjPvuhCMy/5Njlmx+S8FwLZYKnr6JvGUAO
	v2GLrWHgeTqdz1jaJgAIvhKI3bEvY0gLGGcfRi0VotNnV3y5nM7HcyrJy1L2TFO15uY6Tmug/v4
	s+ZwfXg==
X-Google-Smtp-Source: AGHT+IEsCgckTaAhfFQfhM4Jg9O9j3v109dY3lAWFK2g1WXtwqMlWPiL0WRPGVgBPlTYv0xRPlpnJw==
X-Received: by 2002:a19:914d:0:b0:516:c696:9078 with SMTP id y13-20020a19914d000000b00516c6969078mr40743lfj.50.1713890248926;
        Tue, 23 Apr 2024 09:37:28 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s23-20020a056512203700b00518c86b3eb7sm2076034lfs.80.2024.04.23.09.37.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:37:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51b09c3a111so4131735e87.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2024 09:37:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDg5hfxMVmt2acKn3syaDTro+P+cR+7llaUPwGkRAT7zW6N8iLTk2MnDqBtMl2S3Pf90FaN108aq8ByJ2F7lBQTuvh9sTCWaOjsC8fddNIgOrw0uac
X-Received: by 2002:a05:6512:3a93:b0:51b:14f9:3f1d with SMTP id
 q19-20020a0565123a9300b0051b14f93f1dmr64343lfu.30.1713890248006; Tue, 23 Apr
 2024 09:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
 <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
 <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
 <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com> <563ec0ed-a851-450b-aed6-986f6ea324ca@I-love.SAKURA.ne.jp>
In-Reply-To: <563ec0ed-a851-450b-aed6-986f6ea324ca@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2024 09:37:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge_xT33zVY21rk4Le5xyPitiSFYL=qJ5NNwF-F79PJDg@mail.gmail.com>
Message-ID: <CAHk-=wge_xT33zVY21rk4Le5xyPitiSFYL=qJ5NNwF-F79PJDg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 08:26, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/04/22 1:04, Linus Torvalds wrote:
> >
> > Actually, another option would be to just return an error at 'set_ldisc()' time.
>
> This patch works for me. You can propose a formal patch.

Ok, I wrote a commit message, added your tested-by, and sent it out

    https://lore.kernel.org/all/20240423163339.59780-1-torvalds@linux-foundation.org/

let's see if anybody has better ideas, but that patch at least looks
palatable to me.

                  Linus
