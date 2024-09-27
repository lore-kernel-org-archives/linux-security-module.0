Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018F189B9C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438669; cv=none; b=b/i1RRddwHsOHS3jKhEkKjQfNDtDjIHOwEHxaRI3nOa9Bn/ciCHtCdMjirz9KJxya6aK3KXAJnwGEC4g1z5YW/QlrSuyAUuBbQpn1jr+QM28MVpZ1AgaEXxeTw0KiaNS82T8Q0MFkOIdRLV7DGkcfgx4yyCE+5ym4GKpe2FyEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438669; c=relaxed/simple;
	bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP1N0VVr37+cxzJTwR9ZxWvm3ZqCwwdAPLQycPn7Xjzoixdk7y+jIt1JwVXzwCJesvIXRf2Yiz248WrHF+M8Fl1LD+FmAGxyjv4BPV8XGdiiBRiltA5EeGeD1ZQ+Q0EfyFR/knQszQA0IqPX5JRdHInfyp2MZY7qINiSZHYZvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=097hUeN6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="097hUeN6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso17221355e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727438666; x=1728043466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
        b=097hUeN6Fwz5/BL43oDYO8p/1fifXuzVn7Mso1pxqMg/WbzJaigjzvHc90Tf0v1XRc
         aOmdmBLaqJBV9u9K7cuC1AvCSOqZNP9Fr6vIBxF/Ubf5XCNqrHQH77mwanWhOj8HpMzO
         a/POu5LZcImYnMDDwXgUUi7j9BGYcaNfKSLfodZiHNfDt/i3ofPOxhcBKvkJNHHUwha/
         QNmPnUkazkbZCNO1OuIe1RvnVLS4+b8IK4BrDvCMv5xFOscPh7/GYkAONiddW1696Iww
         jpne4UrtHqdi7TISYT6v/2a8qnyNDxYSCxjUB89HoYBbsy+4YBzwH6hB04VMJe6okZ5f
         DzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438666; x=1728043466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
        b=i35wJZW7DOwW1QuOCMSoa5LfWMOnbNyzENObEnyzxLAHOaQ7H4xN5h+EBxhXpB0IYo
         Bxj2eDouv/LQ4956PMhUOcFDDnx+Zou5zvkVivkQS6KSNBmV2wF6MsriCuNE+RqYZwp0
         xE0EsI1uMIz7YdylPLES4ZPuejdl85Z2zxQmgRoC4YRzaBowUj/8hTU4Zkjtayq0rqb0
         BxdlYW1JV8EzistF6b7W00zNiloMkpUTuPhD+WKfj9q4ghAWRYIKB3LCPTsNjN+qH09z
         7mdSIvA+tZTFuBhnDogODEfiIgutqG3zXYArMbd1fNieWBDE/N0K/LzLqxE6rHjlV3zh
         tS1w==
X-Forwarded-Encrypted: i=1; AJvYcCX7jmuVFkFX/y24BAiVpbft0wnSK55XV2u2ILcQIE83iu6Pw1ACCb/Pady7ekm8wqGZWAPv0lztp+6UzmmRx13kW+GrV7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCiSSMOeie/muJ0AdshPQRbJ5JXCxpQwjH81rVwgXCgwnz5CD
	QrOtidb0uJHgGE/P5BXda8hKuGHhMHTop8gd4NuTJB//UzVz7x2o786j32HjX79I9/L86K3iGKz
	RYhJ58WnQqx8lrhGNQzfJkIE/qMqOVAI40pwr
X-Google-Smtp-Source: AGHT+IEy3dP7p1C2eMoRV16OpmNG4PB6S4oIj5yrTQFRdGKMIDUcgcOI2efalw5tNFlnpHn1BB6580PiK2e8zpr1Klo=
X-Received: by 2002:a5d:4808:0:b0:37c:d55a:38a5 with SMTP id
 ffacd0b85a97d-37cd5a69225mr1687246f8f.11.1727438665878; Fri, 27 Sep 2024
 05:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
 <20240926-bewundere-beseitigen-59808f199f82@brauner> <20240926-pocht-sittlich-87108178c093@brauner>
In-Reply-To: <20240926-pocht-sittlich-87108178c093@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 14:04:13 +0200
Message-ID: <CAH5fLghUj3-8eZMOVhhk0c9x29B7uMj=9dHWsRJYC1ghxqUdxg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] rust: add PidNamespace wrapper
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 6:36=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Ok, so here's my feeble attempt at getting something going for wrapping
> struct pid_namespace as struct pid_namespace indirectly came up in the
> file abstraction thread.

This looks great!

> The lifetime of a pid namespace is intimately tied to the lifetime of
> task. The pid namespace of a task doesn't ever change. A
> unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
> change the task's pid namespace only the pid namespace of children
> spawned by the task. This invariant is important to keep in mind.
>
> After a task is reaped it will be detached from its associated struct
> pids via __unhash_process(). This will also set task->thread_pid to
> NULL.
>
> In order to retrieve the pid namespace of a task task_active_pid_ns()
> can be used. The helper works on both current and non-current taks but
> the requirements are slightly different in both cases and it depends on
> where the helper is called.
>
> The rules for this are simple but difficult for me to translate into
> Rust. If task_active_pid_ns() is called on current then no RCU locking
> is needed as current is obviously alive. On the other hand calling
> task_active_pid_ns() after release_task() would work but it would mean
> task_active_pid_ns() will return NULL.
>
> Calling task_active_pid_ns() on a non-current task, while valid, must be
> under RCU or other protection mechanism as the task might be
> release_task() and thus in __unhash_process().

Just to confirm, calling task_active_pid_ns() on a non-current task
requires the rcu lock even if you own a refcont on the task?

Alice
