Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5453368
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397717; cv=none; b=DMEEruNSrHPJ72wbm3bR4FEYkQMu3BPEb1putKOJYm0VAOAfDr6OzLUc1w7+uQEQmp9A40IO48IqAji68fep0cw1V9WJgRhWg23EMWOIa9LTHH134uYBcd5cq4HtajbpOHpmwy+p+rjAjOPHZQtHLoxTAg9QLZQJLynZuE5GQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397717; c=relaxed/simple;
	bh=5j6iT2zeBprglLkGjsx781QuAZzbfmuFvWgXrzwhfk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY4qsp/O97G1Bfcc3fpdcq59s77Jx+rIsEicW7uQzieqvddh5mvs5bD9JVgOqoa1zxOZSLjjtbOKizy2IvwEwxxj4hLhV0zUYLF4loH1zkLaLvCt0I+CaaeumlAlJk98dzVWMaExkPxP+PctP4TJp+ql/Xn/QoxLSV8ZlmDB5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S9B9a/Jf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S9B9a/Jf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so6240325a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734397713; x=1735002513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=S9B9a/JfOu4dceFJkqv/IlkRzbeItpl78nr/Z8ktTpCZmz2A//DQvPf4Jt8JV0Fl/e
         dxqrgzzi9YvgEgTxEXwOmAqmZY5VURR7knXCcRWkLvZJXH6q/YlIJIwHvKxlsERSzVIt
         ThDXeYowbAMaMrlGYAb72HDGR/MgPTo+GpuNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734397713; x=1735002513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=HapNt2IhrpnSO4PH0pgsFgEy81auSxyLuvCF9Nj6eXuJdB7G9WerZC5zJ3/nkzxFjQ
         OBKjJ7nN9nyf/H1q36rAUHP5zaehSnUvRJssV1yyolX13LNzVpcFjLLpcKO3PpdvvjLC
         Qmc5XlkUEz1EEZ29qZO2/bis4Xf/FwNz3xeSw90hsdZAFUfgpkAkUfIrrATouSwUN7Xt
         GZlrJbF1swz/cLhuDwRFTPrro6sPH4lpJlzdI6qacztY57Ttj8twWp8qP0FqyWJi01qj
         wqWJjZRN2Ezvdd9+djfDYYfYehZaDfX8eIrzb9A0eCA/kMtWcHkJ7I+bKzmmJfJRp9+W
         gHPw==
X-Forwarded-Encrypted: i=1; AJvYcCXGSAzm6cM56qGCOuDZu9Frg96OCRSh7HndB5AKPtgJWtl8yxhmVcdqfdSfLNuNuk6R7tIAkm/HDoTufdLvBF0Cf99Prvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ioZ2H6nd3bh5YksBvZDX3YUznyholhGwvGGGOZXPbgZdGzyt
	WA+vghMrPOjdteTkVOB1tVkjhrtH5Mf/1ivvqeqjP6PWO65/fB8yuRpCvZdil/IUWhIdQL43jhv
	GCxc=
X-Gm-Gg: ASbGncu4w9VrAXSmv1r+/Mad/6mVkDtLT3dB3T9ZMH/OHhma3YVXP0da/SUFISEm8zt
	t3CA/1q6TGOtQ//WDNwI3Vh0ExDLhaEI/u+wfBHHNl7PNPl3LiYcJIBZ3eT+kNry+0rourHdHb6
	H+5bNB6ERCFsqLERXuTyk+CuCEkdWtKo0NCmoukErTmHtPEfcs719W1LCg2EwI5sGpVbBSFlptw
	FrIIyk0p/X+Pw+jccd6wJEWJwlC9jeAH4mQhezxa0t+NgvsmayM3ppGGKlWJFug3WucwtU/XEHW
	wuV/hzdo28QGDmgCMDtSq+cDRD6hIts=
X-Google-Smtp-Source: AGHT+IG87vFZnpyriT/vgs2lAAqjNPkzHln0lByKT9DBJwEXa05NhwZyhWjy15shmDzgS9WNSNtQdQ==
X-Received: by 2002:a05:6402:40d4:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d63c405fbbmr37719612a12.28.1734397713292;
        Mon, 16 Dec 2024 17:08:33 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae11c7sm3712786a12.45.2024.12.16.17.08.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 17:08:31 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so635885866b.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 17:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfZEZNOJzOy5i8bABcCfdnIuaeypQKj+fEGrE5Jgcs0+4/UlqN7R44PyLF++R2HPzkK0epRl+vnO2Yp7Fj6SrptY5jhvg=@vger.kernel.org
X-Received: by 2002:a05:6402:27d4:b0:5d0:d91d:c197 with SMTP id
 4fb4d7f45d1cf-5d63c3db906mr36599487a12.27.1734397709817; Mon, 16 Dec 2024
 17:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213054610.55843-1-laoar.shao@gmail.com> <20241213054610.55843-6-laoar.shao@gmail.com>
In-Reply-To: <20241213054610.55843-6-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2024 17:08:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Subject: Re: [PATCH 5/7] security: Replace get_task_comm() with %pTN
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, x86@kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-wireless@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 21:47, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Since task->comm is guaranteed to be NUL-terminated, we can print it
> directly without the need to copy it into a separate buffer.

So i think we should do the "without copying into a separate buffer"
part of this series, but I do think we should just accept "%s" and
"task->comm".

IOW - getting rid of get_task_comm() is good.

But the "%pTN" pointer format ends up being unnecessary.

          Linus
