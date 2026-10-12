Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316935F60E
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812000; cv=pass; b=umxYF3Ubew92tQ+y1Wl/xVKIbL58lrWgzSBvyhbZiKvGZb5eWF6Pz3D5roXwfLGmbldlvO/oYHrAHtirL/Hrncmps/DpE+nrrosjmTFmktxrVmB8wIL/FTjaYvVnW4ghQYYIO7cdHhjoIsHv/uu3wQ1E5XGlQftPKOMq1NszhIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812000; c=relaxed/simple;
	bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oToLPtSVnvfXAh7EqDgZRnMkQ+AeowGsZF4hEm3K+Ka0WCFcIe0j+1jS7l7oQq2qq3Jic31vMcIScZdb/4R1Z6GkXpXScVtJu8yUMtT1KpWgX1zVeLoq7mrpOrdQlmau9IbVEP56vCL5vUqth4I9btIeuocvH6SEbGt/trrnnXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSzwUVwG; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSzwUVwG"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67699afea08so1109864d50.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 06:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811998; cv=none;
        d=google.com; s=arc-20260327;
        b=fHs0sZwx+XP6r5JfRVmPLN6LuJ4EI2emq1Nn7VXpRvaPRHuyR9OupGeSEIz4hlQGlf
         scWPcPtxKENJhvf7xWu/msnF+AVOGi5JHOnsbqWuB56zLi8HoV4UjKHXAWiDFaqzipnD
         2qJDiIaEMjEI1qKlOqplHmKckL15uBO951GZAoTWzja/BSnHFdl7S/lVLnjhwNLMt2R7
         QqmLGw3UZxYvuWF8M1n41ted5YdzX34HZTBcZKrymO7Kos7VnembdYtDmYbOiRbNnyrz
         4OA6R05ugZWlZyMqfLPKeGQ7+6oT0ryQOogxRZLXFoBzmknRME6+jG6uqmp+O82atnuC
         C0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        fh=S1oh+RGf4iMpbDlN40zCavk/R38tBs5qiiJ5wu29NXM=;
        b=YEcdYYmiGSBxEjR5WIjVtt5tmO/UpIVN2KlwPHGv6muA1hrptO5RJSBki0KZjD0oFK
         T2Fx3EQWhggZ+Qzpa9gbSNXrV+qj5DrCC2O7gjZvxLOXsBeDnEGhli8G4+RiLuq3X+aC
         XOex2cHjhjYIg8aPknHaIrUoOYdpfTU4HfzaL3d+uKxZqZB4U6pXQFmf2xbvTCSVNxij
         N935p8VkhUD9e8lFbT26KsZ25z9mZdRmdXn+mgcC9F0ilBQ330H9poYykt2pivB/yE4e
         swx8eKHwWP3iyM2b8UCO+Jvwt+ZSBPQvziUSWUaGlPMB3zqr7Gtn3caJhGT6WUM+/weF
         +T9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811998; x=1792416798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        b=FSzwUVwG6G1mDAVrABaSLpBK7Bojaj/Xk3xCR8fmpDJEBquYYdhmlStPb3W6XEf9vs
         AXyTRDOpU4zWm3geVCbPxF+dj12uuIwg+WX5qtUN9SyObD/8m92TNsx8DtUJLZG35fJM
         s1rQBXHRvjZk9DrfcVyJPvvJg8VSKrjch/nczCFZoytXGbBBMM8ohIWTTBm/IUyRU+JS
         UyvnHqe7WmTjZjRAEQ84z32O02JjZ70Ln/mnUE+6w4YDaiZ8TEbsJYbVww1H5Tn3CicH
         H/33qGybbu70JhgQaXCAEsrp0Kao2a3g9qENJ3JeQXssX1JF528u2Py6rIkNiL48O6wd
         KATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811998; x=1792416798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        b=g/yQQzRZM4+0QXs4Yo7onD0S8kGcUhHC44prmrTsAbSSrM94hS/OxRhW7t+yMmdZhi
         nyJv3ScfxqjfPbxlIdJ/NF3+90tCohE4lWw/Yz/munIqy5pfPGjsjx7hWvRaV5dxlTvb
         HSxbQ30dzn847S+CxJrJDj6PwzH7JRdPpoYRovV0D+0j3qr6U+H8TM+qZ1k8iY8VjpOA
         3XMrCpTEjZw2d4t2LA4dE1Xl7IZKW3dH8CCZa/lAJjWr3VuR8lz6sjX85+rcXM1ZIdhq
         rSEcN5nlTYPCduXhKFqkkzvD+nhHTzWxYlEZpKvaWGcaMrIDxkGa5v3OVUDDBUCnafKY
         2qLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdZDhBDZOcslyyRduLEdGe6Sc2ff83Dso6Ri3ofdR+ZqWgLtwTV909H/8hoFQZPFmO3lO2yEEsnyzTiyJFewoLyJV+fIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNqk2eVlvoM/3X3vA7ZOcpLgZ5MJKgneDgyyosCZPzsDoDDd/f
	crAnnEXqySPiTm2Y9S95olx0kMQkd5xtale85HLwHHci1c7NNZf3snNwwq/sCbsuiy1VFChrPVZ
	jzviETxP9HI/eF7T0//9sSrhe/ESISE8=
X-Gm-Gg: AYBFou0Lxktk2dr9Y6LHnGQpwVT5vsdWsRqAJv5hZUQDYyY8phsdqTL0Xa3QeDx2u8T
	h43LSU1nYi390p3/19VxoVLrkikn5wnHrp0r0IwfxH+gpeM/hky2p+U4LGC1GMQS+Zs0XT+FUy8
	teT2LV1cLd6I9ma6XuF7GpB1WLMxEeDDzZR0qB1v8uY6X8DtwqhiEyjfK88sKaCN/32YSSuESJu
	oLJlOcr30lVt81T2pc+KNR4D+cO4YSqJAXOcHn8fQcyiv9Pv9NhiOEc4Q/g3tZtiPt6mgYb8oh+
	1fQWWY+pbsMcCPPNyCr01p3F72r81nYY3gIc5UtdCNCy6j0Fk9iM0hcoGiql+edb8I/3
X-Received: by 2002:a53:ea42:0:b0:676:8b69:97eb with SMTP id
 956f58d0204a3-6793634a484mr2435865d50.160.1791811997636; Mon, 12 Oct 2026
 06:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org> <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
In-Reply-To: <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:33:06 +0800
X-Gm-Features: AclHuK8khvWi4McmLLK-ANublHQc9k3MPlNZnAtRVi0Ml1u14dD-i-9XyWHto-8
Message-ID: <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Sorry for the previous email =E2=80=94 the line wrapping got a bit messy on=
 my
side. Hope it was still readable :).

Best regards,
Cen

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=80 21:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jarkko,
>
> Thanks very much for the detailed feedback and for your patience with thi=
s :).
>
> Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 21:03=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > I appreciate the fix but if I'm completely hones the commit message
> > looks like direct LLM output, which is not acceptable.
> >
> > It needs to be proof-readed and edited. For this reason, I want a bette=
r
> > iteration before I apply this.
> >
> > Br, Jarkko
>
> Thanks very much for the detailed feedback and for your patience with thi=
s.
>
> Several people have mentioned that my commit messages look like they were
> generated by an LLM =E2=80=94 and to be honest, I did write them with LLM=
 assistance.
> However, they often gave me the feeling of being questioned rather
> than explained.
> I spend most of my time looking for bugs, following my interest, so
> I=E2=80=99m more familiar
> with bug patterns than with the deeper details of the subsystem. That
> means I can
> make mistakes. I=E2=80=99m willing to listen to feedback and keep revisin=
g the
> patch until it=E2=80=99s in
> good shape, but the pressure sometimes makes me afraid to continue the
> conversation,
> worried about making more mistakes. Your patient explanation this time
> really means a
> lot to me.
>
> Of course, I also fully understand that busy developers feel
> uncomfortable when seeing
> unclear or poorly written messages. I just wanted to express my thanks
> for taking the time
> to gently and patiently explain things clearly.
>
> I=E2=80=99ll carefully rework the commit message following your suggestio=
ns to
> make the concurrency
> scenario and the reasoning clearer, and send a new patch once it=E2=80=99=
s
> ready. I=E2=80=99d appreciate it if
> you could take another look then.
>
> Best regards,
> Cen Zhang
