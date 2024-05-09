Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CF128393
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286272; cv=none; b=r9/Kz4iHd/tFO3NBsaWWSpCPeywEroNI5Cz+N7COPUPsfqHr3Wh1J+IgVC0jRAqdJ9lOuRTfZTGI/sxJPn4tD7FOtt2w0nodpsOW1Ty3EghFtXIFzoB/UQH+P4ztlfY5JHSiOTQv67M8ckHhs96VvC2od4qp9TkwuT2OV5qfNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286272; c=relaxed/simple;
	bh=YV//7fsqwnpC8rn7Ht8SARvm/2KOCQeO6XAmlJNmCxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOI/zi+PGjYUGN9sHFbmb59VOwmSb/4A0wwdP2+FYs2jb+GyZMBxHf8uMYl77diRWoNn/xCT6NfP+lrbVCWKObBM4ub1xqiMTdb/E6t+h8ZGUcqbFwZ57bXOdMzLrBC9f3QWqxIkEt7rHIOxn3YxxaPAUm3fUu7Z+nGFcj3+u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ez92D9UX; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ez92D9UX"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7f3a5ab6a18so369531241.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715286270; x=1715891070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBlvSCCzNhiMSs/fdIYYqTI6GfHdvf7llrF9PbjYLSM=;
        b=ez92D9UXtVa/5zgB0EM4zjoF/hfYeU9pCfAFjSfETytdJxp8ehWm7YOOHl0AeB1GFV
         ze7X3zhMESPmNTsqPi6yOS5NMIeWWTh4GDOM+wjYaOFbX7qij58hdiEoqgIqZbkbUe8F
         eLgELerxBBmQfjn5bWS9SLP81BEDka9FPbmjRClQGjjIvMhJZdZ/dXJivrppq17c5JD8
         OWFs6Gxpq9cCUANgo3kvpYwBT6b0HRNAAo1JmwqHjfvH6u6y1iP1fXH3kAPorp2OpzEu
         DFXcr90bqR36+h74ZJdkLAYsANRRHobnln36HjxSoc0czsuhN9Z8/39Mho5hbrnMtqeO
         abOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715286270; x=1715891070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBlvSCCzNhiMSs/fdIYYqTI6GfHdvf7llrF9PbjYLSM=;
        b=WBI4LD7pOMRANlTXGcwUBNGfIAX5VJgXOtpNctnit38oJa5gb7GDXE7gfxKLBmchx3
         xpOXn5OcPos5QTb09WMjEYoraPHToXvO1GFF2gXd3u7M+SeVMFUSJ8Yj8skD3vDR8A6t
         muEtA1U/CTkybx85S1KreFX18mAuUKlliSk0tw4lwWZ+1RRw6aOYqAjWfNVYNsJbKohd
         C/Dhv/pQmovhCU4Y9gevtJizNkD93URS4kHOrzhcxCq8yAaY1HAbQw51N8RlAHFZ6vQR
         sjunC0tLaD8/ObfOlg+OpIsxjhwBqZAThlVTOWko6mTrSiqEHSsHRqG+FHoyc/CPJYFJ
         eWHA==
X-Forwarded-Encrypted: i=1; AJvYcCXfOyhyXXROqdJ8G9rEoizCMKLhzRdtvq0hywFpP4Wg7W6+skQxWM1kCbdABNZJorOP8mkaqTOT4cr5Wgre2kVF71uSleSyY9d71pag8nivePPo611u
X-Gm-Message-State: AOJu0YwVN3XKQdv5pUUV67GW5pXPjXKSaIxz5ODTViEnAvHhea/+u4uX
	OLajNUMb2yNctPG3lI8x+6lE04DS81I7lgPzOYlXpiagbx0OH4OJHqe4tpMvN0NB/VkP+TGY4rC
	gfr0vMfDg/KNaltD2fphn8Lv89WG1IdXrbbXQ
X-Google-Smtp-Source: AGHT+IH8KzvWPNo+HCZvNXMR9+VREiiHcFItnWuyCOonwxk6dBAa2EME39LnQ5/ASqOHhsf8rqfTCey1gxGm1cJP4OY=
X-Received: by 2002:a05:6102:5090:b0:47b:b404:d63e with SMTP id
 ada2fe7eead31-48077e0b67dmr968926137.15.1715286268370; Thu, 09 May 2024
 13:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook> <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
In-Reply-To: <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 16:24:17 -0400
Message-ID: <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, jackmanb@google.com, renauld@google.com, 
	casey@schaufler-ca.com, song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:00=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> One idea here is that only LSM hooks with default_state =3D false can be =
toggled.
>
> This would also any ROPs that try to abuse this function. Maybe we can ca=
ll "default_disabled" .toggleable (or dynamic)
>
> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may be=
 a fair middle ground?

Seems reasonable to me, although I think it's worth respinning to get
a proper look at it in context.  Some naming bikeshedding below ...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4bd1d47bb9dc..5c0918ed6b80 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -117,7 +117,7 @@ struct security_hook_list {
>         struct lsm_static_call  *scalls;
>         union security_list_options     hook;
>         const struct lsm_id             *lsmid;
> -       bool                            default_enabled;
> +       bool                            toggleable;
>  } __randomize_layout;

How about inverting the boolean and using something like 'fixed'
instead of 'toggleable'?

--=20
paul-moore.com
