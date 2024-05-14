Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B318131E
	for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716223; cv=none; b=U/wlW5vtQQQnPPru5q6pQ51mBQi/u6fT+Wu9LpsZbhDQYf7eHPcsdC4WYhe4EHEt8Yml/BwVUWmhxXb0gaZNtpfdRF+zVHYGpFV7ol7cZLw40tdJQOpVIt0WGvuBBsIzWxXh+4PmV+aU+NjKe1dEWvPTpX1sQs1dEw5UVr4X6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716223; c=relaxed/simple;
	bh=xCGobSiEZZKVIGvtlb17VkXzrJav2cpynpYO5pxHsTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY7+YcrEigRexTOkQbNiWzM35hjTSsEUL5LpaO5BrjqKcu/xkYWGMk7z8+i58nykC8Tml0vUbfLYb+wpeK9RcKCpckpMkSgczrJZjk8tZkVwaOfG3sdRxwdl9P+6OHRxXXLP8pc6n2MF3h2OhNS+WYVPf88/jJdhkdEBYKHcx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JF+Zbwi4; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JF+Zbwi4"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de4665b4969so6196339276.2
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716220; x=1716321020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=JF+Zbwi4A37UVjOELqyuSxI5XF16PnHoy/clBUi83jiG+YRodmecFW52qZKz4Kq726
         4PTOrHIBMXKsd7NPB6GCHO6oGJCvxjHHJaMw38WnlU+B/cm4WbJETzVMZ2TafdoTfo4X
         rBPSV09s7/igRv/0AE1D7RnilAUdFI2LXQQWFeHNyDVUgFRiRFPHAJLU+iEB4N2/widJ
         cASIqHwqPxifXEwwXws+q0QEDlDblFWXqGYAXJmXfXw3VXV1KCegxMxVhRx0XCksA/sB
         1VxkK02/WpwjROj2m5sVqBTGjVDYmmzXsDovMQ2t1pd4IrqPTv+jT8xruRy07h+w1pWB
         IsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716220; x=1716321020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=mDsc4NFrAEFTYvRttWzJPTZZdvpon/IzZUgB9qe0XO/vL6A+7UkvHyH25YEpg8BpyY
         Vsp9tVrSy74yhwo8cR9pNIw4F3aZbyi9djnA/Qa3niS3+zCsLD9STcJMcvqmjVKDTNEX
         JQrdpcB+/sJLg3wp2mcjUFXLkhYU+3mn0j5OLIOvpVxACAihUbjPyKlu9KedlDQ3vaHJ
         Gv4W0ZL6BOzw4JCyeBx/CWp7qk+6zvlFgdACNkvifpIGieUSlrAg5RpCaq6R2W0O2LBk
         EZKH5JSGCfK0+97gkBgnLlbZf+S4s2oNyms/g1wbWRD7PY1ER81/M7GMEAiegdZIt5o5
         uhrA==
X-Forwarded-Encrypted: i=1; AJvYcCVwm3wQ/o5YDQTkX7vVRCd4PzjLTuq2ogZb8pvOvBavJZud2Exp9jhNKXongDWKw/d7mQbjJU6zdlbSLJmwfn+9aBfDQrZytDHvFzMrDJufxFUcZA82
X-Gm-Message-State: AOJu0Yx76DOOBi2KWnbVeUEZ6mKvTiyJI8kxk9/AjVhTsrAHRdi2qKbS
	LvGimHg5QXNlsyqvjRVfyqL3yRioYLZlKs5/gQd65D3yKpNYhaNMx6NeUcjDvx85OuDvlGb8Y1a
	utiPnreEwkxoxu92/y1PvDIUjw3J/PwcSDDa8
X-Google-Smtp-Source: AGHT+IFWIy5UA2F/+z955H9aT1kkILcAstR0rQ1Z6k7ELYYSk3poMncJ+M812qPYw6M0u0TMB7AFkJo/BviRvM2KHkE=
X-Received: by 2002:a05:6902:218f:b0:dee:8da8:aeb7 with SMTP id
 3f1490d57ef6-dee8da8b092mr8719461276.25.1715716220678; Tue, 14 May 2024
 12:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-21-git-send-email-wufan@linux.microsoft.com>
 <ZjXsBjAFs-qp9xY4@archie.me> <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
In-Reply-To: <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:50:09 -0400
Message-ID: <CAHC9VhQewDL4cWXSiAgzvrHa8N5rd6TbhSCM3jRp29=Kmr3m-Q@mail.gmail.com>
Subject: Re: [PATCH v18 20/21] Documentation: add ipe documentation
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 4:13=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 5/4/2024 1:04 AM, Bagas Sanjaya wrote:
> > On Fri, May 03, 2024 at 03:32:30PM -0700, Fan Wu wrote:
> >> +IPE does not mitigate threats arising from malicious but authorized
> >> +developers (with access to a signing certificate), or compromised
> >> +developer tools used by them (i.e. return-oriented programming attack=
s).
> >> +Additionally, IPE draws hard security boundary between userspace and
> >> +kernelspace. As a result, IPE does not provide any protections agains=
t a
> >> +kernel level exploit, and a kernel-level exploit can disable or tampe=
r
> >> +with IPE's protections.
> >
> > So how to mitigate kernel-level exploits then?
>
> One possible way is to use hypervisor to protect the kernel integrity.
> https://github.com/heki-linux is one project on this direction. Perhaps
> I should also add this link to the doc.

I wouldn't spend a lot of time on kernel exploits in the IPE
documentation as it is out of scope for IPE.  In face, I would say
just that in the last sentence in the paragraph above:

"As a result, kernel-level exploits are considered outside the scope
of IPE and mitigation is left to other mechanisms."

(or something similar)

--=20
paul-moore.com
