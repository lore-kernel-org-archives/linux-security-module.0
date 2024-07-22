Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC316D30E
	for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652377; cv=none; b=II7Y+rmRlMwUQdA2ZtSJCi/x8cFBZE/yfXUYJ06SLwxVHNQIJnHzZP32jor/K18ZtXAUA2KrN5OE+Sg7pzlsNkompPUuIqm9gzhW2NknHe4n2nJuBNxhDEJhMhdJsqvzpkqmz7OJIxitki+gyyStUIhqTFbbYsj/GHLtQFkLmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652377; c=relaxed/simple;
	bh=08A40bbhznrlKFn2gZRVp22dL57vJ4Sag/bNSCApeS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjbpLhWJCYCPifoAWHrCBSuAiOpt1ByF8NUU4w2TLKOiQQYsCPMwtOBJI6WSqLwhoqYDZu4cKP8sK4qwTZqdLzBmk9j9d9Atl84uBO4u7ZLgO6EcqGBa0+sa1zN1PuPZJe5D45wsLICx+dvgiNdnQia7U/60FoGpwkmUmr9/hVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4S8G4QcC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4S8G4QcC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so33950a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2024 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721652374; x=1722257174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=4S8G4QcCqOGfRYHIIs0g5/Wwjr//Em8gk65flqFmVi4ClJ/rNSvYsMirttABh5ptNu
         bhhxnqQjubap6Y1faNWAhsltz/e61/eAe8C0Agi47vO4bdvyE2kwKISBeINduzF2IGI1
         UuJwSJIO4uLuwtekWq3BDNa1ybfbTRwTljRdwAu5S9J6h+xLw5W91TERxZd+0uWg5G0n
         bqEtfPDZTzwxTr31PhTJ3tdrVW2gMzF9JWq64wD8pu6vd0Uu0Yk57uW9bxSo8qLJ2f8M
         8HTFXVixodWq0YdSVTLGTRAl45q3ISqbqg8XuBrQC871AtIa/OzQmGYCprIw5P264z3E
         fyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652374; x=1722257174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkPk7qSJmsTXHG/tHIONPG7HUxcysTuWtB6jumYqrdM=;
        b=jPpq+944TUI9NAKon3pqY0f2cZH1rrzvWBuJgaz5x2+2i8ZcHM6+uTpVyGF7n412M0
         Ja1UxaEpY98FG0ZjnjtvJeWp7l7QN+N862Xwn8cXG7KQvcqIjrU6wRNV50A5xo+1Hnde
         iDjv4+ahsX3phDh14Up7ymcrVig/OSlm3KM+JGUA1kwh8KoND4V2nkWOGmsatvxb0616
         BbEcZPQFlT0Yg8cixcwhPb1hEnW4BRWNBYDtBf2013b5udzpgww4cXkvmZe0R2S5Y/Eb
         fiDdSmd9QiHGwNxLubt49ESctAX6G5HNpYhVwCaRl+Zyb4KuZe8+lUiDbLqV9lz/sDgk
         87Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7gZbcdhn4QcV9U6B6j31s8bJqummw7210WeT08XXs2Uux+qUfEt9yvNIXExOvPSQk3vadXcnSPhThm+Dp098Q4gIG47y5uUEv/26M1aWlF86U/gX
X-Gm-Message-State: AOJu0Yxtxpi9d31oZeIKNVp3xGTz5x4oNMcXw0P/pbAr190YbVHI2nvh
	A6UGWtBl64rNeTqa8M7wnj3MAPnSMQfhy7p2rJo9gH6GE5DeN6EBj9+cn6eLKNaynXe2fLcXZod
	r+G94Avq15j0l6IuVhEqDq5RWuM7BplNXK/Vh
X-Google-Smtp-Source: AGHT+IHCi62PM+KOTFc8/S9a0uMCt8sBsWfBOfvWEaTCwIQZzIuRwZy1cJ/vucoCoYuRW5CLLmMrzJQs2JS1pzid0TE=
X-Received: by 2002:a05:6402:34c9:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5a4a842af45mr220593a12.3.1721652371314; Mon, 22 Jul 2024
 05:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
In-Reply-To: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 22 Jul 2024 14:45:35 +0200
Message-ID: <CAG48ez3MNJ9QiULabERc-SWQLx4T80_UOvsqCVFXTi3yxeeMRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:22=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> Currently, a sandbox process is not restricted to send a signal
> (e.g. SIGKILL) to a process outside of the sandbox environment.
> Ability to sending a signal for a sandboxed process should be
> scoped the same way abstract unix sockets are scoped.
>
> The same way as abstract unix socket, we extend "scoped" field
> in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset
> will deny sending any signal from within a sandbox process to its
> parent(i.e. any parent sandbox or non-sandboxed procsses).
>
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
[...]
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       const struct task_struct *result =3D
> +               get_pid_task(fown->pid, fown->pid_type);

get_pid_task() returns a refcounted reference; you'll have to call
put_task_struct(result) to drop this reference at the end of the
function.

> +       const struct landlock_ruleset *const dom =3D
> +               landlock_get_task_domain(result);
> +       if (signal_is_scoped(dom, tsk))
> +               return 0;
> +       return EPERM;
> +}
