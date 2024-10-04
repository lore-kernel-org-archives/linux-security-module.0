Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934B1DD9D1
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068351; cv=none; b=iv+8zmKmBudsa4WNA10ryc7ZmDSEplRgHDxBpbxXWiv7ZEEQyToCkqRWq7yS1EhkZ8bYogcPvxGoDI5TejFEsrkocP0kVGdceXXHwRtgo+Ep5Ru2N85hy6VLhNq9Y1y9DKNh+T28lzsZ+XsAy0TvRDfpUTmO3qog9pXia+ctyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068351; c=relaxed/simple;
	bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ6f6zMlYYH0LwoP1nQwMNhrVNvq2G3lTtX74D8BTU27Aq1GymrDI6oIrrhKQ7KzBd4wHnApjHC0orc9NeXqlTorm2D8ShYgqDCT9WW+VKp0xNO4tXhkN9XNaDQ4+fkByCMmXB7T7gEiWYoAS6JaRCqkAjazCNQ9/eWB6DT0r0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZExCjbWp; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZExCjbWp"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e262e36df27so2893125276.0
        for <linux-security-module@vger.kernel.org>; Fri, 04 Oct 2024 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728068348; x=1728673148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
        b=ZExCjbWpU/NmNl3celrmgJSfhTD5VkDxbrXlyIYqmOAwQ/fqji4qUMD3bmG2GUTBSj
         fgWI5F0ehDiD4QcWE5K5v+FkZ0SKjZDWeizuzrm2xyzdVI5Ih/dWp9V/hpRy/BExZnZk
         j1UVVgSMcADejUhieI2/qJTJfUNQK5jZsF35gvuO+2w2pDwkK9+qZWH1JFqym8qU++sT
         V5rRFl5JMaoCh6ciVfm5YjVYvtkB0OY38HTBk9NnBGJyeXVGdf3zBCK5IA1HYy8nuhwI
         Qmct3WTrcP+V0i8a+sGgKJVlzVtswLi9Lup3QuzVdT1BU4Lw9DrcXlPGt+proDuiDZOy
         a1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068348; x=1728673148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
        b=LBeL53etrZvMAC4ErCIhF+Xwd6xwlVy46HguNvUy3IZaRtCHSPPCMwc6ykGTrntbcG
         jwHMjCaEqa5cuMTvJny4N10TxAtL55ZUC8usv0TiofsfPpHGWZIUjSRijhxcF/8CfEYz
         ZM01fYd22iuZ66HFdDHzKUXfqHZHvo7+oVJciFsMpMAmfAj0Niv/URySG5UADj0b+yK6
         +ZJ2ic2YYPFccOJYFZIXM5vgg9CrQ3iKZSBvpCu7fbF4nC13GFw+qlMobHYtOLZk/TfB
         OKEI145Wh9LZ2SlmKVENODQAg6Hlll2spX2jsEaTn8+15ACWmYgk/3Xy8g0x0vs3btG7
         XJHA==
X-Forwarded-Encrypted: i=1; AJvYcCX9aXx/vj9LGj6x4i6t6Vqq0x6otgGBWDlaurJbasK/pHbrXsF5e9YnpET57XJTiqWN+3IOXiC12ap56JBhHW1+xFhyIR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mIsPtIqJcuT7IRnO99tkClHRuF8OYjFx7T2bmDnNtXJEMGJu
	g8D2qYv+RE8u0IErPeLNyMHsfFeLz2165F3lP9J6jzCjmXqb7tG+Y0tz0fNZqYK+MZosu/fegYT
	V7AY6e4PA8kgzEQS3e/Q4gAlWE7OfD7iXtL4e
X-Google-Smtp-Source: AGHT+IG0iCzD9AFrN7PsxPgtv+RjvyOcT6RejRFpSNsBCVIrW9RtC6f8zoVh6IJM8DdDUtvP4V6iHTCxKwNS0beEFq8=
X-Received: by 2002:a5b:891:0:b0:e24:9e26:133 with SMTP id 3f1490d57ef6-e286f81947emr6696376276.14.1728068348374;
 Fri, 04 Oct 2024 11:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
 <20241004184019.GA16388@wind.enjellic.com>
In-Reply-To: <20241004184019.GA16388@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 14:58:57 -0400
Message-ID: <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:40=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > On 10/2/24 03:38, Dr. Greg wrote:
> > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:

...

> The third problem to be addressed, and you acknowledge it above, is
> that there needs to be a flexible pathway for security innovation on
> Linux that doesn't require broad based consensus and yet doesn't
> imperil the kernel.

The new LSM guidelines are documented at the URL below (and available
in the README.md file of any cloned LSM tree), the document is also
linked from the MAINTAINERS file:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-g=
uidelines

The guidelines were developed last summer on the LSM mailing list with
input and edits from a number of LSM developers.

https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX8LWb=
KQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com

--=20
paul-moore.com
