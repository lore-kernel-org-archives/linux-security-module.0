Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278C189B8D
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137584; cv=none; b=fZk+na8PkETUUolOzxiNZ+9TmeVGFVOwLoqFPW2gQzcyxcfphPAFWZKsCxNZGUz5U5Kd0U3MoMrgUz0tgLeI3Zo7wfZD6fKFWDS3h/ruCHY/OnUX1QEfi2JbqGzh2QHIXEhBZR/FnF9T0zjSnyLYybQ77VWx+ltNu/QS44fUuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137584; c=relaxed/simple;
	bh=UTK3MbTaCL1n1/5i9jTkY9GsZk+1O6VCjq62oiu9i98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFzujKoyNTkjr25hyVuSjUbk5+lIdB9nzH/Yc89r7fFDkGPCrj3ddvWeNGWJOvKfE4ZbQA5oUpjvqrK8SQbUhaSuqzhoE3SwXtYMybM9Q/wu4XauqiY/t+THpPv8+f5NyfiNszwdCEUriiO9CFCazZ7C5htKuKL/JwC6X7TVmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BMlXRMmq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BMlXRMmq"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0bf9b821e8so1105366276.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Aug 2024 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723137582; x=1723742382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7j4id+E0N59hINJSa1Ik/tq6mBYW9RIP0gt258DV/U=;
        b=BMlXRMmqo3nNOfPAuzmFLhr9ar++2lcMfEqHyuhNHE7SUrvLeRzim3yjIlMKSJYiMl
         s4U+1ufIfxI36brhEFrbDuFjQDN7f74tgPtVzcSui2gYT6OOXV+8f2udORV4fR2wQ9qH
         Ee8glQm+tdYhbi7uNqvGCwnvR3q04eGqqZSIWktZtFpFskFjmb5kfXfNN5OillaJ43xa
         caHxH/8HsPl9WtTXHiQZ6r2ugZV0vNWctSNdiQu5Qm6reEWZzc3+Vf34FU9HHlSav2vk
         Cii2qi0g5VBy5o99YjTGC4gr3rckcEBtUOLTuqdUCUZgb0sIal2ZQMlWKOe36RLI/TG4
         XA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137582; x=1723742382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7j4id+E0N59hINJSa1Ik/tq6mBYW9RIP0gt258DV/U=;
        b=qNS2ATGkHa7Isb+4cQPh03UDJ7Ff2AP5Kf07L0HpGTOGBX2VgFqOmcE6i80fgMTH9k
         5gwqB33oRiHUPCdJnLWWbzT90tWC8vLD8USLhk4UrV941zp+cDFhPBRlZxf5CbI4SeQk
         I3FBW/BthKOyj/9fRvi3dqjbBuKW7vrZG41X1C/lGh6fCPIXo3y0/jV2++LZibrwJKHf
         33PkzvLhpX+SWEJIOvyJjpYIynCIUJ4YZio6sKvYpVm/DFL/Gar5qJGsa5eWpswyXmXf
         LOsg7llYTi1Cp+V9XDtpJ+jljrj/Wq5fVzkcvXTp37yhU6vUgjsd90rlhB5DZ0uElCxw
         4Avg==
X-Forwarded-Encrypted: i=1; AJvYcCVLF6g6wQtHI4n3p+1hEWqYYYCjpXx9Lpuhpo1kcvce01mt1cyiEHITpkdoPGrgji+jLPgZHCcO23HbzETmp0PBLbMJ7gZQlLu2FCs21WObwajPPtxn
X-Gm-Message-State: AOJu0Yw6mXzIY0cOPz+BqjaVBr8b6VjTBCT/22K0mrzBrWmiyJ8ifSg/
	IzMyvLJ2LwHouIJ2VZV989viFv55yTLtNQuUjcR9Ar1UPpNf+sPUVLf0ndFCJVfxZMyRDsC3Pzi
	UI8sXvW6jl9dc+34iipKEHZ51Y4zHzmn0oI/9aSRNyfrFiN+IZg==
X-Google-Smtp-Source: AGHT+IGFllm8smp8j3SS8Lkq9w2mfD8VByKiAxaIaEgk87F2tTSALoLQCwnk+1HhpjXBLzVARdifZYrNQLu26MduEDo=
X-Received: by 2002:a05:690c:f83:b0:65f:7ac6:7f69 with SMTP id
 00721157ae682-69bf7353562mr34263017b3.6.1723137582068; Thu, 08 Aug 2024
 10:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
In-Reply-To: <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 13:19:31 -0400
Message-ID: <CAHC9VhTp0oy51Lnn8O2ffCTAxpu02pZwKdeJtww-LxTFkgEv8w@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:57=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
>
> This seems very odd for especially ARM as I don't see this error when
> I do it on the next branch. Possibly something in setup_arch is
> initializing jump_tables indirectly between v6.11-rc2 and linux-next
> and/or this is a warning that does not immediately splash up on the
> dmesg.
>
> Both ARM64 and x86 (the architectures I really have access to)
> initializes jump_tables and x86 is the only architecture that does an
> explicit static_call_init is x86 and it's already in the setup_arch
> code.
>
> https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/arm64/kernel/setup=
.c#L295
> https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/x86/kernel/setup.c=
#L783
>
> Guenter, I have updated my tree, could you give it another run please?

KP, once we've got the ordering/fix sorted out, can you make sure the
reasoning is well documented in the commit description?  From what I'm
reading here it doesn't seem like it's something obvious, so providing
a detailed description will help us several years down the road when
someone changes something and it breaks again :)

--=20
paul-moore.com
