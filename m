Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88673EE1EF
	for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761069; cv=pass; b=SSYm3x1r3FXaFt6xP3nlVI4IOwouznVEaLVuy7Wz6Bh3qZluK9g8ezosSB9kU42J1qAx4ZLtkTLuF/NxOfaY9nRbcw8HT5NoMDieS5y6YlFToXeObFqWNt1hP0otZFWi/liBJ+DjYNHr7HVRIagLb5M8anmK3rznf5/HM/3mFDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761069; c=relaxed/simple;
	bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAjqBncCKCul+1eB0YFNlsQJG5dA+5YkdRBLYJX+hozqo55PmPwhH37BNsIrkzsjtcIIpAqqMX62L1slAlBYHrwxYcEINlH5ICu7HWlfeI2SId1qysxF707AOyxkn2NeeVpjmgPQHueRr05gxxC7gqy9814iL1RhEGQjdw7Z8QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4QhHqXc; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4QhHqXc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso125375ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Aug 2026 09:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787761067; cv=none;
        d=google.com; s=arc-20260327;
        b=CuJYu55o3bpQDu1Bt1yHstWIDgC/lCOT25x6dPdf9WnyoijAeUL3/MauXoPIyG6CIE
         iTlG/EhlZ+cWzHB6Ip5dwlTeeksm1SUxXUNrOJPWWpyfgUsOWhiFjSs5ozyvNxCOz+/6
         5BQYGcPdCWT9xLsD+7xzc0VZR1mn1ASgA2rojt9QQxJHm5WcmuAGcW9YGoBBJlLPN1Ai
         Z4m2F96jBdps/lyOdcl0KVQX0p2ZWfA43tWh99OMdxqEMPMybfDoENWcG4ry4JrpXZZv
         E099DPNOu0tuRb6r3jGzVr2mXvrvUbjvsqQsXwxeYoFUUzNf/Stom2DcYxB99ShNva31
         6zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        fh=Q9fGOIbFXYVwm2hMV/fJO0469289ON02uExsmv3euV0=;
        b=YbzhNn6MqtIooEXYAW9u5D+PZJGg73Cp6rB434YyWSOwxRFQ0ep1kDTmzHRk3MiPNe
         rwrJXf9vDifn4CCHRewnh2Pv/0XtHGHDqHolJUv16OXKGTG0eD91E6YnoiXJJ2ZtxgPp
         2at2KNGtVzZSlBH+McDywmPQMzVTX4YFCVKs9+O7YZoZC0TEEh8bN7k7n+8ToB6y5FtV
         8y2ROifNOlpY/wNa3EcjnNPPUl+A90sguuGSytr4IYgH6V1Ye6SpkfD5Y/2yTniLAeAi
         tVQRCSCd48oQ7zYkUakxqWw1aIDC/+ZKXRR5sVWN+lwGaMCdpYYVP366/Ljri7fsmxVe
         zEyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787761067; x=1788365867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=a4QhHqXct0MduGzVvbw1MsWUUPpJFSF/I8Ms5YisVYGeSN9NfyA8AtB89KL4nhOoZj
         x/Uo8PTJ1pwKE5XHih44zVuP9NPAbjo6iQjan9/tq7zLQSUjSaQKBfzyerxUdFyFbVCv
         furBmExqjQkZNJYqx18G2+HvJixKoRKLG/ttfW+T+WyJ7gGoc7yR8EhfhMHKmc1K1GV0
         QWaEyY2m+ie898e/TtQ6mDD8E4I9CLXdFiLEYVHuJ/2ECB/xAKM0Kesw1FQmKnQUJBBR
         RtuLM2mxblQGWognI6/k8wF3kCdlvn2LDCo6pFLLq1/0wobE2KjgUhJnC5GvaOw37NAa
         2tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761067; x=1788365867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=k91kzuMA9/gaupJAe7LqCdOMMEztB6TsRSLzOoNIGHCKJuaCX5dK7MoHkXzCION0Mn
         cJc6v5rNJ0MHLFz2/eLYMx/TpHJb+QotA/57vB4hIzbSdp/12ItbqTrcDcWxexZClJsE
         ZIioOdiTg3IqMksIswaxN5kNoAqZ/v2UjLtef8v0/9L6LigOat5NW6kaYFXQOuCnAOGx
         tlhEKVMloHL+bJ8OUdP4m+vn7QXwOo0bFFOX1g/WRHztuB5yiILwcwOATj028/PPoWjV
         5VtB9eJC2t0dOSk8XF7/X94+TeU9RUTj/XzYPv/u5ORGo+YofJZGfPM2oV5XHzo+GFpm
         DwiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTEM8jecmQxXhRu/jVMekQYe69vh1VvnXo8nUZMZrzUISoPsw5fxB0hFZ2uJEISJ58AblISZgj7zXKFs5rmzQAUt4bqdo=@vger.kernel.org
X-Gm-Message-State: AFuF++kENj1Yvn17Flpvg6TU9bQMs2aewk7pA1QpNCimD+METD6CZZ0i
	giEExj/bx6E0BPmoaOF92qUUghdRKEO0ew9pTOfohl3ER2zafx0qfjYOj6yRW3G9SYihzWwIl0V
	q3G/q5QWlsQBZ5/1TuOGQoKcoU+R1vZHdsYbSnYsT
X-Gm-Gg: AR+sD13AjIc7noG0qrrcnkeOyzjGZG55UmDlJA7MOH1wRueMzpOwjHxUU8AH1OWG9cu
	B5dr3juXmic51iJbAZNBnlsLz/LNM4IMbvWOOkJZho7nGXvqnbQLVprMn5MNCRTYv9jw6eoPo1A
	/6Ej0TfmWLWFry/weuQQc73jxNa1ir1yPeRMGc/ElB2BRgGU4ipTMgCWQc3Zt07/oecPOc35M0B
	vx5LQMQ6CGXrCvXDC6S/T1u7HGWVmqYCfRFEqxj3VuEhmVbGm76vyPrekRjUOfsAwUeWx82Dxt9
	X9kgS31eo9kGnAFsuL4/udeRv6iSWIwMZ+4DppY0Q4mu137+eWRXKdoU25BvG92nLivpcJuybR2
	osgtdcZruiHOHYykR21GmDQwbBX6XMg==
X-Received: by 2002:a17:903:1a2f:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d7105043bfmr5843385ad.9.1787761066499; Wed, 26 Aug 2026
 09:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
 <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
 <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner> <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
In-Reply-To: <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Aug 2026 18:17:06 +0200
X-Gm-Features: AcwNN1XyOejgP8xhG53At4w9H1ZIts9vwM506J2nZcs81pxFYrfApeUAbMczaOg
Message-ID: <CAG48ez1s-=GB62T6k5NFjkgsLYJN_eYhDwT2U9UXeTTCZBV_UQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Aug 26, 2026 at 12:29:14PM +0200, Christian Brauner wrote:
> > It seems odd to just call a hook when it's introspection denied.
> > And if that's the case why not also have a general hook in
> > ptrace_may_access() itself in the introspection branch?
> >
> > I would actually have use-cases for this btw.
>
> To be clear: I have no quarrels with this going in as is. I'm just
> interested in how policy decision such as this can be made more
> meaningful in general. If you have thoughts around this you want to
> share, please do.

A distinction that might be useful in my opinion would be to
distinguish between read access to memory/registers (like for
collecting information after a crash) and write access to process
state like memory/registers (which would only be needed for actual
debugging or fault injection). However, ptrace() makes it hard to draw
such a clean distinction because resuming a stopped task can inject
signals with arbitrary signal numbers...
