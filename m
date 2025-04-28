Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4583208
	for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878780; cv=none; b=fVJ9/yZGbZKyyPriIBaPDtEs0n22RA2R+QGO26Bg3Gma7ec/X92d4qJGzOdrHiMoZ/bCFZZf6xvx/IEuSHm/leUp4TCar8CwnqRzNyvToFDMCBRiHmqkVwMUv9dvwcnU1psExM7OIFliCrdPhouaSdEJHeQPQiPmMb9Ysy/HLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878780; c=relaxed/simple;
	bh=fg8npc41BWVeHyE1uqgU8UhWodXMg1Oh3v1bw1fIlmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVHDUFzay95JRUeIdGyX3K+enhufseHgSJTMei0PkWlbTGF6ymMPpmUS3pcNgOORd5l3u002etx6ZNc1iUP6+VAoQpY/OgdZFhQhtQd3YTmEoiw6mFPJHq0Y6XbKORWEa+OkU7QPXyIPRiHQbnv3oyHhEOfccJVMNuJePi2Z4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VqCHUq2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VqCHUq2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so8777661a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745878776; x=1746483576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8XDwBQPlEIP8aVqPv3AjI4cdfu20FLxCVQRt+FN+Qg=;
        b=1VqCHUq2JgRbZPQIA97vijYsvvxulx5uJi4gGfIn2upm8dplDiU2mRWE1y4oF6jTmm
         0xAEnZwKLdc1NbABkrC0HboFhyqLd3G+UG7QkpKfKNG1qow/WOXgGZvwnw30KX77pqwh
         hGC26mETO+rerC48a8WbOjpoN9qSKeqkyrixio+cTP3mKXgmrlln/MSIkLOb3y5hYdt2
         +aerD3L8i3oz+Ts3+IviqeVqSKWsLfpTYUmumTcb0+v1nFurBlwsjBeZDkav+d948m6X
         YhlxNGo/iT6emg3525RM1jPdO1rJhKaGgFikob4bnoKVgSZQ5SqRujGVAu7mGffjKigU
         4XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745878776; x=1746483576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8XDwBQPlEIP8aVqPv3AjI4cdfu20FLxCVQRt+FN+Qg=;
        b=ZEGMkZ/i4mrwic+Pu0jlKQpL4MIFy5ZHqc8F/+WOgFi/n5shvoEHxy4JJNrwTh23P4
         SbCFkxt0funDuKmdKwR85ytmpf/bM7nPFXhM2/SQmNMYo0x+evJLmv1/j+2WRjy9Xw6s
         l2b1CijddHf6uJRBIWkeS4rWLeZBEXBPfXYKnTZ+0V4s+jIGjoeLkOd6HbC0GjKzUcUo
         6HE+ygU2e2kqZ/gfxi7yitM/zURWfK5RsjtKmWuvvr5VVJuqDU2Lhip0hG1uCTduEJDj
         LgkSfwaNQ6pGoNY1WcUPIcjZ0dfk3lJKkjEa2Rhqf8cTCDoX4LPuUx79QfFFCy4oaVKw
         Rtaw==
X-Gm-Message-State: AOJu0YztvYY+wmUEu4e0U4w8D3XnRE8orb1oDJg1NLWPZ4cQgOEsXf0S
	vstapW4RhaKql7D4ICDUTCd2hjvHzPJEpvYFcAmf2gjqoaMPZofntd1RuJSnN55BiSWbLUkyC1O
	kBSjs9LvtxRmRuiQmEFYI0hKl29Xwt1tNQV9OPeKRk1QbPqevxT/H5GM=
X-Gm-Gg: ASbGnctjoVUIqnBGOe/Wsl3Z7iQiqUR8OvhQ5EZOPxhKcg1Wpis93Fxrgei9Re/GncE
	9YhhJFKUcHkklDFruYRuQYUo6ySy/eS1R6VCidIsXDgcRpzLmmnFp3GSNoVP6nUYo97wPnJfbzS
	YU9FoETeI4f9pUhTwIBuhfj+oRW6+ApKoWdWl17IuhnULhnIZ9JUCg
X-Google-Smtp-Source: AGHT+IGWZKpNMmqFZiWMQ945Bg761Qg/Yi1T36c0fh1GOvu66gCNyz7GZWSWO6GtIKp0hZHU+tJgOOjzYGKgOqkhCEg=
X-Received: by 2002:a05:6402:280f:b0:5e0:49e4:2180 with SMTP id
 4fb4d7f45d1cf-5f7398350c0mr10651567a12.25.1745878776245; Mon, 28 Apr 2025
 15:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9THx_+SzE_+DMjCeSRE28s3kxZ0OkXgSib3tU3svdQPzA@mail.gmail.com>
In-Reply-To: <CAA25o9THx_+SzE_+DMjCeSRE28s3kxZ0OkXgSib3tU3svdQPzA@mail.gmail.com>
From: Luigi Semenzato <semenzato@google.com>
Date: Mon, 28 Apr 2025 15:19:24 -0700
X-Gm-Features: ATxdqUGlKxLtTrC4LXeqxsJBk2ZUqu5u7ZVrZ2w2CA3x5CtDr2UzMuuPCQyv9pU
Message-ID: <CAA25o9Q24atyK5M6BQaVx5sVq_ZouwRdhXEo3UPa5pE4XVqxQw@mail.gmail.com>
Subject: Re: how are new CAP_* added? CAP_{DISPLAY,DRM,GPU}?
To: linux-security-module@vger.kernel.org, serge@hallin.com
Cc: Jann Horn <jannh@google.com>, Daniel Erickson <danerickson@google.com>, 
	Dave Hill <davehill@google.com>, Alex Glaznev <glaznev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a use case for adding a CAP_DRM, or similar, to replace the
CAP_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of
becoming the DRM master.

I am not an expert on either DRM or capabilities, and I am wondering
how one can decide the appropriate level of granularity for a new
capability.  Is CAP_DRM general enough (but not too much), or should
it be CAP_GPU, or CAP_DISPLAY?  Or perhaps capabilities should be
discouraged for this case?

Thanks!


On Mon, Apr 28, 2025 at 3:16=E2=80=AFPM Luigi Semenzato <semenzato@google.c=
om> wrote:
>
> I have a use case for adding a CAP_DRM, or similar, to replace the CAP_SY=
S_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of becoming the DRM m=
aster.
>
> I am not an expert on either DRM or capabilities, and I am wondering how =
one can decide the appropriate level of granularity for a new capability.  =
Is CAP_DRM general enough (but not too much), or should it be CAP_GPU, or C=
AP_DISPLAY?  Or perhaps capabilities should be discouraged for this case?
>
> Thanks!
>
