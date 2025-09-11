Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78C2C21EC
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622869; cv=none; b=R0A0MfB4/8mz18rs2DFPHKchJlsX2twf4SSf4C3nDoLbQBPiTK2Mob/RkHPDlfx4WvkTxXz4v093w9bCXTup4DA7abaPlqOxUOkRmnb8UbRZz6HWfp6QqB+9cavHVKf8FH8Ca+boDU21uwPZRZ/3p2w8oRCpCHbeFW0udsARMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622869; c=relaxed/simple;
	bh=23JJq+roFifUeF8C6bU5RojD6718sgxi/PjX0hdr5ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJi/Cws4gzKgpD3kSG1bbvnOJvDR7SlqEidHS9LJa0qrqxeE5PmdRHQZOp3lL7oYz6UZ+K9OEZECuCWx6BwpKxrjdLGp5qJ4t7rZQsuqh00NP1vateSez/tY0AenoSREZVuS/kcUZFCNEj+FcCg6oD0nn3JpqcbpeE/5c15f1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KU8izAxH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KU8izAxH"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7722bcb989aso851365b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757622867; x=1758227667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Pc/MNKgT1tpkpWwiHPHXGDjYhl41JOtHh7+jToyEzk=;
        b=KU8izAxHzcPkaZYujWS2E3mxi5NBZgZxNagCCQ/CjlMzanbo970ZOnfDHe6OMxgcIp
         4BPzPxdkByqJ7N+AXRUDj2omnu/kHLJ75iYeI3p+SCh/QpTfJiuwp04Uw1C+h/BPUb21
         Aj+zLJlYOFlNw5s1CnHgUwFlOfI9igbcsAW/U3L2g+f7eBYsrwuqUyUH7JjfG4byHtMu
         hk9q512pIEtch8fVsG5w6JHD4Iamwiyq7MinkP6ihhsnQkh+3ygeH3AA6SlEErzclDS1
         9oW5EMXlvBCMtiSnXrL4oEJt1LZhdZSSN1NPqZhvtTPtG/5fEVjngqzxsC3RdTFmGDtX
         HGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622867; x=1758227667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Pc/MNKgT1tpkpWwiHPHXGDjYhl41JOtHh7+jToyEzk=;
        b=DSQ4mQmU3nkRzuUaNbBTSLdH1F7qP/+nkPGuCtfw6nXo3oZS5/t1bwTh4U1Hw1xzo9
         q/vHMxy5+qdLth7T7E2XNk5iMsKDnLOtPccEWpNOVj1TgYT++L2S46ockwEV6E5Xz/e9
         OFEqXw21p2afcL9t0yqwb5/h4rj9UKntcDTrmYfcjbABiluWUtPu+FL1Fsnd133Sjml4
         cIA5ybudA+STMW9J04xrlWqafT+XhVFuWQYBEBX63UkpPh16wlMgnYOiQdIPxnbRBt5n
         oc1nwKcN7os9oCyv826tbteiYyjB6k9AJQ4NDnHPxEkg5N8veWZEZVxnnvD/dlHdQv3e
         pxNw==
X-Forwarded-Encrypted: i=1; AJvYcCWL3kYI3/twAQTS7XcVhLhDr4Y3KRmFzFoXjc3r7tRNz5X4EYu/HTM9F6VHl4JXgkp2s7Hpeqn72YqbpcCIJEGbNjJDCqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx683q0ku3NDd+YgPPJ9biqbJxwUibIZoH+uoSqOyjZQAU+Oml
	Vgutdpl2w2xTjMWuhZTYDgwQ5GCVAaf/3wB1wOY/ppGfP4/352wDZgWLiWWjwyYe6OUS2huKX8l
	jlHI997+EvZ+HrBO79Ta12pwzl7Lhelb+HYm15sIO
X-Gm-Gg: ASbGncu8pXyL0L9OkjTLCAz54AxiupxluLIswHvehFWOeBzVQvkLSC7L9kfZYb/aQYG
	psA/HJFH1UuTnTxGzpz+Dk78wl/jKccWxJOFgB8eTpXuSjGTw1G+TV44RVdpMW8q2RZgRNe73TS
	+VtGAFdD8wRC8YqHEkhNlMAgXZzb+5AdDmKz4hihlJV8cIeHir2zKvGCK2/lr1FvyE3mqrlQii1
	6tkQhQ=
X-Google-Smtp-Source: AGHT+IFYyJWjNuAI2LwN0HbeQn4fud3Pe3JigFs4PckWumJaQYpd+6Yx/XHQjaMSpQzmhS14qX49gT1B4tGgjj6Tpe8=
X-Received: by 2002:a05:6a20:a109:b0:24d:7926:bb22 with SMTP id
 adf61e73a8af0-2602a49b15cmr487751637.9.1757622867423; Thu, 11 Sep 2025
 13:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824222813.92300-1-rdunlap@infradead.org> <aKzot67f7F3wtHs7@kernel.org>
In-Reply-To: <aKzot67f7F3wtHs7@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 16:34:15 -0400
X-Gm-Features: Ac12FXw48kSzm76Yb9aQ6HZ2usu4bEgbnBioWlHWDs4daytc5ayhNulgG_v7YI8
Message-ID: <CAHC9VhQsVMKN6YyHFF81rPvxirtM7UwwAJSpOZdeybGCuO1c2g@mail.gmail.com>
Subject: Re: [PATCH] security: keys: use menuconfig for KEYS symbol
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 6:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Sun, Aug 24, 2025 at 03:28:13PM -0700, Randy Dunlap wrote:
> > Give the KEYS kconfig symbol and its associated symbols a separate
> > menu space under Security options by using "menuconfig" instead of
> > "config".
> >
> > This also makes it easier to find the security and LSM options.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >
> >  security/keys/Kconfig |   14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)

...

> I wote for this at least. Definitely an improvement:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'm guessing you're planning to take this patch Jarkko?

--=20
paul-moore.com
