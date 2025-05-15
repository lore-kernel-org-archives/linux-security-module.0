Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35529B8C3
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342632; cv=none; b=fjMGvzePU5QzrDNv18YCGGAP9VuK9quSX14o4CQ/qzlIStvAWhWRLEUPbWVMUsohtqiDHNqoBvBeMe4G3aEK4aaapKB9S9ecAzWcgqldhyZ5lMWsI2I+hX803oav2DcpBQmhQKSFn3QxciMZoEVsHqv5eJ2dzrbtc71uU6sCdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342632; c=relaxed/simple;
	bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn75uhtEezcgzGrVPsIp3TUBnTSwG9UrcHiEe5LCF3JXZy+SLJFRJYG7DQOHFK2Q7Yl+l3x/XbxzIX4Ebs3JAhm0KRihTOmScJ+mot3B3HW3Jgpfj0mrjp4RdXfxpizHEUh8sPHqrMAOgJEhMVjXuwNcdIrqXaV1y1vtVyqIk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiK4c5VK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiK4c5VK"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1342a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342629; x=1747947429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=NiK4c5VKp6uMSJjFMco2TAD5PtvZRm+/Nbty7oVQE3OaZnmKVU3RWdW2kJpwdm8WC1
         9w3+WoYcman57A0RL3v1OVsw2ok20PXL4KRfwkKPZ/DBIqDWy335+k02rAGSMrjKctKZ
         kIPgCvZ3G6k5tUmICjohmIP7Tqge+2ljZ4o6RWu5N7kW8TSzeumG31IpV+p7XfW+pjve
         tNqTL2N5jYN4W/2iw1ODL89i8TcXuy+J52rVziqY0RxKH46PaFD2vk6BytslHkn7eUuz
         WLvCrhCe6ppUBB17JifhmtoB2h3P99gvhohrMn5FM1oktQvi412X2dzVdFTWJaOheR3s
         XPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342629; x=1747947429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=U9a1CwHcM/zC/wueVBBygqz/6rwJmGp/vZpmIKnvKtVn2nP+zXL86mH7491rBn62b0
         XxJGiDRvVhg2TG60RDAQXvr+kDy5WoE1L4FgcZ+zoDU5zMPOp0dQ90pzsJ4Oxi19+lcp
         0oO6BpehEoERrPX7AGaxpr5/+5iQxUKbXu+bscH4KyssNQaOra0owBTwDuRXVK/GAZpL
         rwuTHoYIZ6QwJnT7fe0ChesjPggG6JX9cAjuy8P+vO0XEnPraXnm/zdDnuc43Sje51MR
         4WMJll3D59wdbXXiWIsr8Nx9JJetbnDoY6ipDcugb5caPhN4YfotQa7T1F17VZzunueJ
         MGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHPKtA8MEKRPt4XqoCOtCM67nbD6ySrjlaZRVta/5cw7i6xmeEmKTWpCE1mZL4ehipd1bxvGkDlziEd6O3dGwzKs+wVxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcjrHl/NCh81RY07GQxQyfZV95ZQFpSsIfad//IE/GPtQQemg
	H5Pk7SNJ6CGigii5f7oTkuncSQCHwUmqsK3bmey1I7cMo7IXELfWstMAJPJ1dEAjfq5ak3Y4i9L
	++msM2B5c5LjtVBNBdTKU4vjHfFMJdyOZn4WZEhR8
X-Gm-Gg: ASbGncu6FXGykqf56p+MzY+fx6tMKFi5Or57TTDF1H0jZOj5seq0mZU78r9snSiFmMh
	jmdc1KsKjh3AXLFSMlRG86fazu+pbR1oLqyu4nmA7psriNOtAozRWUgzArIA1LIKoeiyP0jXzgo
	neIwv56SKLXPJ9Soi8jGjhAoJyFZ4JDlBxniP8hr1XD1/hurq6VuViIy59MnRN
X-Google-Smtp-Source: AGHT+IHZOBTJlThJhcv/ZxHz/H+8QZlugn3sleQN3wcAGTU8hgAWjH2Njf0TmrGz0ZHIoDeXYKzWzlKfCbbNua8Uh/A=
X-Received: by 2002:a50:cd19:0:b0:5fc:a9f0:3d15 with SMTP id
 4fb4d7f45d1cf-5ffce28bb43mr138873a12.1.1747342629100; Thu, 15 May 2025
 13:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:33 +0200
X-Gm-Features: AX0GCFvCU69IQ16RRV7879LgqrtFsOSgJDh6k5Q76ICOqMSjVLU262TZzPZwqzY
Message-ID: <CAG48ez0dqyzT3k4-HC3UjhCncgnPk28c1Av-iV8c9hB5tcu2YA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
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
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
