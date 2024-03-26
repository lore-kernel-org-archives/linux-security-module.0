Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909113CFA4
	for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480693; cv=none; b=N4y3YQ6yT5h3XS4DeH3zTM80pxxGag4DsVd8R9QbHME7R92CFhMGGXAwHiaMs5Z51TDIcD65NwzeVuxlIJNmbR/MY2VA1Vjd6osmEqahG4VZ6nkid2PxDPd7MbJTND+igVBQyIVqg83Sq2jkOW/8mWvfrj1yY2yMpGOeN9XjxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480693; c=relaxed/simple;
	bh=c2enpOGs0X4T4rjqA7ge5hA+2N1P5nMY1p+BtQwpvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvgR075R1/E36b+AdbmHoYwgS1d0BmkewNmHcdydXiAd/Rla2g+hjz+WNhnQfduNE7CJUs30zKwWqyM7wONym4NdTFS0tP13HrmRZKmPUEJpJau078EZ8dOoh+MpafS2YyDvwmVQyRXJozrh9uNOYqqEsBykMQztPymI+SUwx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EsFc3yX2; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EsFc3yX2"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6031258276.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711480691; x=1712085491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaxPwfF6pcSWzIoXPt3G+TXmBRyW+5V+y3uoFizWf9Y=;
        b=EsFc3yX2r7LXKbaBWPyMnOKWwGmNXgiF8lUhJDrsdtAHd5+ZBWiouzr2A7jkRmkKNQ
         9ClNxKBDdC/fPj33Qnlpd1eDYYs371Ie61f/TuEx3H9IZlAbr0jtD8FSAXrB4w/ppFJa
         Vq86UYpi7/bHFeaZZMJ4AHSS1mF0EcPeqk8taxaT/uyc9g//TJAMnFPD0mGc8IO5TSC7
         sLRlKR7QhxD3kqhV1zFZTECgdtukh0zOlCuVxWJGcZFkOqEBYC6X90SikoCn6wUDoXB5
         slUPTqcvaKDGa9WgteMAx4JqaOY/Pq6KthxnAQq5BAjodshJZzX5hC/FP7CHn0Z9jjWa
         hJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480691; x=1712085491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaxPwfF6pcSWzIoXPt3G+TXmBRyW+5V+y3uoFizWf9Y=;
        b=hDJGz9XPrtHxkPV2TEXJ0Ag+9H51RANuti0iAe5hN/xsJgVaFT1sHeIa1JeRJrx1gM
         4m6BKHCpt1xYQpQFE96MGcCEjbxCGEDHeFyMVkQZpVB3LCJ/AcXsA/RE1sKqkipyjR9Z
         RUKYdO8hoa7v/2KiOs8Sf+BIw/8Me8xIKsTR31i+jdL2dcjwQmqsU+onIlmMAKqEDg8s
         VhKSvb+nw+XJCRQCnPQKtE5wWEl5QW7dinJdtCvvXK2wxtmrt9cZH9ocIudV7vbo+aiY
         TLdyDV0f8ogmXlKT201r3S7mmIGq0qUjvju2JUzrf6ypVY0lXACLV854IOQrU3K5/pXH
         FQqA==
X-Gm-Message-State: AOJu0YyhSGHwJN5K8whGMjVjBs9mpr+uzB9GTUlvHU1GRbDWKdqB/ftI
	39lCuXOpr2emUMR3LTICzvizXs4k7kcwUDf9pw7w3w/SejoQTemW0YW6OudgqsWli14OLXJjTKp
	jsb65fnbPav+CO4293vWFJmPndW8HhdchcTKt
X-Google-Smtp-Source: AGHT+IEcNPIscIUrckKDg5If7x3ZclJg0Hn8ehLPXdqFB6Huk7CPYW+4wqalcC+NaGkyWtv8nYTfzs1Tr9JJsquzDkI=
X-Received: by 2002:a25:bc87:0:b0:dd1:3cc1:5352 with SMTP id
 e7-20020a25bc87000000b00dd13cc15352mr1736980ybk.15.1711480691209; Tue, 26 Mar
 2024 12:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com> <20240315125418.273104-2-cgzones@googlemail.com>
In-Reply-To: <20240315125418.273104-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 15:18:00 -0400
Message-ID: <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Document the unused function parameter of yama_relation_cleanup() to
> please kernel doc warnings.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/yama/yama_lsm.c | 1 +
>  1 file changed, 1 insertion(+)

One small comment below, but otherwise looks okay to me.

Reviewed-by:

> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 49dc52b454ef..f8e4acd41b72 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -111,6 +111,7 @@ static void report_access(const char *access, struct =
task_struct *target,
>
>  /**
>   * yama_relation_cleanup - remove invalid entries from the relation list
> + * @work: unused
>   *
>   */
>  static void yama_relation_cleanup(struct work_struct *work)

Should we also take this opportunity to mark the parameter as '__always_unu=
sed'?

--=20
paul-moore.com
