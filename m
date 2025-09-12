Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5D27B4F5
	for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679812; cv=none; b=VBzMOLG3CoJI7w4jqPaW05R7Nsh2QHEfm/uZt/JBbPT3DfmHULSWzMc9OL7Kmfh5OHO3Q10xHzPGeeGo1ZBW4Bmk2KKsr1+Ae9wrx5VXEtZpQk8mJVVmLOS5lqM+rkTFlyEM6CqUrRVdWt/awvgFj1GIdNZiAPzsMu1djcCSuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679812; c=relaxed/simple;
	bh=S1oPc2GKq8KfIf1Mc67HyoTZ7bK74Zl1+obV4SQ+uug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJ7Hwdh9/dBiAvdsyIxSE57bTgVTrpOi6swEJFU+WFliXugq6lwMT8zt0uAg/UaxUCjTypkjTvAGU6WBEBzxPbAPPNbU8xbFEB9PvY/Yvw1IQJf61nqo3KyCRzWcryzV+RQdV65/FrZRhOcJGqac/c4zjWv502soHydPIMJ8EKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR6UERgm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR6UERgm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so2180686a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757679810; x=1758284610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk5aXXiLpcn48WsQx1TlS1mVz9lzg5cXcpwbqc7D6pY=;
        b=bR6UERgmjAMexNiImuZhyEwUw3WBqda9OiKsKIEVWvuAAdBkGsQOGoPzEE07UD5RpD
         XKmNq4+UHrVJvd+41k9KEBXhriwoGGkKJMnAIgTnm6I7mX/dETK1NI7s/Yv7JlGMT/d/
         BG4UmiMqKfOkWuVBXgUtZNM/phJZJV3mWhf3aEXJ+nislxIOCvaNBts0lL+1xiJ5KWGK
         1um7GAnb2YzziGHtK5YloVpZj5NczxsktMkObjz0piFBwTmK1CyLpEayUZwleGdTAclx
         YYdBEoaFpFM6YUeMV3ABMCfAgOrSaBK9Ym96XqJ6ZOII2BbtGhQzhdzAmDMwXvBz9dnn
         Cb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679810; x=1758284610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk5aXXiLpcn48WsQx1TlS1mVz9lzg5cXcpwbqc7D6pY=;
        b=fci7UZ+63zfbkFYa0D7tMwr0WUnQ+1Lfu7t+bXPoVj1qbC6kQ2KX1APa4/N8QedrgP
         xbk5KqJa6qSKFpyr/+l15gZHkqUq4XNQJbkJnD4ns4MFpymZZzzRS1C5iRmo6RXheXKR
         Afj95bUCKKcO061euDR4aUUVbMDxYL/dj61TjTB5qLheL77B0MvpBOrjr1+5RX5+Nzd7
         2VTbQikaBfmIld3k8tiNIuAClH/AAMgUeTiL7bEa0erQhLoG8qkkfFNgBH6EY8npis4f
         6Q8492lL1BMOoxtYgAzhxDYJUG9k3yGEtfwT8Bdi2H9M2N6sIZbd00vqqP1Qka9JSyVX
         09wg==
X-Forwarded-Encrypted: i=1; AJvYcCUTBJom8EJVNGhEu54ezAeoS6uZNBsupFhoIyYf05yhrHhVQRCr39Ll2U7+dBnxpDCUPbjBDl9RdB5XqJQzGXXmHGQojA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIilQ2JWuIQEFslVvMUCYPaLhvFPB7jzWtyd/cnGJOtU1Dm3gE
	GPyVaWyR2pc8Tk1D2wXFlgcYuTPheVrdW98i9rESxgvxboeVDpZz3M8Lhw1SWjKfurSDb9429rg
	2cVdc+vtrVTgt/7e+SgaTxg4tL15R45g=
X-Gm-Gg: ASbGnctu+ffbsFyVMA43ICnPNfoHIydQdeWZjTPaQhFjbep0x9Jonrfqa7LkHckdvt7
	a+sMJr8VG6Wd1OjCIugxlF3eMAi5w5BSa108uNcO/fYseoUz6KHYkkhTqDCCQCN/abj7c3aTWZZ
	iNo1IVzbHHTJe02ewSmGjgNfvwqiiMcbgAu4EHSiyUwPg9YyYw23T/UsE+tudlcUu/r6pXJVwB4
	qG1adGAvDxKasYyKg==
X-Google-Smtp-Source: AGHT+IFBVy+u+bLkmXvhEFMxbFJNA24xfTduD/XNxZHgH/x+lwo5j6oeXfmMzKMjq/3IeluMaxK7RTnFHu6Ollx7nHs=
X-Received: by 2002:a17:90b:4c11:b0:32b:a6f6:9b7d with SMTP id
 98e67ed59e1d1-32de4f8c83cmr3074071a91.26.1757679809658; Fri, 12 Sep 2025
 05:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
 <aMNVDOCjCBZZE8Kb@mail.hallyn.com> <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Sep 2025 08:23:18 -0400
X-Gm-Features: Ac12FXz-6en58JzIGhC-vVkEnTHC8_1RjiAqK1v46Cg3xAoUI9a_K7ffirB-Ed4
Message-ID: <CAEjxPJ5K5Ki7uRa_aF=ULzHUChtbsBJX3nL3TZnL-Ak+G6kkaw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, omosnace@redhat.com, 
	john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 11, 2025 at 7:02=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com=
> wrote:
> > On Wed, Sep 03, 2025 at 03:24:26PM -0400, Stephen Smalley wrote:
> > > In the hopes of nudging the conversation in [1] in a more focused
> >
> > Hi Stephen,
> >
> > what was [1] supposed to be here?  I can think of two possibilities,
> > but I'm not seeing it inline...
>
> I'm guessing Stephen was talking about the "LSM namespacing API" thread:
>
> https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF=
1uN=3DUEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Yes, that was the link I intended to include in my message.
Most of that thread isn't necessary though to reviewing this RFC.
