Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFC146A68;
	Sat, 25 Jan 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802708; cv=none; b=EckluunsX2rXKox8kVZqDa5TO8+2xbnMmQ0FKcwQlpX0lsaFgBQg+lfW16B+BwHjW6QzDicT8hPRwxXPlCk/PGASFHWmpbcyDLeY0rpWdPrCfGS+Gso8Z51IH9J6W+SdsptFgej3I4tAqPgQj2LM5L5R96jg6NkJnjOONlyL4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802708; c=relaxed/simple;
	bh=PqX/Bi2A9rVXygU8/KfvjCjbmijpTkyxNyFT3Xr1Fw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQaPq0d8ctCccRds4UwU16ctYuSco/a4Eq18cxx76+U6Z71qysvbwKhmHgrp+RJFf9js9loZgCZHXihiy2tEHTaPwuOTIfdAspKHOHwLUJ67OHW5sc1KW3iJp/Ls0HMGz+2ziy97kgdl8PdsdIXJvBZ5l8N/UwpqJKO3WFZ4K9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdj1cXOk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdj1cXOk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab65fca99b6so581948366b.0;
        Sat, 25 Jan 2025 02:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737802704; x=1738407504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqX/Bi2A9rVXygU8/KfvjCjbmijpTkyxNyFT3Xr1Fw8=;
        b=Wdj1cXOkoGgYd527P7R3U51d9cLBXEZdEe4OjdKZStjGE1NcdVX06qEPxmoukL83kY
         qE9GMMHh7m7zALEPInQUEukSl6jvTBHLHLveYxi15v1z/Ol/4D67a9RHPRZiUIUtfugq
         gwZOR13ejctBpXSe/nne1wp89RoYXiE5vX4+/QGMLl5bnNdruprjaFktYx+KD2rBx86W
         0MrT78Bw4gldDqeh+ShtK6icNH/v7WJxed7m5kTykTTFJi6p9ghDALX/dhdAjpy04E6O
         OLXPr8ai2CBWgifb5t5W72RW5oUyuS5VfXfCY2lXCUoD1BTCxng09kM9glLB59F9tJSY
         SGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737802704; x=1738407504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqX/Bi2A9rVXygU8/KfvjCjbmijpTkyxNyFT3Xr1Fw8=;
        b=AsyJ3i5ELxNASDO0ygGSvdj6CPGXyMERQXgQ254PLKiRK2jZ06nZJyQsrJNpGrBF/L
         BpZXuBlXDYUr3VtCz3B6Mf5alzth3cp2bwkUyDjDX3ABkVFTxRRIopu1QsJv6xrOiLfK
         5VcwQYAV9344m4cCsx/BSYbTLvWYWymfwkVnvbeKdaIxRNarRS1zdR8yR1IqQ4It58D0
         FilzJrJAfb2MBhWmxnwmfkMRDp2j6FgJHNG71HAahdkX5ZppWZDbfsiRokdfXSYMmiSz
         uhhCHqEso5nxUbJ3bzN9qDp/MjL9/Y5RrHnRkB/VAja+Lw65YZhrDHKNfWzBQ5kKJsgO
         X3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAdHe3Vbsb3lzI2LDC8UBJrBbtWVxTT4PMVMlzosTY5QejFmoVHYRHwOLEcVwjEErIn5Nty2iE01oxC88=@vger.kernel.org, AJvYcCViS/RN6aBes52KFvISSX7RoVeHiRUD4mxyfZTeztco+5phALWSsYmkbt6kaiN/QfDY5hYagp/vkJy9n1w5ZYW7UdP55z+d@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIWAB20oytHGI2MG03k+n4MnNIGEdCwbVvwKigxXIYpg2sSWF
	dOmHzdlndIe/9ZJ6+2xfnlhf1obmhZeQfkf/TJdMqKILCQpFr5pNLxlnmv9K/t0Wwm23qbjH3fr
	5HApgSjOxGFCxfHfT9kajcTGUfr8=
X-Gm-Gg: ASbGncuWiRSgrF/d3LkTQnkkB7lUstGaxtyL2AoZCVYHM6FVCR5L4wrx2rhDqW7Z9Hr
	xFs3pP2uEC+Oubp8ATyik9nNJcKXTulbHsBbqKQP7k0GW2XE0zacQRkqW+VNjFypSO0fkT5ZLeZ
	vMTrYp6JnRtvHhGMerQuOb
X-Google-Smtp-Source: AGHT+IGHfcWWymzI+LFR3rdlOlIa8vG+CK1YsB8vQUIUCWc/hoG1n92g3VRdlrdnTKdKqX7j2EKnJwvAbjYtBeuHcyI=
X-Received: by 2002:a17:906:dc8c:b0:ab2:f937:b3aa with SMTP id
 a640c23a62f3a-ab38b4cff42mr3133094466b.56.1737802704322; Sat, 25 Jan 2025
 02:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123192058.2558-1-tanyaagarwal25699@gmail.com> <00e63eb5-e8b4-43af-b1bb-764f3c5230ca@canonical.com>
In-Reply-To: <00e63eb5-e8b4-43af-b1bb-764f3c5230ca@canonical.com>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Sat, 25 Jan 2025 16:28:12 +0530
X-Gm-Features: AWEUYZkhMB3pE6PNwMhWfqdrHT_4zKKqQTCA_d_-sPorMtbcKBiev4xbNVUrE1E
Message-ID: <CAPdGtUzy4Mv+zikHwQTQOa2gP4n8QagWjp=-_DiKpOF98n3q3w@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix typos and spelling errors
To: John Johansen <john.johansen@canonical.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com, 
	Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 4:34=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 1/23/25 11:21, Tanya Agarwal wrote:
> > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> >
> > Fix typos and spelling errors in apparmor module comments that were
> > identified using the codespell tool.
> > No functional changes - documentation only.
> >
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
> Acked-by: John Johansen <john.johansen@canonical.com>
>
> I have pulled this into my tree



Thanks John!

Regards,
Tanya Agarwal
