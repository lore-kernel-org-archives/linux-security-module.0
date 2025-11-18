Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF7368285
	for <linux-security-module@vger.kernel.org>; Tue, 18 Nov 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480842; cv=none; b=i9gZEe9lGzznXw2pKwQYYWjJaJ7E7oFMExeGkfrys0l9c/bNFaZt5OtGYHfEuVeMz+kZhQ9zga876+bVQtjzdAAjKYJUNrDEYEWfMcQBquCf6KqCNiuOPr6BZujN+CwXAKsh4BJTMbeTPUretbM84JTYxr+9sHBJ9PqmLnS05pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480842; c=relaxed/simple;
	bh=8CQCmidGdPkc2b/tZmkROHBO9f7ZOzfmG4di24uwWVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHvHxrYpibB/HdKMyzBjpj2HLb/dkzOI1RONo5kqlKACP1eVklLgZKm7PIklYLGkCTzgfUNRh1EF0AhFCewl0hPUs7BHdXkfqVMfGsjOlAIJQgJYdtakDtSjuxQ1rycoh0GYYNn5INvrxqLREtdMGiyUg+OYzfddw7lM92pb+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f+V8oOoi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f+V8oOoi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-299d40b0845so44683735ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Nov 2025 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763480839; x=1764085639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I04v2N1nzI9o6E2ZzcTjSlfjZjbOjQHTpl7HKOLq/9o=;
        b=f+V8oOoijvub9kXVkLhPrcl1KBHf3evs1LhlfKhYLYTmmmTkRlv5zxbDL+TzHVqdrG
         Pq5qrxWBK9RPIqDTz099DiQXjRETaWW/EFegWQ/YGEfYKwuHXA8TFmIzhVrYRihGzGtD
         NgovPhpz9eOjpSVle8F+InS34RLtAayAtaHXxlt/3sRhSOto1WkcAGoW6uelT1ajJZgO
         mUTUwQ3ekflaUzAftJHcEHn8LQvaFaAePvT8EETAfUmZroH4AfOFVZRM/LN2c2MKk3IO
         bO1NotiiifqdNemacQNZsGb+igu1Yo9yHyOZJruqU5USU+HwttvYjK5Z0dj8R045gEUI
         PGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480839; x=1764085639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I04v2N1nzI9o6E2ZzcTjSlfjZjbOjQHTpl7HKOLq/9o=;
        b=Us6sixug0UYKZWfp5u2t2nMjqYa/sUlve2LYSMGUISdMvrdgyKUezrbGtD9HqnSitM
         YecW3NPo4h7Or633ooKg7hq6b5ZQpuJci5amPw4pCSEFZ1eem/zxqYzg3oGtSLr+6Dz8
         BCfSdLanJdNZl9vJPuojhSz781+TtNKJ+OCKT/tWa2aHgy13SyMXwyPIDS16MHcy32JF
         8NHyfxeq1Fy36fJXZFQfXcIViSwemiDzV4XmX7yRYkftdEron3VzEFWhiK2v45myToMV
         SgyOKju0fDMDf2mFBttTAvZF8Bn7Gn3x0SC+K3fhJ8a8HhhULT/pVdeSZMIRTzjM3inI
         96pw==
X-Forwarded-Encrypted: i=1; AJvYcCXNs1329C9fA2wwWI3zRU8j4xfkmuen5aH06vzxkphJS6o0mQFrQdawdX9AULbuulRiepWqeeDQeUvpgrPCBE+rNg0FKkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwJJ7Y+pbg74WJ3/ykszmRnVVAE/ZrADxo/72+valsmVyAlLZ
	x9wJw4e4SwAcI5aKyYR2/KuAoR8xpFbWCONiXbMyldydOqBZXJ0lO3J6qp9J4vysk1759n6kZdR
	zJ35KR51h8JSuMoyCcd7zk6rbrBp2TSu3ByP1G8lC
X-Gm-Gg: ASbGnct9LEYHFsm8ENdO5/nFH8GLfXp65lqkDgPeXydXq7bZynDa/UWdq4Ptp+JnVEG
	IGx2NopfeTf74iXMbCWLNddT/HEFPUxvneBR951BFLCzOTRTB+PQsbNS/8gxSR38ku9F6WEeQ/P
	grOgXWA+h/nOXdjp/30VARQGxS144aMwQWp41D+1kiFCaFfUfM0+wv6BP6BMow/h6IRwiHFkiwY
	Hnat3UuErs6eazoz4lKfjZHcM8RkCA4hsN9mGla1LesfLpOjGjlBUo1YwcoSrFFPqRm+h6hfJeB
	3eLQrg==
X-Google-Smtp-Source: AGHT+IEvgFXlL2DsS+aYCNAbX23FZ2Eku3IbWa1uZyiKXdLu+8y0gB8DpM0LkB8g4IdougIX4ixY5jGOUHP/wszkXH8=
X-Received: by 2002:a17:902:d607:b0:295:34ba:7afa with SMTP id
 d9443c01a7336-2986a7524d7mr200384905ad.43.1763480839493; Tue, 18 Nov 2025
 07:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRegH8P4cPlzzlX9@mail.hallyn.com> <aRx/1MvvBqu5MhKv@mail.hallyn.com>
In-Reply-To: <aRx/1MvvBqu5MhKv@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Nov 2025 10:47:06 -0500
X-Gm-Features: AWmQ_bl-rI09S5jbfOXl0N9IHhgOj5J7kiACv5E0eqfRv6DzNnvZ4n1T26vt5m8
Message-ID: <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com>
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, 
	Ryan Foster <foster.ryan.r@gmail.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:16=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Fri, Nov 14, 2025 at 03:33:19PM -0600, Serge E. Hallyn wrote:
> > Split most of the rootid_owns_currentns() functionality
> > into a more generic rootid_owns_ns() function which
> > will be easier to write tests for.
> >
> > Rename the functions and variables to make clear that
> > the ids being tested could be any uid.
> >
> > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > CC: Ryan Foster <foster.ryan.r@gmail.com>
> > CC: Christian Brauner <brauner@kernel.org>
>
> Paul, Christian, let me know if you have any objections, else I will
> queue this up in caps-next.

Seems reasonable to me, but it would be good to fix the parameter doc
bug that the kernel test robot identified.  I suspect it is just the
extra vertical comment space between the top one line summary and the
parameter list.

--=20
paul-moore.com
