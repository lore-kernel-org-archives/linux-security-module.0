Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC649190072
	for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406060; cv=none; b=ivqPAGz+LnKtqdnGUE+ECw3Wwz6zILXdlTM+dcYGAIOfjZWcl77b/v2hjIwi2GaK5fzj8F1XsLVer7pXpgYcamlYcdndPFe2crWmc3kn8b3wIYYTziO8gOKuBp9urCobLiPpY0i7T3E+2P4IASnWM/JLS/JZENfIaCV7G/idm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406060; c=relaxed/simple;
	bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIryG5D4nPQrw8VYF5ynZB2otnwHATh0vtF/v7NKe1RwhKXuAKvjg3VW7px3ooUaV2YtLmXJzv5TngwZUdOB1GO8WZyOzJbMSPoTRqMwDq5FkuhjaS6sXuI+fFj2q5jZ5iApWUpefChyXjTVkxFNSXdBYJlS1/TTsxzNZVhgEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGuVxTQI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGuVxTQI"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so9816a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406057; x=1748010857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=vGuVxTQIYGn+f+GPputS3WJ9uQtgpFnyZMc9zU0hVE3w1I4meBQumbC+zkmaj5pMWe
         /dZ/2GJ0+PzCZcZR/PQPexTMpxLls4XG1LTX8Mc3C/i8CG32oIFfgPxVGqdcwchU5zB4
         waLL9ogKl6fzdnTwNoLduMHTbuvTcTxKFViMrSAH36JaH9xcg8H+evngATmCjuUndS1Q
         AyBQSmOBIhMjyk8aWV4d+pWVovMq91xkrfFSjlI6R5pYhyDsP6ynrmFd1CfsBwzd71gm
         kNsReH4HvmeReUdPdQCbQt7EY6p3YBi3CeqZKPedRIR4RMFJfu1wO/izNHE/etK1p/JD
         YnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406057; x=1748010857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=H8Gm7uOtryTaFPQgUuRkMsrz1+HLC7ZOjRSGkSsPyvvOH8QGu0IwL/Sj3j/UYGErZp
         O/kPdQ3/CQGq7RChhhk/mjcBF5h7ntbIrOZUl+RoQQHDVdhBDOD4N75FScIz24gKscmg
         /pJ6Pw+DidzKTsM2Wqfu3o80MokB5jwqz8KXiVxap97V4CwhuIs8Uqlsk9GZ81WtlzlL
         Bxn6gXgGy6BSvhaUlmftaZQzAwb2G/tor8YdBA2uiVqz9Zn15FMh1I7tAnh/s7HdJYxA
         LnJ9s73nhIeUdp61x5d8zGRDeKFiqJNNbSgB7Y3Fz7xBkUMmeT90qYHckxIMwOL53xw4
         rtcw==
X-Forwarded-Encrypted: i=1; AJvYcCWZwUdl+IEfIeRaq77as1GB5WZ8hbiwWmV1u2WsXSSdVkCag2SaFTLc61lJs52UijMpJxa+EQOyFL5zEF33CDXKLAQb3yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkzpemGvOoaV5jWFHHYgklpxz08YzCWVaDfdbncsDm641zfhi
	la3xMOdzP4a59aYMZEzCNY/sPp+rjczlQqIW8EIa7pL6+bMoRPdFqQb+6soJS5f6nmkb9YQgFfv
	d4FfzrSJQReUW1/vyaEAQw/NRoCWY6GCiG5QDT28m
X-Gm-Gg: ASbGnctMJT34KReoxace8V/ES/oBotlGf964qAHEWSGj36VPo2xIYD0LleIERfQ33Aj
	xcopW5PMj3F00GYrp5ptcpYf9Smr3jmwhKpatLaqwHCxqsQyoJWuEz0ZaHkCHbfjpHFQL6kkGO/
	WEPIQiQrlwK0yURuTuCtO7wF/pTxS5lmn8tLNL660JS2btB7wHBoOM29hf+Bmy
X-Google-Smtp-Source: AGHT+IGCSHxzW91C4A5f0hB+8GzPDiVXw/aNuBqA0vePJ7mSh5UedOWWbXq+/BmaUddB31Y12bkHvm3bpH51L/eGgVg=
X-Received: by 2002:a50:8e51:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ffce29ea75mr210811a12.7.1747406056679; Fri, 16 May 2025
 07:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:33:40 +0200
X-Gm-Features: AX0GCFtQVpgNrEjVFvdmdJYYDaEF3VTJ2Dm_tJFrdzJ22BVKOsDvuggvKcRma0U
Message-ID: <CAG48ez0e+-SdB6AWXFKBy4i2Dy8ducic4aH5=hKQDqpN_G-sRg@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Coredumping currently supports two modes:
[..]
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
