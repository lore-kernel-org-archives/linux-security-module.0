Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497FA192B64
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381535; cv=none; b=ko7KL3xYBUlzF5rXd1mR32E5dnqdaGFozHLUNQAL8XARt5riGm/qsS5sSSjghpXQGJDDm2lDsnPtdlpF77hkvooSWUDkuvPFnUtj/DipLOSuClcvHnaARc2D53TFUOPNavJBR6SC2IuXFB2+nkdgosg7KLHlb0T+iihCiMpOdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381535; c=relaxed/simple;
	bh=L0PFJlPNg2nSFAwbo1MUufU0ZJpnKOJlq9Zz7UzENlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNuTo96UpLtEWyiLRwpiWhWDMjRZtC6Ox7NcdMQI9zJkygargJh0H8jGMK1Tuw5si0rrodNWCodUTDB9VyCFkeM7eeFC2BwkIKitBWbG1ldmM77lnWG+yAmQWD3d8QcuSBnSOSpZ9j3cPeNUOpnVXbKyPV0TFtRZ0pv7jW/BaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUyH/i+4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUyH/i+4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so7814980e87.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722381531; x=1722986331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=LUyH/i+4jDT5bE4URJyTFujqpAZxmWvwf/xO57JopMjanlblkfWQTssjMnjHklDkEp
         seDlFF3A/f+EpadRHhLdClF69n5TG/Inkr6x0JNLV5WwPytpKP9NtH5rv7NeJd9L/ROZ
         9h81OFdMh05qQpkjOJ8e4/jGCCebIZEsEDWtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381531; x=1722986331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=k9EmYHR2QyPFhkqH5Dad9zzMFJ70+8oA5TPI/VfTuUAi9yw4jqvRlVBAf9Aw7sRHdB
         yDpA5HgUyxzGDLCjpYJMOzIDmr90o0R7XLmAMNXZ3awpeFIctR/I2YcO9mrkrE59hL9E
         3t5kwF1VwK7n7hOKRitn+oSWWCZCoVYyu7pPscftMYbirwaf8J+3o7z5tYWZO6lc3Crg
         L0micSQrY54tkc/1cwq/C8y89LXLMBlqX+wIXI9Dm+k0gOWHWOxOTn6fifTW56Pce37v
         dkCzFwq1aaxEYP1ed9hboE3Fp90PHllBVFmp7l/cwllr+1r7dvBrcDRkBvtIlKPn7N/2
         xiUg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8dKLYBhZqF2PRRRU5tykmMk5akftrL3XdEGjqepm9YjRWzT5qylxadachE4bw+wQygUSvWUtjlUJa5KZEtRC0tBX2juEPfJtiMFNs4DAHAuZM46w
X-Gm-Message-State: AOJu0Ywz9GTciRGkQw+SncSnxQF2J6okvfTyJMvTII7fwDVpXIns6NwG
	9fWVqKtm7FghEUzkaJ+VEZKskPcucfYuezftvX6eE4IWD8DsRrVyI+YEJtFQ8OZyQ0rrOoPCOyt
	b3hNUDA==
X-Google-Smtp-Source: AGHT+IEFlyJWonbQN5+iKqeRp/w988BB1+RYGmmEV//2KnT65XNp2zccidYSVlkNcuHI385UgWl38w==
X-Received: by 2002:ac2:4c03:0:b0:52e:9b9e:2c14 with SMTP id 2adb3069b0e04-5309b2e135fmr6026810e87.60.1722381531125;
        Tue, 30 Jul 2024 16:18:51 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41159sm700317666b.129.2024.07.30.16.18.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6996488a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8XBXrala5GWYiJxTAZkwp2Gnnk15LQkWPKrXr63zy/J/jTPwAWmaLe3HhoF6zIMbi8jQPE/VI9uyU/fzzx0f0TJ5zpY6iCthhnoXS5Q+TEQT8GG+R
X-Received: by 2002:a05:6402:430d:b0:5a3:3cfd:26f7 with SMTP id
 4fb4d7f45d1cf-5b022a95ad0mr9903249a12.32.1722381529467; Tue, 30 Jul 2024
 16:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
In-Reply-To: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 16:18:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
To: Jeff Xu <jeffxu@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
>
> > +               task = get_proc_task(file_inode(file));
> > +               if (task) {
> > +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
>
> Do we need to call "read_lock(&tasklist_lock);" ?
> see comments in ptrace_check_attach() of  kernel/ptrace.c

Well, technically I guess the tasklist_lock should be taken.

Practically speaking, maybe just using READ_ONCE() for these fields
would really be sufficient.

Yes, it could "race" with the task exiting or just detaching, but the
logic would basically be "at one point we were tracing it", and since
this fundamentally a "one-point" situation (with the actual _accesses_
happening later anyway), logically that should be sufficient.

I mean - none of this is about "permissions" per se. We actually did
the proper *permission* check at open() time regardless of all this
code. This is more of a further tightening of the rules (ie it has
gone from "are we allowed to ptrace" to "are we actually actively
ptracing".

I suspect that the main difference between the two situations is
probably (a) one extra step required and (b) whatever extra system
call security things people might have which may disable an actual
ptrace() or whatever..

              Linus
