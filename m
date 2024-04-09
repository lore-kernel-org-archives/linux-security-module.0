Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DB156975
	for <linux-security-module@vger.kernel.org>; Tue,  9 Apr 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687105; cv=none; b=UOOAiYBSF7DEoecnefE9aoMk1jr3qTIhWmzY6tHYgbMorPBraNJYm4wqIgHqFh14i5lnKCAdsSeZbY5i/t9auvxgBSgpmrlFlKY87gtSRYuWjEqxYLEc/zLuJ5Z9tnDPvzJPwraGgw3hCLrrO0WSLBJayQPEOV3M/5O7+5x/x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687105; c=relaxed/simple;
	bh=TnTEVY6GSh34M+Bzz7VmtJbXDhI5rgwhzvIBnQk47So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdw4OlZN7OhiFC6WQiHv+AktZY5brz8iOcp0OiTAIKVh4l+t9YdpaKc352lYGp/t5djRZk/xYNTbqMB0CHAE+csfa0vFTYeYX4uPVURIJEOqGhTg15tCvqjVyyy9JrXl6x25Wl1fJK0mOMAAaVNTF3kQRhDphy+7rFumLO49mzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SLjNtE/i; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SLjNtE/i"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a519eae91d1so576198166b.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712687102; x=1713291902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw5DUGs7JS8G4SFB7desIP/FBgPQWEWdQsI36wfeDxo=;
        b=SLjNtE/iY4EtBSVi487FbI93I81Qprrhuy5Scww7Cz9b3Te2a73Fon7Zg2NVTvnR2k
         E4RheFjbqS/7rYA10ooVADNAHW35qubBfn9iJCUEi5ETOHd4tvDvldRxb4DJbRix50XR
         /08l6E5sqqdOxtMUIas1lY35idsoh0hD7XnBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687102; x=1713291902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lw5DUGs7JS8G4SFB7desIP/FBgPQWEWdQsI36wfeDxo=;
        b=RzEXSgmE3ld0zHfR5/nACXgY3C0o472sMWidq0geYGa+D4sheuR8Jctdl4aMQ5SZ+d
         hk+IhUb45NJoAYXoaXldhfxycb12u/EemqIMmVNawC5lWQsCdFKOPX83oTiF6ylmsGfW
         /oOcaItY0G2SU/1oi4n7NEDHJv3tPyEec7Sz7xvuf5nahF0OPvDB7+TQ4lSfwxxwdrj8
         gjfNJK3OcCKas4lbFyNtU0XqXDPeWsstfr4PUVVzm2vZTphLjf+S+KqSKf5QMfRzYP/f
         ++w9QCWQVIVL7VCznhl1Yy6i7tSjLcZ4himmOZQnwI27LtnCmC/wU1eqOiaESHN7xJUz
         Rf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXacETg075LLw3v7kU9fYLOABgmH7KgOjRKuBvxcYq9vOgjmdCTMFb/9PhmVd6D+JtQvviURh6Zb38MNN7E66ucBbOU8SOehut/Bs8X6ZAujkaosTUs
X-Gm-Message-State: AOJu0YyEr4vqZMtZfC9E+RRTiaiGM8o7brLpNrnWr7cPA2mCW0Zhd1Ju
	c+8x+hmT4DjPN73v8xY0ZViqQd4RGRJOuhNOnwsnVPCU4TwroG1ayEmIE+hRHIXQLeTBtKwp7GO
	FTxlxnQ==
X-Google-Smtp-Source: AGHT+IHox1t8aEVg8VrEhIhfvZdK3EmGqc8lz0cYVnbhbnKj89c8SzIh5PgEGnQfZXEc6S0B3R50yQ==
X-Received: by 2002:a17:906:c44f:b0:a46:ec44:477c with SMTP id ck15-20020a170906c44f00b00a46ec44477cmr161834ejb.41.1712687101907;
        Tue, 09 Apr 2024 11:25:01 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709061f4900b00a519054d7ddsm5956436ejk.61.2024.04.09.11.25.01
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:25:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso7887245a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 11:25:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/JDJ99RFa8JFXYKjrQuWCpFM/Ib84ReLw4ioKwnN10/Jodm9m/acR4XIkb4nirGzoCQ0owSy6NVkGNJponPO3pPpLCycdsE+Y089QoqxKHckPwPvj
X-Received: by 2002:a17:906:4a16:b0:a51:a288:5af9 with SMTP id
 w22-20020a1709064a1600b00a51a2885af9mr172847eju.51.1712687101019; Tue, 09 Apr
 2024 11:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
 <202404091041.63A1CFC1A@keescook>
In-Reply-To: <202404091041.63A1CFC1A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Apr 2024 11:24:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>
Message-ID: <CAHk-=whXwcBzFJd65gQ09EGt1yuH6RyuErhOgvJK8pjkAVw07w@mail.gmail.com>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
>
> I don't think it's sane to demand that LSM stacking be removed. That's
> just not the world we live in -- we have specific and large scale needs
> for the infrastructure that is in place.

I think we really need to push back on this all.

The whole stacking is new. There can't be too many users. And it damn
well can be limited.

Right now that sttaic stacking code is written to allow 11 levels.

Why? Just because you people cannot agree.

Stop it.

> I don't think describing static calls as "random hacks" is very fair;

Static calls aren't random hacks.

But the "up to eleven levens of nesting" and "reorider arbitrarily" IS.

This needs to be *fixed*.

Seriously, what part of "this is now an attack vector" did people not get?

            Linus
