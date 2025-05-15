Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098F29B8C0
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342414; cv=none; b=Y7GmK3kxm9ffa0+QkT4vDjo0bRw2VpRL+c+R706xUmIsrL7UV5gJVTBqKVTrPAt1lMVtHQErGsD1B94WS2w34UWzEnGCuQZv3pLhmP6Ihi5zPJ2q0i6X8Mg9NBtIaqqB105/+pkWD2gJolEmivB0jwmyaUYNZPKdKP48kZk6TSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342414; c=relaxed/simple;
	bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ+1rgkkVdJAyHoBJ+XjQduwRHu5KgKDpLdmcoxn6Mqzt+wmJRqoj6C0M4Jh7AF6tPYF/8zmBjQVKF0of23aFnKe8c69J/kEpcXqoQ5ZIpPEj9BW0YILiJBVYWaxp+VwUTGBMtVrI4kH6Rv6EVjZBPW+LqOZTEFK8eQl6iNEay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgMIKSY7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgMIKSY7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso3730a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342410; x=1747947210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
        b=dgMIKSY7qCR1OgW5sBb03YdJPEHN5kAbtkaWQVcH9WAE6tvRKU0b5McF0GAeW3i8Uu
         TE8jbF2GWjNVROICmloT9YchArTuGtOJzbxD+xoHm4xIT8CZFxNzjQ/jdzBh193hsnCt
         BR+5IQnWqWuc3yOF0d78xp1JlCN1zRAS2HjDMYEvaAGQH8ImRdcfr//cwhGs7YLtBxxk
         E4KsoHt7mMgD4GYCoyfD4lScnqrAw7KKzbQSTJrYD/mxKjKRDzSZSYi3EKZQhVT4mVU2
         PfW7PXj7jh7RZs7LM2QYR6pcfB4FIIHa6/cOA9h02RsBaLoBl8EtzulbNM19ve4q6QmD
         aqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342410; x=1747947210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
        b=pt/z5iYLbDeA4ug+4kPBrMiqbU9eO5PAkapqMtCLPX8jaswBPB7WgwOugnguXqlxe0
         WK3nt93G6gxgGnXMyt8FTDNXliIgZ+YasUc/5S6ulySchzihmSDCkUctbVhTrCzZNq4c
         9ob80JvB2jLq/+fpXDCFRrhug9tkccnJc4ZDkQ3ahVjbv8aojKLD3sO9yJDdT+TCXEAq
         4Px4YbMom1b0eqbBNJ7zulUIQbdMyJTQVjcXFsPN3z4wy1y2WLJJxyEGtu0dmmJ+oGpF
         V1G97fBzoeh7/lEgBCL/uFrll6r/yMnkloCoYKqh6D/nI7Y42hEvsemQxExEj2XpHI51
         egaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWWuqmO54R7VnBZe5wPlUEKi6Thol9ht+tn8EcNuVrf/dbq748VhkGOBH/K0aU3PSt1JRQqOM873/qKgfBrlzVU4c1J+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkF+kKECGGROkPylTJX4TL63ahACSLO/jEBVRAz6LXBguVp3dI
	/UdLFGozA9S+8uqNzDlY2CQQQF7kRi++mVFcKZV7P94HCFKFUyygYAOPIa21JIt7nOQErey5qV7
	oI9xVLrJcPfIlnZIpHTqrr6NWnk4Qp2A5BiQd6MOW
X-Gm-Gg: ASbGncu2kQmNdh9qLArzk0VswR0zbrV24sM1U6hebFMfdMfTvZAaL2YEJsbCBgeXHRd
	rVRWQB5a7qesTR62YkyD1G4f+tseqBRFohEeOKeAIB0bz6rx/mjcw/1FYQIxQgYZlsSAozFVfoB
	JYBpZoq3FLWE4yxl+2pFsNS5g3eKL6vyJRLooKd70qgzAX5ozXK2BD7lD7CMcLF2bjN4tW5f0=
X-Google-Smtp-Source: AGHT+IECLHFWIrRiZUC7O4hqEBDUksv17PKckJK1rnL5QMtfgaSKVKKd7QPmPRV/LqJk6d0BzJrKKJ5nDtiVXyuVaB4=
X-Received: by 2002:a50:fa8e:0:b0:600:77b:5a5a with SMTP id
 4fb4d7f45d1cf-600077b6b0dmr89509a12.1.1747342410107; Thu, 15 May 2025
 13:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:54 +0200
X-Gm-Features: AX0GCFvZyxY7ct4_THeym5x5LEYv3lsYRODqj4j24boe3WIKlaAJKd5VKjymUt4
Message-ID: <CAG48ez2HPOmWgY1riBJbt6tFzAJbJv_N5XnPwhAbVBfA1-sRBA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] coredump: massage do_coredump()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
